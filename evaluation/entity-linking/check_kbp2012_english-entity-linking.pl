#!/usr/bin/perl -w

use strict;

# Check a TAC 2012 KBP Track English entity-linking task submission for various common errors:
#      * missing query ID (exactly one link required per query ID)
#      * invalid query ID
#      * invalid link (only approximate) 

# Usage is:
#    check_kbp2012_english-entity-linking.pl results_file
#  where results_file is the name of the results file to be checked

# Results input file is in the form 
#   <query_id> <link>

# link must be one of 
#         1. NILxxxx,  where xxxx can be any number number of characters (non-whitespace)
#         2. <entity_ID>, where <entity_ID> is the ID attribute of an
#            entity element of the TAC 2009/2010 KBP knowledge base 

# Messages regarding submission are printed to an error log

# Change this variable to the directory where the error log should be put
my $errlog_dir = ".";

my $MAX_ERRORS = 25;

# Array containing number of links returned for each query id.
# These query id values are specific to the TAC 2012 KBP track.
# Query id is of the form "EL_ENG_xxxxx"; where xxxxx is a 5-character zero-padded positive integer.
my $min_id_num = 1;
my $max_id_num = 2229;
my @query_ids;


my $results_file;		# input file name
my ($errlog,$num_errors,$line_num);
my ($id, $id_num, $link);
my ($i, $last_i, $line);


if ($#ARGV != 0) {
    print STDERR "Usage: $0 resultsfile \n";
    die "\n";
}

$results_file = $ARGV[0];
$num_errors = 0;

# set up output files 
$last_i = -1;
while ( ($i=index($results_file,"/",$last_i+1)) > -1) {
    $last_i = $i;
}
$errlog = $errlog_dir . "/" . substr($results_file,$last_i+1) . ".errlog";
open ERRLOG, ">$errlog" ||
	die "Cannot open error log for writing\n";


foreach $i ($min_id_num .. $max_id_num) {
    $query_ids[$i] = 0;
}

# The submission file for the KBP entity-linking task has at exactly one response for
# each query ID.
# A response line is of the form
#    <query_id> <link>

open RESULTS, "<$results_file" ||
    die "Unable to open results file $results_file: $!";
$line_num = 0;
while ($line = <RESULTS>) {
    chomp $line;
    $line_num++;

    next if ($line =~ /^\s*$/);

    $line =~ s/^\s*(.*\S)\s*$/$1/g;
    undef $id,
    undef $id_num;
    undef $link;
    ($id, $link) = split " ", $line, 2;
    
    if (!defined $link || length($link) == 0) {
	&error("Wrong number of fields");
	next;
    }
	
    # get query id
    if ($id =~ /^EL_ENG_([0-9]{5})$/) {
	$id_num = $1;
	if ($id_num < $min_id_num or $id_num > $max_id_num) {
	    &error("Invalid query id (id number is out of range): $id\n");
	    next;
	}
    } else {
   	&error("Invalid query id: $id\n");
	next;
    }
    

    # check that link is valid (approximate)
    if ($link !~ /^E[0-9]{7}$/ and $link !~ /^NIL\S+$/) {
	&error("Unrecognizable link `$link'");
	next;
    }

    $query_ids[$id_num] += 1;	

}


# Do global check:
#   error if we don't have exactly one link for each query
foreach $id_num ($min_id_num .. $max_id_num) {
    if ($query_ids[$id_num] == 0) {
	&error("Missing response for query number $id_num");
    } elsif ($query_ids[$id_num] > 1) {
	&error("Too many responses ($query_ids[$id_num]) for query number $id_num");
    }
}
print ERRLOG "Finished processing $results_file\n";

close ERRLOG || die "Close failed for error log $errlog: $!\n";
if ($num_errors) { exit 255; }
exit 0;


 # print error message, keeping track of total number of errors
sub error {
   my $msg_string = pop(@_);

    print ERRLOG 
    "$0 $results_file: Error on line $line_num --- $msg_string\n";

    $num_errors++;
    if ($num_errors > $MAX_ERRORS) {
        print ERRLOG "$0 of $results_file: Quit. Too many errors!\n";
        close ERRLOG ||
		die "Close failed for error log $errlog: $!\n";
	exit 255;
    }
}
