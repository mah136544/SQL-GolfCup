drop database Golfcup;
create database Golfcup;
use Golfcup;

create table Spelare(
Pnr varchar(13),
Namn varchar(50),
Alder int,
primary key(Pnr)
)engine=innodb;

create table Tavling(
Tavlingsnamn  varchar(30),
Datumtid date,
primary key(Tavlingsnamn)
)engine=innodb;

create table Konstruktion(
SrNr varchar(30),
Hard varchar(3),
primary key(SrNr)
)engine=innodb;

create table Klubba(
KNr varchar(30),
Material varchar(30),
Pnr varchar(13),
Konstruktion varchar(30),
Primary key(pnr,KNr),
foreign key(Pnr) references Spelare(Pnr)
on delete cascade
)engine=innodb;


create table Regn(
RTyp varchar(30),
Vind varchar(10),
primary key(RTyp)
)engine=innodb;

create table Jacka(
Modell varchar(30),
Storlek Varchar(5),
Material varchar(30),
Pnr varchar(13),
primary key (Pnr, Modell),
foreign key(Pnr) references Spelare(Pnr)
on delete cascade
)engine=innodb;

create table Delta(
Pnr varchar(13),
Tavlingsnamn varchar(30),
primary key(Pnr, Tavlingsnamn),
foreign key(Pnr) references Spelare(Pnr)
on delete cascade,
foreign key(Tavlingsnamn) references Tavling(Tavlingsnamn)
on delete cascade
)engine=innodb;

create table Har(
RTyp varchar(30),
Tavlingsnamn varchar(30),
Tid datetime,
primary key(RTyp, Tavlingsnamn),
foreign key(RTyp) references Regn(RTyp)
on delete cascade,
foreign key(Tavlingsnamn) references Tavling(Tavlingsnamn)
on delete cascade
)engine=innodb;

insert into Spelare (Pnr, Namn, Alder) values ('19940201-1345', 'Johan Andersson', 25);
insert into Spelare (Pnr, Namn, Alder) values ('19990306-1345', 'Nicklas Jansson', 27);
insert into Spelare (Pnr, Namn, Alder) values ('19990307-1346', 'Annika Persson', 26);

insert into Tavling (Tavlingsnamn, Datumtid) values('Big Golf Cup Skövde', '2021-06-10');

insert into Konstruktion (SrNr, Hard) values ('234567', '10');
insert into Konstruktion (SrNr, Hard) values ('244567', '5');

insert into Regn (RTyp, Vind) values ('hagel', '10m/s');

insert into Jacka (Modell, Storlek, Material, Pnr) values ('BomberJacka', 'S', 'Fleece', '19940201-1345');
insert into Jacka (Modell, Storlek, Material, Pnr) values ('VinterJacka', 'S', 'gortex', '19940201-1345');

insert into Klubba (KNr, Material, Pnr, Konstruktion) values('2345', 'Trä', '19940201-1345', '234567');
insert into Klubba (KNr, Material, Pnr, Konstruktion) values('2445', 'Trä','19940201-1345' , '244567');
insert into Klubba (KNr, Material, Pnr, Konstruktion) values('2545', 'Iron','19940201-1345' , '244567');

insert into Delta (Pnr, Tavlingsnamn) values ('19940201-1345', 'Big Golf Cup Skövde');
insert into Delta (Pnr, Tavlingsnamn) values ('19990306-1345', 'Big Golf Cup Skövde');
insert into Delta (Pnr, Tavlingsnamn) values ('19990307-1346', 'Big Golf Cup Skövde');

insert into Har (RTyp, Tavlingsnamn, Tid) values ('hagel', 'Big Golf Cup Skövde', '2021-06-10 14:00:00');

/* 1 Hämta ålder för spelare Johan Andersson */
select Alder from Spelare where Namn='Johan Andersson';

/* 2 Hämta datum för Tävling Big Golf Cup Skövde */
select Datumtid from Tavling where Tavlingsnamn='Big Golf Cup Skövde';

/* 3 Hämta material för Johan Anderssons klubba */
select Material from Klubba where Pnr in (select Pnr from Spelare where Namn= 'Johan Andersson');

/* 4 Hämta alla jackor som tillhör Johan Andersson */
select Modell, Storlek, Material from Jacka where Pnr in (select Pnr from Spelare where Namn= 'Johan Andersson');

/* 5 Hämta alla  spelare som deltog i Big Golf Cup Skövde */
select Namn from Delta inner join Spelare on Delta.Pnr=Spelare.Pnr
inner join Tavling as competition on Delta.Tavlingsnamn=competition.Tavlingsnamn
where competition.Tavlingsnamn= 'Big Golf Cup Skövde';

/* 6 Hämta Regnens Vindstyrka för Big Golf Cup Skövde  */
select Vind from Har inner join Regn on Har.RTyp=Regn.RTyp
inner join Tavling as competition on Har.Tavlingsnamn=competition.Tavlingsnamn
where competition.Tavlingsnamn= 'Big Golf Cup Skövde';

/* 7 Hämta alla spelare som är under 30 år */
select Namn from Spelare where Alder < 30;

/* 8 Ta bort Johan Anderssons jackor */
delete from Jacka where Pnr in (select Pnr from Spelare where Namn= 'Johan Andersson');

/* 9 Ta bort Nicklas Jansson */
delete from Spelare where Namn= 'Nicklas Jansson' limit 1;

/* 10 Hämta medelåldern för alla spelare */
select avg(Alder) from Spelare;

select * from Spelare;




