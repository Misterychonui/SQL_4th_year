BEGIN TRANSACTION Schedule_Check
    DECLARE @DoctorID INT =2;  -- 2 � 3 � 115 � 123 rollback
    DECLARE @NewCabinet INT = 115; -- 1 � 5 � 101 � 212 commit
	UPDATE Doctor SET Cabinet = @NewCabinet WHERE ID = @DoctorID;
    IF EXISTS 
	(
		SELECT 1 FROM Doctor d JOIN Schedule s ON d.ID = s.DoctorID WHERE d.Cabinet = @NewCabinet
        AND d.ID <> @DoctorID
        AND s.[Day of week] 
		IN (SELECT s2.[Day of week] FROM Schedule s2 WHERE s2.DoctorID = @DoctorID)
    )
    BEGIN
        RAISERROR ('Cannot update cabinet, it is occupied by another doctor.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
	else
	begin
		COMMIT TRANSACTION;
	end
select * from Doctor

select * from Schedule order by DoctorID




 