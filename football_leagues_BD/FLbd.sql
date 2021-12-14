create table team (
 teamid int not null auto_increment primary key,
 name varchar(30)
);

create table position (
positionid int not null primary key,
name varchar(20)
);

-- position может быть базовое слово в mysql поэтому можно обрамить его обратными ковычками 
	`position`
	
	insert into position (positionid, name)
	values (1, 'Coach');
	
	insert into position (positionid, name)
	values (2, 'Goalkeeper');
	
	insert into position (positionid, name)
	values (3, 'Midfielder');
	
	insert into position (positionid, name)
	values (4, 'Forward');
	
	insert into position (positionid, name)
	values (5, 'Defender');
	
	insert into team (name) values ('Manchester United');
	insert into team (name) values ('Liverpool');
	insert into team (name) values ('Arsenal');
	insert into team (name) values ('Chelsea');
	insert into team (name) values ('Manchester City');
	
	
	create table person (
	personid int not null AUTO_INCREMENT primary key,
	teamid int,
	firstname varchar(30),
	lastname varchar(30),
	positionid int not null,
	constraint fk_teamid FOREIGN KEY (teamid) REFERENCES team (teamid),
	constraint fk_positionid foreign key (positionid) references position (positionid)
	);
	
	insert into person (teamid, firstname, lastname, positionid)
	values (1, 'Victor', 'Lindelof', 3);
	insert into person (teamid, firstname, lastname, positionid)
	values (1, 'Erick', 'Bailly', 3);
	insert into person (teamid, firstname, lastname, positionid)
	values (1, 'Phil', 'Jones', 3);
	insert into person (teamid, firstname, lastname, positionid)
	values (1, 'Paul', 'Pogba', 4);
	insert into person (teamid, firstname, lastname, positionid)
	values (1, 'Edinson', 'Cavani', 5);
	insert into person (teamid, firstname, lastname, positionid)
	values (1, 'Anthony', 'Martial', 5);
	
	insert into person (teamid, firstname, lastname, positionid) values (2, 'Jürgen', 'Klopp', 1);
insert into person (teamid, firstname, lastname, positionid) values (2, 'Alisson', 'Ramsess', 2);
insert into person (teamid, firstname, lastname, positionid) values (2, 'Virgil', 'van Dijk', 3);
insert into person (teamid, firstname, lastname, positionid) values (2, 'Georginio', 'Wijnaldum', 4);
insert into person (teamid, firstname, lastname, positionid) values (2, 'Thiago', 'Alcântara', 4);
insert into person (teamid, firstname, lastname, positionid) values (2, 'Roberto', 'Firmino', 5);

insert into person (teamid, firstname, lastname, positionid) values (3, 'Mikel', 'Arteta', 1);
insert into person (teamid, firstname, lastname, positionid) values (3, 'Bernd', 'Leno', 2);
insert into person (teamid, firstname, lastname, positionid) values (3, 'Kieran', 'Tierney', 2);
insert into person (teamid, firstname, lastname, positionid) values (3, 'Bukayo', 'Saka', 3);
insert into person (teamid, firstname, lastname, positionid) values (3, 'Rob', 'Holding', 2);
insert into person (teamid, firstname, lastname, positionid) values (3, 'Nicolas', 'Pépé', 5);

insert into person (teamid, firstname, lastname, positionid) values (4, 'Carlo', 'Ancelotti', 1);
insert into person (teamid, firstname, lastname, positionid) values (4, 'Jordan', 'Pickford', 2);
insert into person (teamid, firstname, lastname, positionid) values (4, 'Fabian', 'Delph', 4);

insert into person (teamid, firstname, lastname, positionid) values (5, 'Thomas', 'Tuchel', 1);
insert into person (teamid, firstname, lastname, positionid) values (5, 'Kepa', 'Arrizabalaga', 2);
insert into person (teamid, firstname, lastname, positionid) values (5, 'Antonio', 'Rüdiger', 3);
insert into person (teamid, firstname, lastname, positionid) values (5, 'Christian', 'Pulisic', 4);

	
	
	create table game (
	gameid int not null auto_increment primary key,
	hometeamid int not null,
	guestteamid int not null,
	hometeamgoals int default 0,
	guestteamgoals int default 0,
	constraint fk_hometeamid foreign key (hometeamid) references team (teamid),
	constraint fk_guestteamid foreign key (guestteamid) references team (teamid)
	);
	
	-- Генерируем значения для заполнения таблицы игр:
	select ht.teamid as hometeamid, gt.teamid as guestteamid,
		round(rand() * 3) as hometeamgoals,
		round(rand() * 3) as guestteamgoals
	from team ht
	join team gt
	where ht.teamid != gt.teamid;
	
	-- можно результат этого запроса вставить в таблицу:
	
	insert into game (hometeamid, guestteamid, hometeamgoals, guestteamgoals)
	select ht.teamid as hometeamid, gt.teamid as guestteamid,
		round(rand() * 3) as hometeamgoals,
		round(rand() * 3) as guestteamgoals
	from team ht
	join team gt
	where ht.teamid != gt.teamid;
	
	
 select * from game g 
join team gt on gt.teamid = g.hometeamid
order by gameid;

	--берем имена команд с таблицы team и джоиним с таблицей game, выбирая из game 4 поля

select gt.name guestcomandname,
 guestteamgoals,
 hometeamgoals,
 ht.name homecomandname 
from game g 
join team gt on gt.teamid = g.guestteamid
join team ht on ht.teamid = g.hometeamid;


--хотим вывести еще столбец со значением победила команда или нет:

select gt.name guestcomandname,
 guestteamgoals,
 hometeamgoals,
 ht.name homecomandname,
 case
 when hometeamgoals > guestteamgoals then 'Домашняя команда победила'
 when hometeamgoals < guestteamgoals then 'Гостевая команда победила'
 when hometeamgoals = guestteamgoals then 'Ничья'
 else 'error'
 end
from game g 
join team gt on gt.teamid = g.guestteamid
join team ht on ht.teamid = g.hometeamid;


insert into person (firstname, positionid) values ('Ronaldo', 3);


--Если teamid = null то будем отображать цифру 1 -> ifnull(teamid, 1):

select ifnull(teamid, 1), firstname, lastname from person;

select ifnull(teamid, 1) as teamid, firstname, ifnull(lastname, 'undefined') as lastname from person;

coalesce тоже самое только может вмещать несколько значений
select coalesce(teamid, 1) as teamid, firstname, coalesce(lastname, firstname 'undefined') from person;

--___________________________________________________________________________________________________________________


--Удаляем все содержимое  таблицы всключая primary key, которые затем будут начинаться с начала
truncate table game;

--_______________________
--создание клона таблицы (не создает primary, foreign keys)

create table gamecopy
select * from game;

--_______________________

--считаем сколько людей играет в каждой команде
select name, count(*)
 from team t 
join person p on t.teamid = p.teamid
group by name;



--считаем сколько людей играет в каждой команде, а так же сколько позиций

select t.name, psn.name, count(*)
 from team t
join person p on t.teamid = p.teamid
join position psn on psn.positionid = p.positionid
group by t.name, psn.name;


--___________________________________________________________________________________________________________________
--Many to many

create table persongame (
personid int not null,
gameid int not null,
primary key (personid, gameid),
constraint fk_personid foreign key (personid) references person (personid),
constraint fk_gameid foreign key (gameid) references game (gameid)
);

insert into persongame
select p.personid, g.gameid
from game g
	join person p on g.guestteamid = p.teamid;
	
	insert into persongame
select p.personid, g.gameid
from game g
	join person p on g.hometeamid = p.teamid;


select * from game g
join persongame pg on g.gameid = pg.gameid
join person p on pg.personid = p.personid;



--_______________________

create table phone(
phoneid int not null primary key auto_increment,
phonenumber varchar(15),
phonetype int
);


create table personphone(

personid int not null,
phoneid int not null,
primary key (personid, phoneid),
constraint fk_personidphone foreign key (personid) references person(personid),
constraint fk_phoneid foreign key (phoneid) references phone(phoneid)

);

insert phone (phonenumber) values('21345');
insert phone (phonenumber) values('34543');
insert phone (phonenumber) values('435234');
insert phone (phonenumber) values('563-4352');
insert phone (phonenumber) values('324662');

insert into personphone values(1,1);
insert into personphone values(1,2);
insert into personphone values(2,3);


select p.firstname, p.lastname, phn.phonenumber from person p
join personphone ph on p.personid = ph.personid
join phone phn on phn.phoneid = ph.phoneid;

insert into personphone values (5,4);
insert into personphone values (6,4);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	