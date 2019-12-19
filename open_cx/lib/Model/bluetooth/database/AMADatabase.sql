PRAGMA foreign_keys = on;
BEGIN TRANSACTION;

-- Table: Person
DROP TABLE IF EXISTS Person;

CREATE TABLE Person (
    personKey    TEXT PRIMARY KEY,
    name         TEXT,
    affiliation  TEXT,
    bio          TEXT,
    url          TEXT,
    imageURL     TEXT
);


-- Table: Item
DROP TABLE IF EXISTS Item;

CREATE TABLE Item (
    itemKey       TEXT PRIMARY KEY,
    title         TEXT,
    type          TEXT,
    url           TEXT,
    peopleString  TEXT,
    affiliations  TEXT,
    description   TEXT
);


-- Table: Session
DROP TABLE IF EXISTS Session;

CREATE TABLE Session (
    sessionKey       TEXT PRIMARY KEY,
    title            TEXT,
    chairsString     TEXT,
    type             TEXT,
    day              TEXT,
    startTime        INTEGER,
    timeString       TEXT,
    location         TEXT,
    description      TEXT,
    isCustom         INTEGER
);


-- Table: Schedule
DROP TABLE IF EXISTS Schedule;

CREATE TABLE Schedule (
    scheduleDay      INTEGER PRIMARY KEY,
    weekday          TEXT,
    date             TEXT
);


-- Table: ScheduleSession
DROP TABLE IF EXISTS ScheduleSession;

CREATE TABLE ScheduleSession (
    sessionKey       TEXT PRIMARY KEY REFERENCES Session(sessionKey),
    scheduleDay      INTEGER REFERENCES Schedule(scheduleDay)
);


-- Table: SessionItem
DROP TABLE IF EXISTS SessionItem;

CREATE TABLE SessionItem (
    sessionKey       TEXT REFERENCES Session(sessionKey),
    itemKey          TEXT REFERENCES Item(itemKey),
    PRIMARY KEY(sessionKey, itemKey)
);


-- Table: SessionChair
DROP TABLE IF EXISTS SessionChair;

CREATE TABLE SessionChair (
    sessionKey       TEXT REFERENCES Session(sessionKey),
    personKey        TEXT REFERENCES Person(personKey),
    PRIMARY KEY(sessionKey, personKey)
);



-- Table: ItemAuthor
DROP TABLE IF EXISTS ItemAuthor;

CREATE TABLE ItemAuthor (
    itemKey          TEXT REFERENCES Item(itemKey),
    personKey        TEXT REFERENCES Person(personKey),
    PRIMARY KEY(itemKey, personKey)
);

--------------

-- verifies if a session on a given day is added to the schedule of the same day

CREATE TRIGGER IF NOT EXISTS CheckDayScheduleSession
BEFORE INSERT ON ScheduleSession
WHEN ((SELECT date
       FROM Schedule
       WHERE scheduleDay = new.scheduleDay)
       <>
       (SELECT day
        FROM Session
        WHERE sessionKey = new.sessionKey))
BEGIN
    SELECT RAISE(rollback,'Error: Session does not belong in this schedule');
END;


--------------

INSERT INTO Schedule (scheduleDay, weekday, date) VALUES(
   1,
   "Mon",
   "2019-04-01"
);

INSERT INTO Schedule (scheduleDay, weekday, date) VALUES(
   2,
   "Tue",
   "2019-04-02"
);

INSERT INTO Schedule (scheduleDay, weekday, date) VALUES(
   3,
   "Wed",
   "2019-04-03"
);

INSERT INTO Schedule (scheduleDay, weekday, date) VALUES(
   4,
   "Thu",
   "2019-04-04"
);

--------------

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
