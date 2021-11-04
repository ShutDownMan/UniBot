-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 0.9.4-beta
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: Jedson Gabriel ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: universidados | type: DATABASE --
-- DROP DATABASE IF EXISTS universidados;
CREATE DATABASE universidados;
-- ddl-end --


-- object: public."Diary" | type: TABLE --
-- DROP TABLE IF EXISTS public."Diary" CASCADE;
CREATE TABLE public."Diary" (
	"dateID" varchar(32) NOT NULL,
	"diaryData" jsonb,
	CONSTRAINT "Diary_pk" PRIMARY KEY ("dateID")

);
-- ddl-end --
ALTER TABLE public."Diary" OWNER TO postgres;
-- ddl-end --

-- object: public."Materia" | type: TABLE --
-- DROP TABLE IF EXISTS public."Materia" CASCADE;
CREATE TABLE public."Materia" (
	"materiaID" varchar(32) NOT NULL,
	"materiaData" jsonb,
	CONSTRAINT "Materia_pk" PRIMARY KEY ("materiaID")

);
-- ddl-end --
ALTER TABLE public."Materia" OWNER TO postgres;
-- ddl-end --

-- object: public."Class" | type: TABLE --
-- DROP TABLE IF EXISTS public."Class" CASCADE;
CREATE TABLE public."Class" (
	"classID" serial NOT NULL,
	"classData" jsonb,
	CONSTRAINT "Class_pk" PRIMARY KEY ("classID")

);
-- ddl-end --
ALTER TABLE public."Class" OWNER TO postgres;
-- ddl-end --

-- object: public."Reminder" | type: TABLE --
-- DROP TABLE IF EXISTS public."Reminder" CASCADE;
CREATE TABLE public."Reminder" (
	"remindID" serial NOT NULL,
	"remindData" jsonb,
	CONSTRAINT "Reminder_pk" PRIMARY KEY ("remindID")

);
-- ddl-end --
ALTER TABLE public."Reminder" OWNER TO postgres;
-- ddl-end --


