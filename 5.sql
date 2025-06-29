--use [Registry];--
use [2023_KB_1];
Create TRIGGER check_doctor_insert
ON Doctor
FOR INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE [Position] = 'Therapist' AND [Plot number] IS NULL)
    BEGIN
         RAISERROR('Therapist must have a plot number.',  16,1)
        ROLLBACK TRANSACTION
    END
END

Insert Doctor(ID, FIODoctor, Position, Cabinet, [Plot number])
Values (6,N'Kuvardina Marina Rostislavovna', 'Lor', 102, 1)

Insert Doctor(ID, FIODoctor, Position, Cabinet, [Plot number])
Values (7,N'Burilicheva Victria Vladlenovna', 'Therapist', 122, null)


Create TRIGGER check_doctor_update
ON Doctor
FOR UPDATE
AS
BEGIN
    IF EXISTS 
	(
        SELECT 1 FROM inserted i
        JOIN Doctor d ON i.Cabinet = d.Cabinet AND i.ID <> d.ID 
		join Schedule s on i.ID = s.DoctorID
		join Schedule s1 on s1.DoctorID=s.DoctorID 
		where s.[Day of week] = s1.[Day of week]
    )
    BEGIN
         RAISERROR('Another doctor has the same cabinet.',16,1)
        ROLLBACK TRANSACTION
    END
END

update Doctor set [Cabinet]=101
where [FIODoctor]='Yagodin Vyacheslav Tarasovich'


alter TRIGGER check_schedule_delete
ON Schedule
INSTEAD OF DELETE
AS
BEGIN
declare @ID int
    DECLARE @DoctorID INT
    DECLARE @DayOfWeek NVARCHAR(15)
    DECLARE @cursor CURSOR

    SET @cursor = CURSOR FOR
    SELECT DoctorID, [Day of week], ID FROM deleted

    OPEN @cursor
    FETCH NEXT FROM @cursor INTO @DoctorID, @DayOfWeek, @ID

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF EXISTS (SELECT 1 FROM Schedule WHERE Schedule.ID 
		IN (SELECT [Schedule].ID FROM Schedule s join Stattalon st on st.ScheduleID=s.ID 
		WHERE DoctorID = @DoctorID AND [Day of week] = @DayOfWeek and s.ID=@ID
		and s.Coupons!=0 
		and st.[Date of examination]>=CONVERT(date, GETDATE())))
        BEGIN
            RAISERROR ('Cannot delete schedule with issued tickets.' ,16,1);	
        END
        ELSE
        BEGIN
					delete from Stattalon where ScheduleID=@ID 
            DELETE FROM Schedule WHERE DoctorID = @DoctorID AND [Day of week] = @DayOfWeek
        END
        FETCH NEXT FROM @cursor INTO @DoctorID, @DayOfWeek, @ID
    END

    CLOSE @cursor
    DEALLOCATE @cursor
END

select * from Stattalon
select * from Schedule
delete from Schedule where Schedule.[Day of week] = N'Monday' --удаления будет
delete from Schedule where Schedule.[Day of week] = N'Saturday'--удаления не будет

Insert Stattalon([ScheduleID], [Aliling Patinet], Diagnosos, [Date of examination]) 
Values
(19, N'130-678-390-62', N'trigger test','2024-06-03'),--проверить id
(20, N'130-678-390-62', N'trigger test','2024-06-03'),--проверить id
(20, N'130-678-390-62', N'trigger test','2024-06-10');--проверить id

Insert Schedule([DoctorID], [Day of week], [Coupons], [Reception time])
Values
(3,N'Saturday', 4, '10:00-14:00'),--удаления не будет
(2,N'Saturday', 2, '09:00-17:00'),--удаления не будет
(2,N'Saturday', 4, '09:00-17:00');--удаления не будет

Insert Stattalon([ScheduleID], [Aliling Patinet], Diagnosos, [Date of examination]) 
Values
(4, N'130-678-390-62', N'trigger test','2024-06-14'),--проверить id
(5, N'130-678-390-62', N'trigger test','2024-06-14'),--проверить id
(6, N'130-678-390-62', N'trigger test','2024-06-14');--проверить id

Insert Schedule([DoctorID], [Day of week], [Coupons], [Reception time])
Values
(3,N'Friday', 0, '10:00-14:00'),--удаления будет
(3,N'Friday', 0, '09:00-17:00'),--удаления будет
(3,N'Friday', 0, '09:00-17:00');--удаления будет

