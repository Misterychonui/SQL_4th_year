create ROLE Sych_Doctor;
go
grant execute on [University\m.sych].[GetDoctorSchedule] to Sych_Doctor with grant option;
grant execute on [University\m.sych].[GetFioByPlotNumder] to Sych_Doctor with grant option;
grant execute on [University\m.sych].[GetFioWithMaxHouses] to Sych_Doctor with grant option;

go
grant select on [University\m.sych].[Addres] to Sych_Doctor with grant option;
grant select on [University\m.sych].[Doctor] to Sych_Doctor with grant option;
grant select on [University\m.sych].[Schedule] to Sych_Doctor with grant option;
grant select on [University\m.sych].[Stattalon] to Sych_Doctor with grant option;

drop  role Sych_Doctor;

CREATE ROLE Sych_Head_Doctor;
go
grant execute on [University\m.sych].[GetDoctorSchedule] to Sych_Doctor with grant option;
grant execute on [University\m.sych].[GetFioByPlotNumder] to Sych_Doctor with grant option;
grant execute on [University\m.sych].[GetFioWithMaxHouses] to Sych_Doctor with grant option;

grant execute on [University\m.sych].[GetDoctorSchedule] to Sych_Head_Doctor;
grant execute on [University\m.sych].[GetFioByPlotNumder] to Sych_Head_Doctor;
grant execute on [University\m.sych].[GetFioWithMaxHouses] to Sych_Head_Doctor;

grant select, update, insert on [University\m.sych].[Addres] to Sych_Head_Doctor with grant option;
grant select, update, insert on [University\m.sych].[Doctor] to Sych_Head_Doctor with grant option;
grant select, update, insert on [University\m.sych].[Schedule] to Sych_Head_Doctor with grant option;
grant select, update, insert on [University\m.sych].[Stattalon] to Sych_Head_Doctor with grant option;
grant select, update, insert on [University\m.sych].[Plot] to Sych_Head_Doctor with grant option;


grant select on [University\m.sych].[GetFreeSlotsByDoctor] to Sych_Head_Doctor;

revoke grant option for select on [University\m.sych].[Stattalon] to Sych_Head_Doctor;



