CREATE DATABASE NU_Student_ID_System1;
GO

USE NU_Student_ID_System1;
GO


CREATE TABLE Students
(
    StudentID VARCHAR(30) PRIMARY KEY,

    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    MiddleName VARCHAR(50),
    Suffix VARCHAR(10),

    Email VARCHAR(100),

    Program VARCHAR(100),
    YearLevel VARCHAR(30)
);
GO


CREATE TABLE Staff
(
    StaffID VARCHAR(30) PRIMARY KEY,

    Name VARCHAR(100),

    [S] VARCHAR(100),

    Role VARCHAR(50),

    Status VARCHAR(30),

    [__PowerAppsId__] VARCHAR(100)
);
GO

CREATE TABLE Schedules
(
    ScheduleID VARCHAR(30) PRIMARY KEY,

    ScheduleDate DATE,

    StartTime TIME,

    EndTime TIME,

    RequestType VARCHAR(50),

    Term VARCHAR(30),

    Venue VARCHAR(100),

    MaxSlots INT,

    CurrentSlots INT,

    AvailabilityStartDate DATE,

    AvailabilityEndDate DATE,

    Status VARCHAR(30),

    CHECK (MaxSlots > 0),

    CHECK (CurrentSlots >= 0),

    CHECK (CurrentSlots <= MaxSlots)
);
GO

CREATE TABLE IDApplications
(
    ApplicationID VARCHAR(30) PRIMARY KEY,

    StudentID VARCHAR(30),

    RequestType VARCHAR(50),

    Term VARCHAR(30),

    CORFileLink VARCHAR(500),

    CORStatus VARCHAR(50),

    Status VARCHAR(50),

    StaffRemarks VARCHAR(255),

    DateSubmitted DATETIME,

    DateReviewed DATETIME,

    FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID)
);
GO

CREATE TABLE Appointments
(
    AppointmentID VARCHAR(30) PRIMARY KEY,

    ApplicationID VARCHAR(30),

    ScheduleID VARCHAR(30),

    QueueNumber VARCHAR(20),

    QueueStatus VARCHAR(30),

    IDProcessingStatus VARCHAR(50),

    FOREIGN KEY (ApplicationID)
        REFERENCES IDApplications(ApplicationID),

    FOREIGN KEY (ScheduleID)
        REFERENCES Schedules(ScheduleID)
);
GO


CREATE TABLE IDApplication
(
    ApplicationID VARCHAR(30) PRIMARY KEY,

    StudentID VARCHAR(30) ,

    RequestType VARCHAR(50) ,

    Term VARCHAR(30),

    CORFileLink VARCHAR(500),

    CORStatus VARCHAR(50),

    Status VARCHAR(50),

    StaffRemarks VARCHAR(255),

    DateSubmitted DATETIME,

    DateReviewed DATETIME,

    FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID)
);
GO


CREATE TABLE Appointment
(
    AppointmentID VARCHAR(30) PRIMARY KEY,

    ApplicationID VARCHAR(30) ,

    ScheduleID VARCHAR(30) ,

    QueueNumber VARCHAR(20),

    QueueStatus VARCHAR(30),

    IDProcessingStatus VARCHAR(50),

    FOREIGN KEY (ApplicationID)
        REFERENCES IDApplications(ApplicationID),

    FOREIGN KEY (ScheduleID)
        REFERENCES Schedules(ScheduleID)
);
GO


CREATE TABLE AuditLog
(
    LogID VARCHAR(30) PRIMARY KEY,

    ApplicationID VARCHAR(30) ,

    Action VARCHAR(100),

    PerformedBy VARCHAR(100),

    [Timestamp] DATETIME,

    Notes VARCHAR(255),

    FOREIGN KEY (ApplicationID)
        REFERENCES IDApplications(ApplicationID)
);
GO



ALTER TABLE Students
ADD ReviewedByStaffID VARCHAR(30);
GO

ALTER TABLE Students
ADD CONSTRAINT FK_Students_Staff
FOREIGN KEY (ReviewedByStaffID) REFERENCES Staff(StaffID);
GO

ALTER TABLE Staff
ADD LastProcessedApplicationID VARCHAR(30);
GO

ALTER TABLE Staff
ADD CONSTRAINT FK_Staff_IDApplication
FOREIGN KEY (LastProcessedApplicationID) REFERENCES IDApplication(ApplicationID);
GO

ALTER TABLE Schedules
ADD CreatedByStaffID VARCHAR(30);
GO

ALTER TABLE Schedules
ADD CONSTRAINT FK_Schedules_Staff
FOREIGN KEY (CreatedByStaffID) REFERENCES Staff(StaffID);
GO

INSERT INTO Students
(
    StudentID,
    LastName,
    FirstName,
    MiddleName,
    Suffix,
    Email,
    Program,
    YearLevel
)
VALUES

(
    '2026-100001',
    'Navarro',
    'Adrian',
    'Lopez',
    NULL,
    'anavarro@student.nu-fairview.edu.ph',
    'BS Information Technology',
    '1st Year'
),

(
    '2026-100002',
    'Castillo',
    'Bianca',
    'Reyes',
    NULL,
    'bcastillo@student.nu-fairview.edu.ph',
    'BS Computer Science',
    '2nd Year'
),

(
    '2026-100003',
    'Aquino',
    'Cedric',
    'Flores',
    NULL,
    'caquino@student.nu-fairview.edu.ph',
    'BS Architecture',
    '3rd Year'
),

(
    '2026-100004',
    'Villanueva',
    'Denise',
    'Garcia',
    NULL,
    'dvillanueva@student.nu-fairview.edu.ph',
    'BS Civil Engineering',
    '2nd Year'
),

(
    '2026-100005',
    'Mendoza',
    'Ethan',
    'Cruz',
    'Jr',
    'emendoza@student.nu-fairview.edu.ph',
    'BS Accountancy',
    '1st Year'
),

(
    '2026-100006',
    'Ramos',
    'Faith',
    'Torres',
    NULL,
    'framos@student.nu-fairview.edu.ph',
    'BS Hospitality Management',
    '4th Year'
);
GO

INSERT INTO Staff
(
    StaffID,
    Name,
    [S],
    Role,
    Status,
    [__PowerAppsId__]
)
VALUES

(
    'STF-001',
    'Andrea Santos',
    'asantos@nu-fairview.edu.ph',
    'Administrator',
    'Active',
    'PA-STAFF-001'
),

(
    'STF-002',
    'Miguel Rivera',
    'mrivera@nu-fairview.edu.ph',
    'Staff',
    'Active',
    'PA-STAFF-002'
),

(
    'STF-003',
    'Clarisse Lim',
    'clim@nu-fairview.edu.ph',
    'Staff',
    'Active',
    'PA-STAFF-003'
),

(
    'STF-004',
    'Joshua Tan',
    'jtan@nu-fairview.edu.ph',
    'Staff',
    'Active',
    'PA-STAFF-004'
),

(
    'STF-005',
    'Patricia Gomez',
    'pgomez@nu-fairview.edu.ph',
    'Staff',
    'Inactive',
    'PA-STAFF-005'
);
GO


INSERT INTO Schedules
(
    ScheduleID,
    ScheduleDate,
    StartTime,
    EndTime,
    RequestType,
    Term,
    Venue,
    MaxSlots,
    CurrentSlots,
    AvailabilityStartDate,
    AvailabilityEndDate,
    Status
)
VALUES

(   
    'SCH-001',
    '2026-10-15',
    '09:00:00',
    '11:00:00',
    'New ID',
    '1st Term',
    'ITSO Office',
    30,
    1,
    '2026-10-08',
    '2026-10-14',
    'Available'
),

(
    'SCH-002',
    '2026-10-15',
    '13:00:00',
    '15:00:00',
    'New ID',
    '1st Term',
    'ITSO Office',
    30,
    1,
    '2026-10-08',
    '2026-10-14',
    'Available'
),

(
    'SCH-003',
    '2026-10-16',
    '09:00:00',
    '11:00:00',
    'Update',
    '1st Term',
    'ITSO Office',
    25,
    1,
    '2026-10-08',
    '2026-10-15',
    'Available'
),

(
    'SCH-004',
    '2026-10-16',
    '13:00:00',
    '15:00:00',
    'Update',
    '1st Term',
    'ITSO Office',
    25,
    1,
    '2026-10-08',
    '2026-10-15',
    'Available'
),

(
    'SCH-005',
    '2026-10-17',
    '09:00:00',
    '11:00:00',
    'Lost ID',
    '1st Term',
    'ITSO Office',
    20,
    1,
    '2026-10-08',
    '2026-10-16',
    'Available'
),

(
    'SCH-006',
    '2026-10-17',
    '13:00:00',
    '15:00:00',
    'Damaged ID',
    '1st Term',
    'ITSO Office',
    20,
    1,
    '2026-10-08',
    '2026-10-16',
    'Available'
);
GO


INSERT INTO IDApplications
(
    ApplicationID,
    StudentID,
    RequestType,
    Term,
    CORFileLink,
    CORStatus,
    Status,
    StaffRemarks,
    DateSubmitted,
    DateReviewed
)
VALUES

(
    'APP-001',
    '2026-100001',
    'New ID',
    '1st Term',
    'https://example.com/cor/student1',
    'Verified',
    'Approved',
    'Requirements complete',
    '2026-10-08 08:00:00',
    '2026-10-08 09:00:00'
),

(
    'APP-002',
    '2026-100002',
    'New ID',
    '1st Term',
    'https://example.com/cor/student2',
    'Verified',
    'Approved',
    'Requirements complete',
    '2026-10-08 08:15:00',
    '2026-10-08 09:15:00'
),

(
    'APP-003',
    '2026-100003',
    'Update',
    '1st Term',
    'https://example.com/cor/student3',
    'Verified',
    'Approved',
    'Update request approved',
    '2026-10-08 08:30:00',
    '2026-10-08 09:30:00'
),

(
    'APP-004',
    '2026-100004',
    'Update',
    '1st Term',
    'https://example.com/cor/student4',
    'Verified',
    'Approved',
    'Update request approved',
    '2026-10-08 08:45:00',
    '2026-10-08 09:45:00'
),

(
    'APP-005',
    '2026-100005',
    'Lost ID',
    '1st Term',
    'https://example.com/cor/student5',
    'Verified',
    'Approved',
    'Lost ID request approved',
    '2026-10-08 09:00:00',
    '2026-10-08 10:00:00'
),

(
    'APP-006',
    '2026-100006',
    'Damaged ID',
    '1st Term',
    'https://example.com/cor/student6',
    'Verified',
    'Approved',
    'Damaged ID request approved',
    '2026-10-08 09:15:00',
    '2026-10-08 10:15:00'
);
GO

INSERT INTO Appointments
(
    AppointmentID,
    ApplicationID,
    ScheduleID,
    QueueNumber,
    QueueStatus,
    IDProcessingStatus
)
VALUES

(
    'APT-001',
    'APP-001',
    'SCH-001',
    'N001',
    'Waiting',
    'Pending'
),

(
    'APT-002',
    'APP-002',
    'SCH-002',
    'N002',
    'Waiting',
    'Pending'
),

(
    'APT-003',
    'APP-003',
    'SCH-003',
    'U001',
    'Waiting',
    'Pending'
),

(
    'APT-004',
    'APP-004',
    'SCH-004',
    'U002',
    'Waiting',
    'Pending'
),

(
    'APT-005',
    'APP-005',
    'SCH-005',
    'L001',
    'Waiting',
    'Pending'
),

(
    'APT-006',
    'APP-006',
    'SCH-006',
    'D001',
    'Waiting',
    'Pending'
);
GO


INSERT INTO AuditLog
(
    LogID,
    ApplicationID,
    Action,
    PerformedBy,
    [Timestamp],
    Notes
)
VALUES

(
    'LOG-001',
    'APP-001',
    'Submitted',
    '2026-100001',
    '2026-10-08 08:00:00',
    'New ID application submitted'
),

(
    'LOG-002',
    'APP-001',
    'Approved',
    'STF-001',
    '2026-10-08 09:00:00',
    'New ID application approved'
),

(
    'LOG-003',
    'APP-002',
    'Approved',
    'STF-002',
    '2026-10-08 09:15:00',
    'New ID application approved'
),

(
    'LOG-004',
    'APP-003',
    'Approved',
    'STF-003',
    '2026-10-08 09:30:00',
    'Update request approved'
),

(
    'LOG-005',
    'APP-004',
    'Approved',
    'STF-002',
    '2026-10-08 09:45:00',
    'Update request approved'
),

(
    'LOG-006',
    'APP-005',
    'Approved',
    'STF-003',
    '2026-10-08 10:00:00',
    'Lost ID request approved'
),

(
    'LOG-007',
    'APP-006',
    'Approved',
    'STF-004',
    '2026-10-08 10:15:00',
    'Damaged ID request approved'
);
GO


SELECT * FROM Students;

SELECT * FROM Staff;

SELECT * FROM Schedules;

SELECT * FROM IDApplications;

SELECT * FROM Appointments;

SELECT * FROM AuditLog;
GO


SELECT
    Students.StudentID,
    Students.FirstName,
    Students.LastName,

    IDApplication.ApplicationID,
    IDApplication.RequestType,

    Appointments.AppointmentID,
    Appointments.QueueNumber,
    Appointments.QueueStatus,
    Appointments.IDProcessingStatus,

    Schedules.ScheduleID,
    Schedules.ScheduleDate,
    Schedules.StartTime,
    Schedules.EndTime,
    Schedules.Venue

FROM Students

INNER JOIN IDApplication
ON Students.StudentID = IDApplication.StudentID

INNER JOIN Appointments
ON IDApplication.ApplicationID = Appointments.ApplicationID

INNER JOIN Schedules
ON Appointments.ScheduleID = Schedules.ScheduleID;
GO

USE NU_Student_ID_System1;
GO






SELECT
    OBJECT_NAME(fk.parent_object_id) AS TableName,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS ForeignKeyColumn,
    OBJECT_NAME(fk.referenced_object_id) AS ReferencedTable,
    fk.name AS ForeignKeyName
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc
    ON fk.object_id = fkc.constraint_object_id
ORDER BY TableName;