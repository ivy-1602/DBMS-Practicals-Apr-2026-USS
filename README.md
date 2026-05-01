# 🎵 DBMS Diaries
_One database. Twelve albums. A semester of queries._

---

## What's This?

My Semester 3 DBMS lab work — 6 assignments built entirely around Taylor Swift's discography because if you have to write SQL for hours, you might as well make it about something that interests you ;)

From ER diagrams to triggers, from nested queries to views — all of it runs on a database of 12 studio albums and their songs.

---

## 🗂️ Quick Look

```
DBMS-Practicals/
├── TaylorSwift_DBMS.sql   → All 6 assignments in one clean file
├── ER_Diagram.png         → Chen notation ER diagram (made in Notion)
└── README.md              → You are here
```

6 assignments covering database design, SQL implementation,
stored procedures, triggers, and enough SELECT statements
to make any professor nod approvingly.

---

## 👀 What's Inside

| Assignment | Topic | What I Actually Did |
|-----------|-------|-------------------|
| A3 | Database Design & ER Model | Drew rectangles, diamonds and ovals in Notion at midnight |
| A4a-b | DDL & DML + Alter & Drop | Created tables, inserted 12 albums, panicked about duplicate columns |
| A4c-e | Indexes + Relational + Pattern | LIKE '%love%' hits different on a Taylor Swift database |
| A4f-h | Aggregates + Nested + Set | GROUP BY era, HAVING good taste |
| A4i-j | Views + Sorting | Created 3 views, sorted everything, felt powerful |
| A5 | Stored Procedure | `CALL GetAlbumTracks(10)` → Midnights tracklist appears like magic |
| A6 | Trigger | Auto-capitalizes song titles because `Lavender Haze` is simply ✨✨✨✨|

---

## Running the Code

Open **phpMyAdmin** (via XAMPP) or **MySQL Workbench**, then:

```sql
-- Run the full file or paste section by section
SOURCE TaylorSwift_DBMS.sql;
```

Or paste directly into the SQL tab and hit **Go**.

> **Note:** Run Assignment 4 DDL section first before anything else.
> The database needs to exist before you can query it. (Learned this the hard way.)

---

## The Database

```
Albums (12 rows)                    Songs (24+ rows)
─────────────────────               ──────────────────────────
AlbumID  │ PK, AUTO_INCREMENT       SongID      │ PK
Title    │ VARCHAR(200)             AlbumID     │ FK → Albums
ReleaseYear │ INT                   TrackNumber │ INT
Genre    │ VARCHAR(100)             TrackTitle  │ VARCHAR(150)
                                    Duration_sec│ INT
```

One-to-Many relationship. One album, many songs.
Simple schema. Surprisingly emotional data.

---

## Navigation

Start here based on your situation:

- _"I just need the SQL"_ → **TaylorSwift_DBMS.sql**
- _"I need to understand the schema"_ → **ER_Diagram.png**
- _"I want to see what GROUP BY looks like on music data"_ → Assignment 4f
- _"I want to call a procedure and feel like a developer"_ → Assignment 5

---

## 📫 About Me

**Uma Salunke** — SE AI & ML Engineering Student

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Uma_Salunke-blue?style=flat&logo=linkedin)](https://linkedin.com/in/umasalunke7)
[![GitHub](https://img.shields.io/badge/GitHub-ivy--1602-black?style=flat&logo=github)](https://github.com/ivy-1602)

---

## 📄 License

MIT License — use it, learn from it, build your own themed database.

---

## 📝 Final Note

This repo isn't trying to be a database textbook.
Some queries could be more optimized.
Some schema decisions could be debated.
The trigger that capitalizes `Lavender Haze` is non-negotiable.

_The best query is the one that returns what you expected._
_The second best is the one that teaches you why it didn't._

Made with 🧠 & 🎵

---

P.S. — Yes, the database includes The Life of a Showgirl (2025).
We stay current around here.

P.P.S. — If your DBMS professor asks why you chose Taylor Swift,
tell them it's a case study in discography management systems.
Technically true.
