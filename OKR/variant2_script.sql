USE accounting;

-- Создание таблиц
-- Отделы
CREATE TABLE Departments (
    DepartmentId INT IDENTITY(1,1) PRIMARY KEY,
    [DepartmentName] NVARCHAR(255) NOT NULL
);

-- Должности
CREATE TABLE Positions (
    PositionId INT IDENTITY(1,1) PRIMARY KEY,
    [PositionName] NVARCHAR(255) NOT NULL,
    [Salary] DECIMAL(10, 2) NOT NULL
);

-- Сотрудники
CREATE TABLE Employees (
    [EmployeeId] INT PRIMARY KEY,
    [FullName] NVARCHAR(255) NOT NULL,
    [SSN] NVARCHAR(12) UNIQUE NOT NULL,
    [Gender] NVARCHAR(1) DEFAULT 'M',
    [DateOfBirth] DATE NOT NULL,
    [CurrentDepartment] INT,
    [CurrentPosition] INT,
    [DateOfEmployment] DATE,
    [PreviousWorkExperience] INT DEFAULT 0,
    FOREIGN KEY ([CurrentDepartment]) REFERENCES Departments(DepartmentId),
    FOREIGN KEY ([CurrentPosition]) REFERENCES Positions(PositionId)
);

-- Трудовая книжка
CREATE TABLE EmploymentRecords (
    [EmployeeId] INT,
    [DateOfEmployment] DATE,
    [Position] INT,
    FOREIGN KEY ([EmployeeId]) REFERENCES Employees([EmployeeId]),
    FOREIGN KEY ([Position]) REFERENCES Positions(PositionId)
);

-- Заполнение таблиц данными
INSERT INTO Departments ([DepartmentName])
VALUES
    ('IT'),
    ('Банк'),
    ('Бухгалтерия');

INSERT INTO Positions ([PositionName], [Salary])
VALUES
    ('Senior .NET Software Engineer', 150000.00),
    ('Младший банкир', 30000.00),
    ('Главный бухгалтер', 90000.00);

INSERT INTO Employees ([EmployeeId], [FullName], [SSN], [Gender], [DateOfBirth], [CurrentDepartment], [CurrentPosition],
                       [DateOfEmployment], [PreviousWorkExperience])
VALUES
    (1, 'Александр Зеневич', '123456789012', 'M', '1990-09-24', 1, 1, '2021-05-01', 2),
    (2, 'Дарья Олеговна', '210987654321', 'F', '1985-02-20', 2, 2, '2017-11-15', 0),
    (3, 'Илон Маск', '313131313131', 'M', '1988-03-17', 3, 3, '2023-03-10', 4),
    (4, 'Джерард Уэй', '792357192063', 'M', '1983-08-01', 1, 2, '2018-07-10', 3),
    (5, 'Филипп Киркорович', '195821057320', 'M', '1973-12-30', 2, 1, '2019-02-25', 1),
    (6, 'Андрей Штормович', '678901234567', 'M', '1995-04-03', 3, 3, '2016-09-18', 2);

INSERT INTO EmploymentRecords ([EmployeeId], [DateOfEmployment], [Position])
VALUES
    (1, '2021-05-01', 1),
    (2, '2017-11-15', 2),
    (3, '2023-03-10', 3),
    (4, '2018-07-10', 2),
    (5, '2019-02-25', 1),
    (6, '2016-09-18', 3);

-- Создание триггеров
-- Триггер для проверки значений полей в таблице "Сотрудники"
CREATE TRIGGER CheckEmployeeValues
ON Employees
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE ([DateOfBirth] - [PreviousWorkExperience] - DATEDIFF(YEAR, [DateOfBirth], GETDATE())) < 16)
    BEGIN
        THROW 51000, 'Возраст за вычетом предыдущего опыта работы за вычетом текущего опыта работы не может быть меньше 16 лет.', 1;
        ROLLBACK;
    END

    IF EXISTS (SELECT 1 FROM inserted WHERE [DateOfEmployment] > GETDATE())
    BEGIN
        THROW 51001, 'Дата поступления на работу должна быть не больше текущей даты.', 1;
        ROLLBACK;
    END
END;

-- Триггер для установки значения поля "пол" на основе отчества
CREATE TRIGGER SetGenderBasedOnPatronymic
ON Employees
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE e
    SET e.[Gender] = CASE
        WHEN RIGHT(e.[FullName], 3) = '-ВНА' THEN 'F'
        WHEN RIGHT(e.[FullName], 4) = '-ВИЧ' THEN 'M'
        ELSE 'ERROR' -- Invalid patronymic, trigger generates an error
    END
    FROM Employees e
    INNER JOIN inserted i ON e.[EmployeeId] = i.[EmployeeId]
    WHERE i.[Gender] IS NULL AND (RIGHT(i.[FullName], 3) = '-ВНА' OR RIGHT(i.[FullName], 4) = '-ВИЧ');
END;

-- Триггер для регистрации изменений в таблице "Сотрудники" в таблице "Трудовая книжка"
CREATE TRIGGER LogEmployeeChanges
ON Employees
AFTER UPDATE
AS
BEGIN
    INSERT INTO EmploymentRecords ([EmployeeID], [DateOfEmployment], [Position])
    SELECT i.[EmployeeId], GETDATE(), d.[CurrentPosition]
    FROM inserted i
    JOIN deleted d ON i.[EmployeeID] = d.[EmployeeID];
END;