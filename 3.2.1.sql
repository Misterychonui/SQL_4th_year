/*a)  ������� ���������� � ��������� ������� � ��������� ����� �� �������� ���� ������*/
select d.FIODoctor , s.Coupons
from Schedule s 
inner join Stattalon c on s.ID=c.ScheduleID
inner join Doctor d on d.ID=s.DoctorID
where ([Day of week]=datename(dw,getdate()) and [FIODoctor] like '������ �������� ���������' and c.[Aliling Patinet] not like 'NULL')