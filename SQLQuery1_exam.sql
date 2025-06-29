create table Stydents
(
	[Number of book] int primary key,
	FIO nvarchar(20) not null unique,
	[Year of Admission] int not null,
	[Group] nvarchar(20)  not null,
	[Course] int not null,
	[Averege score] numeric(4,3),
	[Form of education] nvarchar(8) default 'day',
	[Academic leave] tinyint default 0
)
create table Disciplines
(
	Code int primary key,
	[Name of Disciplines] nvarchar(20) not null unique
)
create table Sesion
(
	Id int primary key,
	[BookNumber] int foreign key references Stydents([Number of book]),
	[CodeDisciplines] int foreign key references Disciplines(Code),
	[Date] date not null,
	[Time] time not null,
	[Auditorium] int not null,
	[Score] int not null
)