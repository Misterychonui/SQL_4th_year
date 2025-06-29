--Сыч Максим КБ-41СО
use [KB];
alter trigger TriggerSych
on [Книги]
after insert
as
begin
declare @EditorID int;
declare @BookCount int;
declare @NewEditorID int;
declare @ContractID int;

select @EditorID = [Ответственный редактор], @ContractID = [№ контракта]
from inserted;

select @BookCount = count(*) from Книги
where [Ответственный редактор] = @EditorID and [Дата выхода] is null;

if @BookCount > 5
begin
	select top 1 @NewEditorID = s.[Табельный номер]
	from Сотрудники s JOIN Должности d on s.[Код должности] = d.[Код должности]
	where d.[Название должности] = 'Редактор'
	and (select count(*) from Книги k where k.[Ответственный редактор] = s.[Табельный номер] and k.[Дата выхода] is null) < 5;

	if @NewEditorID is not null
	begin
		update Книги
		set [Ответственный редактор] = @NewEditorID
		where [№ контракта] = @ContractID;
	end
else
begin
	raiserror('Превышено количество книг у редактора. Найти другого редактора не удалось. Контракт не может быть заключен.', 16, 1);
	rollback transaction;
end
end
end;
INSERT [Книги] ([№ контракта], [Дата подписи контракта], [Менеджер], [Название], [Цена], [Затраты], [Авторский гонорар], [Дата выхода], [Тираж], [Ответственный редактор], [Остаток тиража]) VALUES (8, CAST(0xA9390B00 AS Date), 4, N'Экономическая информатика', 270.0000, 200.0000, 120.0000, CAST(0xC8390B00 AS Date), 2000, 2, 2000)


--хранимая процедура
alter procedure ProcedureSych
@Деньнедели int,--R1
@Номерурока int,--R1
@Тип nvarchar(50)--R6
as 
begin 
select top 1 k.[Кабинет], k.[Вместимость] from [University\m.sych].[R6] k
left join [University\m.sych].[R1] r on k.[Кабинет]=r.[Кабинет]
and r.[День недели]=@Деньнедели 
and r.[Номер урока]=@Номерурока
where k.[Тип] = @Тип and r.[Кабинет] is null
order by k.[Вместимость] desc
end

exec ProcedureSych 1,2, N'Лекционная аудитория';

--multi-statement функция

create function FunctionSych()
returns @ScheduleDetails table (
Класс nvarchar(10),
Предмет nvarchar(50),
[Количество уроков по плану] int,
[Количество уроков в расписании] int
)
as
begin

insert into @ScheduleDetails (Класс, Предмет, [Количество уроков по плану], [Количество уроков в расписании])
select up.Класс, up.Предмет, up.[Количество уроков в неделю] as [Количество уроков по плану],
isnull (rs.[Количество уроков в расписании], 0) as [Количество уроков в расписании]
from [University\m.sych].[R2] up
left join ( select Класс, Предмет, count(*) as [Количество уроков в расписании] from [University\m.sych].[R1]
group by Класс, Предмет) rs
on up.Класс = rs.Класс and up.Предмет = rs.Предмет;

return;
end;

select * from FunctionSych();

