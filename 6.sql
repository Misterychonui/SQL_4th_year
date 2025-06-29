--Установите на Вашем SQL Server режим смешанной аутентификации. Перезагрузите сервер.

--Создайте 2 имени входа SQL Server( Test1, Test2). Одно с помощью  SQL Server Management Studio (SSMS), второе с помощью команды Create Login.
CREATE LOGIN Test2 WITH PASSWORD = 'password';
GO
--Создайте двух пользователей вашей базы данных( Test1, Test2). Одного с помощью  SSMS, второго с помощью команды Create User.
--USE [Registry]
use [2023_KB_1];
GO
CREATE USER Test2 FOR LOGIN Test2;
GO
--Создайте роль 2 роли базы данных (Role1, Role2). Одну с помощью  SSMS, вторую с помощью команды.
--USE [Registry]
use [2023_KB_1];
GO
CREATE ROLE Role2;
GO
--Сделайте пользователя Test1 участником роли Role1, а Test2 - Role2.(SSMS, команда)
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

