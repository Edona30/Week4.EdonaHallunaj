create database NegozioDischi

create table Band(
IDBand int identity(1,1) constraint PK_Band primary key not null,
Nome nvarchar(20) not null,
NumeroComponenti numeric not null);

create table Brano(
IDBrano int identity(1,1) constraint PK_Brano primary key not null,
Titolo nvarchar(30) not null,
Durata numeric not null);

create table Album(
IDAlbum int identity(1,1) constraint PK_Album primary key not null,
Titolo nvarchar(30) not null,
AnnoDiUscita int not null,
CasaDiscografica nvarchar(40) not null,
Genere nvarchar(20) not null,
Distribuzione nvarchar(20) not null,
IDBand int constraint FK_Band foreign key references Band(IDBand));

alter table Album 
add constraint UC_Album unique(Titolo, AnnoDiUscita, CasaDiscografica, Genere, Distribuzione);

create table AlbumBrano(
IDAlbum int not null constraint FK1_Album references Album(IDAlbum),
IDBrano int not null constraint FK2_Brano references Brano(IDBrano));


--INSERIMENTO DATI 

insert into Band values ('883', 2);
insert into Band values ('Maneskin', 4);
insert into Band values ('TheGiornalisti', 3);
insert into Band values ('John Lennon',1);

insert into Album values ('Nord sud ovest est', 1993,'Free Records Indipendent', 'Pop', 'CD', 1);
insert into Album values ('Love/Life', 2002,'Free Records Indipendent', 'Pop', 'CD', 1);
insert into Album values ('Hanno Ucciso l''uomo ragno', 1992,'Free Records Indipendent', 'Pop-Rock', 'CD-Vinile', 1);
insert into Album values ('Chosen', 2017,'Sony Music', 'Rock', 'CD- Streaming', 2);
insert into Album values ('Il Ballo della Vita', 2020,'Sony Music', 'Rock', 'CD-Streaming', 2);
insert into Album values ('Love', 2018,'Carosello Records', 'Pop', 'CD-Streaming-Vinile', 3);
insert into Album values ('Fuori Campo', 2014,'Carosello Records', 'Pop', 'CD-Streaming-Vinile', 3);
insert into Album values ('Imagine', 1971, 'Apple', 'Rock', 'CD-Vinile', 4)

insert into Brano values ('Nord sud ovest est', 253);
insert into Brano values ('Sei un mito', 307);
insert into Brano values ('Come mai', 257);
insert into Brano values ('Ci sono anc''io', 226);
insert into Brano values ('Quello che capita', 291);
insert into Brano values ('Una canzone d''amore', 334);
insert into Brano values ('Hanno ucciso l''uomo ragno', 186 );
insert into Brano values ('Non me la menare', 254);
insert into Brano values ('6/1/sfigato', 239);
insert into Brano values ('Chosen', 222);
insert into Brano values ('Recovery', 176);
insert into Brano values ('Vengo dalla Luna', 185);
insert into Brano values ('New Song', 249);
insert into Brano values ('Torna a casa', 226);
insert into Brano values ('Zero Stare sereno', 196);
insert into Brano values ('New York', 220);
insert into Brano values ('Overture', 85);
insert into Brano values ('Per lei', 177);
insert into Brano values ('Promisquità', 210);
insert into Brano values ('Imagine', 180);
insert into Brano values ('Clipped Inside', 229);

insert into AlbumBrano values (1,1);
insert into AlbumBrano values (1,2);
insert into AlbumBrano values (1,3);
insert into AlbumBrano values (2,4);
insert into AlbumBrano values (2,5);
insert into AlbumBrano values (2,6);
insert into AlbumBrano values (3,7);
insert into AlbumBrano values (3,8);
insert into AlbumBrano values (3,9);
insert into AlbumBrano values (4,10);
insert into AlbumBrano values (4,11);
insert into AlbumBrano values (4,12);
insert into AlbumBrano values (5,13);
insert into AlbumBrano values (5,14);
insert into AlbumBrano values (6,15);
insert into AlbumBrano values (6,16);
insert into AlbumBrano values (6,17);
insert into AlbumBrano values (7,18);
insert into AlbumBrano values (7,19);
insert into AlbumBrano values (8,20);
insert into AlbumBrano values (8,21);

select * from Album;
select * from Band;
select * from Brano;
select * from AlbumBrano;

--1)Scrivere una query che restituisca i titoli degli album degli “883” in ordine alfabetico;

select distinct a.Titolo 
from Brano b join AlbumBrano ab on b.IDBrano=ab.IDBrano 
             join Album a on ab.IDAlbum=a.IDAlbum
			 join Band ba on a.IDBand=ba.IDBand
where ba.Nome = '883' 
order by a.Titolo asc 

--2) Selezionare tutti gli album della casa discografica “Sony Music” relativi all’anno 2020;

select a.Titolo
from Album a
where CasaDiscografica = 'Sony Music' and AnnoDiUscita = 2020 

--3) Scrivere una query che restituisca tutti i titoli delle canzoni dei “Maneskin” appartenenti 
--ad album pubblicati prima del 2019;

select b.Titolo
from Brano b join AlbumBrano ab on b.IDBrano=ab.IDBrano
             join Album a on ab.IDAlbum=a.IDAlbum
			 join Band ba on a.IDBand=ba.IDBand
where ba.Nome = 'Maneskin' and a.AnnoDiUscita<2019 


--4) Individuare tutti gli album in cui è contenuta la canzone “Imagine”;
select *
from Album a join AlbumBrano ab on a.IDAlbum=ab.IDAlbum
             join Brano b on b.IDBrano=ab.IDBrano
where b.Titolo = 'Imagine'

--5) Restituire il numero totale di canzoni eseguite dalla band “The Giornalisti”;select count(ba.Nome) as [Numero totale delle canzoni dei TheGiornalisti]from Brano b join AlbumBrano ab on b.IDBrano=ab.IDBrano             join Album a on ab.IDAlbum=a.IDAlbum			 join Band ba on ba.IDBand=a.IDBandwhere ba.Nome='TheGiornalisti'group by ba.Nome

--6)Contare per ogni album, la “durata totale” cioè la somma dei secondi dei suoi brani

select a.Titolo, sum(b.Durata) as [Durata Totale dell'Album]
from Brano b join AlbumBrano ab on ab.IDBrano=b.IDBrano
             join Album a on a.IDAlbum=ab.IDAlbum
group by a.Titolo

--7)Mostrare i brani (distinti) degli “883” che durano più di 3 minuti (in alternativa usare i 
--secondi quindi 180 s).
select distinct b.Titolo 
from Brano b join AlbumBrano ab on b.IDBrano=ab.IDBrano 
             join Album a on ab.IDAlbum=a.IDAlbum
			 join Band ba on a.IDBand=ba.IDBand
where ba.Nome = '883' and b.Durata>180

--8)Mostrare tutte le Band il cui nome inizia per “M” e finisce per “n”.
select * from Band b 
where b.Nome like 'M%N' 

/*9)Mostrare il titolo dell’Album e di fianco un’etichetta che stabilisce che si tratta di un
Album:
‘Very Old’ se il suo anno di uscita è precedente al 1980, 
‘New Entry’ se l’anno di uscita è il 2021,
‘Recente’ se il suo anno di uscita è compreso tra il 2010 e 2020, 
‘Old’ altrimenti.*/

select a.Titolo,
case
    when a.AnnoDiUscita<1980 then 'Very Old'
	when a.AnnoDiUscita=2021 then 'New Entry'
	when a.AnnoDiUscita between 2010 and 2020 then 'Recente'
	else 'Old'
end as [Classificazione Album]
from Album a

--10)Mostrare i brani non contenuti in nessun album.
select b.Titolo
from Brano b

















