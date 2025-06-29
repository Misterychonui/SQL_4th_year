--��� ������ ��-41��
use [KB];
alter trigger TriggerSych
on [�����]
after insert
as
begin
declare @EditorID int;
declare @BookCount int;
declare @NewEditorID int;
declare @ContractID int;

select @EditorID = [������������� ��������], @ContractID = [� ���������]
from inserted;

select @BookCount = count(*) from �����
where [������������� ��������] = @EditorID and [���� ������] is null;

if @BookCount > 5
begin
	select top 1 @NewEditorID = s.[��������� �����]
	from ���������� s JOIN ��������� d on s.[��� ���������] = d.[��� ���������]
	where d.[�������� ���������] = '��������'
	and (select count(*) from ����� k where k.[������������� ��������] = s.[��������� �����] and k.[���� ������] is null) < 5;

	if @NewEditorID is not null
	begin
		update �����
		set [������������� ��������] = @NewEditorID
		where [� ���������] = @ContractID;
	end
else
begin
	raiserror('��������� ���������� ���� � ���������. ����� ������� ��������� �� �������. �������� �� ����� ���� ��������.', 16, 1);
	rollback transaction;
end
end
end;
INSERT [�����] ([� ���������], [���� ������� ���������], [��������], [��������], [����], [�������], [��������� �������], [���� ������], [�����], [������������� ��������], [������� ������]) VALUES (8, CAST(0xA9390B00 AS Date), 4, N'������������� �����������', 270.0000, 200.0000, 120.0000, CAST(0xC8390B00 AS Date), 2000, 2, 2000)


--�������� ���������
alter procedure ProcedureSych
@���������� int,--R1
@���������� int,--R1
@��� nvarchar(50)--R6
as 
begin 
select top 1 k.[�������], k.[�����������] from [University\m.sych].[R6] k
left join [University\m.sych].[R1] r on k.[�������]=r.[�������]
and r.[���� ������]=@���������� 
and r.[����� �����]=@����������
where k.[���] = @��� and r.[�������] is null
order by k.[�����������] desc
end

exec ProcedureSych 1,2, N'���������� ���������';

--multi-statement �������

create function FunctionSych()
returns @ScheduleDetails table (
����� nvarchar(10),
������� nvarchar(50),
[���������� ������ �� �����] int,
[���������� ������ � ����������] int
)
as
begin

insert into @ScheduleDetails (�����, �������, [���������� ������ �� �����], [���������� ������ � ����������])
select up.�����, up.�������, up.[���������� ������ � ������] as [���������� ������ �� �����],
isnull (rs.[���������� ������ � ����������], 0) as [���������� ������ � ����������]
from [University\m.sych].[R2] up
left join ( select �����, �������, count(*) as [���������� ������ � ����������] from [University\m.sych].[R1]
group by �����, �������) rs
on up.����� = rs.����� and up.������� = rs.�������;

return;
end;

select * from FunctionSych();

