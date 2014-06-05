package edu.stanford.nlp.kbp.slotfilling.evaluate;

import edu.stanford.nlp.ie.machinereading.structure.Span;
import edu.stanford.nlp.kbp.common.*;
import edu.stanford.nlp.kbp.slotfilling.ir.KBPIR;
import edu.stanford.nlp.kbp.slotfilling.ir.KBPRelationProvenance;
import edu.stanford.nlp.util.logging.Redwood;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static edu.stanford.nlp.util.logging.Redwood.Util.endTrack;
import static edu.stanford.nlp.util.logging.Redwood.Util.forceTrack;
import static edu.stanford.nlp.util.logging.Redwood.Util.startTrack;

/**
 * <p>
 *   A slot filler making use of DeepDive as its implementation, rather than
 *   running the default pipeline.
 * </p>
 *
 *
 * @author Gabor Angeli
 */
public class DeepDiveSlotFiller implements SlotFiller {

  protected static final Redwood.RedwoodChannels logger = Redwood.channels("DeepDive");

  /**
   * The database connection DeepDive will be listening on.
   */
  public final Connection psql;

  private final PreparedStatement query;

  private final GoldResponseSet goldResponses;
  private final Maybe<KBPIR> ir;

  /**
   * Create a new DeepDive slot filler, based around the connection supplied in the
   * properties {@link Props}.
   */
  public DeepDiveSlotFiller(GoldResponseSet goldResponses, Maybe<KBPIR> ir) {
    this("jdbc:postgresql://" + Props.DEEPDIVE_HOST + ":" + Props.DEEPDIVE_PORT + "/" + Props.DEEPDIVE_DB,
        Props.DEEPDIVE_USERNAME, Props.DEEPDIVE_PASSWORD, goldResponses, ir);
  }

  /**
   * Create a new DeepDive slot filler, based around the connection supplied.
   * @param uri The connection specification for the database to read from.
   * @param username The username to connect to postgres using.
   * @param password The password to connect to postgres using.
   */
  public DeepDiveSlotFiller(String uri, String username, String password, GoldResponseSet goldResponses, Maybe<KBPIR> ir) {
    this.goldResponses = goldResponses;
    this.ir = ir;
    try {
      psql = DriverManager.getConnection(uri, username, password);

      query = psql.prepareStatement(
          /*"SELECT DISTINCT" +
              // Distinctness Conditions
              "   ON (subject.text,                      " +
              "       subject.type,                      " +
              "       rel.name,                          " +
              "       object.text,                       " +
              "       object.type                        ) " +
              //
              // FIELDS
              //
              // KB Entry
              "       subject.text                       AS entity_name,\n" +
              "       subject.type                       AS entity_type,\n" +
              "       rel.name                           AS relation,\n" +
              "       object.text                        AS slot_value_name,\n" +
              "       object.type                        AS slot_value_type,\n" +
              "       subject.freebase_id                AS entity_id,\n" +
              // Provenance
              "       sent.doc_id                        AS doc_id,\n" +
              "       sent.sentence_index                AS sentence_index,\n" +
              "       subject_mention.token_offset_begin AS entity_token_begin,\n" +
              "       subject_mention.length             AS entity_token_length,\n" +
              "       object_mention.token_offset_begin  AS slot_value_token_begin,\n" +
              "       object_mention.length              AS slot_value_token_length,\n" +
              "       sent.character_offset_begin        AS char_begin,\n" +
              "       sent.character_offset_end          AS char_end,\n" +
              // Score
              "       rel_instance.expectation           AS score,\n" +
              // For Debugging
              "       sent.text                          AS sentence,\n" +
              "       sent.words                         AS words,\n" +
              "       object.freebase_id                 AS slot_value_id\n" +
              //
              // TABLES
              //
              "\tFROM \n" +
              // Inferrable tables
              "\t     candidate_relation_instance_result_materialized rel_instance,\n" +
              "\t     candidate_relation_mention_result_materialized  rel_mention,\n" +
              "\t     el_candidate_link_result_materialized           subject_link,\n" +
              "\t     el_candidate_link_result_materialized           object_link,\n" +
              // Other tables
              "\t     relation_type                                 rel,\n" +
              "\t     canonical_entity                              subject,\n" +
              "\t     canonical_entity                              object,\n" +
              "\t     candidate_entity_mention                      subject_mention,\n" +
              "\t     candidate_entity_mention                      object_mention,\n" +
              "\t     sentence                                      sent\n" +
              // "\t     document                                      doc\n" +
              "\tWHERE \n" +

              // Join on doc_id for better performance
              "\t      sent.doc_id       = object_mention.doc_id                     AND\n" +
              "\t      sent.doc_id       = subject_mention.doc_id                    AND\n" +
              "\t      sent.doc_id       = subject_link.doc_id                       AND\n" +
              "\t      sent.doc_id       = object_link.doc_id                        AND\n" +
              "\t      sent.doc_id       = rel_mention.doc_id                        AND\n" +

              // Don't consider the NIL entities
              "\t      subject.entity_id            <> 'NIL0000'                     AND\n" +
              "\t      object.entity_id             <> 'NIL0000'                     AND\n" +

              //
              // JOINS
              //
              // Link relation instance to canonical entity + relation
              "\t      rel_instance.subject_id       = subject.entity_id             AND\n" +
              "\t      rel_instance.object_id        = object.entity_id              AND\n" +
              "\t      rel_instance.relation_type_id = rel.id                        AND\n" +
              // Link relation instance to entity mentions
              "\t      subject.entity_id             = subject_link.entity_id        AND\n" +
              "\t      subject_mention.mention_id    = subject_link.mention_id       AND\n" +
              "\t      object.entity_id              = object_link.entity_id         AND\n" +
              "\t      object_mention.mention_id     = object_link.mention_id        AND\n" +
              // Link entity mentions to relation mention
              "\t      rel_mention.subject_id        = subject_mention.mention_id    AND\n" +
              "\t      rel_mention.object_id         = object_mention.mention_id     AND\n" +
              "\t      rel_mention.relation_type_id  = rel.id                        AND\n" +
              // Link relation mentions to sentence and document
              "\t      sent.sentence_id              = subject_mention.sentence_id   AND\n" +
              // "\t      doc.doc_id                    = sent.doc_id                   AND\n" +
              //
              // CONDITIONS
              //
              // Everything is correct
              "\t      rel_instance.expectation      > " + Props.DEEPDIVE_THRESHOLD_INSTANCE + " AND\n" +
              "\t      rel_mention.expectation       > " + Props.DEEPDIVE_THRESHOLD_MENTION +  " AND\n" +
              "\t      subject_link.expectation      > " + Props.DEEPDIVE_THRESHOLD_LINK +     " AND\n" +
              "\t      object_link.expectation       > " + Props.DEEPDIVE_THRESHOLD_LINK +     " AND\n" +
              // Ensure provenance
              // "\t      doc.source                    = '" + sourceForYear() + "'   AND\n" +
              // Query variables
              "\t      ( subject.text              = ?                    AND         \n" +
              "\t        subject.type              = ?                        )       \n" +
              "ORDER BY subject.text, subject.type, rel.name, object.text, object.type, rel_mention.expectation DESC;"*/

              "SELECT * FROM relation_extraction_evaluation_new\n" + 
              "\t   WHERE entity_name = ? AND entity_type = ? AND\n" + 
              "\t   (slot_value_type = 'CAUSE_OF_DEATH' OR\n" + 
              "\t    slot_value_type = 'CITY' OR\n" + 
              "\t    slot_value_type = 'COUNTRY' OR\n" + 
              "\t    slot_value_type = 'CRIMINAL_CHARGE' OR \n" + 
              "\t    slot_value_type = 'DATE' OR\n" + 
              "\t    slot_value_type = 'IDEOLOGY' OR\n" +   
              "\t    slot_value_type = 'MISC' OR\n" + 
              "\t    slot_value_type = 'MODIFIER' OR\n" + 
              "\t    slot_value_type = 'NATIONALITY' OR\n" + 
              "\t    slot_value_type = 'NUMBER' OR\n" + 
              "\t    slot_value_type = 'ORGANIZATION' OR\n" +  
              "\t    slot_value_type = 'PERSON' OR\n" + 
              "\t    slot_value_type = 'RELIGION' OR\n" + 
              "\t    slot_value_type = 'STATE_OR_PROVINCE' OR\n" + 
              "\t    slot_value_type = 'TITLE' OR\n" + 
              "\t    slot_value_type = 'URL' OR\n" + 
              "\t    slot_value_type = 'LOCATION' OR\n" + 
              "\t    slot_value_type = 'DURATION');"
      );
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }
  }

  /**
   * The post-processors to run on the DeepDive output -- this is a smaller list than would be
   * run in the official system, but some cleaning is still necessary...
   */
  public static final SlotfillPostProcessor deepDiveFilters = SlotfillPostProcessor.all(
      // Singleton consistency
      new HeuristicSlotfillPostProcessors.FilterIgnoredSlots(),
      new HeuristicSlotfillPostProcessors.SanityCheckFilter(),
      new HeuristicSlotfillPostProcessors.ConformToGuidelinesFilter(),
      new HeuristicSlotfillPostProcessors.DuplicateRelationOnlyInListRelations()
  );

  /**
   * Get the document.source field in the DeepDive schema associated with the given
   * KBP year.
   * That is, make sure that the results we're returning are from the official document
   * set.
   */
  public static String sourceForYear() {
    switch (Props.KBP_YEAR) {
      case KBP2009:
      case KBP2010:
      case KBP2011:
      case KBP2012:
        return "kbp_2010";
      case KBP2013:
        return "kbp_2013";
      default:
        throw new IllegalStateException("Unknown year: " + Props.KBP_YEAR);
    }
  }

  @Override
  public List<KBPSlotFill> fillSlots(KBPOfficialEntity queryEntity) {
    forceTrack("DeepDive Query For: " + queryEntity);
    try {
      // Prepare Query
      query.setString(1, queryEntity.name.toLowerCase());
      query.setString(2, queryEntity.type.name);
      // Execute Query
      ResultSet result = query.executeQuery();
      // Populate Result
      List<KBPSlotFill> fills = new ArrayList<KBPSlotFill>();
      startTrack("Raw responses");
      while (result.next()) {
        KBPSlotFill fill =
            KBPNew.from(queryEntity)
                .slotValue(result.getString("slot_value_name"))
                .slotType(result.getString("slot_value_type"))
                .rel(result.getString("relation"))
                .score(result.getDouble("score"))
                .provenance(new KBPRelationProvenance(
                    result.getString("doc_id"),
                    Props.INDEX_OFFICIAL.getPath(),  // always the official index
                    result.getInt("sentence_index"),
                    new Span(result.getInt("entity_token_begin"),
                             result.getInt("entity_token_begin") + result.getInt("entity_token_length")),
                    new Span(result.getInt("slot_value_token_begin"),
                             result.getInt("slot_value_token_begin") + result.getInt("slot_value_token_length")))
                  ).KBPSlotFill();
        this.goldResponses.registerResponse(fill);
        logger.log(fill);
        fills.add(fill);
      }
      endTrack("Raw Responses");
      // Prune results to conform to KBP specification
      Collections.sort(fills);
      fills = deepDiveFilters.postProcess(queryEntity, fills, this.goldResponses);
      // Print results
      logger.prettyLog(this.goldResponses.loggableForEntity(queryEntity, ir));
      return fills;
    } catch (SQLException e) {
      throw new RuntimeException(e);
    } finally {
      endTrack("DeepDive Query For: " + queryEntity);
    }
  }

}
