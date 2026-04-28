-- ============================================================
--   DBMS Lab Practicals
--   Database: Taylor Swift Discography
--   Tool: phpMyAdmin (XAMPP / MariaDB)
-- ============================================================


-- ============================================================
--   ASSIGNMENT 3 : DATABASE DESIGN AND ER MODEL
--   Goal: Identify entities, attributes and relationships
-- ============================================================

-- Entities:
--   Albums  → AlbumID (PK), Title, ReleaseYear
--   Songs   → SongID (PK), AlbumID (FK), TrackTitle, TrackNumber

-- Relationship:
--   Albums (1) ────── contains ────── (N) Songs
--   One album contains many songs (One-to-Many)

-- ER Diagram: See ER_Diagram.png in this repository

-- ============================================================
--   ASSIGNMENT 4 : SQL IMPLEMENTATION (DDL & DML)
--   Goal: Build the database and insert the data
-- ============================================================

-- ------------------------------------------------------------
--   Step 1: Create Database and Tables
-- ------------------------------------------------------------
CREATE DATABASE TaylorSwiftDiscography;
USE TaylorSwiftDiscography;

CREATE TABLE Albums (
    AlbumID     INT          PRIMARY KEY AUTO_INCREMENT,
    Title       VARCHAR(100) NOT NULL,
    ReleaseYear INT
);

CREATE TABLE Songs (
    SongID      INT          PRIMARY KEY AUTO_INCREMENT,
    AlbumID     INT          NOT NULL,
    TrackNumber INT,
    TrackTitle  VARCHAR(150) NOT NULL,
    FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID)
);

-- ------------------------------------------------------------
--   Step 2: Insert 12 Core Studio Albums
-- ------------------------------------------------------------
INSERT INTO Albums (Title, ReleaseYear) VALUES
    ('Taylor Swift',                  2006),
    ('Fearless',                      2008),
    ('Speak Now',                     2010),
    ('Red',                           2012),
    ('1989',                          2014),
    ('reputation',                    2017),
    ('Lover',                         2019),
    ('folklore',                      2020),
    ('evermore',                      2020),
    ('Midnights',                     2022),
    ('The Tortured Poets Department', 2024),
    ('The Life of a Showgirl',        2025);

-- ------------------------------------------------------------
--   Step 3: Insert Songs (2 tracks per album)
-- ------------------------------------------------------------
INSERT INTO Songs (AlbumID, TrackNumber, TrackTitle) VALUES
    (1,  1,  'Tim McGraw'),                   -- Taylor Swift
    (1,  11, 'Our Song'),
    (2,  3,  'Love Story'),                   -- Fearless
    (2,  6,  'You Belong With Me'),
    (3,  2,  'Sparks Fly'),                   -- Speak Now
    (3,  9,  'Enchanted'),
    (4,  5,  'All Too Well'),                 -- Red
    (4,  6,  '22'),
    (5,  2,  'Blank Space'),                  -- 1989
    (5,  3,  'Style'),
    (6,  5,  'Delicate'),                     -- reputation
    (6,  6,  'Look What You Made Me Do'),
    (7,  2,  'Cruel Summer'),                 -- Lover
    (7,  3,  'Lover'),
    (8,  2,  'cardigan'),                     -- folklore
    (8,  8,  'august'),
    (9,  1,  'willow'),                       -- evermore
    (9,  2,  'champagne problems'),
    (10, 3,  'Anti-Hero'),                    -- Midnights
    (10, 11, 'Karma'),
    (11, 1,  'Fortnight'),                    -- The Tortured Poets Department
    (11, 2,  'The Tortured Poets Dept'),
    (12, 1,  'Fate of Ophelia'),              -- The Life of a Showgirl
    (12, 2,  'Opalite');

-- ------------------------------------------------------------
--   Step 4: Verify Data
-- ------------------------------------------------------------
SELECT * FROM Albums;
SELECT * FROM Songs;

-- ------------------------------------------------------------
--   a. ALTER TABLE
-- ------------------------------------------------------------
ALTER TABLE Albums
MODIFY COLUMN Title VARCHAR(200);

ALTER TABLE Albums
MODIFY COLUMN Genre VARCHAR(100) DEFAULT 'Pop/Country';

ALTER TABLE Songs
MODIFY COLUMN Duration_sec INT DEFAULT 200;

DESC Albums;
DESC Songs;

-- ------------------------------------------------------------
--   b. DROP TABLE
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Temp_Eras (
    EraID   INT PRIMARY KEY AUTO_INCREMENT,
    EraName VARCHAR(50)
);

INSERT INTO Temp_Eras (EraName) VALUES
    ('Debut'), ('Fearless'), ('Speak Now'), ('Red'),
    ('1989'), ('reputation'), ('Lover'), ('folklore');

SELECT * FROM Temp_Eras;
DROP TABLE IF EXISTS Temp_Eras;
SHOW TABLES;

-- ------------------------------------------------------------
--   c. INDEX OPERATIONS
-- ------------------------------------------------------------
DROP INDEX IF EXISTS idx_album_title ON Albums;
DROP INDEX IF EXISTS idx_song_album   ON Songs;

CREATE INDEX idx_album_title ON Albums(Title);
CREATE INDEX idx_song_album  ON Songs(AlbumID, TrackNumber);

SHOW INDEX FROM Albums;
SHOW INDEX FROM Songs;

-- ------------------------------------------------------------
--   d. RELATIONAL OPERATORS
-- ------------------------------------------------------------

-- Equal to
SELECT * FROM Albums WHERE ReleaseYear = 2020;

-- Greater than
SELECT * FROM Albums WHERE ReleaseYear > 2019;

-- Less than
SELECT * FROM Albums WHERE ReleaseYear < 2015;

-- Between
SELECT * FROM Albums WHERE ReleaseYear BETWEEN 2014 AND 2020;

-- IN
SELECT * FROM Albums
WHERE Title IN ('folklore', 'evermore', 'Midnights');

-- NOT IN
SELECT * FROM Albums
WHERE Title NOT IN ('folklore', 'evermore', 'Midnights');

-- ------------------------------------------------------------
--   e. PATTERN MATCHING
-- ------------------------------------------------------------

-- Starts with L
SELECT TrackTitle FROM Songs WHERE TrackTitle LIKE 'L%';

-- Ends with e
SELECT TrackTitle FROM Songs WHERE TrackTitle LIKE '%e';

-- Contains 'love'
SELECT TrackTitle FROM Songs WHERE TrackTitle LIKE '%love%';

-- Albums with 'the' in title
SELECT Title FROM Albums WHERE Title LIKE '%the%';

-- NOT matching
SELECT TrackTitle FROM Songs WHERE TrackTitle NOT LIKE '%love%';

-- ------------------------------------------------------------
--   f. AGGREGATE FUNCTIONS + GROUP BY + HAVING
-- ------------------------------------------------------------

-- Count totals
SELECT COUNT(*) AS Total_Albums FROM Albums;
SELECT COUNT(*) AS Total_Songs  FROM Songs;

-- Min and Max year
SELECT
    MIN(ReleaseYear) AS First_Release,
    MAX(ReleaseYear) AS Latest_Release
FROM Albums;

-- Songs per album
SELECT
    a.Title,
    COUNT(s.SongID) AS Total_Songs
FROM Albums a
JOIN Songs s ON a.AlbumID = s.AlbumID
GROUP BY a.Title
ORDER BY Total_Songs DESC;

-- HAVING — albums with more than 1 song
SELECT
    a.Title,
    COUNT(s.SongID) AS Total_Songs
FROM Albums a
JOIN Songs s ON a.AlbumID = s.AlbumID
GROUP BY a.Title
HAVING COUNT(s.SongID) > 1;

-- ------------------------------------------------------------
--   g. NESTED QUERIES
-- ------------------------------------------------------------

-- Albums that have songs
SELECT Title FROM Albums
WHERE AlbumID IN (
    SELECT DISTINCT AlbumID FROM Songs
);

-- Songs from most recent album
SELECT TrackTitle FROM Songs
WHERE AlbumID = (
    SELECT AlbumID FROM Albums
    ORDER BY ReleaseYear DESC
    LIMIT 1
);

-- Albums released after average release year
SELECT Title, ReleaseYear FROM Albums
WHERE ReleaseYear > (
    SELECT AVG(ReleaseYear) FROM Albums
);

-- ------------------------------------------------------------
--   h. SET OPERATORS
-- ------------------------------------------------------------

-- UNION — early era OR recent era
SELECT Title, ReleaseYear FROM Albums WHERE ReleaseYear < 2015
UNION
SELECT Title, ReleaseYear FROM Albums WHERE ReleaseYear > 2019;

-- UNION ALL (includes duplicates)
SELECT Title FROM Albums WHERE ReleaseYear < 2015
UNION ALL
SELECT Title FROM Albums WHERE ReleaseYear > 2019;

-- Track 1 OR Track 2 songs
SELECT TrackTitle, TrackNumber FROM Songs WHERE TrackNumber = 1
UNION
SELECT TrackTitle, TrackNumber FROM Songs WHERE TrackNumber = 2
ORDER BY TrackNumber;

-- ------------------------------------------------------------
--   i. VIEWS
-- ------------------------------------------------------------

-- View 1: Songs with album info
DROP VIEW IF EXISTS SongDetails;
CREATE VIEW SongDetails AS
SELECT
    s.SongID,
    s.TrackNumber,
    s.TrackTitle,
    a.Title       AS AlbumName,
    a.ReleaseYear
FROM Songs s
JOIN Albums a ON s.AlbumID = a.AlbumID;

SELECT * FROM SongDetails;

-- View 2: Post 2019 albums only
DROP VIEW IF EXISTS RecentEras;
CREATE VIEW RecentEras AS
SELECT AlbumID, Title, ReleaseYear
FROM Albums
WHERE ReleaseYear >= 2020;

SELECT * FROM RecentEras;

-- View 3: Album song counts
DROP VIEW IF EXISTS AlbumSongCount;
CREATE VIEW AlbumSongCount AS
SELECT
    a.Title,
    a.ReleaseYear,
    COUNT(s.SongID) AS Total_Songs
FROM Albums a
JOIN Songs s ON s.AlbumID = a.AlbumID
GROUP BY a.Title, a.ReleaseYear;

SELECT * FROM AlbumSongCount;

-- ------------------------------------------------------------
--   j. SORTING
-- ------------------------------------------------------------

-- Oldest to newest
SELECT Title, ReleaseYear FROM Albums
ORDER BY ReleaseYear ASC;

-- Newest to oldest
SELECT Title, ReleaseYear FROM Albums
ORDER BY ReleaseYear DESC;

-- Songs alphabetically
SELECT TrackTitle FROM Songs
ORDER BY TrackTitle ASC;

-- Songs by album then track number
SELECT
    a.Title        AS Album,
    s.TrackNumber,
    s.TrackTitle
FROM Songs s
JOIN Albums a ON s.AlbumID = a.AlbumID
ORDER BY a.ReleaseYear ASC, s.TrackNumber ASC;

-- Top 5 most recent albums
SELECT Title, ReleaseYear FROM Albums
ORDER BY ReleaseYear DESC
LIMIT 5;


-- ============================================================
--   ASSIGNMENT 5 : STORED PROCEDURE
--   Goal: Create a procedure to list tracks of any album
-- ============================================================

CREATE PROCEDURE GetAlbumTracks (IN target_id INT)
BEGIN
    SELECT
        s.TrackNumber,
        s.TrackTitle,
        a.Title       AS AlbumName,
        a.ReleaseYear
    FROM Songs s
    JOIN Albums a ON s.AlbumID = a.AlbumID
    WHERE s.AlbumID = target_id
    ORDER BY s.TrackNumber;
END;

-- Test calls
CALL GetAlbumTracks(1);    -- Taylor Swift (debut)
CALL GetAlbumTracks(7);    -- Lover
CALL GetAlbumTracks(10);   -- Midnights
CALL GetAlbumTracks(12);   -- The Life of a Showgirl


-- ============================================================
--   ASSIGNMENT 6 : TRIGGER
--   Goal: Auto-capitalize every song title on insert
-- ============================================================

CREATE TRIGGER Clean_Song_Titles
BEFORE INSERT ON Songs
FOR EACH ROW
BEGIN
    SET NEW.TrackTitle = CONCAT(
        UPPER(SUBSTRING(NEW.TrackTitle, 1, 1)),
        LOWER(SUBSTRING(NEW.TrackTitle, 2))
    );
END;

-- Test: insert lowercase titles
INSERT INTO Songs (AlbumID, TrackNumber, TrackTitle)
VALUES (10, 5, 'lavender haze');

-- Verify trigger worked — should show 'Lavender haze'
SELECT SongID, TrackTitle FROM Songs
WHERE AlbumID = 10
ORDER BY SongID DESC
LIMIT 3;

-- ============================================================
--   TaylorSwiftDiscography — DBMS Lab Practicals
--   Made with 🎵 & SQL
-- ============================================================
