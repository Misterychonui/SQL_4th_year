alter function Check_Unique_Sesion()
returns table
as
return 
(
select [Date],[Time],[Auditorium]   from Sesion group by [Date], [Time], [Auditorium] having count(*)>1
);


select * from  Check_Unique_Sesion();


alter trigger Update_Average_Score on Sesion
after update, insert 
as
begin
update Stydents
set [Averege score] = (select avg(Cast([Score] as float)) from Sesion where [BookNumber]=[Number of book])
where [Number of book] in (select distinct [BookNumber] from inserted)
end

insert Sesion(Id, [BookNumber], [CodeDisciplines], [Date], [Time], [Auditorium], [Score])
values
(8,1,3, '2024-07-05', '14:00', 406, 5);
select * from Sesion
select * from Stydents