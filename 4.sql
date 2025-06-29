--use [Registry];
use [2023_KB_1];
ALTER PROCEDURE GetDoctorSchedule
AS
BEGIN
    SELECT d.FIODoctor, d.Cabinet, s.[Reception time],s.Coupons - ISNULL(COUNT(st.ID), 0) AS PatientCount
    FROM Doctor d JOIN Schedule s ON d.ID = s.DoctorID
    LEFT JOIN Stattalon st ON s.ID = st.ScheduleID AND st.[Date of examination] = CAST(GETDATE() AS DATE)
    WHERE DATENAME(WEEKDAY, GETDATE()) = s.[Day of week]
    GROUP BY d.FIODoctor,d.Cabinet, s.[Reception time], s.Coupons
END

--из купонов вычесть кол-во статалонов
exec GetDoctorSchedule


select * from Schedule where [Day of week]=N'Tuesday'; 
select * from Stattalon where [Date of examination] =  CAST(GETDATE() AS DATE);

Insert Stattalon([ScheduleID], [Aliling Patinet], Diagnosos, [Date of examination]) 
Values
(8, N'130-678-390-62', N'arm muscle strain','2024-06-11'), 
(10, N'130-456-765-32', N'pneumonia', '2024-06-11'),
(13, N'130-678-390-62', N'arm muscle strain','2024-06-11'),
(15, N'130-456-765-32', N'pneumonia', '2024-06-11');


--alter PROCEDURE GetStreetsByPlotNumber
--    @PlotNumber INT
--AS
--BEGIN
--    SELECT distinct [Street]
--    FROM Addres
--    WHERE PlotID = @PlotNumber
--END

--declare @plnumber int;
--set @plnUmber = 3
--exec GetStreetsByPlotNumber @plnUmber

alter PROCEDURE  GetFioByPlotNumder
    @PlotNumber INT,
	@DoctorName NVARCHAR(max) OUTPUT
AS
BEGIN
    SELECT @DoctorName = STRING_AGG(d.FIODoctor, ',') 
    FROM Doctor d
    JOIN Plot p ON p.ID = d.[Plot number]
    WHERE p.Number = @PlotNumber
END
--output 
declare @DoctorInfo NVARCHAR(max);
exec GetFioByPlotNumder 1, @DoctorInfo output
Select @DoctorInfo as DoctorInfo


alter procedure GetFioWithMaxHouses
as
begin
	DECLARE @PlotNumber INT
	declare @AdressFlat int
    DECLARE @DoctorName NVARCHAR(max) 

	SELECT TOP 1 @PlotNumber = a.PLOTID FROM Addres a
    GROUP BY a.PLOTID
    ORDER BY COUNT(a.ID) DESC
	EXEC GetFioByPlotNumder @PlotNumber, @DoctorName output

    SELECT @PlotNumber as PlotNumber, @DoctorName as DoctorName
end

exec GetFioWithMaxHouses


alter FUNCTION GetPlotNumberByAddress
(
    @Street NVARCHAR(50),
    @House INT,
	@Flat int
)
RETURNS INT
AS
BEGIN
    DECLARE @PlotNumber INT

    SELECT @PlotNumber = PLOTID
    FROM Addres
    WHERE Street = @Street AND House = @House and Flat = @Flat 

    RETURN @PlotNumber
end

declare @PlotNumber int
exec @PlotNumber = GetPlotNumberByAddress 'Gagarin street', 13, 150
print @PlotNumber

alter FUNCTION GetVisitsByPatient
(
    @InsurancePolicy NVARCHAR(16)
)
RETURNS TABLE
AS
RETURN
(
    SELECT  d.FIODoctor, st.Diagnosos, st.[Date of examination]
	FROM Schedule s
    LEFT JOIN Stattalon st ON s.ID = st.ScheduleID
	left join Doctor d on d.ID = s.DoctorID
    WHERE  d.ID=s.DoctorID and  st.[Aliling Patinet] = @InsurancePolicy AND YEAR(st.[Date of examination]) = YEAR(GETDATE())
)

select * from GetVisitsByPatient ('131-325-293-13')


alter FUNCTION GetFreeSlotsByDoctor
(
    @DoctorID INT
)
RETURNS @FreeSlots TABLE
(
    DayOfWeek NVARCHAR(15),
    ReceptionTime NVARCHAR(20),
	Coupons int
)
AS
BEGIN
    INSERT INTO @FreeSlots
   SELECT s.[Day of week], s.[Reception time], s.[Coupons]
    FROM Schedule s
    LEFT JOIN (SELECT ScheduleID FROM Stattalon GROUP BY ScheduleID) AS st ON s.ID = st.ScheduleID
    WHERE s.DoctorID = @DoctorID AND (s.Coupons != 0)
    RETURN
END

select * from GetFreeSlotsByDoctor(3)



