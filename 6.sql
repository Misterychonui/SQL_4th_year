--���������� �� ����� SQL Server ����� ��������� ��������������. ������������� ������.

--�������� 2 ����� ����� SQL Server( Test1, Test2). ���� � �������  SQL Server Management Studio (SSMS), ������ � ������� ������� Create Login.
CREATE LOGIN Test2 WITH PASSWORD = 'password';
GO
--�������� ���� ������������� ����� ���� ������( Test1, Test2). ������ � �������  SSMS, ������� � ������� ������� Create User.
--USE [Registry]
use [2023_KB_1];
GO
CREATE USER Test2 FOR LOGIN Test2;
GO
--�������� ���� 2 ���� ���� ������ (Role1, Role2). ���� � �������  SSMS, ������ � ������� �������.
--USE [Registry]
use [2023_KB_1];
GO
CREATE ROLE Role2;
GO
--�������� ������������ Test1 ���������� ���� Role1, � Test2 - Role2.(SSMS, �������)
--USE [Registry]
use [2023_KB_1];
GO
ALTER ROLE Role2 ADD MEMBER Test2;
GO

--USE [Registry]
use [2023_KB_1];
GO
CREATE ROLE Boss;
GO

--USE [Registry]
use [2023_KB_1];
GO 
CREATE ROLE Doctor;
GO

