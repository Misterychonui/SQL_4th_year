/*b)  Для заданного пациента (ФИО) выдать все его посещения с начала текущего года*/
Insert Stattalon([ScheduleID], [Aliling Patinet], Diagnosos, [Date of examination]) 
Values
(4, N'130-567-753-90','пневмония', '2023-02-18'),
(6, N'130-567-753-90','пневмония', '2024-02-20'),
(2,N'130-567-753-90', 'помутнение хрусталика', '2024-01-20'),
(1, N'130-567-753-90', 'пневмония', '2024-02-22'),
(3, N'130-567-753-90', 'растяжения мышц рук','2024-03-04'),
(10, N'130-567-753-90', 'аллергия','2024-02-21');
Select * From Stattalon

select p.[FIOPatient],s.[Date of examination], s.Diagnosos, d.FIODoctor 
from [dbo].[Stattalon] s 
inner join [dbo].[Patient] p on p.[Insurance policy]=s.[Aliling Patinet] 
inner join [dbo].[Schedule] c on c.ID=s.ScheduleID
inner join [dbo].[Doctor] d on (d.ID=c.DoctorID and s.[Aliling Patinet] like '130-567-753-90' and year([Date of examination])=year(getdate()))
order by [Date of examination]

