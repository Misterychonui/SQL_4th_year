use [2023_KB_1];
--use [Registry];--
create table Plot
(
ID INT PRIMARY KEY IDentity(1,1),
Number int not null
)
create table Stattalon
(
ID INT PRIMARY KEY Identity(1,1),
[ScheduleID] INT foreign key references Schedule(ID),
[Aliling Patinet] nvarchar(16) foreign key references Patient([Insurance policy] ),
Diagnosos nvarchar(200),
[Date of examination] date not null
)
create table Schedule
(
ID INT PRIMARY KEY IDentity(1,1),
[DoctorID] INT Foreign key references Doctor(ID),
[Day of week] nvarchar(15) not null,
[Coupons] int not null,
[Reception time] nvarchar(20) not null
)
create table Patient
(
FIOPatient Nvarchar(50) not null,
[Insurance policy] Nvarchar(16) primary key,
Age int not null,
[AddresID] int not null foreign key references Addres(ID)
)
create table Doctor
(
ID INT PRIMARY KEY,
FIODoctor Nvarchar(50) not null unique,
Position Nvarchar(50) not null,
Cabinet int not null ,
[Plot number] int foreign key references Plot(ID)
)

create table Addres
(
ID INT PRIMARY KEY IDentity(1,1),
[PLOTID] int foreign key references Plot(ID),
Street Nvarchar(50) not null,
House int not null,
Flat int not null
)


Insert Patient(FIOPatient, [Insurance policy], Age, [AddresID])
Values
(N'Nikiforova Regina Kazimirovna', '131-325-293-13', 24, 1),
(N'Golotina Veronika Nikolaevna', '130-456-765-32', 65, 2),
(N'Chumakova Zinaida Antoninovna', '130-678-390-62', 23, 2),
(N'Chirkov Ivan Makarovich', '131-100-659-40', 44, 3),
(N'Marin Gerasim Samuilovich', '130-567-753-90', 11, 1);

Select * From Patient

Insert Schedule([DoctorID], [Day of week], [Coupons], [Reception time])
Values
--(4,N'Wednesday', 4, '10:00-14:00'),
--(2,N'Tuesday', 2, '09:00-17:00'),
--(2,N'Tuesday', 4, '09:00-17:00'),
--(4,N'Воскресенье',1, '10:00-17:00'),
--(4,N'Sunday',1, '10:00-17:00'),
(1,N'Monday', 1, '10:00-18:00'),
--(1,N'Tuesday', 3, '10:00-18:00'),
(2,N'Monday', 2, '09:00-17:00'),
--(2,N'Tuesday', 4, '09:00-17:00'),
--(3,N'Wednesday',  5, '09:00-16:00'),
--(3,N'Thursday',  0, '09:00-16:00'),
--(3,N'Tuesday',  3, '09:00-16:00'),
--(3,N'Wednesday',  2, '09:00-16:00'),
--(4,N'Tuesday',3, '10:00-17:00'),
--(4,N'Friday',1, '10:00-17:00'),
--(5,N'Wednesday', 2, '11:00-16:00'),
(5,N'Monday', 6, '11:00-16:00');

Select * From Schedule

Insert Doctor(ID, FIODoctor, Position, Cabinet, [Plot number])
Values
(1,N'Kipriyanova Victoria Rostislavovna', 'Lor', 101, 1),
(2,N'Kuvardina Svetlana Karpovna', 'Oculist', 115, 1),
(3,N'Yagodin Vyacheslav Tarasovich', 'Therapist', 123, 2),
(4,N'Burilicheva Polina Stepanovna', 'Surgeon', 144, 1),
(5,N'Shiryaeva Marina Vladlenovna', 'Endocrinologist', 212, 2);

Select * From Doctor 

Insert Stattalon([ScheduleID], [Aliling Patinet], Diagnosos, [Date of examination]) 
Values
(7, N'130-678-390-62', N'arm muscle strain','2024-06-21'),
(9, N'130-456-765-32', N'pneumonia', '2024-06-22'),
(10, N'130-678-390-62', N'arm muscle strain','2024-06-22'),
(8,N'131-325-293-13', N'cataract', '2024-06-21'),
(11, N'131-100-659-40', N'allergy','2024-06-23');

Select * From Stattalon

Insert Plot(Number)
values
(1),
(2),
(3);
Select * From Plot

Insert Addres([PLOTID], Street, House, Flat)
values
(1,N'Matrsova street', 7, 43);
(1,N'Moscow avenue', 163, 146),
(2,N'Slepneva street', 24, 47),
(3,N'Matrosova street', 7, 23),
(2,N'Gagarin street', 13, 150),
(1,N'Suzdal highway', 10, 16);
Select * From Addres


