SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN TRANSACTION;
UPDATE Schedule SET Coupons = 5 WHERE ID = 1;
-- Проверяем изменения
SELECT * FROM Schedule WHERE ID = 1;
-- Session 1
ROLLBACK TRANSACTION;

SELECT * FROM Schedule WHERE ID = 1;
--Грязное чтение
-- Session 1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;
UPDATE Schedule SET Coupons = 5 WHERE ID = 1;
SELECT * FROM Schedule WHERE ID = 1;
-- В этот момент мы не фиксируем транзакцию и оставляем изменения незавершенными
-- Session 1
ROLLBACK TRANSACTION;
-- Проверяем, что данные откатились
SELECT * FROM Schedule WHERE ID = 1;

-- Read Commited
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;
SELECT * FROM Schedule WHERE ID = 1;
COMMIT TRANSACTION;

-- Repeateble read
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRANSACTION;
SELECT * FROM Schedule WHERE ID = 1;
COMMIT TRANSACTION;

-- Прочитаем данные снова (значение не должно измениться)
SELECT * FROM Schedule WHERE ID = 1;
COMMIT TRANSACTION;

-- Phantom
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRANSACTION;
SELECT * FROM Schedule;

-- Прочитаем данные снова (новая запись не должна появиться)
SELECT * FROM Schedule;
COMMIT TRANSACTION;

-- Phantom serialized
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;
SELECT * FROM Schedule;
-- Прочитаем данные снова (новая запись не должна появиться)
SELECT * FROM Schedule;
COMMIT TRANSACTION;