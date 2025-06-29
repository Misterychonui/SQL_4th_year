/*a)  Выбрать информацию о свободных талонах к заданному врачу на заданный день недели*/
select d.FIODoctor , s.Coupons
from Schedule s 
inner join Stattalon c on s.ID=c.ScheduleID
inner join Doctor d on d.ID=s.DoctorID
where ([Day of week]=datename(dw,getdate()) and [FIODoctor] like 'Ягодин Вячеслав Тарасович' and c.[Aliling Patinet] not like 'NULL')