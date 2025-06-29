create role Exam;
grant select on [Clever students] to Exam;
grant select on Stydents to Exam;
grant select, insert, update on Sesion to Exam;
grant execute on Check_Unique_Sesion to Exam;

create user Test;
alter role Exam add member Test;
