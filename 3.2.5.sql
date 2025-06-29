/*e) Вывести количество посещений для каждого участка на заданную дату*/
Insert Stattalon([ScheduleID], [Aliling Patinet], Diagnosos, [Date of examination]) 
Values
(4, N'130-567-753-90','пневмония', '2024-03-10'),
(5, N'130-567-753-90','пневмония', '2024-03-10'),
(11,N'130-567-753-90', 'помутнение хрусталика', '2024-03-10');
Select * From Stattalon

SELECT Plot.ID as 'Номер участка', count(Stattalon.ID) AS VisitsCount
FROM Plot
LEFT JOIN Doctor ON Plot.ID = Doctor.[Plot number]
LEFT JOIN Schedule ON Doctor.ID = Schedule.DoctorID
LEFT JOIN Stattalon ON Schedule.ID = Stattalon.ScheduleID
WHERE [Date of examination] = CAST(GETDATE() AS date) and [dbo].[Stattalon].[Aliling Patinet] is not null and [dbo].[Stattalon].Diagnosos is not null 
GROUP BY Plot.ID;
