Select * From Schedule
order by [Day of week], [Coupons] desc

Select * From Doctor
where [Plot number]=2

Select * From Stattalon
where Diagnosos = 'pneumonia'

Select COUNT(*) as Количество From Doctor
where Cabinet>150

Select [DoctorID], COUNT(*) as [Количество рабочих дней] from Schedule
group by [DoctorID]

select  [Day of week], [reception time] from Schedule
group by cube([Day of week],[Reception time])

select [Day of week] as День, Count([Day of week]) as [Количество дней], sum([Coupons]) as Талоны from Schedule
group by ([Day of week])
order by ([Day of week]) 


select * from Stattalon
where [Aliling Patinet] not like '%Ivan%'

select p.[Insurance policy], p.[Age], p.[AddresID], s. * from [dbo].[Patient] p, [dbo].[Stattalon] s
where p.[FIOPatient] = s.[Aliling Patinet]

select s.[Day of week], d. * from Schedule s, Doctor d
where s.[DoctorID] = d.[ID] and [Day of week] not like '%Wednesday%'

select p.[Insurance policy], p.[Age], p.[AddresID], s. * from [dbo].[Patient] p inner join [dbo].[Stattalon] s on p.[FIOPatient] = s.[Aliling Patinet]

select s.[Day of week], d. * from Schedule s inner join Doctor d on s.[DoctorID] = d.[ID] and [Day of week] not like '%Wednesday%'

select p.[Insurance policy], s.[Date of examination]
from Patient p left join Stattalon s
on p.FIOPatient=s.[Aliling Patinet]

select *
From Patient
LEFT JOIN Stattalon ON Patient.[Insurance policy] = Stattalon.[Aliling Patinet] 
left join Schedule on Schedule.ID=Stattalon.ScheduleID
LEFT JOIN Doctor on Schedule.DoctorID=Doctor.ID


select *
from Addres left join Patient
on Addres.ID=Patient.AddresID

select p.ID, d. *
from Plot p right join [dbo].[Doctor] d
on p.Number=d.[Plot number]

select s.[Day of week], d.FIODoctor
from Schedule s right join Doctor d
on s.DoctorID=d.ID and s.[Day of week] like '%Monday%'

select sum(s.Coupons) as 'All talons', d.FIODoctor 
from Schedule s join Doctor d on s.DoctorID=d.ID 
join Stattalon t on t.ScheduleID=s.ID and t.[Aliling Patinet] not like 'NULL'
Group by FIODoctor


select Count(s.[Date of examination]) as 'Number of patient', s.[Date of examination] as 'Reception day'
from [dbo].[Stattalon] s 
Group by s.[Date of examination]

select max(p.[Age]) as 'Age', s.[Aliling Patinet]
from Patient p join Stattalon s
on p.[Insurance policy]=s.[Aliling Patinet]
Group by s.[Aliling Patinet]
Having max(p.[Age])<40 and s.[Aliling Patinet] not like 'NULL'

select min(s.Coupons), d.Cabinet
from Doctor d join Schedule s
on d.ID=s.DoctorID
Group by d.Cabinet
Having min(s.Coupons)=0

select  p.ID as 'Plot number',count(d.[Plot number]) as 'Number of doctors'
from Doctor d join Plot p on d.[Plot number]=p.ID
group by p.ID 
having count(d.[Plot number]) >=1


select p.[FIOPatient] from Patient p
where exists
(select * from Addres a where a.ID=p.AddresID and p.[AddresID]=2)

select d.FIODoctor from Doctor d
where exists
(select s.DoctorID from Schedule s where s.DoctorID=d.ID and s.[Day of week] like 'Wednesday')

select s.[Date of examination] from Stattalon s
where s.[Aliling Patinet] in
(select p.[Insurance policy] from Patient p where s.[Aliling Patinet]=p.[Insurance policy] and s.[Diagnosos] like 'pneumonia' and s.[Aliling Patinet] not like 'NULL')

select p.[Insurance policy] from Patient p
where p.AddresID in
(select a.ID from Addres a where a.ID=p.AddresID and a.Street='Moscow avenue')

Create view [Free cabinet] as (select min(s.Coupons), d.Cabinet
from Doctor d join Schedule s on d.ID=s.DoctorID
Group by d.Cabinet)
select * from [Free cabinet]

Create view SNILS as (select p.[Insurance policy] from Patient p
where p.AddresID in
(select a.ID from Addres a where a.ID=p.AddresID and a.Street='Moscow avenue'))
select * from SNILS

with [Patient Names CTE] (Name) as(
select s.[Aliling Patinet] from Stattalon s join Schedule r on s.ScheduleID=r.ID and r.[DoctorID]=2)
select * from [Patient Names CTE]

with CabinetCTE (Cabinet, Plot) as(
select d.Cabinet,p.Number from Doctor d join Plot p on d.[Plot number]=p.ID)
select * from CabinetCTE

select ROW_NUMBER() over (order by  [Plot number]) as Номер, * from Doctor

select ROW_NUMBER() over(Partition by [Date of examination] order by [Aliling Patinet] desc) as Номер, * from [dbo].[Stattalon]

select rank() over (order by [PLOTID]) as Участок, * from Addres

select [Day of week], [Reception time] from [dbo].[Schedule]
where [Day of week] = 'Monday'
union
select [Day of week], [Reception time] from [dbo].[Schedule]
where [Day of week] = 'Wednesday'
order by [Day of week]

select [Diagnosos] from [dbo].[Stattalon]
except
select [Diagnosos] from [dbo].[Stattalon] s
where (select p.Age from Patient p where s.[Aliling Patinet]=p.FIOPatient)>24

select [FIOPatient] from [dbo].[Patient]
where [Age]<60
intersect
select [Aliling Patinet] from [dbo].[Stattalon]
where [Diagnosos] = 'pneumonia'

Select p.[FIOPatient], "Возрастная группа" =
CASE
when p.[Age]>=18 then 'Adult department'
when p.[Age]<18 then 'Childrens department'
end
from Patient p

select * from
(
select [Day of week], [Coupons]
from [dbo].[Schedule]
) as source
pivot
(
sum([Coupons]) for [Coupons] in([0],[1],[2],[3],[4],[5],[6]) 
)as [pivot] 

select [FIODoctor], [Type],[Value] from [dbo].[Doctor]
unpivot ([Value] for [Type] in([Cabinet],[Plot number])) as [unpivot]




