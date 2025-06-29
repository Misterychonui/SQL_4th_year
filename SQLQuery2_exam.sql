Insert Disciplines (Code, [Name of Disciplines])
Values
(1,'Math'),
(2,'Language'),
(3,'PE');

insert Stydents ([Number of book], FIO, [Year of Admission], [Group], [Course], [Averege score], [Form of education], [Academic leave])
values
(1,'Sych Maxim', 2020,'IB-4', 4, 4.123,'day',0),
(2,'Sorokin Semen',2020,'KB-4',4, 4.123,'day',0),
(3,'Mironova Lisa',2020,'IB-4',4, 4.456,'day',0),
(4,'Odinsova Kate',2020,'KB-4',4, 4.456,'day',0),
(5,'Gopanenko Ann',2021,'IB-3',3, 4.436,'night',0);
select * from Stydents

insert Sesion(Id, [BookNumber], [CodeDisciplines], [Date], [Time], [Auditorium], [Score])
values
(1,1,1, '2024-07-05', '09:00', 410, 4),
(2,1,1, '2024-07-05', '09:00', 410, 4),
(3,2,2, '2024-07-06', '10:00', 401, 4),
(4,3,3, '2024-07-07', '10:00', 402, 4),
(5,4,1, '2024-07-05', '09:00', 410, 4),
(6,5,2, '2024-07-06', '11:00', 401, 4);

alter view [Clever students] as (select s.[Group],FIO,[Averege Score],[Course] from Stydents s
--where [Averege Score] in
--(select Max([Averege Score]) from Stydents
--group by [Group] 
--)
join(select Max([Averege Score])as Maxg, [Group] from Stydents
group by [Group] ) 
g on s.[Group] = g.[Group] and s.[Averege score] =g.Maxg 
)

select * from [Clever students]