--
-- Greenplum Database database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ea; Type: TABLE; Schema: public; Owner: czhang; Tablespace: 
--

CREATE TABLE ea (
    query text,
    sub text,
    rel text,
    obj text
);


ALTER TABLE public.ea OWNER TO czhang;

--
-- Data for Name: ea; Type: TABLE DATA; Schema: public; Owner: czhang
--

COPY ea (query, sub, rel, obj) FROM stdin;
SF208	kendra wilkinson	per:age	23
SF209	chelsea library	org:alternate_names	chelsea district library
SF212	chad white	per:age	22
SF211	paul kim	per:age	24
SF210	crown prosecution service	org:alternate_names	cps
SF262	noordhoff craniofacial foundation	org:alternate_names	ncf
SF263	national christmas tree association	org:city_of_headquarters	chesterfield
SF260	north phoenix baptist church	org:city_of_headquarters	phoenix
SF228	professional rodeo cowboys association	org:alternate_names	prca
SF229	new hampshire institute of politics	org:city_of_headquarters	manchester
SF208	kendra wilkinson	per:age	21
SF209	chelsea library	org:alternate_names	chelsea district library
SF212	chad white	per:age	22
SF211	paul kim	per:age	25
SF210	crown prosecution service	org:alternate_names	cps
SF262	noordhoff craniofacial foundation	org:country_of_headquarters	taiwan
SF263	national christmas tree association	org:members	river ridge tree farms
SF260	north phoenix baptist church	org:city_of_headquarters	phoenix
SF228	professional rodeo cowboys association	org:alternate_names	prca
SF229	new hampshire institute of politics	org:city_of_headquarters	manchester
SF219	opera national de paris	org:alternate_names	opera de paris
SF218	madoff securities	org:alternate_names	bernard l madoff investment securities
SF208	kendra wilkinson	per:alternate_names	kendra baskett
SF209	chelsea library	org:alternate_names	mckune memorial library
SF212	chad white	per:cities_of_residence	portland
SF211	paul kim	per:age	25
SF210	crown prosecution service	org:alternate_names	cps
SF262	noordhoff craniofacial foundation	org:country_of_headquarters	taiwan
SF263	national christmas tree association	org:stateorprovince_of_headquarters	missouri
SF260	north phoenix baptist church	org:number_of_employees/members	7,000
SF228	professional rodeo cowboys association	org:alternate_names	prca
SF229	new hampshire institute of politics	org:city_of_headquarters	manchester
SF219	opera national de paris	org:city_of_headquarters	paris
SF218	madoff securities	org:alternate_names	bernard l madoff investment securities llc
SF222	ownit mortgage solutions	org:alternate_names	ownit's
SF223	national union for the total independence of angola	org:alternate_names	unita
SF220	nuclear supplier group	org:alternate_names	nsg
SF221	paralyzed veterans of america	org:alternate_names	pva
SF226	option one mortgage	org:alternate_names	option one
SF227	national republican campaign committee	org:alternate_names	nrcc
SF224	pennsylvania supreme court	org:alternate_names	pa. supreme court
SF225	old lane partners	org:alternate_names	old lane lp
SF284	sean preston	per:age	two
SF235	national beef packing co.	org:alternate_names	national beef
SF234	jackson hewitt	org:alternate_names	jackson hewitt tax services
SF237	multidisciplinary association for psychedelic studies	org:alternate_names	maps
SF236	national military family association	org:alternate_names	nmfa
SF231	lewis hamilton	per:age	22
SF230	massachusetts house of representatives	org:city_of_headquarters	boston
SF233	inter-american press association	org:alternate_names	iapa
SF232	institute for diversity and ethics in sport	org:city_of_headquarters	orlando
SF259	jewish national fund	org:alternate_names	jnf
SF258	jakarta globe	org:country_of_headquarters	indonesia
SF204	chris ivery	per:age	38
SF205	molly malaney	per:age	24
SF206	mark buse	per:alternate_names	the ferret
SF207	charles wuorinen	per:age	70
SF200	george boyd	per:member_of	nottingham forest
SF201	erika rose	per:employee_of	infiniti le mode
SF202	donald wildmon	per:age	69
SF203	frankie delgado	per:cities_of_residence	hollywood
SF246	alexandra burke	per:age	20
SF217	manila economic and cultural office	org:alternate_names	meco
SF216	samsung	org:alternate_names	samsung electronics
SF215	babyshambles	org:country_of_headquarters	england
SF208	kendra wilkinson	per:children	hank
SF209	chelsea library	org:alternate_names	chelsea district library
SF212	chad white	per:cities_of_residence	portland
SF211	paul kim	per:alternate_names	paul
SF210	crown prosecution service	org:alternate_names	cps
SF262	noordhoff craniofacial foundation	org:country_of_headquarters	taiwan
SF263	national christmas tree association	org:stateorprovince_of_headquarters	missouri
SF260	north phoenix baptist church	org:political/religious_affiliation	baptist
SF228	professional rodeo cowboys association	org:alternate_names	pro rodeo cowboys association
SF229	new hampshire institute of politics	org:parents	st. anselm college
SF219	opera national de paris	org:city_of_headquarters	paris
SF218	madoff securities	org:alternate_names	bernard madoff securities
SF222	ownit mortgage solutions	org:city_of_headquarters	agoura hills
SF223	national union for the total independence of angola	org:alternate_names	unita
SF220	nuclear supplier group	org:alternate_names	nsg
SF221	paralyzed veterans of america	org:alternate_names	the pva
SF226	option one mortgage	org:alternate_names	option one
SF227	national republican campaign committee	org:political/religious_affiliation	republican
SF224	pennsylvania supreme court	org:members	justice max baer
SF225	old lane partners	org:founded	2005
SF284	sean preston	per:age	2
SF235	national beef packing co.	org:city_of_headquarters	kansas city
SF234	jackson hewitt	org:alternate_names	smart tax/jackson hewitt
SF237	multidisciplinary association for psychedelic studies	org:alternate_names	maps
SF236	national military family association	org:city_of_headquarters	alexandria
SF231	lewis hamilton	per:age	22
SF230	massachusetts house of representatives	org:city_of_headquarters	boston
SF233	inter-american press association	org:alternate_names	iapa
SF232	institute for diversity and ethics in sport	org:parents	university of central florida
SF259	jewish national fund	org:alternate_names	jnf
SF258	jakarta globe	org:top_members/employees	lin neumann
SF204	chris ivery	per:charges	postal theft
SF205	molly malaney	per:spouse	jason_mesnick
SF206	mark buse	per:employee_of	freddie mac
SF207	charles wuorinen	per:age	70
SF200	george boyd	per:member_of	peterborough united
SF201	erika rose	per:schools_attended	boston college
SF202	donald wildmon	per:age	72
SF203	frankie delgado	per:cities_of_residence	hollywood
SF246	alexandra burke	per:cities_of_residence	london
SF217	manila economic and cultural office	org:alternate_names	meco
SF216	samsung	org:alternate_names	samsung corp.
SF215	babyshambles	org:country_of_headquarters	uk
SF208	kendra wilkinson	per:children	hank baskett iv
SF209	chelsea library	org:alternate_names	chelsea district library
SF212	chad white	per:cities_of_residence	portland
SF211	paul kim	per:alternate_names	paul
SF210	crown prosecution service	org:alternate_names	cps
SF262	noordhoff craniofacial foundation	org:founded	1989
SF263	national christmas tree association	org:stateorprovince_of_headquarters	missouri
SF260	north phoenix baptist church	org:political/religious_affiliation	christian
SF228	professional rodeo cowboys association	org:alternate_names	prca
SF229	new hampshire institute of politics	org:parents	saint anselm college
SF219	opera national de paris	org:country_of_headquarters	france
SF218	madoff securities	org:alternate_names	bernard l. madoff investment securities llc
SF222	ownit mortgage solutions	org:city_of_headquarters	agoura hills
SF223	national union for the total independence of angola	org:alternate_names	unita
SF220	nuclear supplier group	org:alternate_names	nsg
SF221	paralyzed veterans of america	org:alternate_names	pav
SF226	option one mortgage	org:city_of_headquarters	irvine
SF227	national republican campaign committee	org:political/religious_affiliation	republican
SF224	pennsylvania supreme court	org:stateorprovince_of_headquarters	pennsylvania
SF225	old lane partners	org:founded	2005
SF284	sean preston	per:age	2
SF235	national beef packing co.	org:city_of_headquarters	kansas city
SF234	jackson hewitt	org:alternate_names	jackson hewitt tax services inc.
SF237	multidisciplinary association for psychedelic studies	org:alternate_names	maps
SF236	national military family association	org:city_of_headquarters	alexandria
SF231	lewis hamilton	per:age	22
SF230	massachusetts house of representatives	org:city_of_headquarters	boston
SF233	inter-american press association	org:alternate_names	iapa
SF232	institute for diversity and ethics in sport	org:parents	university of central florida
SF259	jewish national fund	org:alternate_names	jnf
SF270	bryan fuller	per:age	38-year-old
SF204	chris ivery	per:cities_of_residence	boston
SF205	molly malaney	per:spouse	jason mesnick
SF206	mark buse	per:employee_of	freddie mac
SF207	charles wuorinen	per:date_of_birth	june 9 , 1938
SF200	george boyd	per:title	winger
SF201	erika rose	per:schools_attended	university of miami
SF202	donald wildmon	per:alternate_names	donald e. wildmon
SF203	frankie delgado	per:employee_of	mtv
SF246	alexandra burke	per:country_of_birth	england
SF217	manila economic and cultural office	org:alternate_names	meco
SF216	samsung	org:alternate_names	samsung electronics co.
SF215	babyshambles	org:founded_by	pete doherty
SF208	kendra wilkinson	per:children	hank baskett iv
SF209	chelsea library	org:alternate_names	chelsea district library
SF212	chad white	per:stateorprovince_of_birth	oregon
SF211	paul kim	per:alternate_names	paul
SF210	crown prosecution service	org:alternate_names	cps
SF262	noordhoff craniofacial foundation	org:founded_by	samuel noordhoff
SF263	national christmas tree association	org:website	www.christmastree.org
SF260	north phoenix baptist church	org:political/religious_affiliation	baptist
SF228	professional rodeo cowboys association	org:city_of_headquarters	colorado springs
SF229	new hampshire institute of politics	org:parents	st. anselm college
SF219	opera national de paris	org:top_members/employees	gerard mortier
SF218	madoff securities	org:alternate_names	madoff securities international ltd
SF222	ownit mortgage solutions	org:city_of_headquarters	agoura hills
SF223	national union for the total independence of angola	org:alternate_names	unita
SF220	nuclear supplier group	org:alternate_names	nsg
SF221	paralyzed veterans of america	org:country_of_headquarters	america
SF226	option one mortgage	org:city_of_headquarters	irvine
SF227	national republican campaign committee	org:top_members/employees	tom cole
SF224	pennsylvania supreme court	org:stateorprovince_of_headquarters	pennsylvania
SF225	old lane partners	org:founded_by	vikram pandit
SF284	sean preston	per:age	one
SF235	national beef packing co.	org:city_of_headquarters	kansas city
SF234	jackson hewitt	org:alternate_names	jackson hewitt tax services
SF237	multidisciplinary association for psychedelic studies	org:city_of_headquarters	boston
SF236	national military family association	org:city_of_headquarters	alexandria
SF231	lewis hamilton	per:age	23
SF230	massachusetts house of representatives	org:city_of_headquarters	boston
SF233	inter-american press association	org:alternate_names	iapa
SF232	institute for diversity and ethics in sport	org:stateorprovince_of_headquarters	florida
SF259	jewish national fund	org:alternate_names	jewish national fund ( jnf ) lands dept.
SF270	bryan fuller	per:age	38-year-old
SF204	chris ivery	per:city_of_birth	boston
SF205	molly malaney	per:spouse	jason mesnick
SF206	mark buse	per:employee_of	freddie mac
SF207	charles wuorinen	per:employee_of	new york city opera
SF242	pentax corp.	org:alternate_names	pentax
SF201	erika rose	per:title	singer/songwriter
SF202	donald wildmon	per:alternate_names	don wildmon
SF203	frankie delgado	per:member_of	hills
SF246	alexandra burke	per:origin	british
SF217	manila economic and cultural office	org:alternate_names	meco
SF216	samsung	org:alternate_names	samsung everland
SF215	babyshambles	org:top_members/employees	pete doherty
SF208	kendra wilkinson	per:employee_of	e!
SF209	chelsea library	org:alternate_names	mckune memorial library
SF212	chad white	per:stateorprovince_of_birth	oregon
SF211	paul kim	per:alternate_names	paul
SF210	crown prosecution service	org:alternate_names	crown
SF262	noordhoff craniofacial foundation	org:founded_by	samuel noordhoff
SF263	national christmas tree association	org:website	http://www.christmastree.org
SF260	north phoenix baptist church	org:political/religious_affiliation	christian
SF228	professional rodeo cowboys association	org:city_of_headquarters	colorado springs
SF229	new hampshire institute of politics	org:parents	st. anselm college
SF219	opera national de paris	org:top_members/employees	gerard mortier
SF218	madoff securities	org:city_of_headquarters	new york
SF222	ownit mortgage solutions	org:city_of_headquarters	agoura hills
SF223	national union for the total independence of angola	org:alternate_names	union for the total independence of angola
SF220	nuclear supplier group	org:alternate_names	nsg
SF221	paralyzed veterans of america	org:country_of_headquarters	united states
SF226	option one mortgage	org:city_of_headquarters	irvine
SF239	myanmar timber enterprise	org:alternate_names	mte
SF224	pennsylvania supreme court	org:stateorprovince_of_headquarters	pennsylvania
SF225	old lane partners	org:founded_by	pandit
SF284	sean preston	per:age	2
SF235	national beef packing co.	org:city_of_headquarters	kansas city
SF234	jackson hewitt	org:alternate_names	jackson hewitt tax services inc.
SF237	multidisciplinary association for psychedelic studies	org:city_of_headquarters	boston
SF236	national military family association	org:member_of	smart television alliance
SF231	lewis hamilton	per:age	23
SF230	massachusetts house of representatives	org:number_of_employees/members	160
SF233	inter-american press association	org:alternate_names	iapa
SF232	institute for diversity and ethics in sport	org:stateorprovince_of_headquarters	florida
SF259	jewish national fund	org:alternate_names	jnf
SF270	bryan fuller	per:age	37
SF204	chris ivery	per:spouse	ellen pompeo
SF272	adam senn	per:age	23
SF206	mark buse	per:employee_of	ml strategies
SF207	charles wuorinen	per:employee_of	new york city opera
SF242	pentax corp.	org:alternate_names	pentax
SF201	erika rose	per:title	singer/songwriter
SF202	donald wildmon	per:children	tim
SF203	frankie delgado	per:member_of	hills
SF246	alexandra burke	per:origin	british
SF217	manila economic and cultural office	org:alternate_names	meco
SF216	samsung	org:alternate_names	samsung group
SF215	babyshambles	org:top_members/employees	pete doherty
SF208	kendra wilkinson	per:spouse	hank baskett
SF209	chelsea library	org:city_of_headquarters	chelsea
SF212	chad white	per:title	model
SF211	paul kim	per:alternate_names	paul
SF210	crown prosecution service	org:alternate_names	cps
SF262	noordhoff craniofacial foundation	org:founded_by	dr. samuel noordhoff
SF263	national christmas tree association	org:website	http://www.christmastree.org/
SF260	north phoenix baptist church	org:stateorprovince_of_headquarters	arizona
SF228	professional rodeo cowboys association	org:country_of_headquarters	united states
SF229	new hampshire institute of politics	org:stateorprovince_of_headquarters	new hampshire
SF208	kendra wilkinson	per:spouse	hank baskett
SF209	chelsea library	org:country_of_headquarters	united states of america
SF212	chad white	per:title	model
SF211	paul kim	per:alternate_names	poolboy
SF210	crown prosecution service	org:city_of_headquarters	london
SF262	noordhoff craniofacial foundation	org:founded_by	samuel noordhoff
SF263	national christmas tree association	org:website	www.christmastree.org
SF260	north phoenix baptist church	org:stateorprovince_of_headquarters	arizona
SF228	professional rodeo cowboys association	org:country_of_headquarters	united states
SF229	new hampshire institute of politics	org:stateorprovince_of_headquarters	new hampshire
SF218	madoff securities	org:city_of_headquarters	new york
SF222	ownit mortgage solutions	org:founded	2003
SF223	national union for the total independence of angola	org:alternate_names	unita
SF220	nuclear supplier group	org:city_of_headquarters	vienna
SF221	paralyzed veterans of america	org:country_of_headquarters	united states
SF226	option one mortgage	org:city_of_headquarters	irvine
SF239	myanmar timber enterprise	org:alternate_names	mte
SF224	pennsylvania supreme court	org:stateorprovince_of_headquarters	pennsylvania
SF225	old lane partners	org:founded_by	vikram s. pandit
SF284	sean preston	per:age	three
SF235	national beef packing co.	org:country_of_headquarters	u.s.
SF234	jackson hewitt	org:alternate_names	jackson hewitt tax service inc.
SF237	multidisciplinary association for psychedelic studies	org:founded_by	rick doblin
SF236	national military family association	org:stateorprovince_of_headquarters	virginia
SF231	lewis hamilton	per:age	23
SF230	massachusetts house of representatives	org:stateorprovince_of_headquarters	massachusetts
SF233	inter-american press association	org:alternate_names	iapa
SF232	institute for diversity and ethics in sport	org:stateorprovince_of_headquarters	florida
SF259	jewish national fund	org:alternate_names	jnf
SF270	bryan fuller	per:alternate_names	brian fuller
SF204	chris ivery	per:spouse	ellen pompeo
SF272	adam senn	per:age	23-year old
SF206	mark buse	per:employee_of	goldman sachs
SF207	charles wuorinen	per:origin	american
SF242	pentax corp.	org:country_of_headquarters	japan
SF243	new south wales rugby union	org:alternate_names	nswru
SF202	donald wildmon	per:cities_of_residence	tupelo
SF203	frankie delgado	per:origin	american
SF246	alexandra burke	per:origin	british
SF217	manila economic and cultural office	org:city_of_headquarters	taipei
SF216	samsung	org:alternate_names	samsung electronics co.
SF215	babyshambles	org:top_members/employees	andy boyd
SF208	kendra wilkinson	per:spouse	hank baskett
SF209	chelsea library	org:country_of_headquarters	america
SF212	chad white	per:title	fashion supermodel
SF211	paul kim	per:children	anthony kim
SF210	crown prosecution service	org:city_of_headquarters	london
SF262	noordhoff craniofacial foundation	org:member_of	toaid
SF208	kendra wilkinson	per:title	tv personality
SF209	chelsea library	org:stateorprovince_of_headquarters	mi
SF212	chad white	per:title	model
SF211	paul kim	per:children	anthony kim
SF210	crown prosecution service	org:city_of_headquarters	london
SF262	noordhoff craniofacial foundation	org:top_members/employees	jessica chen
SF260	north phoenix baptist church	org:stateorprovince_of_headquarters	arizona
SF228	professional rodeo cowboys association	org:number_of_employees/members	more than 7,000
SF229	new hampshire institute of politics	org:stateorprovince_of_headquarters	new hampshire
SF218	madoff securities	org:country_of_headquarters	us
SF222	ownit mortgage solutions	org:founded_by	william d. dallas
SF223	national union for the total independence of angola	org:alternate_names	unita
SF220	nuclear supplier group	org:city_of_headquarters	vienna
SF221	paralyzed veterans of america	org:country_of_headquarters	america
SF226	option one mortgage	org:number_of_employees/members	1,400
SF239	myanmar timber enterprise	org:alternate_names	mte
SF224	pennsylvania supreme court	org:stateorprovince_of_headquarters	pennsylvania
SF225	old lane partners	org:founded_by	john havens
SF284	sean preston	per:age	three
SF235	national beef packing co.	org:country_of_headquarters	u.s.
SF234	jackson hewitt	org:alternate_names	jackson hewitt corp.
SF237	multidisciplinary association for psychedelic studies	org:founded_by	rick doblin
SF236	national military family association	org:stateorprovince_of_headquarters	va.
SF231	lewis hamilton	per:age	23
SF230	massachusetts house of representatives	org:stateorprovince_of_headquarters	massachusetts
SF233	inter-american press association	org:city_of_headquarters	miami
SF232	institute for diversity and ethics in sport	org:stateorprovince_of_headquarters	florida
SF259	jewish national fund	org:alternate_names	jnf
SF270	bryan fuller	per:cities_of_residence	clarkston
SF204	chris ivery	per:spouse	ellen pompeo
SF272	adam senn	per:cities_of_residence	paris
SF206	mark buse	per:employee_of	at&t
SF207	charles wuorinen	per:origin	american
SF242	pentax corp.	org:country_of_headquarters	japan
SF243	new south wales rugby union	org:alternate_names	nsw rugby union
SF202	donald wildmon	per:cities_of_residence	tupelo
SF203	frankie delgado	per:title	nightlife impresario
SF246	alexandra burke	per:origin	british
SF217	manila economic and cultural office	org:city_of_headquarters	taipei
SF216	samsung	org:alternate_names	samsung group
SF215	babyshambles	org:top_members/employees	adrian hunter
SF208	kendra wilkinson	per:title	tv personality
SF209	chelsea library	org:stateorprovince_of_headquarters	michigan
SF212	chad white	per:title	supermodel
SF211	paul kim	per:cities_of_residence	saratoga
SF210	crown prosecution service	org:city_of_headquarters	london
SF262	noordhoff craniofacial foundation	org:top_members/employees	rebecca wang
SF260	north phoenix baptist church	org:top_members/employees	dan yeary
SF228	professional rodeo cowboys association	org:stateorprovince_of_headquarters	colorado
SF229	new hampshire institute of politics	org:stateorprovince_of_headquarters	new hampshire
SF218	madoff securities	org:founded	1960
SF222	ownit mortgage solutions	org:founded_by	william d. dallas
SF223	national union for the total independence of angola	org:alternate_names	unita
SF220	nuclear supplier group	org:founded	1974
SF221	paralyzed veterans of america	org:subsidiaries	paralyzed veterans of america's new mexico chapter
SF226	option one mortgage	org:number_of_employees/members	1400
SF239	myanmar timber enterprise	org:alternate_names	mte
SF224	pennsylvania supreme court	org:subsidiaries	disciplinary board
SF225	old lane partners	org:founded_by	vikram s. pandit
SF284	sean preston	per:age	2
SF235	national beef packing co.	org:shareholders	premium beef
SF234	jackson hewitt	org:city_of_headquarters	parsippany
SF237	multidisciplinary association for psychedelic studies	org:founded_by	rick doblin
SF236	national military family association	org:subsidiaries	operation purple
SF231	lewis hamilton	per:alternate_names	louis hamilton
SF230	massachusetts house of representatives	org:subsidiaries	house rules committee
SF233	inter-american press association	org:city_of_headquarters	miami
SF232	institute for diversity and ethics in sport	org:stateorprovince_of_headquarters	florida
SF259	jewish national fund	org:alternate_names	jewish national fund-keren kayemeth l'israel
SF270	bryan fuller	per:cities_of_residence	los angeles
SF204	chris ivery	per:spouse	ellen pompeo
SF272	adam senn	per:city_of_birth	paris
SF206	mark buse	per:employee_of	at&amp;t
SF207	charles wuorinen	per:title	composer
SF242	pentax corp.	org:country_of_headquarters	japan
SF243	new south wales rugby union	org:alternate_names	nswru
SF202	donald wildmon	per:cities_of_residence	tupelo
SF203	frankie delgado	per:title	television personality
SF246	alexandra burke	per:origin	british
SF217	manila economic and cultural office	org:city_of_headquarters	taipei
SF216	samsung	org:alternate_names	samsung everland
SF215	babyshambles	org:top_members/employees	pete doherty
SF208	kendra wilkinson	per:title	model
SF209	chelsea library	org:stateorprovince_of_headquarters	michigan
SF212	chad white	per:title	male supermodel
SF211	paul kim	per:cities_of_residence	saratoga
SF210	crown prosecution service	org:city_of_headquarters	london
SF208	kendra wilkinson	per:title	former playboy bunny
SF209	chelsea library	org:subsidiaries	friends of the library group
SF212	chad white	per:title	model
SF211	paul kim	per:origin	korean- american
SF210	crown prosecution service	org:country_of_headquarters	united kingdom
SF260	north phoenix baptist church	org:top_members/employees	dan yeary
SF228	professional rodeo cowboys association	org:stateorprovince_of_headquarters	colorado
SF229	new hampshire institute of politics	org:top_members/employees	dean spiliotes
SF218	madoff securities	org:founded	in 1960
SF222	ownit mortgage solutions	org:founded_by	william dallas
SF223	national union for the total independence of angola	org:alternate_names	union for the total independence of angola
SF220	nuclear supplier group	org:founded	1974
SF221	paralyzed veterans of america	org:subsidiaries	new england chapter of the paralyzed veterans of america
SF226	option one mortgage	org:parents	h&r block
SF239	myanmar timber enterprise	org:country_of_headquarters	myanmar
SF224	pennsylvania supreme court	org:top_members/employees	justice thomas saylor
SF225	old lane partners	org:parents	citigroup inc.
SF284	sean preston	per:alternate_names	sean preston federline
SF235	national beef packing co.	org:stateorprovince_of_headquarters	missouri
SF234	jackson hewitt	org:city_of_headquarters	parsippany
SF237	multidisciplinary association for psychedelic studies	org:stateorprovince_of_headquarters	california
SF236	national military family association	org:top_members/employees	joyce wessel raezer
SF231	lewis hamilton	per:cities_of_residence	stevenage
SF230	massachusetts house of representatives	org:subsidiaries	house committee on economic development
SF233	inter-american press association	org:city_of_headquarters	miami
SF232	institute for diversity and ethics in sport	org:stateorprovince_of_headquarters	florida
SF259	jewish national fund	org:alternate_names	keren kayemeth l'israel
SF270	bryan fuller	per:cities_of_residence	l.a .
SF204	chris ivery	per:spouse	ellen pompeo
SF272	adam senn	per:countries_of_residence	america
SF206	mark buse	per:employee_of	ups
SF207	charles wuorinen	per:title	composer
SF242	pentax corp.	org:parents	hoya corp.
SF243	new south wales rugby union	org:alternate_names	nswru
SF202	donald wildmon	per:cities_of_residence	tupelo
SF203	frankie delgado	per:title	celebrity
SF246	alexandra burke	per:origin	british
SF217	manila economic and cultural office	org:country_of_headquarters	taiwan
SF216	samsung	org:alternate_names	samsung group
SF215	babyshambles	org:top_members/employees	pete doherty
SF214	haifa university	org:alternate_names	haifa
SF209	chelsea library	org:subsidiaries	friends of the chelsea district library
SF267	julian bond	per:age	68
SF211	paul kim	per:origin	asian
SF210	crown prosecution service	org:country_of_headquarters	britain
SF260	north phoenix baptist church	org:top_members/employees	dan yeary
SF228	professional rodeo cowboys association	org:top_members/employees	troy ellerman
SF229	new hampshire institute of politics	org:top_members/employees	jennifer donahue
SF218	madoff securities	org:founded_by	bernard l. madoff
SF222	ownit mortgage solutions	org:number_of_employees/members	800
SF223	national union for the total independence of angola	org:alternate_names	unita
SF220	nuclear supplier group	org:members	australia
SF221	paralyzed veterans of america	org:subsidiaries	paralyzed veterans of america michigan chapter
SF226	option one mortgage	org:parents	h&r block inc.
SF239	myanmar timber enterprise	org:country_of_headquarters	myanmar
SF224	pennsylvania supreme court	org:top_members/employees	max baer
SF225	old lane partners	org:parents	citigroup inc
SF284	sean preston	per:alternate_names	sean preston federline
SF235	national beef packing co.	org:stateorprovince_of_headquarters	missouri
SF234	jackson hewitt	org:city_of_headquarters	parsippany
SF237	multidisciplinary association for psychedelic studies	org:stateorprovince_of_headquarters	california
SF236	national military family association	org:top_members/employees	joyce wessel raezer
SF231	lewis hamilton	per:cities_of_residence	stevenage
SF230	massachusetts house of representatives	org:subsidiaries	joint committee on the environment, natural resources, and agriculture,
SF233	inter-american press association	org:city_of_headquarters	miami
SF232	institute for diversity and ethics in sport	org:top_members/employees	richard lapchick
SF259	jewish national fund	org:alternate_names	jnf
SF270	bryan fuller	per:date_of_birth	july 27 , 1969
SF204	chris ivery	per:spouse	ellen pompeo
SF272	adam senn	per:employee_of	gucci
SF206	mark buse	per:employee_of	cablevision
SF207	charles wuorinen	per:title	composer
SF242	pentax corp.	org:parents	hoya corp.
SF243	new south wales rugby union	org:top_members/employees	fraser neill
SF202	donald wildmon	per:cities_of_residence	tupelo
SF203	frankie delgado	per:title	musician
SF246	alexandra burke	per:parents	melissa bell
SF217	manila economic and cultural office	org:country_of_headquarters	taiwan
SF216	samsung	org:alternate_names	samsung electronics co.
SF254	nottingham-spirk design associates	org:alternate_names	nottingham-spirk
SF214	haifa university	org:subsidiaries	centre for tourism, pilgrimage and recreation research
SF209	chelsea library	org:top_members/employees	bill harmer
SF267	julian bond	per:age	68
SF211	paul kim	per:stateorprovinces_of_residence	california
SF210	crown prosecution service	org:country_of_headquarters	england
SF214	haifa university	org:subsidiaries	centre for kibbutz studies
SF209	chelsea library	org:top_members/employees	bill harmer
SF267	julian bond	per:age	68
SF211	paul kim	per:stateorprovinces_of_residence	ca
SF210	crown prosecution service	org:country_of_headquarters	britain
SF228	professional rodeo cowboys association	org:top_members/employees	keith martin
SF229	new hampshire institute of politics	org:top_members/employees	jennifer donahue
SF218	madoff securities	org:stateorprovince_of_headquarters	new york
SF222	ownit mortgage solutions	org:number_of_employees/members	800
SF223	national union for the total independence of angola	org:alternate_names	uunita
SF220	nuclear supplier group	org:members	germany
SF221	paralyzed veterans of america	org:subsidiaries	southeastern chapter of the paralyzed veterans of america
SF226	option one mortgage	org:parents	h&r block
SF239	myanmar timber enterprise	org:country_of_headquarters	myanmar
SF224	pennsylvania supreme court	org:top_members/employees	j. michael eakin
SF225	old lane partners	org:parents	citigroup
SF284	sean preston	per:alternate_names	sean preston spears federline
SF235	national beef packing co.	org:stateorprovince_of_headquarters	mo.
SF234	jackson hewitt	org:city_of_headquarters	parsippany
SF237	multidisciplinary association for psychedelic studies	org:stateorprovince_of_headquarters	massachusetts
SF236	national military family association	org:website	www.nmfa.org
SF231	lewis hamilton	per:cities_of_residence	stevenage
SF230	massachusetts house of representatives	org:top_members/employees	edward j. markey
SF233	inter-american press association	org:city_of_headquarters	miami
SF232	institute for diversity and ethics in sport	org:top_members/employees	richard lapchick
SF259	jewish national fund	org:alternate_names	jnf
SF270	bryan fuller	per:employee_of	abc
SF204	chris ivery	per:title	record producer
SF272	adam senn	per:employee_of	gucci
SF206	mark buse	per:employee_of	exxonmobil
SF207	charles wuorinen	per:title	composer
SF242	pentax corp.	org:top_members/employees	fumio urano
SF243	new south wales rugby union	org:top_members/employees	jim l'estrange
SF202	donald wildmon	per:employee_of	american family association
SF203	frankie delgado	per:title	star
SF246	alexandra burke	per:parents	mellisa burke
SF217	manila economic and cultural office	org:country_of_headquarters	taiwan
SF216	samsung	org:alternate_names	samsung electronics co.
SF254	nottingham-spirk design associates	org:country_of_headquarters	america
SF214	haifa university	org:subsidiaries	institute for maritime studies
SF209	chelsea library	org:top_members/employees	joan elmouchi
SF267	julian bond	per:age	68
SF211	paul kim	per:title	senior manager
SF210	crown prosecution service	org:country_of_headquarters	britain
SF228	professional rodeo cowboys association	org:website	http://www.prorodeo.com
SF229	new hampshire institute of politics	org:top_members/employees	dean spiliotes
SF218	madoff securities	org:stateorprovince_of_headquarters	new york
SF222	ownit mortgage solutions	org:number_of_employees/members	800
SF223	national union for the total independence of angola	org:alternate_names	uniya
SF220	nuclear supplier group	org:members	china
SF221	paralyzed veterans of america	org:subsidiaries	florida gulf coast chapter of the paralyzed veterans of america
SF226	option one mortgage	org:parents	cerberus capital management lp
SF239	myanmar timber enterprise	org:country_of_headquarters	myanmar
SF224	pennsylvania supreme court	org:top_members/employees	justice max baer
SF225	old lane partners	org:parents	citigroup
SF284	sean preston	per:alternate_names	sean preston spears federline
SF235	national beef packing co.	org:stateorprovince_of_headquarters	missouri
SF234	jackson hewitt	org:founded	1982
SF237	multidisciplinary association for psychedelic studies	org:top_members/employees	rick doblin
SF280	paul sculfor	per:age	36
SF231	lewis hamilton	per:city_of_birth	stevenage
SF230	massachusetts house of representatives	org:top_members/employees	michael costello
SF233	inter-american press association	org:city_of_headquarters	miami
SF232	institute for diversity and ethics in sport	org:top_members/employees	richard lapchick
SF259	jewish national fund	org:alternate_names	jnf
SF270	bryan fuller	per:employee_of	fox
SF204	chris ivery	per:title	record producer
SF272	adam senn	per:employee_of	mtv
SF206	mark buse	per:origin	american
SF241	alice dellal	per:age	20
SF242	pentax corp.	org:top_members/employees	fumio urano
SF243	new south wales rugby union	org:top_members/employees	fraser neill
SF202	donald wildmon	per:employee_of	american family association
SF203	frankie delgado	per:title	producer
SF246	alexandra burke	per:title	singer
SF217	manila economic and cultural office	org:parents	philippines
SF216	samsung	org:founded_by	lee byung-chull
SF254	nottingham-spirk design associates	org:founded	1972
SF214	haifa university	org:subsidiaries	national security studies center
SF213	ontario human rights commission	org:alternate_names	ohrc
SF267	julian bond	per:children	phyllis bond-mcmillan
SF211	paul kim	per:title	pool maintenance technician
SF210	crown prosecution service	org:country_of_headquarters	uk
SF228	professional rodeo cowboys association	org:website	www.prorodeo.com
SF229	new hampshire institute of politics	org:top_members/employees	dean spiliotes
SF218	madoff securities	org:top_members/employees	bernard l madoff
SF222	ownit mortgage solutions	org:shareholders	merrill lynch
SF223	national union for the total independence of angola	org:city_of_headquarters	luanda
SF220	nuclear supplier group	org:members	japan
SF221	paralyzed veterans of america	org:top_members/employees	homer s. townsend jr.
SF226	option one mortgage	org:parents	h&amp;r block inc
SF289	jake pavelka	per:age	32-year-old
SF224	pennsylvania supreme court	org:top_members/employees	max baer
SF225	old lane partners	org:parents	citigroup
SF284	sean preston	per:alternate_names	sean preston federline
SF235	national beef packing co.	org:top_members/employees	tim klein
SF234	jackson hewitt	org:founded_by	john hewitt
SF237	multidisciplinary association for psychedelic studies	org:top_members/employees	rick doblin
SF280	paul sculfor	per:cities_of_residence	los angeles
SF231	lewis hamilton	per:city_of_birth	stevenage
SF230	massachusetts house of representatives	org:top_members/employees	william straus
SF233	inter-american press association	org:city_of_headquarters	miami
SF232	institute for diversity and ethics in sport	org:top_members/employees	richard e. lapchick
SF259	jewish national fund	org:alternate_names	jewish national fund ( jnf )
SF270	bryan fuller	per:employee_of	showtime
SF204	chris ivery	per:title	record producer
SF272	adam senn	per:employee_of	dolce & gabbana
SF206	mark buse	per:title	staff director
SF241	alice dellal	per:alternate_names	alice delal
SF242	pentax corp.	org:top_members/employees	fumio urano
SF243	new south wales rugby union	org:top_members/employees	fraser neill
SF202	donald wildmon	per:employee_of	american family association
SF245	susan boyle	per:age	forty seven
SF246	alexandra burke	per:title	singer
SF217	manila economic and cultural office	org:parents	philippine department of trade and industry
SF216	samsung	org:founded_by	lee byung-chull
SF254	nottingham-spirk design associates	org:top_members/employees	john nottingham
SF214	haifa university	org:subsidiaries	theater department
SF213	ontario human rights commission	org:alternate_names	ohrc
SF267	julian bond	per:cities_of_residence	atlanta
SF264	norris comprehensive cancer center	org:alternate_names	usc/norris cancer hospital
SF210	crown prosecution service	org:country_of_headquarters	britain
SF228	professional rodeo cowboys association	org:website	http://www.prorodeo.com
SF229	new hampshire institute of politics	org:top_members/employees	dean spiliotes
SF218	madoff securities	org:top_members/employees	peter madoff
SF222	ownit mortgage solutions	org:shareholders	jpmorgan chase
SF223	national union for the total independence of angola	org:city_of_headquarters	luanda
SF220	nuclear supplier group	org:members	bulgaria
SF221	paralyzed veterans of america	org:top_members/employees	john ring
SF226	option one mortgage	org:parents	h&amp;amp;r block inc.
SF289	jake pavelka	per:age	32
SF224	pennsylvania supreme court	org:website	http://www.courts.state.pa.us/
SF225	old lane partners	org:top_members/employees	vikram pandit
SF284	sean preston	per:alternate_names	christian michael
SF235	national beef packing co.	org:top_members/employees	tim klein
SF234	jackson hewitt	org:parents	cendant
SF237	multidisciplinary association for psychedelic studies	org:top_members/employees	igor grant
SF280	paul sculfor	per:countries_of_residence	england
SF231	lewis hamilton	per:city_of_birth	stevenage
SF230	massachusetts house of representatives	org:top_members/employees	a. pedone
SF233	inter-american press association	org:founded	the 1940s
SF232	institute for diversity and ethics in sport	org:top_members/employees	richard e. lapchick
SF259	jewish national fund	org:alternate_names	jnf
SF270	bryan fuller	per:employee_of	nbc
SF204	chris ivery	per:title	record producer
SF272	adam senn	per:origin	american
SF206	mark buse	per:title	aide
SF241	alice dellal	per:cities_of_residence	london
SF242	pentax corp.	org:top_members/employees	fumio urano
SF243	new south wales rugby union	org:top_members/employees	jim l'estrange
SF202	donald wildmon	per:employee_of	american_family_association
SF245	susan boyle	per:age	48
SF246	alexandra burke	per:title	songstress
SF217	manila economic and cultural office	org:top_members/employees	antonio basilio
SF216	samsung	org:founded_by	lee byung- chull
SF254	nottingham-spirk design associates	org:top_members/employees	john spirk
SF214	haifa university	org:subsidiaries	government and political theory department
SF213	ontario human rights commission	org:city_of_headquarters	toronto
SF267	julian bond	per:employee_of	american university
SF264	norris comprehensive cancer center	org:alternate_names	norris cancer center
SF210	crown prosecution service	org:country_of_headquarters	britain
SF261	new jerusalem foundation	org:founded_by	olmert
SF229	new hampshire institute of politics	org:top_members/employees	dean spiliotes
SF218	madoff securities	org:top_members/employees	peter madoff
SF222	ownit mortgage solutions	org:shareholders	civc partners
SF223	national union for the total independence of angola	org:country_of_headquarters	angola
SF220	nuclear supplier group	org:members	france
SF221	paralyzed veterans of america	org:top_members/employees	jim dudley
SF226	option one mortgage	org:parents	h&r block
SF289	jake pavelka	per:age	31
SF238	metro atlanta chamber of commerce	org:top_members/employees	sam williams
SF225	old lane partners	org:top_members/employees	vikram pandit
SF284	sean preston	per:alternate_names	sean preston federline spears
SF235	national beef packing co.	org:top_members/employees	tim klein
SF234	jackson hewitt	org:stateorprovince_of_headquarters	new jersey
SF237	multidisciplinary association for psychedelic studies	org:top_members/employees	richard doblin
SF280	paul sculfor	per:country_of_birth	great britain
SF231	lewis hamilton	per:countries_of_residence	great britain
SF230	massachusetts house of representatives	org:top_members/employees	eugene l. o'flaherty
SF233	inter-american press association	org:founded	the 1940s
SF232	institute for diversity and ethics in sport	org:top_members/employees	richard e. lapchick
SF259	jewish national fund	org:country_of_headquarters	state of israel
SF270	bryan fuller	per:employee_of	nbc
SF204	chris ivery	per:title	music executive producer
SF272	adam senn	per:title	model
SF206	mark buse	per:title	lobbyist
SF241	alice dellal	per:employee_of	mango
SF242	pentax corp.	org:top_members/employees	shinichiro mitsuhashi
SF252	project islamic hope	org:alternate_names	project islamic hope (helping oppressed people everywhere)
SF202	donald wildmon	per:employee_of	american family association
SF245	susan boyle	per:age	48
SF246	alexandra burke	per:title	artist
SF217	manila economic and cultural office	org:top_members/employees	antonio basilio
SF216	samsung	org:founded_by	lee byung- chull
SF254	nottingham-spirk design associates	org:website	http://www.ns-design.com/
SF214	haifa university	org:subsidiaries	school of political science
SF213	ontario human rights commission	org:country_of_headquarters	canada
SF267	julian bond	per:employee_of	university of virginia
SF264	norris comprehensive cancer center	org:parents	university of southern california
SF210	crown prosecution service	org:parents	england
SF261	new jerusalem foundation	org:founded_by	ehud olmert
SF229	new hampshire institute of politics	org:top_members/employees	paul manuel
SF218	madoff securities	org:top_members/employees	shana madoff
SF222	ownit mortgage solutions	org:stateorprovince_of_headquarters	calif.
SF223	national union for the total independence of angola	org:country_of_headquarters	angola
SF220	nuclear supplier group	org:members	switzerland
SF221	paralyzed veterans of america	org:top_members/employees	carl  blake
SF226	option one mortgage	org:shareholders	richard breeden
SF289	jake pavelka	per:age	31
SF238	metro atlanta chamber of commerce	org:top_members/employees	sam williams
SF225	old lane partners	org:top_members/employees	guru ramakrishnan
SF284	sean preston	per:cities_of_residence	malibu
SF235	national beef packing co.	org:top_members/employees	john r. miller
SF234	jackson hewitt	org:stateorprovince_of_headquarters	n.j.
SF237	multidisciplinary association for psychedelic studies	org:top_members/employees	rick doblin
SF280	paul sculfor	per:employee_of	new york model management
SF231	lewis hamilton	per:countries_of_residence	england
SF230	massachusetts house of representatives	org:top_members/employees	alice k. wolf
SF233	inter-american press association	org:founded	1940s
SF232	institute for diversity and ethics in sport	org:top_members/employees	richard lapchick
SF259	jewish national fund	org:country_of_headquarters	israel
SF270	bryan fuller	per:employee_of	abc
SF273	hector elizondo	per:date_of_birth	dec. 22
SF272	adam senn	per:title	owner
SF206	mark buse	per:title	staff director
SF241	alice dellal	per:employee_of	dame vivienne westwood
SF253	pamela martin &amp;amp; associates	org:city_of_headquarters	washington
SF252	project islamic hope	org:city_of_headquarters	los angeles
SF202	donald wildmon	per:employee_of	american family association
SF245	susan boyle	per:alternate_names	susan magdalane boyle
SF246	alexandra burke	per:title	artist
SF217	manila economic and cultural office	org:top_members/employees	antonio basilio
SF216	samsung	org:founded_by	lee byung-chul
SF268	raul castro	per:age	75
SF214	haifa university	org:subsidiaries	department of computer science
SF213	ontario human rights commission	org:country_of_headquarters	canada
SF267	julian bond	per:employee_of	university of virginia
SF264	norris comprehensive cancer center	org:parents	usc
SF210	crown prosecution service	org:subsidiaries	west and north yorkshire complex case unit
SF261	new jerusalem foundation	org:founded_by	olmert
SF229	new hampshire institute of politics	org:top_members/employees	paul manuel
SF218	madoff securities	org:top_members/employees	shana d. madoff
SF222	ownit mortgage solutions	org:stateorprovince_of_headquarters	calif.
SF223	national union for the total independence of angola	org:country_of_headquarters	angola
SF220	nuclear supplier group	org:members	new zealand
SF221	paralyzed veterans of america	org:top_members/employees	carl blake
SF226	option one mortgage	org:stateorprovince_of_headquarters	california
SF289	jake pavelka	per:alternate_names	that frigin idiot who picked vienna over tenley
SF238	metro atlanta chamber of commerce	org:top_members/employees	sam williams
SF225	old lane partners	org:top_members/employees	vikram pandit
SF284	sean preston	per:date_of_birth	september 2005
SF235	national beef packing co.	org:top_members/employees	john r. miller
SF234	jackson hewitt	org:stateorprovince_of_headquarters	n.j.
SF237	multidisciplinary association for psychedelic studies	org:top_members/employees	rick_doblin
SF280	paul sculfor	per:origin	british
SF231	lewis hamilton	per:countries_of_residence	uk
SF230	massachusetts house of representatives	org:top_members/employees	daniel e. bosley
SF233	inter-american press association	org:members	gonzalo marroquin
SF232	institute for diversity and ethics in sport	org:top_members/employees	richard lapchick
SF259	jewish national fund	org:country_of_headquarters	israel
SF270	bryan fuller	per:employee_of	abc
SF273	hector elizondo	per:date_of_birth	1936-12-22
SF272	adam senn	per:title	model
SF206	mark buse	per:title	lobbyist
SF241	alice dellal	per:other_family	suzy
SF253	pamela martin &amp;amp; associates	org:city_of_headquarters	washington d.c.
SF252	project islamic hope	org:founded_by	najee ali
SF202	donald wildmon	per:employee_of	american family association
SF245	susan boyle	per:cities_of_residence	blackburn
SF246	alexandra burke	per:title	vocalist
SF217	manila economic and cultural office	org:top_members/employees	tomas alcantara
SF216	samsung	org:subsidiaries	samsung japan
SF268	raul castro	per:age	76
SF214	haifa university	org:subsidiaries	center for brain and behavior research
SF213	ontario human rights commission	org:country_of_headquarters	canada
SF267	julian bond	per:employee_of	georgia house of representatives
SF264	norris comprehensive cancer center	org:parents	university of southern california
SF210	crown prosecution service	org:subsidiaries	counter terrorism division
SF214	haifa university	org:subsidiaries	jewish-arab center
SF213	ontario human rights commission	org:founded	1961
SF267	julian bond	per:employee_of	american university
SF264	norris comprehensive cancer center	org:subsidiaries	pigmented lesion clinic
SF210	crown prosecution service	org:subsidiaries	special crime division
SF229	new hampshire institute of politics	org:top_members/employees	paul manuel
SF269	ali fedotowsky	per:age	25
SF213	ontario human rights commission	org:stateorprovince_of_headquarters	ontario
SF267	julian bond	per:employee_of	university of virginia
SF264	norris comprehensive cancer center	org:top_members/employees	dr. david peng
SF210	crown prosecution service	org:top_members/employees	ken macdonald
SF229	new hampshire institute of politics	org:top_members/employees	paul christopher manuel
SF222	ownit mortgage solutions	org:stateorprovince_of_headquarters	california
SF223	national union for the total independence of angola	org:country_of_headquarters	angola
SF220	nuclear supplier group	org:members	russia
SF221	paralyzed veterans of america	org:top_members/employees	carl  blake
SF226	option one mortgage	org:stateorprovince_of_headquarters	calif.
SF289	jake pavelka	per:cities_of_residence	dallas
SF269	ali fedotowsky	per:age	25
SF213	ontario human rights commission	org:stateorprovince_of_headquarters	ontario
SF267	julian bond	per:employee_of	university of virginia
SF264	norris comprehensive cancer center	org:top_members/employees	david peng
SF210	crown prosecution service	org:top_members/employees	ken macdonald
SF229	new hampshire institute of politics	org:top_members/employees	paul christopher manuel
SF222	ownit mortgage solutions	org:stateorprovince_of_headquarters	california
SF223	national union for the total independence of angola	org:country_of_headquarters	angola
SF220	nuclear supplier group	org:members	norway
SF221	paralyzed veterans of america	org:website	http://www.pva.org/site/pageserver
SF226	option one mortgage	org:stateorprovince_of_headquarters	california
SF289	jake pavelka	per:cities_of_residence	dallas
SF225	old lane partners	org:top_members/employees	vikram pandit
SF284	sean preston	per:date_of_birth	september 2005
SF285	spencer pratt	per:age	24
SF234	jackson hewitt	org:stateorprovince_of_headquarters	n.j.
SF237	multidisciplinary association for psychedelic studies	org:top_members/employees	rick doblin
SF280	paul sculfor	per:origin	british
SF231	lewis hamilton	per:countries_of_residence	switzerland
SF230	massachusetts house of representatives	org:top_members/employees	james r. miceli
SF233	inter-american press association	org:number_of_employees/members	2,000
SF232	institute for diversity and ethics in sport	org:top_members/employees	richard lapchick
SF259	jewish national fund	org:country_of_headquarters	israel
SF270	bryan fuller	per:employee_of	abc
SF273	hector elizondo	per:date_of_birth	1936
SF294	kate gosselin	per:age	47
SF206	mark buse	per:title	chief of staff
SF241	alice dellal	per:other_family	jack dellal
SF253	pamela martin &amp;amp; associates	org:city_of_headquarters	washington, d.c.
SF252	project islamic hope	org:political/religious_affiliation	islamic
SF202	donald wildmon	per:employee_of	afa
SF245	susan boyle	per:city_of_birth	blackburn
SF246	alexandra burke	per:title	vocalist
SF217	manila economic and cultural office	org:top_members/employees	antonio basilio
SF216	samsung	org:subsidiaries	samsung semiconductor inc.
SF268	raul castro	per:age	76
SF269	ali fedotowsky	per:age	25
SF213	ontario human rights commission	org:top_members/employees	barbara hall
SF267	julian bond	per:employee_of	american university
SF269	ali fedotowsky	per:cities_of_residence	san francisco
SF213	ontario human rights commission	org:top_members/employees	barbara hall
SF267	julian bond	per:employee_of	university of virginia
SF210	crown prosecution service	org:top_members/employees	sir ken macdonald
SF229	new hampshire institute of politics	org:top_members/employees	paul manuel
SF222	ownit mortgage solutions	org:top_members/employees	william dallas
SF223	national union for the total independence of angola	org:country_of_headquarters	angola
SF220	nuclear supplier group	org:members	united states
SF269	ali fedotowsky	per:cities_of_residence	williamstown
SF213	ontario human rights commission	org:top_members/employees	barbara hall
SF267	julian bond	per:member_of	naacp
SF210	crown prosecution service	org:top_members/employees	ken macdonald
SF229	new hampshire institute of politics	org:top_members/employees	paul_manuel
SF222	ownit mortgage solutions	org:top_members/employees	dan rawitch
SF223	national union for the total independence of angola	org:country_of_headquarters	angola
SF220	nuclear supplier group	org:members	ireland
SF226	option one mortgage	org:stateorprovince_of_headquarters	california
SF289	jake pavelka	per:cities_of_residence	dallas
SF269	ali fedotowsky	per:city_of_birth	williamstown
SF213	ontario human rights commission	org:website	http://www.ohrc.on.ca/en/resources/ne
SF267	julian bond	per:member_of	national association for the advancement of colored people
SF210	crown prosecution service	org:top_members/employees	mohammad obeidat
SF229	new hampshire institute of politics	org:top_members/employees	paul manuel
SF222	ownit mortgage solutions	org:top_members/employees	william d. dallas
SF223	national union for the total independence of angola	org:founded_by	jonas savimbi
SF220	nuclear supplier group	org:members	austria
SF226	option one mortgage	org:top_members/employees	faith schwartz
SF289	jake pavelka	per:city_of_birth	denton
SF284	sean preston	per:date_of_birth	2005
SF285	spencer pratt	per:age	26
SF234	jackson hewitt	org:subsidiaries	so far inc.
SF237	multidisciplinary association for psychedelic studies	org:top_members/employees	rick doblin
SF280	paul sculfor	per:origin	british
SF231	lewis hamilton	per:countries_of_residence	switzerland
SF230	massachusetts house of representatives	org:top_members/employees	frank smizik
SF233	inter-american press association	org:subsidiaries	press freedom committee
SF298	carolyn maloney	per:age	59
SF259	jewish national fund	org:country_of_headquarters	israel
SF270	bryan fuller	per:employee_of	nbc
SF273	hector elizondo	per:employee_of	cbs
SF294	kate gosselin	per:alternate_names	k8
SF206	mark buse	per:title	staff director
SF241	alice dellal	per:parents	guy dellal
SF253	pamela martin &amp;amp; associates	org:country_of_headquarters	us
SF252	project islamic hope	org:political/religious_affiliation	islamic
SF202	donald wildmon	per:employee_of	american family association
SF245	susan boyle	per:countries_of_residence	scotland
SF257	independent steelworkers union	org:alternate_names	isu
SF217	manila economic and cultural office	org:top_members/employees	rodolfo sabulao
SF216	samsung	org:subsidiaries	thai samsung electronics co. ltd.
SF268	raul castro	per:age	76
SF269	ali fedotowsky	per:employee_of	abc
SF213	ontario human rights commission	org:website	http://www.ohrc.on.ca/en/resources/news/en/resources/news/statement
SF267	julian bond	per:member_of	national association for the advancement of colored people
SF210	crown prosecution service	org:top_members/employees	ken macdonald
SF229	new hampshire institute of politics	org:top_members/employees	paul manuel
SF222	ownit mortgage solutions	org:top_members/employees	william d. dallas
SF223	national union for the total independence of angola	org:top_members/employees	isaias samakvu
SF220	nuclear supplier group	org:members	netherlands
SF288	jamie spears	per:cities_of_residence	mccomb
SF289	jake pavelka	per:employee_of	abc
SF284	sean preston	per:other_family	lynne
SF285	spencer pratt	per:age	26
SF234	jackson hewitt	org:subsidiaries	ask tax
SF237	multidisciplinary association for psychedelic studies	org:top_members/employees	richard doblin
SF280	paul sculfor	per:origin	british
SF231	lewis hamilton	per:countries_of_residence	england
SF230	massachusetts house of representatives	org:top_members/employees	salvatore f. dimasi
SF233	inter-american press association	org:top_members/employees	rafael molina
SF298	carolyn maloney	per:age	60
SF259	jewish national fund	org:country_of_headquarters	israel
SF270	bryan fuller	per:schools_attended	university of southern california
SF273	hector elizondo	per:employee_of	cbs
SF294	kate gosselin	per:employee_of	tlc
SF206	mark buse	per:title	director
SF241	alice dellal	per:title	model
SF253	pamela martin &amp;amp; associates	org:country_of_headquarters	united states
SF252	project islamic hope	org:political/religious_affiliation	islam
SF202	donald wildmon	per:employee_of	afa
SF245	susan boyle	per:countries_of_residence	britain
SF257	independent steelworkers union	org:alternate_names	isu
SF217	manila economic and cultural office	org:top_members/employees	rodolfo sabulao
SF216	samsung	org:subsidiaries	samsung motors
SF268	raul castro	per:age	76
SF269	ali fedotowsky	per:employee_of	facebook
SF213	ontario human rights commission	org:website	http://www.ohrc.on.ca
SF267	julian bond	per:member_of	national association for the advancement of colored people
SF265	nitschmann middle school	org:city_of_headquarters	bethlehem
SF269	ali fedotowsky	per:employee_of	facebook
SF266	national red cross	org:alternate_names	american national red cross
SF267	julian bond	per:member_of	national association for the advancement of colored people
SF265	nitschmann middle school	org:city_of_headquarters	bethlehem
SF269	ali fedotowsky	per:stateorprovinces_of_residence	ma
SF266	national red cross	org:alternate_names	american red cross
SF267	julian bond	per:member_of	naacp
SF265	nitschmann middle school	org:city_of_headquarters	bethlehem
SF223	national union for the total independence of angola	org:top_members/employees	paulo lukamba
SF220	nuclear supplier group	org:number_of_employees/members	45
SF288	jamie spears	per:cities_of_residence	liberty
SF289	jake pavelka	per:employee_of	abc
SF284	sean preston	per:other_family	jamie spears
SF285	spencer pratt	per:age	26
SF234	jackson hewitt	org:subsidiaries	smart tax of georgia inc.
SF287	beyonce knowles	per:alternate_names	beyonce
SF280	paul sculfor	per:origin	british
SF231	lewis hamilton	per:countries_of_residence	england
SF230	massachusetts house of representatives	org:top_members/employees	john tierney
SF233	inter-american press association	org:top_members/employees	rafael molina
SF298	carolyn maloney	per:alternate_names	carolyn b. maloney
SF259	jewish national fund	org:country_of_headquarters	israel
SF270	bryan fuller	per:stateorprovinces_of_residence	washington
SF273	hector elizondo	per:employee_of	abc
SF294	kate gosselin	per:employee_of	tlc
SF206	mark buse	per:title	lobbyist
SF241	alice dellal	per:title	model
SF253	pamela martin &amp;amp; associates	org:dissolved	august 2006
SF252	project islamic hope	org:stateorprovince_of_headquarters	california
SF202	donald wildmon	per:employee_of	american family association
SF245	susan boyle	per:countries_of_residence	scotland
SF257	independent steelworkers union	org:alternate_names	isu
SF247	bernama	org:alternate_names	bernama news agency
SF216	samsung	org:subsidiaries	everland
SF268	raul castro	per:age	76
SF269	ali fedotowsky	per:stateorprovinces_of_residence	ca
SF266	national red cross	org:alternate_names	red cross
SF267	julian bond	per:member_of	naacp board
SF265	nitschmann middle school	org:city_of_headquarters	bethlehem
SF223	national union for the total independence of angola	org:top_members/employees	julao paulo
SF220	nuclear supplier group	org:number_of_employees/members	45
SF288	jamie spears	per:cities_of_residence	kentwood
SF289	jake pavelka	per:other_family	jessie pavelka
SF284	sean preston	per:other_family	allie
SF285	spencer pratt	per:age	26
SF234	jackson hewitt	org:top_members/employees	michael lister
SF287	beyonce knowles	per:alternate_names	beyonce giselle knowles
SF280	paul sculfor	per:origin	british
SF231	lewis hamilton	per:country_of_birth	great_britain
SF230	massachusetts house of representatives	org:top_members/employees	thomas p. conroy
SF233	inter-american press association	org:top_members/employees	rafael molina
SF298	carolyn maloney	per:cities_of_residence	manhattan
SF259	jewish national fund	org:dissolved	1953
SF270	bryan fuller	per:stateorprovinces_of_residence	wash.
SF273	hector elizondo	per:origin	hispanic-american
SF294	kate gosselin	per:spouse	jon gosselin
SF206	mark buse	per:title	chief of staff
SF274	simon cowell	per:age	47
SF253	pamela martin &amp;amp; associates	org:dissolved	2006
SF252	project islamic hope	org:stateorprovince_of_headquarters	california
SF202	donald wildmon	per:member_of	american family association
SF245	susan boyle	per:country_of_birth	scotland
SF257	independent steelworkers union	org:alternate_names	isu
SF247	bernama	org:alternate_names	malaysian national news agency
SF216	samsung	org:subsidiaries	samsung malaysia electronics
SF268	raul castro	per:age	77
SF269	ali fedotowsky	per:title	bachelorette
SF266	national red cross	org:alternate_names	arc
SF267	julian bond	per:member_of	national association for the advancement of colored people
SF265	nitschmann middle school	org:country_of_headquarters	united states of america
SF223	national union for the total independence of angola	org:top_members/employees	camalata numa
SF269	ali fedotowsky	per:title	advertising accounts manager
SF266	national red cross	org:alternate_names	arc
SF267	julian bond	per:member_of	naacp national board of directors
SF265	nitschmann middle school	org:number_of_employees/members	950
SF223	national union for the total independence of angola	org:top_members/employees	jonas savimbi
SF288	jamie spears	per:employee_of	nickelodeon
SF289	jake pavelka	per:parents	jim pavelka
SF284	sean preston	per:other_family	jamie lynn spears
SF285	spencer pratt	per:age	26
SF234	jackson hewitt	org:website	www.jacksonhewitt.com
SF287	beyonce knowles	per:alternate_names	beyonce
SF280	paul sculfor	per:title	model
SF231	lewis hamilton	per:country_of_birth	england
SF230	massachusetts house of representatives	org:top_members/employees	barbara a. l'italien
SF233	inter-american press association	org:top_members/employees	earl maucker
SF298	carolyn maloney	per:countries_of_residence	us
SF259	jewish national fund	org:founded	1901
SF270	bryan fuller	per:title	writer-producer
SF273	hector elizondo	per:title	actor
SF294	kate gosselin	per:stateorprovinces_of_residence	pennsylvania
SF240	national museum of women in the arts	org:alternate_names	nmwa
SF274	simon cowell	per:age	48
SF253	pamela martin &amp;amp; associates	org:founded	1993
SF252	project islamic hope	org:top_members/employees	najee ali
SF202	donald wildmon	per:member_of	american family association
SF245	susan boyle	per:date_of_birth	1961-04-01
SF257	independent steelworkers union	org:alternate_names	isu
SF247	bernama	org:country_of_headquarters	malaysia
SF216	samsung	org:subsidiaries	samsung heavy industries co.
SF268	raul castro	per:age	77
SF269	ali fedotowsky	per:title	advertising account manager
SF266	national red cross	org:country_of_headquarters	united states of america
SF267	julian bond	per:member_of	fairness for all families campaign
SF265	nitschmann middle school	org:parents	bethlehem area school district
SF223	national union for the total independence of angola	org:top_members/employees	daniel domingos
SF288	jamie spears	per:employee_of	nickelodeon
SF289	jake pavelka	per:parents	sallie pavelka
SF284	sean preston	per:other_family	alli sims
SF285	spencer pratt	per:age	26
SF286	ezra levant	per:charges	libel
SF287	beyonce knowles	per:alternate_names	beyonce
SF280	paul sculfor	per:title	model
SF231	lewis hamilton	per:country_of_birth	england
SF230	massachusetts house of representatives	org:top_members/employees	bradley h. jones jr.
SF233	inter-american press association	org:top_members/employees	earl maucker
SF298	carolyn maloney	per:countries_of_residence	united states
SF259	jewish national fund	org:founded	1901
SF270	bryan fuller	per:title	writer-producer
SF273	hector elizondo	per:title	actor
SF266	national red cross	org:founded_by	clara barton
SF267	julian bond	per:member_of	naacp
SF265	nitschmann middle school	org:stateorprovince_of_headquarters	pennsylvania
SF223	national union for the total independence of angola	org:top_members/employees	jonas savimbi
SF288	jamie spears	per:origin	american
SF289	jake pavelka	per:parents	jim pavelka
SF284	sean preston	per:other_family	chanda mcgovern
SF285	spencer pratt	per:alternate_names	speidi
SF286	ezra levant	per:employee_of	western standard
SF287	beyonce knowles	per:alternate_names	beyonce
SF280	paul sculfor	per:title	model
SF231	lewis hamilton	per:country_of_birth	england
SF230	massachusetts house of representatives	org:top_members/employees	salvatore dimasi
SF233	inter-american press association	org:top_members/employees	julio munoz
SF298	carolyn maloney	per:employee_of	us
SF259	jewish national fund	org:founded	1901
SF270	bryan fuller	per:title	creator
SF295	ali larijani	per:age	48
SF240	national museum of women in the arts	org:alternate_names	women's museum
SF274	simon cowell	per:age	47
SF253	pamela martin &amp;amp; associates	org:founded	1993
SF252	project islamic hope	org:top_members/employees	najee ali
SF202	donald wildmon	per:member_of	american_family_association
SF245	susan boyle	per:date_of_birth	1 april 1961
SF257	independent steelworkers union	org:city_of_headquarters	weirton
SF247	bernama	org:country_of_headquarters	malaysia
SF216	samsung	org:top_members/employees	jay y. lee
SF268	raul castro	per:age	77
SF266	national red cross	org:founded_by	clara barton
SF267	julian bond	per:schools_attended	morehouse college
SF265	nitschmann middle school	org:stateorprovince_of_headquarters	pennsylvania
SF223	national union for the total independence of angola	org:top_members/employees	joseph savimbi
SF288	jamie spears	per:parents	lynne spears
SF289	jake pavelka	per:parents	sallie pavelka
SF284	sean preston	per:other_family	ali sims
SF285	spencer pratt	per:cities_of_residence	los angeles
SF286	ezra levant	per:employee_of	western standard
SF287	beyonce knowles	per:alternate_names	beyonce
SF280	paul sculfor	per:title	male model
SF231	lewis hamilton	per:country_of_birth	britain
SF230	massachusetts house of representatives	org:top_members/employees	tom finneran
SF233	inter-american press association	org:top_members/employees	julio munoz
SF298	carolyn maloney	per:employee_of	united states
SF259	jewish national fund	org:political/religious_affiliation	jewish
SF270	bryan fuller	per:title	executive producer
SF295	ali larijani	per:age	48
SF240	national museum of women in the arts	org:city_of_headquarters	washington
SF274	simon cowell	per:alternate_names	simon
SF253	pamela martin &amp;amp; associates	org:number_of_employees/members	132
SF252	project islamic hope	org:top_members/employees	najee ali
SF202	donald wildmon	per:member_of	american family association
SF245	susan boyle	per:employee_of	western college of lothian
SF257	independent steelworkers union	org:city_of_headquarters	weirton
SF247	bernama	org:country_of_headquarters	malaysia
SF216	samsung	org:top_members/employees	sang wan lee
SF268	raul castro	per:age	77
SF266	national red cross	org:number_of_employees/members	33,000
SF267	julian bond	per:stateorprovinces_of_residence	georgia
SF265	nitschmann middle school	org:stateorprovince_of_headquarters	pennsylvania
SF223	national union for the total independence of angola	org:top_members/employees	isaias samakuva
SF288	jamie spears	per:parents	lynne spears
SF289	jake pavelka	per:stateorprovince_of_birth	texas
SF284	sean preston	per:parents	britney spears
SF285	spencer pratt	per:employee_of	hills
SF286	ezra levant	per:employee_of	western standard magazine
SF287	beyonce knowles	per:alternate_names	beyonce
SF280	paul sculfor	per:title	boxer
SF231	lewis hamilton	per:date_of_birth	1985-01-07
SF230	massachusetts house of representatives	org:top_members/employees	charles flaherty
SF233	inter-american press association	org:top_members/employees	julio munoz
SF298	carolyn maloney	per:member_of	us congress
SF259	jewish national fund	org:political/religious_affiliation	jewish
SF270	bryan fuller	per:title	creator
SF295	ali larijani	per:age	49
SF240	national museum of women in the arts	org:founded	1981
SF274	simon cowell	per:alternate_names	simon
SF253	pamela martin &amp;amp; associates	org:number_of_employees/members	132
SF252	project islamic hope	org:top_members/employees	najee ali
SF202	donald wildmon	per:member_of	afa
SF245	susan boyle	per:origin	scottish
SF257	independent steelworkers union	org:city_of_headquarters	weirton
SF247	bernama	org:country_of_headquarters	malaysia
SF216	samsung	org:top_members/employees	shung-hyun cho
SF268	raul castro	per:age	76
SF266	national red cross	org:number_of_employees/members	30,000
SF267	julian bond	per:stateorprovinces_of_residence	georgia
SF265	nitschmann middle school	org:top_members/employees	john acerra
SF223	national union for the total independence of angola	org:top_members/employees	isaias samakuva
SF288	jamie spears	per:parents	lynne spears
SF289	jake pavelka	per:stateorprovince_of_birth	texas
SF284	sean preston	per:parents	kevin federline
SF285	spencer pratt	per:employee_of	mtv
SF286	ezra levant	per:origin	canadian
SF287	beyonce knowles	per:alternate_names	beyonce
SF280	paul sculfor	per:title	construction worker
SF231	lewis hamilton	per:employee_of	mclaren
SF230	massachusetts house of representatives	org:top_members/employees	robert a. deleo
SF233	inter-american press association	org:top_members/employees	earl maucker
SF298	carolyn maloney	per:member_of	democratic party
SF259	jewish national fund	org:political/religious_affiliation	jewish
SF270	bryan fuller	per:title	co-executive producer
SF295	ali larijani	per:age	47
SF240	national museum of women in the arts	org:founded_by	wilhelmina cole holladay
SF274	simon cowell	per:cities_of_residence	london
SF253	pamela martin &amp;amp; associates	org:stateorprovince_of_headquarters	washington
SF252	project islamic hope	org:top_members/employees	najee ali
SF202	donald wildmon	per:member_of	afa
SF245	susan boyle	per:origin	uk
SF257	independent steelworkers union	org:city_of_headquarters	weirton
SF247	bernama	org:country_of_headquarters	malaysia
SF216	samsung	org:top_members/employees	hwang chang-gyu
SF268	raul castro	per:alternate_names	raul castro ruz.
SF266	national red cross	org:subsidiaries	american red cross of greater new york
SF267	julian bond	per:title	chairman
SF265	nitschmann middle school	org:top_members/employees	john acerra
SF223	national union for the total independence of angola	org:top_members/employees	abilio kamalata numa
SF288	jamie spears	per:parents	lynne
SF289	jake pavelka	per:stateorprovinces_of_residence	texas
SF284	sean preston	per:parents	britney spears
SF285	spencer pratt	per:employee_of	mtv
SF286	ezra levant	per:stateorprovinces_of_residence	alberta
SF287	beyonce knowles	per:alternate_names	beyonce
SF280	paul sculfor	per:title	model
SF231	lewis hamilton	per:employee_of	mclaren
SF230	massachusetts house of representatives	org:top_members/employees	richard a. voke
SF233	inter-american press association	org:top_members/employees	earl maucker
SF298	carolyn maloney	per:member_of	house
SF259	jewish national fund	org:political/religious_affiliation	jewish
SF270	bryan fuller	per:title	executive producer
SF295	ali larijani	per:cities_of_residence	najaf
SF240	national museum of women in the arts	org:founded_by	wilhelmina cole holladay
SF274	simon cowell	per:cities_of_residence	london
SF253	pamela martin &amp;amp; associates	org:top_members/employees	deborah jeane palfrey
SF252	project islamic hope	org:top_members/employees	najee ali
SF202	donald wildmon	per:member_of	american family association
SF245	susan boyle	per:origin	scottish
SF257	independent steelworkers union	org:country_of_headquarters	u.s.
SF247	bernama	org:country_of_headquarters	malaysia
SF216	samsung	org:top_members/employees	lee hak-soo
SF268	raul castro	per:alternate_names	raul castro ruz
SF266	national red cross	org:subsidiaries	american red cross of greater indianapolis
SF267	julian bond	per:title	legislator
SF265	nitschmann middle school	org:top_members/employees	john acerra
SF223	national union for the total independence of angola	org:top_members/employees	isaias samakuva
SF288	jamie spears	per:parents	lynne spears
SF289	jake pavelka	per:stateorprovinces_of_residence	texas
SF284	sean preston	per:parents	spears
SF285	spencer pratt	per:employee_of	mtv
SF286	ezra levant	per:title	journalist
SF287	beyonce knowles	per:alternate_names	beyonce
SF266	national red cross	org:subsidiaries	american red cross of frederick county
SF267	julian bond	per:title	chairman
SF265	nitschmann middle school	org:top_members/employees	john_acerra
SF223	national union for the total independence of angola	org:top_members/employees	alda sachiambo
SF288	jamie spears	per:parents	lynne spears
SF289	jake pavelka	per:stateorprovinces_of_residence	texas
SF284	sean preston	per:parents	kevin federline
SF285	spencer pratt	per:other_family	ava
SF286	ezra levant	per:title	author
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:employee_of	mclaren-mercedes
SF230	massachusetts house of representatives	org:top_members/employees	steve walsh
SF233	inter-american press association	org:top_members/employees	earl maucker
SF298	carolyn maloney	per:member_of	house financial services committee
SF259	jewish national fund	org:stateorprovince_of_headquarters	israel
SF270	bryan fuller	per:title	producer
SF295	ali larijani	per:city_of_birth	najaf
SF240	national museum of women in the arts	org:stateorprovince_of_headquarters	washington
SF274	simon cowell	per:country_of_birth	united_kingdom
SF253	pamela martin &amp;amp; associates	org:top_members/employees	deborah jeane palfrey
SF252	project islamic hope	org:top_members/employees	najee ali
SF202	donald wildmon	per:religion	methodist
SF245	susan boyle	per:origin	scottish
SF257	independent steelworkers union	org:country_of_headquarters	u.s.
SF247	bernama	org:founded	1968-05-26
SF216	samsung	org:top_members/employees	lee jae-yong
SF268	raul castro	per:alternate_names	flea
SF266	national red cross	org:subsidiaries	american red cross of greater miami & the keys
SF267	julian bond	per:title	activist
SF266	national red cross	org:subsidiaries	american red cross of ventura county
SF267	julian bond	per:title	chairman
SF223	national union for the total independence of angola	org:top_members/employees	isaias samakuva
SF288	jamie spears	per:schools_attended	parklane academy
SF289	jake pavelka	per:title	bachelor
SF284	sean preston	per:parents	britney spears
SF285	spencer pratt	per:other_family	stephanie pratt
SF286	ezra levant	per:title	publisher: western standard
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:employee_of	mclaren mercedes-benz
SF230	massachusetts house of representatives	org:top_members/employees	robert fennell
SF233	inter-american press association	org:website	http://www.sipiapa.com/default.cfm
SF298	carolyn maloney	per:member_of	congress
SF259	jewish national fund	org:subsidiaries	american arm of the jewish national fund
SF270	bryan fuller	per:title	creator/producer
SF295	ali larijani	per:city_of_birth	najaf
SF240	national museum of women in the arts	org:subsidiaries	database of women artists
SF274	simon cowell	per:country_of_birth	united kingdom
SF253	pamela martin &amp;amp; associates	org:top_members/employees	deborah jeane palfrey
SF252	project islamic hope	org:website	www.islamichope.org
SF202	donald wildmon	per:religion	christian
SF245	susan boyle	per:origin	irish
SF257	independent steelworkers union	org:country_of_headquarters	u.s.
SF247	bernama	org:founded	1968
SF216	samsung	org:top_members/employees	kim in-joo
SF268	raul castro	per:charges	insurrection
SF266	national red cross	org:subsidiaries	metropolitan atlanta chapter
SF267	julian bond	per:title	professor
SF223	national union for the total independence of angola	org:top_members/employees	jonas savimbi
SF288	jamie spears	per:siblings	britney spears
SF289	jake pavelka	per:title	pilot
SF284	sean preston	per:parents	kevin federline
SF285	spencer pratt	per:other_family	holly montag
SF286	ezra levant	per:title	publisher
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:employee_of	mclaren mercedes-benz
SF230	massachusetts house of representatives	org:top_members/employees	ellen story
SF233	inter-american press association	org:website	www.sipiapa.com
SF298	carolyn maloney	per:member_of	congress
SF259	jewish national fund	org:subsidiaries	jewish national fund-u.s.
SF270	bryan fuller	per:title	writer
SF295	ali larijani	per:country_of_birth	iraq
SF240	national museum of women in the arts	org:subsidiaries	library and research center
SF274	simon cowell	per:date_of_birth	1959-10-07
SF253	pamela martin &amp;amp; associates	org:top_members/employees	deborah jeane palfrey
SF276	richard lindzen	per:alternate_names	richard s. lindzen
SF202	donald wildmon	per:religion	christian
SF245	susan boyle	per:religion	catholic
SF257	independent steelworkers union	org:dissolved	2007-04-13
SF247	bernama	org:parents	malaysian government
SF216	samsung	org:top_members/employees	lee hak-soo
SF268	raul castro	per:children	mariela
SF266	national red cross	org:subsidiaries	american red cross of greater los angeles
SF267	julian bond	per:title	chairman
SF223	national union for the total independence of angola	org:top_members/employees	jonas savimbi
SF288	jamie spears	per:siblings	britney spears
SF289	jake pavelka	per:title	commercial flight instructor
SF284	sean preston	per:parents	kevin federline
SF285	spencer pratt	per:other_family	holly
SF286	ezra levant	per:title	commentator
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:employee_of	mclaren-mercedes
SF230	massachusetts house of representatives	org:top_members/employees	robert a. deleo
SF233	inter-american press association	org:website	http://www.sipiapa.com
SF298	carolyn maloney	per:member_of	house financial services committee
SF259	jewish national fund	org:top_members/employees	mike nitzan
SF270	bryan fuller	per:title	writer
SF295	ali larijani	per:country_of_birth	iraq
SF240	national museum of women in the arts	org:top_members/employees	judy l. larson
SF274	simon cowell	per:employee_of	sony bmg
SF253	pamela martin &amp;amp; associates	org:top_members/employees	deborah jeane palfrey
SF276	richard lindzen	per:alternate_names	richard s. lindzen
SF202	donald wildmon	per:religion	methodist
SF245	susan boyle	per:religion	catholic
SF257	independent steelworkers union	org:founded	1951
SF247	bernama	org:subsidiaries	radio24
SF216	samsung	org:top_members/employees	lee byung-chull
SF268	raul castro	per:children	mariela castro
SF266	national red cross	org:subsidiaries	mile high chapter
SF267	julian bond	per:title	legislator
SF223	national union for the total independence of angola	org:top_members/employees	jonas savimbi
SF288	jamie spears	per:siblings	britney spears
SF289	jake pavelka	per:title	actor
SF284	sean preston	per:parents	brit brit
SF285	spencer pratt	per:other_family	holly montag
SF266	national red cross	org:subsidiaries	galveston chapter
SF267	julian bond	per:title	activist
SF223	national union for the total independence of angola	org:top_members/employees	isaias samakuva
SF288	jamie spears	per:siblings	bryan
SF289	jake pavelka	per:title	commercial pilot
SF284	sean preston	per:siblings	jayden james
SF285	spencer pratt	per:schools_attended	university of southern california
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:employee_of	mclaren
SF230	massachusetts house of representatives	org:top_members/employees	salvatore f. dimasi
SF283	michael sandy	per:age	28
SF298	carolyn maloney	per:member_of	house financial services committee
SF259	jewish national fund	org:top_members/employees	ronald s. lauder
SF270	bryan fuller	per:title	series creator
SF295	ali larijani	per:date_of_birth	1958
SF240	national museum of women in the arts	org:top_members/employees	judy larson
SF274	simon cowell	per:employee_of	american idol
SF253	pamela martin &amp;amp; associates	org:website	http://www.deborahjeanepalfrey.com
SF276	richard lindzen	per:employee_of	massachusetts institute of technology
SF202	donald wildmon	per:stateorprovinces_of_residence	mississippi
SF245	susan boyle	per:stateorprovince_of_birth	scotland
SF257	independent steelworkers union	org:number_of_employees/members	1,250
SF247	bernama	org:subsidiaries	bernama tv
SF216	samsung	org:top_members/employees	lee hak-soo
SF268	raul castro	per:children	nilsa
SF266	national red cross	org:top_members/employees	jacob kellenberger
SF267	julian bond	per:title	chairman
SF223	national union for the total independence of angola	org:top_members/employees	isaias samakuva
SF288	jamie spears	per:siblings	britney spears
SF289	jake pavelka	per:title	pilot
SF284	sean preston	per:siblings	jamie lynn spears
SF285	spencer pratt	per:siblings	stephanie pratt
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:employee_of	mclaren mercedes
SF230	massachusetts house of representatives	org:website	housetv.hou.state.ma.us
SF283	michael sandy	per:age	29
SF298	carolyn maloney	per:member_of	house of representatives
SF259	jewish national fund	org:top_members/employees	eitan bronstein
SF270	bryan fuller	per:title	series creator
SF295	ali larijani	per:employee_of	iran
SF240	national museum of women in the arts	org:top_members/employees	susan sterling
SF274	simon cowell	per:employee_of	american idol
SF277	kelly cutrone	per:age	44
SF276	richard lindzen	per:employee_of	mit
SF202	donald wildmon	per:stateorprovinces_of_residence	mississippi
SF245	susan boyle	per:stateorprovince_of_birth	scotland
SF257	independent steelworkers union	org:number_of_employees/members	1,250
SF247	bernama	org:top_members/employees	azman ujang
SF216	samsung	org:top_members/employees	lee yoon-woo
SF268	raul castro	per:children	mariela
SF266	national red cross	org:top_members/employees	mark everson
SF267	julian bond	per:title	chairman
SF223	national union for the total independence of angola	org:top_members/employees	isaias samakuva
SF288	jamie spears	per:siblings	britney
SF289	jake pavelka	per:title	bachelor star
SF284	sean preston	per:siblings	sutton pierce
SF285	spencer pratt	per:siblings	stephanie pratt
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:employee_of	mclaren
SF249	northwood university	org:city_of_headquarters	west palm beach
SF283	michael sandy	per:age	29
SF298	carolyn maloney	per:member_of	house financial institutions subcommittee
SF259	jewish national fund	org:top_members/employees	effi stenzler
SF270	bryan fuller	per:title	writer
SF295	ali larijani	per:employee_of	iran
SF240	national museum of women in the arts	org:top_members/employees	susan fisher sterling
SF274	simon cowell	per:employee_of	syco music
SF277	kelly cutrone	per:age	44
SF276	richard lindzen	per:employee_of	massachusetts institute of technology
SF202	donald wildmon	per:stateorprovinces_of_residence	mississippi
SF245	susan boyle	per:stateorprovince_of_birth	west lothian
SF257	independent steelworkers union	org:number_of_employees/members	1,250
SF247	bernama	org:top_members/employees	yong soo heong
SF216	samsung	org:top_members/employees	yoon-woo lee
SF268	raul castro	per:children	mariela castro espin
SF266	national red cross	org:top_members/employees	mark everson
SF267	julian bond	per:title	chairman
SF223	national union for the total independence of angola	org:top_members/employees	isaias samakuva
SF288	jamie spears	per:siblings	britney spears
SF289	jake pavelka	per:title	commercial pilot
SF284	sean preston	per:siblings	sutton pierce
SF285	spencer pratt	per:siblings	stephanie
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:employee_of	mclaren mercedes
SF249	northwood university	org:city_of_headquarters	west palm beach
SF283	michael sandy	per:age	29
SF298	carolyn maloney	per:member_of	joint economic committee
SF271	chris dodd	per:alternate_names	christopher j. dodd
SF270	bryan fuller	per:title	screenwriter
SF295	ali larijani	per:employee_of	iran
SF240	national museum of women in the arts	org:website	www.nmwa.org
SF274	simon cowell	per:employee_of	syco music
SF277	kelly cutrone	per:age	44
SF276	richard lindzen	per:employee_of	mit
SF202	donald wildmon	per:title	reverend
SF245	susan boyle	per:stateorprovinces_of_residence	scotland
SF257	independent steelworkers union	org:stateorprovince_of_headquarters	west virginia
SF247	bernama	org:top_members/employees	syed jamil syed jaafar
SF216	samsung	org:top_members/employees	yun jong-yong
SF268	raul castro	per:children	alejandro castro espin
SF266	national red cross	org:top_members/employees	mary s. elcano
SF267	julian bond	per:title	chairman
SF266	national red cross	org:top_members/employees	joseph becker
SF266	national red cross	org:top_members/employees	joseph becker
SF288	jamie spears	per:siblings	bryan
SF266	national red cross	org:top_members/employees	bonnie mcelveen-hunter
SF288	jamie spears	per:stateorprovinces_of_residence	mississippi
SF284	sean preston	per:siblings	sutton pierce federline
SF285	spencer pratt	per:siblings	stephanie pratt
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:member_of	formula one
SF249	northwood university	org:city_of_headquarters	midland
SF283	michael sandy	per:age	29
SF298	carolyn maloney	per:member_of	joint economic committee
SF271	chris dodd	per:alternate_names	christopher j. dodd
SF270	bryan fuller	per:title	writer
SF295	ali larijani	per:employee_of	iran
SF240	national museum of women in the arts	org:website	www.nmwa.org
SF274	simon cowell	per:employee_of	fox
SF277	kelly cutrone	per:alternate_names	scary boss lady
SF276	richard lindzen	per:employee_of	massachusetts institute of technology
SF202	donald wildmon	per:title	chairman
SF245	susan boyle	per:stateorprovinces_of_residence	scotland
SF257	independent steelworkers union	org:stateorprovince_of_headquarters	west virginia
SF247	bernama	org:top_members/employees	azman ujang
SF216	samsung	org:top_members/employees	lee hak-soo
SF268	raul castro	per:children	mariela castro
SF266	national red cross	org:top_members/employees	bonnie mcelveen-hunter
SF288	jamie spears	per:stateorprovinces_of_residence	missouri
SF284	sean preston	per:siblings	sutton pierce federline
SF285	spencer pratt	per:siblings	stephanie pratt
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:member_of	international motoring federation
SF249	northwood university	org:city_of_headquarters	midland
SF283	michael sandy	per:alternate_names	michael j. sandy
SF298	carolyn maloney	per:member_of	democrat party
SF271	chris dodd	per:alternate_names	christopher j. dodd
SF270	bryan fuller	per:title	executive producer
SF295	ali larijani	per:employee_of	islamic consultative assembly
SF275	olivia palermo	per:age	20
SF274	simon cowell	per:employee_of	fox
SF277	kelly cutrone	per:children	ava
SF276	richard lindzen	per:employee_of	mit
SF202	donald wildmon	per:title	executive director
SF245	susan boyle	per:title	cook-trainee
SF257	independent steelworkers union	org:stateorprovince_of_headquarters	west virginia
SF247	bernama	org:top_members/employees	mohd annuar zaini
SF216	samsung	org:top_members/employees	roh moo-hyun
SF268	raul castro	per:children	mariela
SF266	national red cross	org:top_members/employees	bonnie mcelveen-hunter
SF288	jamie spears	per:stateorprovinces_of_residence	mississippi
SF284	sean preston	per:siblings	jayden james federline spears
SF285	spencer pratt	per:siblings	stephanie pratt
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:member_of	fia
SF249	northwood university	org:founded_by	dr. arthur e. turner
SF283	michael sandy	per:alternate_names	michael j. sandy
SF298	carolyn maloney	per:member_of	u.s. house
SF271	chris dodd	per:employee_of	us
SF270	bryan fuller	per:title	executive producer
SF295	ali larijani	per:member_of	supreme council for national security
SF275	olivia palermo	per:age	23
SF274	simon cowell	per:origin	british
SF277	kelly cutrone	per:children	ava
SF276	richard lindzen	per:member_of	national academy of sciences
SF202	donald wildmon	per:title	executive director
SF250	national center for disaster preparedness	org:alternate_names	columbia university 's national center for disaster preparedness
SF257	independent steelworkers union	org:stateorprovince_of_headquarters	west virginia
SF247	bernama	org:top_members/employees	mohd annuar zaini
SF216	samsung	org:top_members/employees	roh moo-hyun
SF268	raul castro	per:children	mariela castro
SF266	national red cross	org:top_members/employees	gail mcgovern
SF288	jamie spears	per:stateorprovinces_of_residence	la
SF284	sean preston	per:siblings	jayden james
SF285	spencer pratt	per:siblings	stephanie
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:member_of	formula one
SF249	northwood university	org:stateorprovince_of_headquarters	florida
SF283	michael sandy	per:cause_of_death	chased into the path of a moving car
SF298	carolyn maloney	per:origin	american
SF271	chris dodd	per:employee_of	u.s.
SF270	bryan fuller	per:title	writer
SF295	ali larijani	per:member_of	society of islamic coalition
SF275	olivia palermo	per:cities_of_residence	new york
SF274	simon cowell	per:origin	british
SF277	kelly cutrone	per:cities_of_residence	l.a.
SF276	richard lindzen	per:member_of	norwegian academy of science and letters
SF202	donald wildmon	per:title	chairman
SF250	national center for disaster preparedness	org:parents	columbia university
SF257	independent steelworkers union	org:top_members/employees	mark glyptis
SF247	bernama	org:website	http://www.bernama.com
SF216	samsung	org:top_members/employees	roh moo-hyun
SF268	raul castro	per:countries_of_residence	cuba
SF266	national red cross	org:top_members/employees	marsha j. evans
SF288	jamie spears	per:title	actress
SF284	sean preston	per:siblings	jj
SF285	spencer pratt	per:siblings	stephanie pratt
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:member_of	formula one
SF249	northwood university	org:stateorprovince_of_headquarters	florida
SF283	michael sandy	per:cause_of_death	murder
SF298	carolyn maloney	per:origin	american
SF271	chris dodd	per:employee_of	united states
SF296	robert morgenthau	per:age	88
SF295	ali larijani	per:member_of	supreme national security council
SF275	olivia palermo	per:cities_of_residence	brooklyn
SF274	simon cowell	per:origin	british
SF277	kelly cutrone	per:cities_of_residence	new york city
SF276	richard lindzen	per:member_of	national academy of sciences
SF202	donald wildmon	per:title	president
SF250	national center for disaster preparedness	org:parents	columbia university 's mailman school of public health
SF257	independent steelworkers union	org:top_members/employees	mark glyptis
SF247	bernama	org:website	http://www.bernama.com
SF216	samsung	org:top_members/employees	lee hak-soo
SF268	raul castro	per:countries_of_residence	cuba
SF266	national red cross	org:top_members/employees	mark w. everson
SF288	jamie spears	per:title	star
SF284	sean preston	per:stateorprovinces_of_residence	ca
SF285	spencer pratt	per:siblings	stephanie pratt
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:member_of	monaco_grand_prix
SF249	northwood university	org:subsidiaries	the seahawks
SF283	michael sandy	per:cause_of_death	struck by a car
SF298	carolyn maloney	per:stateorprovinces_of_residence	new york
SF271	chris dodd	per:member_of	senate
SF296	robert morgenthau	per:alternate_names	robert m. morgenthau
SF295	ali larijani	per:member_of	supreme national security council
SF275	olivia palermo	per:cities_of_residence	new york city
SF274	simon cowell	per:origin	british
SF277	kelly cutrone	per:cities_of_residence	syracuse
SF276	richard lindzen	per:member_of	american academy of arts and sciences
SF202	donald wildmon	per:title	rev.
SF250	national center for disaster preparedness	org:parents	columbia university
SF257	independent steelworkers union	org:top_members/employees	mark glyptis
SF247	bernama	org:website	http://www.bernama.com/
SF216	samsung	org:top_members/employees	yoon-woo lee
SF268	raul castro	per:countries_of_residence	cuba
SF266	national red cross	org:top_members/employees	mark w. everson
SF288	jamie spears	per:title	star
SF266	national red cross	org:top_members/employees	bonnie mcelveen-hunter
SF288	jamie spears	per:title	actress
SF285	spencer pratt	per:spouse	heidi montag
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:origin	british
SF249	northwood university	org:founded	1959
SF283	michael sandy	per:cities_of_residence	new york
SF298	carolyn maloney	per:stateorprovinces_of_residence	new york
SF271	chris dodd	per:member_of	senate banking committee
SF296	robert morgenthau	per:alternate_names	robert m. morgenthau
SF295	ali larijani	per:member_of	supreme national security council
SF275	olivia palermo	per:cities_of_residence	new york
SF274	simon cowell	per:origin	british
SF277	kelly cutrone	per:cities_of_residence	new york city
SF276	richard lindzen	per:member_of	ams
SF202	donald wildmon	per:title	chairman
SF250	national center for disaster preparedness	org:parents	columbia university's mailman school of public health
SF257	independent steelworkers union	org:top_members/employees	mark glyptis
SF256	illinois tool works	org:alternate_names	itw
SF216	samsung	org:top_members/employees	lee hak-soo
SF268	raul castro	per:countries_of_residence	cuba
SF266	national red cross	org:top_members/employees	mark w. everson
SF288	jamie spears	per:title	singer
SF285	spencer pratt	per:spouse	heidi montag
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:origin	englishman
SF282	steve mcpherson	per:age	42
SF283	michael sandy	per:city_of_death	new york city
SF298	carolyn maloney	per:stateorprovinces_of_residence	n.y.
SF271	chris dodd	per:member_of	senate
SF296	robert morgenthau	per:alternate_names	bob morgenthau
SF295	ali larijani	per:member_of	supreme national security council
SF275	olivia palermo	per:employee_of	us elle
SF274	simon cowell	per:title	judge
SF277	kelly cutrone	per:cities_of_residence	new york
SF276	richard lindzen	per:member_of	agu
SF202	donald wildmon	per:title	founder
SF250	national center for disaster preparedness	org:parents	columbia's mailman school of public health
SF257	independent steelworkers union	org:top_members/employees	mark glyptis
SF256	illinois tool works	org:alternate_names	itw
SF216	samsung	org:top_members/employees	kwon gye-hyun
SF268	raul castro	per:countries_of_residence	cuba
SF266	national red cross	org:top_members/employees	clara barton
SF288	jamie spears	per:title	actress
SF285	spencer pratt	per:spouse	heidi montag
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:origin	afro-caribbean
SF282	steve mcpherson	per:alternate_names	stephen mcpherson
SF283	michael sandy	per:date_of_death	oct. 8, 2006
SF298	carolyn maloney	per:stateorprovinces_of_residence	new york
SF271	chris dodd	per:member_of	senate foreign relations committee
SF296	robert morgenthau	per:alternate_names	robert m. morgenthau
SF295	ali larijani	per:member_of	supreme national security council
SF275	olivia palermo	per:employee_of	mtv
SF274	simon cowell	per:title	record producer
SF277	kelly cutrone	per:employee_of	bravo
SF276	richard lindzen	per:member_of	aaas
SF202	donald wildmon	per:title	rev.
SF250	national center for disaster preparedness	org:top_members/employees	dr. irwin redlener
SF266	national red cross	org:top_members/employees	elizabeth dole
SF266	national red cross	org:top_members/employees	gail j. mcgovern
SF285	spencer pratt	per:spouse	heidi montag
SF287	beyonce knowles	per:alternate_names	beyonce
SF231	lewis hamilton	per:origin	black
SF282	steve mcpherson	per:employee_of	abc entertainment
SF283	michael sandy	per:date_of_death	2006-10-08
SF298	carolyn maloney	per:stateorprovinces_of_residence	new york
SF271	chris dodd	per:member_of	foreign relations committee
SF296	robert morgenthau	per:alternate_names	robert m. morgenthau
SF295	ali larijani	per:member_of	supreme national security council
SF275	olivia palermo	per:employee_of	mtv
SF274	simon cowell	per:title	talent show judge
SF277	kelly cutrone	per:employee_of	mtv
SF276	richard lindzen	per:title	professor
SF202	donald wildmon	per:title	chairman
SF250	national center for disaster preparedness	org:top_members/employees	irwin redlener
SF256	illinois tool works	org:city_of_headquarters	glenview
SF216	samsung	org:top_members/employees	kwon gye-hyun
SF268	raul castro	per:countries_of_residence	cuba
SF266	national red cross	org:top_members/employees	kevin m. brown
SF285	spencer pratt	per:spouse	heidi montag
SF287	beyonce knowles	per:cities_of_residence	houston
SF231	lewis hamilton	per:origin	british
SF282	steve mcpherson	per:employee_of	abc
SF283	michael sandy	per:parents	zeke sandy
SF298	carolyn maloney	per:stateorprovinces_of_residence	ny
SF271	chris dodd	per:member_of	foreign relations committee
SF296	robert morgenthau	per:children	josh
SF295	ali larijani	per:origin	iranian
SF275	olivia palermo	per:employee_of	elle magazine
SF274	simon cowell	per:title	record producer
SF277	kelly cutrone	per:employee_of	bravo
SF276	richard lindzen	per:title	scientist
SF202	donald wildmon	per:title	chairman
SF250	national center for disaster preparedness	org:top_members/employees	irwin redlener
SF256	illinois tool works	org:city_of_headquarters	glenview
SF255	national wenchuan earthquake expert committee	org:top_members/employees	ma zongjin
SF268	raul castro	per:countries_of_residence	cuba
SF266	national red cross	org:top_members/employees	bernadine healy
SF285	spencer pratt	per:spouse	heidi montag
SF287	beyonce knowles	per:cities_of_residence	houston
SF231	lewis hamilton	per:origin	afro- carribean
SF282	steve mcpherson	per:employee_of	abc entertainment
SF283	michael sandy	per:parents	denise sandy
SF298	carolyn maloney	per:title	representative
SF271	chris dodd	per:member_of	peace corps
SF296	robert morgenthau	per:employee_of	manhattan
SF295	ali larijani	per:origin	iranian
SF275	olivia palermo	per:employee_of	mtv
SF274	simon cowell	per:title	judge
SF277	kelly cutrone	per:employee_of	bravo
SF276	richard lindzen	per:title	meteorology professor
SF244	chante moore	per:age	40
SF250	national center for disaster preparedness	org:top_members/employees	dr. irwin redlener
SF256	illinois tool works	org:city_of_headquarters	glenview
SF255	national wenchuan earthquake expert committee	org:top_members/employees	ma zongjin
SF268	raul castro	per:country_of_birth	cuba
SF266	national red cross	org:top_members/employees	elizabeth dole
SF285	spencer pratt	per:spouse	heidi montag
SF287	beyonce knowles	per:employee_of	l'oreal
SF231	lewis hamilton	per:origin	englishman
SF282	steve mcpherson	per:employee_of	abc entertainment
SF283	michael sandy	per:stateorprovince_of_death	new york
SF298	carolyn maloney	per:title	congresswoman
SF271	chris dodd	per:member_of	banking committee
SF296	robert morgenthau	per:member_of	navy
SF295	ali larijani	per:origin	iranian
SF275	olivia palermo	per:employee_of	elle magazine
SF274	simon cowell	per:title	judge
SF277	kelly cutrone	per:member_of	people's revolution
SF276	richard lindzen	per:title	atmospheric physicist
SF244	chante moore	per:age	41
SF250	national center for disaster preparedness	org:top_members/employees	irwin redlener
SF256	illinois tool works	org:city_of_headquarters	glenville
SF255	national wenchuan earthquake expert committee	org:top_members/employees	ma zongjin
SF268	raul castro	per:country_of_birth	cuba
SF285	spencer pratt	per:spouse	heidi
SF287	beyonce knowles	per:other_family	agnez dereon
SF231	lewis hamilton	per:origin	british
SF282	steve mcpherson	per:employee_of	abc entertainment
SF283	michael sandy	per:title	designer
SF298	carolyn maloney	per:title	lawmaker
SF271	chris dodd	per:member_of	democratic national committee
SF296	robert morgenthau	per:other_family	henry morgenthau
SF295	ali larijani	per:origin	iranian
SF275	olivia palermo	per:employee_of	elle
SF274	simon cowell	per:title	judge
SF277	kelly cutrone	per:member_of	people 's revolution
SF276	richard lindzen	per:title	dr.
SF244	chante moore	per:date_of_birth	1967-02-17
SF250	national center for disaster preparedness	org:top_members/employees	irwin redlener
SF256	illinois tool works	org:country_of_headquarters	u.s.
SF255	national wenchuan earthquake expert committee	org:top_members/employees	ma zongjin
SF268	raul castro	per:country_of_birth	cuba
SF285	spencer pratt	per:spouse	heidi montag
SF287	beyonce knowles	per:other_family	agnez dereon
SF231	lewis hamilton	per:origin	british
SF282	steve mcpherson	per:employee_of	abc entertainment
SF299	jeremy hooper	per:spouse	andrew
SF298	carolyn maloney	per:title	lawmaker
SF271	chris dodd	per:member_of	banking, housing and urban affairs committee
SF296	robert morgenthau	per:other_family	paul grand
SF295	ali larijani	per:origin	iranian
SF275	olivia palermo	per:employee_of	elle
SF274	simon cowell	per:title	judge
SF277	kelly cutrone	per:stateorprovinces_of_residence	new york
SF276	richard lindzen	per:title	dr.
SF244	chante moore	per:date_of_birth	feb. 17
SF250	national center for disaster preparedness	org:top_members/employees	irwin redlener
SF256	illinois tool works	org:country_of_headquarters	u.s.
SF285	spencer pratt	per:title	producer
SF287	beyonce knowles	per:other_family	agnAz dereon
SF231	lewis hamilton	per:origin	british
SF282	steve mcpherson	per:employee_of	abs
SF299	jeremy hooper	per:stateorprovinces_of_residence	new york
SF298	carolyn maloney	per:title	lawmaker
SF271	chris dodd	per:member_of	democratic party
SF296	robert morgenthau	per:spouse	lucinda franks
SF295	ali larijani	per:other_family	ayatollah morteza motahari
SF275	olivia palermo	per:employee_of	wilhelmina modeling agency
SF274	simon cowell	per:title	judge
SF277	kelly cutrone	per:title	founder
SF276	richard lindzen	per:title	dr.
SF244	chante moore	per:employee_of	peak records
SF250	national center for disaster preparedness	org:top_members/employees	dr. irwin redlener
SF256	illinois tool works	org:country_of_headquarters	u.s.
SF268	raul castro	per:date_of_birth	june 3 1931
SF285	spencer pratt	per:title	rapper
SF287	beyonce knowles	per:parents	matthew knowles
SF231	lewis hamilton	per:origin	british
SF282	steve mcpherson	per:employee_of	abc
SF299	jeremy hooper	per:title	blogger
SF298	carolyn maloney	per:title	chairwoman
SF271	chris dodd	per:member_of	senate foreign relations committee
SF296	robert morgenthau	per:title	prosecutor
SF295	ali larijani	per:schools_attended	sharif university
SF275	olivia palermo	per:employee_of	elle
SF274	simon cowell	per:title	judge
SF277	kelly cutrone	per:title	founder
SF276	richard lindzen	per:title	dr.
SF244	chante moore	per:spouse	kenny lattimore
SF250	national center for disaster preparedness	org:top_members/employees	irwin redlener
SF256	illinois tool works	org:country_of_headquarters	u.s.
SF268	raul castro	per:date_of_birth	june 3, 1931
SF285	spencer pratt	per:title	star
SF287	beyonce knowles	per:parents	matthew knowles
SF231	lewis hamilton	per:origin	british
SF282	steve mcpherson	per:employee_of	abc entertainment
SF299	jeremy hooper	per:title	activist
SF298	carolyn maloney	per:title	representative
SF271	chris dodd	per:member_of	senate
SF296	robert morgenthau	per:title	manhattan district attorney
SF295	ali larijani	per:schools_attended	tehran university
SF275	olivia palermo	per:member_of	the city
SF274	simon cowell	per:title	record producer
SF277	kelly cutrone	per:title	publicist
SF276	richard lindzen	per:title	climate scientist
SF244	chante moore	per:spouse	kenny lattimore
SF250	national center for disaster preparedness	org:website	http://www.ncdp.mailman.columbia.edu </p>
SF256	illinois tool works	org:number_of_employees/members	"60,000"
SF268	raul castro	per:date_of_birth	june 3, 1931
SF285	spencer pratt	per:title	reality tv star
SF287	beyonce knowles	per:parents	mathew knowles
SF231	lewis hamilton	per:origin	british
SF282	steve mcpherson	per:employee_of	abc
SF299	jeremy hooper	per:title	blogger
SF298	carolyn maloney	per:title	reps.
SF271	chris dodd	per:member_of	foreign relations committee
SF296	robert morgenthau	per:title	district attorney
SF295	ali larijani	per:schools_attended	sharif university
SF275	olivia palermo	per:member_of	the city
SF274	simon cowell	per:title	judge
SF277	kelly cutrone	per:title	star
SF276	richard lindzen	per:title	alfred p. sloan professor of meteorology
SF244	chante moore	per:title	r&b vocalist
SF250	national center for disaster preparedness	org:website	http://www.ncdp.mailman.columbia.edu
SF256	illinois tool works	org:number_of_employees/members	60,000
SF268	raul castro	per:date_of_birth	1931-06-03
SF285	spencer pratt	per:title	manager
SF287	beyonce knowles	per:parents	mathew knowles
SF231	lewis hamilton	per:parents	anthony hamilton
SF282	steve mcpherson	per:employee_of	abc entertainment
SF299	jeremy hooper	per:title	activist
SF298	carolyn maloney	per:title	vice chair
SF271	chris dodd	per:member_of	peace corps
SF296	robert morgenthau	per:title	manhattan district attorney
SF295	ali larijani	per:siblings	sadegh larijani
SF275	olivia palermo	per:member_of	city
SF274	simon cowell	per:title	judge
SF277	kelly cutrone	per:title	publicist
SF276	richard lindzen	per:title	professor of meteorology
SF244	chante moore	per:title	soul songstress
SF278	brian mcfadden	per:children	lilly sue
SF256	illinois tool works	org:number_of_employees/members	55,000
SF268	raul castro	per:date_of_birth	june 3 , 1931
SF285	spencer pratt	per:title	manager
SF287	beyonce knowles	per:parents	tina knowles
SF231	lewis hamilton	per:parents	anthony
SF282	steve mcpherson	per:schools_attended	cornell
SF299	jeremy hooper	per:title	blogger
SF298	carolyn maloney	per:title	reps.
SF271	chris dodd	per:member_of	senate_banking_committee
SF296	robert morgenthau	per:title	new york district attorney
SF295	ali larijani	per:siblings	mohammad javad
SF275	olivia palermo	per:origin	italian
SF274	simon cowell	per:title	judge
SF277	kelly cutrone	per:title	reality star
SF276	richard lindzen	per:title	professor
SF244	chante moore	per:title	artist
SF278	brian mcfadden	per:spouse	kerry katona
SF256	illinois tool works	org:stateorprovince_of_headquarters	ill.
SF268	raul castro	per:date_of_birth	june 3 , 1931
SF285	spencer pratt	per:title	actor
SF287	beyonce knowles	per:parents	tina knowles
SF231	lewis hamilton	per:parents	anthony
SF282	steve mcpherson	per:title	president of entertainment
SF299	jeremy hooper	per:title	activist
SF298	carolyn maloney	per:title	chairwoman
SF271	chris dodd	per:member_of	senate banking committee
SF296	robert morgenthau	per:title	district attorney
SF295	ali larijani	per:siblings	sadegh larijani
SF275	olivia palermo	per:schools_attended	new school
SF274	simon cowell	per:title	music producer
SF277	kelly cutrone	per:title	public relations guru
SF276	richard lindzen	per:title	climatologist
SF244	chante moore	per:title	artist
SF278	brian mcfadden	per:title	pop star
SF256	illinois tool works	org:stateorprovince_of_headquarters	illinois
SF268	raul castro	per:date_of_birth	june_3
SF285	spencer pratt	per:title	director
SF287	beyonce knowles	per:parents	mathew knowles
SF231	lewis hamilton	per:parents	anthony
SF282	steve mcpherson	per:title	president
SF299	jeremy hooper	per:title	lgbt activist
SF298	carolyn maloney	per:title	vice chairman
SF271	chris dodd	per:member_of	senate
SF296	robert morgenthau	per:title	district attorney
SF295	ali larijani	per:siblings	mohammad javad
SF275	olivia palermo	per:schools_attended	the new school
SF274	simon cowell	per:title	judge
SF277	kelly cutrone	per:title	boss
SF276	richard lindzen	per:title	scientist
SF251	northland church	org:alternate_names	northland, a church distributed
SF287	beyonce knowles	per:siblings	solange knowles
SF231	lewis hamilton	per:parents	anthony
SF282	steve mcpherson	per:title	president of entertainment
SF299	jeremy hooper	per:title	author
SF298	carolyn maloney	per:title	representative
SF271	chris dodd	per:other_family	michael clegg
SF296	robert morgenthau	per:title	manhattan district attorney
SF295	ali larijani	per:siblings	sadegh larijani
SF275	olivia palermo	per:stateorprovinces_of_residence	new york
SF292	holly montag	per:age	25
SF277	kelly cutrone	per:title	pr guru
SF276	richard lindzen	per:title	professor
SF251	northland church	org:alternate_names	northland a church distributed
SF256	illinois tool works	org:stateorprovince_of_headquarters	illinois
SF268	raul castro	per:date_of_birth	june 3, 1931
SF287	beyonce knowles	per:siblings	solange
SF231	lewis hamilton	per:parents	anthony hamilton
SF282	steve mcpherson	per:title	president
SF287	beyonce knowles	per:siblings	solange knowles
SF231	lewis hamilton	per:parents	anthony
SF282	steve mcpherson	per:title	president
SF298	carolyn maloney	per:title	author
SF271	chris dodd	per:parents	thomas j. dodd
SF296	robert morgenthau	per:title	district attorney
SF295	ali larijani	per:siblings	mohammed j.a. larijani
SF275	olivia palermo	per:title	editor
SF292	holly montag	per:employee_of	mtv
SF277	kelly cutrone	per:title	pr maven
SF276	richard lindzen	per:title	professor of atmospheric sciences
SF251	northland church	org:city_of_headquarters	orlando
SF256	illinois tool works	org:subsidiaries	fni ltd.
SF268	raul castro	per:employee_of	cuba
SF287	beyonce knowles	per:siblings	solange knowles
SF231	lewis hamilton	per:parents	anthony hamilton
SF282	steve mcpherson	per:title	president
SF298	carolyn maloney	per:title	rep
SF271	chris dodd	per:parents	thomas j. dodd
SF296	robert morgenthau	per:title	district attorney
SF295	ali larijani	per:siblings	mohammed hashemi
SF275	olivia palermo	per:title	actress
SF292	holly montag	per:employee_of	mtv
SF277	kelly cutrone	per:title	pr queen
SF276	richard lindzen	per:title	professor
SF251	northland church	org:city_of_headquarters	longwood
SF256	illinois tool works	org:subsidiaries	hwa meir packing daily commodities co. ltd.
SF268	raul castro	per:member_of	cuban communist party
SF287	beyonce knowles	per:siblings	solange knowles
SF231	lewis hamilton	per:siblings	nicholas
SF282	steve mcpherson	per:title	president
SF298	carolyn maloney	per:title	rep.
SF271	chris dodd	per:parents	grace
SF287	beyonce knowles	per:spouse	jay z
SF231	lewis hamilton	per:siblings	nicolas
SF282	steve mcpherson	per:title	president
SF298	carolyn maloney	per:title	congresswoman
SF271	chris dodd	per:parents	thomas dodd
SF295	ali larijani	per:title	negotiator
SF275	olivia palermo	per:title	model
SF292	holly montag	per:employee_of	nbc
SF277	kelly cutrone	per:title	boss
SF290	hugo chavez	per:age	53
SF251	northland church	org:city_of_headquarters	longwood
SF256	illinois tool works	org:top_members/employees	david speer
SF268	raul castro	per:member_of	council of state
SF287	beyonce knowles	per:spouse	jay-z
SF231	lewis hamilton	per:siblings	nicolas
SF282	steve mcpherson	per:title	president
SF298	carolyn maloney	per:title	representative
SF271	chris dodd	per:parents	thomas j. dodd
SF295	ali larijani	per:title	negotiator
SF293	david banda	per:alternate_names	daniel ciccone ritchie
SF292	holly montag	per:employee_of	mtv
SF277	kelly cutrone	per:title	boss
SF290	hugo chavez	per:age	53
SF251	northland church	org:city_of_headquarters	longwood
SF256	illinois tool works	org:top_members/employees	david speer
SF268	raul castro	per:member_of	council of ministers
SF287	beyonce knowles	per:spouse	jay-z
SF231	lewis hamilton	per:siblings	nicholas
SF282	steve mcpherson	per:title	president
SF298	carolyn maloney	per:title	congresswoman
SF271	chris dodd	per:parents	tom dodd
SF295	ali larijani	per:title	security chief
SF293	david banda	per:cities_of_residence	london
SF292	holly montag	per:other_family	stephani pratt
SF291	melanie fiona	per:countries_of_residence	canada
SF290	hugo chavez	per:age	54
SF251	northland church	org:city_of_headquarters	longwood
SF256	illinois tool works	org:website	http://www.itw.com/
SF268	raul castro	per:member_of	revolutionary armed forces
SF287	beyonce knowles	per:title	star
SF231	lewis hamilton	per:stateorprovince_of_birth	hertfordshire
SF282	steve mcpherson	per:title	president
SF298	carolyn maloney	per:title	representative
SF271	chris dodd	per:parents	grace
SF295	ali larijani	per:title	lead nuclear negotiator
SF293	david banda	per:cities_of_residence	london
SF292	holly montag	per:other_family	spencer pratt
SF291	melanie fiona	per:origin	canadian
SF290	hugo chavez	per:age	53
SF251	northland church	org:number_of_employees/members	12,000
SF287	beyonce knowles	per:title	spokeswoman
SF231	lewis hamilton	per:stateorprovinces_of_residence	hertfordshire
SF282	steve mcpherson	per:title	president
SF287	beyonce knowles	per:title	executive producer
SF231	lewis hamilton	per:title	driver
SF282	steve mcpherson	per:title	president
SF271	chris dodd	per:parents	thomas
SF295	ali larijani	per:title	top nuclear negotiator
SF293	david banda	per:cities_of_residence	london
SF292	holly montag	per:other_family	spencer pratt
SF291	melanie fiona	per:origin	canadian
SF290	hugo chavez	per:age	51
SF251	northland church	org:political/religious_affiliation	christian
SF268	raul castro	per:member_of	community party
SF287	beyonce knowles	per:title	r&b artist
SF231	lewis hamilton	per:title	driver
SF282	steve mcpherson	per:title	president
SF271	chris dodd	per:schools_attended	georgetown preparatory school
SF295	ali larijani	per:title	chief nuclear negotiator
SF293	david banda	per:cities_of_residence	london
SF292	holly montag	per:other_family	spencer pratt
SF291	melanie fiona	per:origin	canadian
SF290	hugo chavez	per:alternate_names	hugo rafael chavez frias
SF251	northland church	org:political/religious_affiliation	evangelical
SF268	raul castro	per:member_of	council of state
SF287	beyonce knowles	per:title	r&b superstar
SF231	lewis hamilton	per:title	driver
SF282	steve mcpherson	per:title	president
SF271	chris dodd	per:siblings	thomas dodd jr.
SF295	ali larijani	per:title	speaker
SF293	david banda	per:cities_of_residence	london
SF292	holly montag	per:other_family	spencer pratt
SF291	melanie fiona	per:origin	canadian
SF290	hugo chavez	per:alternate_names	hugo rafael chavez frias
SF251	northland church	org:stateorprovince_of_headquarters	florida
SF268	raul castro	per:member_of	council of state
SF287	beyonce knowles	per:title	r&b star
SF231	lewis hamilton	per:title	pilot
SF282	steve mcpherson	per:title	president
SF271	chris dodd	per:siblings	thomas dodd jr.
SF295	ali larijani	per:title	speaker
SF293	david banda	per:countries_of_residence	malawi
SF292	holly montag	per:siblings	heidi
SF291	melanie fiona	per:origin	canadian
SF290	hugo chavez	per:alternate_names	hugo chávez
SF251	northland church	org:stateorprovince_of_headquarters	fla
SF268	raul castro	per:member_of	communist party of cuba
SF231	lewis hamilton	per:title	driver
SF282	steve mcpherson	per:title	president
SF271	chris dodd	per:spouse	susan dodd
SF295	ali larijani	per:title	parliament speaker
SF293	david banda	per:countries_of_residence	malawi
SF292	holly montag	per:siblings	heidi montag
SF291	melanie fiona	per:title	musician
SF290	hugo chavez	per:charges	ordering soldiers to shoot protesters
SF251	northland church	org:stateorprovince_of_headquarters	fla.
SF268	raul castro	per:member_of	council of state and ministers
SF231	lewis hamilton	per:title	pilot
SF282	steve mcpherson	per:title	president
SF271	chris dodd	per:stateorprovinces_of_residence	connecticut
SF295	ali larijani	per:title	negotiator
SF293	david banda	per:countries_of_residence	malawi
SF292	holly montag	per:siblings	heidi montag
SF291	melanie fiona	per:title	singer
SF290	hugo chavez	per:charges	ignoring the rebels'crimes
SF251	northland church	org:stateorprovince_of_headquarters	florida
SF268	raul castro	per:member_of	communist party
SF231	lewis hamilton	per:title	driver
SF231	lewis hamilton	per:title	driver
SF271	chris dodd	per:stateorprovinces_of_residence	connecticut
SF295	ali larijani	per:title	negotiator
SF293	david banda	per:country_of_birth	malawi
SF292	holly montag	per:siblings	heidi montag
SF291	melanie fiona	per:title	singer
SF290	hugo chavez	per:charges	offering an open-ended loan of at least us$250 million to the revolutionary armed forces of colombia
SF251	northland church	org:stateorprovince_of_headquarters	fla.
SF268	raul castro	per:member_of	central committee
SF231	lewis hamilton	per:title	driver
SF271	chris dodd	per:stateorprovinces_of_residence	connecticut
SF295	ali larijani	per:title	commander
SF293	david banda	per:country_of_birth	malawi
SF292	holly montag	per:siblings	heidi montag
SF291	melanie fiona	per:title	singer/songwriter
SF290	hugo chavez	per:charges	antisemitism
SF251	northland church	org:top_members/employees	joel_hunter
SF268	raul castro	per:member_of	council of state
SF248	ellen degeneres	per:age	49
SF271	chris dodd	per:stateorprovinces_of_residence	connecticut
SF295	ali larijani	per:title	culture minister
SF293	david banda	per:date_of_birth	september 2005
SF292	holly montag	per:siblings	heidi
SF291	melanie fiona	per:title	artist
SF290	hugo chavez	per:children	rosines chavez rodriguez
SF251	northland church	org:top_members/employees	joel c. hunter
SF268	raul castro	per:origin	cuba
SF248	ellen degeneres	per:age	50
SF271	chris dodd	per:stateorprovinces_of_residence	connecticut
SF295	ali larijani	per:title	politician
SF293	david banda	per:date_of_birth	2005
SF292	holly montag	per:stateorprovinces_of_residence	colorado
SF291	melanie fiona	per:title	songstress
SF290	hugo chavez	per:children	maria gabriela
SF251	northland church	org:top_members/employees	joel c. hunter
SF268	raul castro	per:origin	cuban
SF248	ellen degeneres	per:age	49
SF271	chris dodd	per:stateorprovinces_of_residence	connecticut
SF295	ali larijani	per:title	director
SF293	david banda	per:date_of_birth	sept. 25 , 2005
SF292	holly montag	per:title	reality tv show star
SF291	melanie fiona	per:title	singer/songwriter
SF290	hugo chavez	per:children	maria
SF279	trista sutter	per:alternate_names	trista
SF268	raul castro	per:origin	cuban
SF248	ellen degeneres	per:age	50
SF271	chris dodd	per:title	chairman
SF295	ali larijani	per:title	secretary
SF293	david banda	per:origin	malawian
SF248	ellen degeneres	per:age	50
SF271	chris dodd	per:title	chairman
SF295	ali larijani	per:title	secretary
SF293	david banda	per:origin	malawian
SF291	melanie fiona	per:title	vocalist
SF290	hugo chavez	per:children	rosines
SF279	trista sutter	per:alternate_names	trista rehn
SF268	raul castro	per:origin	latin american
SF248	ellen degeneres	per:alternate_names	ellen degenerous
SF271	chris dodd	per:title	chairman
SF295	ali larijani	per:title	chief nuclear negotiator
SF293	david banda	per:origin	african
SF291	melanie fiona	per:title	vocalist
SF290	hugo chavez	per:cities_of_residence	caracas
SF279	trista sutter	per:alternate_names	trista
SF268	raul castro	per:origin	caribbean
SF248	ellen degeneres	per:cities_of_residence	new orleans
SF271	chris dodd	per:title	presidential candidate
SF295	ali larijani	per:title	speaker
SF293	david banda	per:origin	malawian
SF291	melanie fiona	per:title	artist
SF290	hugo chavez	per:cities_of_residence	sabaneta
SF279	trista sutter	per:alternate_names	trista stutter
SF268	raul castro	per:origin	cuban
SF248	ellen degeneres	per:cities_of_residence	new orleans
SF297	michael johns	per:cities_of_residence	atlanta
SF295	ali larijani	per:title	speaker
SF293	david banda	per:origin	malawian
SF291	melanie fiona	per:title	artist
SF290	hugo chavez	per:city_of_birth	sabaneta
SF279	trista sutter	per:alternate_names	trista
SF268	raul castro	per:origin	cuban
SF248	ellen degeneres	per:cities_of_residence	beverly hills
SF297	michael johns	per:cities_of_residence	atlanta
SF248	ellen degeneres	per:city_of_birth	new orleans
SF297	michael johns	per:cities_of_residence	los angeles
SF293	david banda	per:origin	malawian
SF248	ellen degeneres	per:city_of_birth	new orleans
SF297	michael johns	per:cities_of_residence	tifton
SF293	david banda	per:origin	malawian
SF290	hugo chavez	per:countries_of_residence	venezuela
SF279	trista sutter	per:alternate_names	trista rehn
SF268	raul castro	per:origin	cuban
SF248	ellen degeneres	per:countries_of_residence	us
SF297	michael johns	per:cities_of_residence	atlanta
SF293	david banda	per:origin	malawian
SF290	hugo chavez	per:countries_of_residence	venezuelan
SF279	trista sutter	per:alternate_names	trista
SF268	raul castro	per:origin	cuba
SF248	ellen degeneres	per:date_of_birth	1958
SF297	michael johns	per:cities_of_residence	atlanta
SF293	david banda	per:origin	african
SF290	hugo chavez	per:countries_of_residence	venezuela
SF279	trista sutter	per:alternate_names	trista
SF268	raul castro	per:origin	cuba
SF248	ellen degeneres	per:employee_of	nbc
SF297	michael johns	per:cities_of_residence	los angeles
SF293	david banda	per:other_family	flora
SF290	hugo chavez	per:countries_of_residence	venezuela
SF279	trista sutter	per:alternate_names	trista
SF268	raul castro	per:origin	cuban
SF248	ellen degeneres	per:employee_of	american express
SF297	michael johns	per:cities_of_residence	perth
SF293	david banda	per:other_family	asinati mwale
SF290	hugo chavez	per:countries_of_residence	venezuela
SF279	trista sutter	per:alternate_names	trista
SF268	raul castro	per:other_family	fidel castro diaz- balart
SF248	ellen degeneres	per:employee_of	covergirl
SF297	michael johns	per:cities_of_residence	perth
SF293	david banda	per:parents	yohane banda
SF290	hugo chavez	per:countries_of_residence	venezuelan
SF279	trista sutter	per:alternate_names	trista
SF268	raul castro	per:other_family	fidel castro diaz balart
SF248	ellen degeneres	per:member_of	writers guild
SF297	michael johns	per:cities_of_residence	los angeles
SF293	david banda	per:parents	yohane banda
SF290	hugo chavez	per:countries_of_residence	venezuela
SF279	trista sutter	per:children	blakesley grace
SF268	raul castro	per:other_family	alina fernandez revuelta
SF248	ellen degeneres	per:member_of	writers guild of america
SF297	michael johns	per:cities_of_residence	buckhead
SF293	david banda	per:parents	madonna
SF290	hugo chavez	per:country_of_birth	venezuela
SF279	trista sutter	per:children	blakesley
SF268	raul castro	per:other_family	fidel jr.
SF248	ellen degeneres	per:member_of	wga
SF297	michael johns	per:cities_of_residence	perth
SF293	david banda	per:parents	yohane banda
SF290	hugo chavez	per:date_of_birth	july 28, 1954
SF279	trista sutter	per:children	blakesley
SF268	raul castro	per:other_family	alina fernandez revuelta
SF248	ellen degeneres	per:other_family	margaret rogers
SF297	michael johns	per:countries_of_residence	australia
SF293	david banda	per:parents	guy ritchie
SF290	hugo chavez	per:date_of_birth	july 28, 1954
SF279	trista sutter	per:children	blaskesley grace sutter
SF268	raul castro	per:other_family	antonio
SF248	ellen degeneres	per:parents	betty
SF297	michael johns	per:countries_of_residence	u.s.
SF293	david banda	per:parents	guy ritchie
SF290	hugo chavez	per:date_of_birth	july 28 , 1954
SF279	trista sutter	per:employee_of	b's purses
SF268	raul castro	per:other_family	alex
SF248	ellen degeneres	per:parents	betty
SF297	michael johns	per:countries_of_residence	united states
SF293	david banda	per:parents	madonna
SF290	hugo chavez	per:date_of_birth	july 28 1954
SF279	trista sutter	per:employee_of	abc
SF268	raul castro	per:other_family	alexis
SF248	ellen degeneres	per:parents	betty degeneres
SF297	michael johns	per:employee_of	cj
SF293	david banda	per:parents	yohane banda
SF290	hugo chavez	per:employee_of	venezuela
SF279	trista sutter	per:siblings	darryl
SF268	raul castro	per:other_family	mirta diaz balart
SF248	ellen degeneres	per:parents	betty
SF297	michael johns	per:employee_of	maverick records
SF293	david banda	per:parents	marita
SF290	hugo chavez	per:employee_of	venezuelan
SF279	trista sutter	per:title	designer
SF268	raul castro	per:other_family	angel
SF248	ellen degeneres	per:spouse	portia de rossi
SF297	michael johns	per:employee_of	tin roof cantina
SF293	david banda	per:parents	madonna
SF290	hugo chavez	per:employee_of	venezuala
SF279	trista sutter	per:title	star
SF268	raul castro	per:other_family	alejandro
SF248	ellen degeneres	per:spouse	portia de rossi
SF297	michael johns	per:member_of	the rising
SF293	david banda	per:parents	guy richie
SF290	hugo chavez	per:employee_of	venezuela
SF279	trista sutter	per:title	star
SF268	raul castro	per:parents	lina ruz
SF248	ellen degeneres	per:spouse	portia de rossi
SF297	michael johns	per:schools_attended	abraham baldwin agriculture college
SF293	david banda	per:parents	madonna
SF290	hugo chavez	per:employee_of	venezuelan
SF248	ellen degeneres	per:stateorprovince_of_birth	louisiana
SF297	michael johns	per:stateorprovinces_of_residence	ga
SF293	david banda	per:parents	guy ritchie
SF290	hugo chavez	per:employee_of	venezuelan
SF268	raul castro	per:parents	lina ruz
SF248	ellen degeneres	per:title	comedian
SF248	ellen degeneres	per:title	star
SF293	david banda	per:parents	madonna
SF290	hugo chavez	per:employee_of	bolivarian republic of venezuela
SF268	raul castro	per:schools_attended	university of havana
SF248	ellen degeneres	per:title	host
SF293	david banda	per:parents	madonna
SF290	hugo chavez	per:employee_of	venezula
SF268	raul castro	per:schools_attended	university of havana
SF248	ellen degeneres	per:title	presenter
SF293	david banda	per:parents	madonna
SF290	hugo chavez	per:member_of	socialist party
SF268	raul castro	per:siblings	fidel castro
SF248	ellen degeneres	per:title	comedian
SF293	david banda	per:siblings	lourdes
SF290	hugo chavez	per:member_of	psuv
SF268	raul castro	per:siblings	ramon castro
SF248	ellen degeneres	per:title	show host
SF293	david banda	per:siblings	rocco
SF290	hugo chavez	per:member_of	psuv
SF268	raul castro	per:siblings	fidel
SF248	ellen degeneres	per:title	star
SF293	david banda	per:siblings	rocco
SF290	hugo chavez	per:member_of	united socialist party
SF268	raul castro	per:siblings	fidel castro
SF248	ellen degeneres	per:title	host
SF293	david banda	per:siblings	rocco
SF290	hugo chavez	per:origin	venezuelan
SF268	raul castro	per:siblings	fidel
SF248	ellen degeneres	per:title	model
SF293	david banda	per:siblings	rocco
SF290	hugo chavez	per:origin	venezuelan
SF268	raul castro	per:siblings	fidel
SF248	ellen degeneres	per:title	comedian
SF293	david banda	per:siblings	lourdes
SF290	hugo chavez	per:origin	venezuelan
SF268	raul castro	per:siblings	ramon
SF248	ellen degeneres	per:title	judge
SF293	david banda	per:siblings	lourdes
SF290	hugo chavez	per:origin	venezuelan
SF268	raul castro	per:siblings	juanita
SF248	ellen degeneres	per:title	talk-show goddess
SF248	ellen degeneres	per:title	presenter
SF290	hugo chavez	per:origin	venezuelan
SF268	raul castro	per:siblings	fidel castro.
SF248	ellen degeneres	per:title	judge
SF290	hugo chavez	per:origin	latin american
SF268	raul castro	per:siblings	fidel castro ruz
SF281	brandon mcinerney	per:age	14
SF290	hugo chavez	per:parents	hugo de los reyes chavez
SF268	raul castro	per:spouse	vilma espin guillois
SF281	brandon mcinerney	per:age	14
SF290	hugo chavez	per:parents	hugo de los reyes chavez
SF268	raul castro	per:spouse	vilma espin
SF281	brandon mcinerney	per:age	14
SF290	hugo chavez	per:parents	hugo de los reyes chavez
SF268	raul castro	per:spouse	vilma espin
SF281	brandon mcinerney	per:age	15
SF290	hugo chavez	per:parents	hugo de los reyes chavez
SF268	raul castro	per:spouse	vilma espin
SF281	brandon mcinerney	per:age	14
SF290	hugo chavez	per:religion	roman catholic
SF268	raul castro	per:spouse	vilma espin
SF281	brandon mcinerney	per:age	14 years old
SF290	hugo chavez	per:schools_attended	venezuela's military academy
SF268	raul castro	per:spouse	vilma espin guillois
SF281	brandon mcinerney	per:age	14
SF290	hugo chavez	per:schools_attended	simon bolivar university
SF268	raul castro	per:spouse	vilma espin guillois
SF281	brandon mcinerney	per:alternate_names	brandon david mcinerney
SF290	hugo chavez	per:siblings	adan chavez
SF268	raul castro	per:spouse	vilma espin guillois
SF281	brandon mcinerney	per:charges	first degree murder
SF290	hugo chavez	per:siblings	adan chavez
SF268	raul castro	per:spouse	vilma_espin_guillois
SF281	brandon mcinerney	per:charges	first-degree murder
SF290	hugo chavez	per:siblings	adan
SF268	raul castro	per:stateorprovince_of_birth	oriente province
SF281	brandon mcinerney	per:charges	gunning down his gay classmate
SF290	hugo chavez	per:siblings	anibal chavez
SF268	raul castro	per:title	president
SF281	brandon mcinerney	per:charges	first degree murder
SF290	hugo chavez	per:siblings	argenis chavez
SF268	raul castro	per:title	defense minister
SF281	brandon mcinerney	per:charges	hate crime
SF290	hugo chavez	per:siblings	narciso chavez
SF268	raul castro	per:title	defense chief
SF281	brandon mcinerney	per:charges	hate crime
SF290	hugo chavez	per:siblings	adelis chavez
SF268	raul castro	per:title	interim president
SF281	brandon mcinerney	per:charges	use of a firearm
SF290	hugo chavez	per:siblings	adan chavez
SF268	raul castro	per:title	interim president
SF281	brandon mcinerney	per:charges	premeditated murder
SF290	hugo chavez	per:siblings	adan
SF268	raul castro	per:title	president
SF281	brandon mcinerney	per:cities_of_residence	oxnard
SF290	hugo chavez	per:spouse	marisabel rodriguez
SF268	raul castro	per:title	general
SF281	brandon mcinerney	per:cities_of_residence	oxnard
SF290	hugo chavez	per:spouse	nancy colmenares
SF268	raul castro	per:title	acting president
SF281	brandon mcinerney	per:member_of	young marines
SF290	hugo chavez	per:spouse	marisabel rodriguez
SF268	raul castro	per:title	vice president
SF281	brandon mcinerney	per:member_of	young marines
SF290	hugo chavez	per:spouse	marisabel rodriguez
SF268	raul castro	per:title	defense secretary
SF281	brandon mcinerney	per:parents	bill mcinerney
SF290	hugo chavez	per:stateorprovince_of_birth	barinas
SF268	raul castro	per:title	president
SF281	brandon mcinerney	per:parents	kendra mcinerney
SF290	hugo chavez	per:stateorprovinces_of_residence	barinas
SF268	raul castro	per:title	president
SF281	brandon mcinerney	per:parents	william frederick mcinerney
SF290	hugo chavez	per:title	president
SF268	raul castro	per:title	second secretary
SF281	brandon mcinerney	per:schools_attended	e.o. green junior high school
SF290	hugo chavez	per:title	president
SF268	raul castro	per:title	defense minister
SF281	brandon mcinerney	per:schools_attended	e.o. green junior high
SF290	hugo chavez	per:title	president
SF268	raul castro	per:title	first vice president
SF281	brandon mcinerney	per:stateorprovinces_of_residence	california
SF290	hugo chavez	per:title	president
SF268	raul castro	per:title	defense minister
SF281	brandon mcinerney	per:title	student
SF290	hugo chavez	per:title	commander
SF268	raul castro	per:title	president
SF281	brandon mcinerney	per:title	murder defendant
SF290	hugo chavez	per:title	paratrooper colonel
SF268	raul castro	per:title	general
SF281	brandon mcinerney	per:title	student
SF290	hugo chavez	per:title	president
SF268	raul castro	per:title	deputy prime minister
SF281	brandon mcinerney	per:title	defendant
SF290	hugo chavez	per:title	president
SF268	raul castro	per:title	president
SF290	hugo chavez	per:title	president
SF268	raul castro	per:title	president
SF290	hugo chavez	per:title	president
SF268	raul castro	per:title	general
SF290	hugo chavez	per:title	president
SF268	raul castro	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	lieutenant colonel
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	president
SF290	hugo chavez	per:title	dictator
SF290	hugo chavez	per:title	president
\.


--
-- Greenplum Database database dump complete
--

