/*c)  Пациент пришел на медосмотр. Выбрать всех специалистов, к которым он может сегодня попасть (без учета свободных/занятых талонов)*/

select d.[FIODoctor], d.Position, d.Cabinet
from Schedule s inner join Doctor d
on s.DoctorID=d.ID and s.[Day of week] like datename(dw,getdate())
