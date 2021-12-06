--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4
-- Dumped by pg_dump version 13.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Class" (
    "classID" integer NOT NULL,
    "classData" jsonb
);


ALTER TABLE public."Class" OWNER TO postgres;

--
-- Name: Class_classID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Class_classID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Class_classID_seq" OWNER TO postgres;

--
-- Name: Class_classID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Class_classID_seq" OWNED BY public."Class"."classID";


--
-- Name: Diary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Diary" (
    "dateID" character varying(32) NOT NULL,
    "diaryData" jsonb
);


ALTER TABLE public."Diary" OWNER TO postgres;

--
-- Name: Materia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Materia" (
    "materiaID" character varying(32) NOT NULL,
    "materiaData" jsonb
);


ALTER TABLE public."Materia" OWNER TO postgres;

--
-- Name: Reminder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Reminder" (
    "reminderID" integer NOT NULL,
    "reminderData" jsonb
);


ALTER TABLE public."Reminder" OWNER TO postgres;

--
-- Name: Reminder_reminderID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Reminder_reminderID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Reminder_reminderID_seq" OWNER TO postgres;

--
-- Name: Reminder_reminderID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Reminder_reminderID_seq" OWNED BY public."Reminder"."reminderID";


--
-- Name: Class classID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Class" ALTER COLUMN "classID" SET DEFAULT nextval('public."Class_classID_seq"'::regclass);


--
-- Name: Reminder reminderID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reminder" ALTER COLUMN "reminderID" SET DEFAULT nextval('public."Reminder_reminderID_seq"'::regclass);


--
-- Data for Name: Class; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Class" ("classID", "classData") FROM stdin;
1551	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-01T10:10:00-03:00", "reminderSent": false}
1552	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-08T10:10:00-03:00", "reminderSent": false}
1553	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-15T10:10:00-03:00", "reminderSent": false}
1554	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-22T10:10:00-03:00", "reminderSent": false}
1555	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-29T10:10:00-03:00", "reminderSent": false}
1556	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-12-06T10:10:00-03:00", "reminderSent": false}
1557	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-02T10:10:00-03:00", "reminderSent": false}
1558	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-09T10:10:00-03:00", "reminderSent": false}
1559	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-16T10:10:00-03:00", "reminderSent": false}
1560	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-23T10:10:00-03:00", "reminderSent": false}
1561	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-30T10:10:00-03:00", "reminderSent": false}
1562	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-11-05T10:10:00-03:00", "reminderSent": false}
1563	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-11-12T10:10:00-03:00", "reminderSent": false}
1564	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-11-19T10:10:00-03:00", "reminderSent": false}
1565	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-11-26T10:10:00-03:00", "reminderSent": false}
1566	{"status": 0, "diaryID": "2021-12-03", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-12-03T10:10:00-03:00", "reminderSent": false}
1567	{"status": 0, "diaryID": "2021-11-01", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-01T17:00:00-03:00", "reminderSent": false}
1568	{"status": 0, "diaryID": "2021-11-08", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-08T17:00:00-03:00", "reminderSent": false}
1569	{"status": 0, "diaryID": "2021-11-15", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-15T17:00:00-03:00", "reminderSent": false}
1570	{"status": 0, "diaryID": "2021-11-22", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-22T17:00:00-03:00", "reminderSent": false}
1571	{"status": 0, "diaryID": "2021-11-29", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-29T17:00:00-03:00", "reminderSent": false}
1572	{"status": 0, "diaryID": "2021-12-06", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-12-06T17:00:00-03:00", "reminderSent": false}
1573	{"status": 0, "diaryID": "2021-11-01", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-01T15:20:00-03:00", "reminderSent": false}
1574	{"status": 0, "diaryID": "2021-11-08", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-08T15:20:00-03:00", "reminderSent": false}
1575	{"status": 0, "diaryID": "2021-11-15", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-15T15:20:00-03:00", "reminderSent": false}
1576	{"status": 0, "diaryID": "2021-11-22", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-22T15:20:00-03:00", "reminderSent": false}
1577	{"status": 0, "diaryID": "2021-11-29", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-29T15:20:00-03:00", "reminderSent": false}
1578	{"status": 0, "diaryID": "2021-12-06", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-12-06T15:20:00-03:00", "reminderSent": false}
1579	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-11-02T07:30:00-03:00", "reminderSent": false}
1580	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-11-09T07:30:00-03:00", "reminderSent": false}
1581	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-11-16T07:30:00-03:00", "reminderSent": false}
1582	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-11-23T07:30:00-03:00", "reminderSent": false}
1583	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-11-30T07:30:00-03:00", "reminderSent": false}
1584	{"status": 0, "diaryID": "2021-11-04", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-04T08:20:00-03:00", "reminderSent": false}
1585	{"status": 0, "diaryID": "2021-11-11", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-11T08:20:00-03:00", "reminderSent": false}
1586	{"status": 0, "diaryID": "2021-11-18", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-18T08:20:00-03:00", "reminderSent": false}
1587	{"status": 0, "diaryID": "2021-11-25", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-25T08:20:00-03:00", "reminderSent": false}
1588	{"status": 0, "diaryID": "2021-12-02", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-12-02T08:20:00-03:00", "reminderSent": false}
1589	{"status": 0, "diaryID": "2021-11-04", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-04T08:20:00-03:00", "reminderSent": false}
1590	{"status": 0, "diaryID": "2021-11-11", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-11T08:20:00-03:00", "reminderSent": false}
1591	{"status": 0, "diaryID": "2021-11-18", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-18T08:20:00-03:00", "reminderSent": false}
1592	{"status": 0, "diaryID": "2021-11-25", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-25T08:20:00-03:00", "reminderSent": false}
1593	{"status": 0, "diaryID": "2021-12-02", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-12-02T08:20:00-03:00", "reminderSent": false}
1594	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-02T08:20:00-03:00", "reminderSent": false}
1595	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-09T08:20:00-03:00", "reminderSent": false}
1596	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-16T08:20:00-03:00", "reminderSent": false}
1597	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-23T08:20:00-03:00", "reminderSent": false}
1598	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-30T08:20:00-03:00", "reminderSent": false}
1599	{"status": 0, "diaryID": "2021-11-02", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-11-02T10:00:00-03:00", "reminderSent": false}
1600	{"status": 0, "diaryID": "2021-11-09", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-11-09T10:00:00-03:00", "reminderSent": false}
1601	{"status": 0, "diaryID": "2021-11-16", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-11-16T10:00:00-03:00", "reminderSent": false}
1602	{"status": 0, "diaryID": "2021-11-23", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-11-23T10:00:00-03:00", "reminderSent": false}
1603	{"status": 0, "diaryID": "2021-11-30", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-11-30T10:00:00-03:00", "reminderSent": false}
1604	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-04T08:20:00-03:00", "reminderSent": false}
1605	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-11T08:20:00-03:00", "reminderSent": false}
1606	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-18T08:20:00-03:00", "reminderSent": false}
1607	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-25T08:20:00-03:00", "reminderSent": false}
1608	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-12-02T08:20:00-03:00", "reminderSent": false}
1609	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-01T08:20:00-03:00", "reminderSent": false}
1610	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-08T08:20:00-03:00", "reminderSent": false}
1611	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-15T08:20:00-03:00", "reminderSent": false}
1612	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-22T08:20:00-03:00", "reminderSent": false}
1613	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-29T08:20:00-03:00", "reminderSent": false}
1614	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-12-06T08:20:00-03:00", "reminderSent": false}
1615	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-03T08:20:00-03:00", "reminderSent": false}
1616	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-10T08:20:00-03:00", "reminderSent": false}
1617	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-17T08:20:00-03:00", "reminderSent": false}
1618	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-24T08:20:00-03:00", "reminderSent": false}
1619	{"status": 0, "diaryID": "2021-12-01", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-12-01T08:20:00-03:00", "reminderSent": false}
1620	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-11-05T10:10:00-03:00", "reminderSent": false}
1621	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-11-12T10:10:00-03:00", "reminderSent": false}
1622	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-11-19T10:10:00-03:00", "reminderSent": false}
1623	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-11-26T10:10:00-03:00", "reminderSent": false}
1624	{"status": 0, "diaryID": "2021-12-03", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-12-03T10:10:00-03:00", "reminderSent": false}
1625	{"status": 0, "diaryID": "2021-11-01", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-11-01T17:00:00-03:00", "reminderSent": false}
1626	{"status": 0, "diaryID": "2021-11-08", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-11-08T17:00:00-03:00", "reminderSent": false}
1627	{"status": 0, "diaryID": "2021-11-15", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-11-15T17:00:00-03:00", "reminderSent": false}
1628	{"status": 0, "diaryID": "2021-11-22", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-11-22T17:00:00-03:00", "reminderSent": false}
1629	{"status": 0, "diaryID": "2021-11-29", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-11-29T17:00:00-03:00", "reminderSent": false}
1630	{"status": 0, "diaryID": "2021-12-06", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-12-06T17:00:00-03:00", "reminderSent": false}
1631	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-11-02T13:00:00-03:00", "reminderSent": false}
1632	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-11-09T13:00:00-03:00", "reminderSent": false}
1633	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-11-16T13:00:00-03:00", "reminderSent": false}
1634	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-11-23T13:00:00-03:00", "reminderSent": false}
1635	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-11-30T13:00:00-03:00", "reminderSent": false}
1636	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-11-05T07:30:00-03:00", "reminderSent": false}
1637	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-11-12T07:30:00-03:00", "reminderSent": false}
1638	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-11-19T07:30:00-03:00", "reminderSent": false}
1639	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-11-26T07:30:00-03:00", "reminderSent": false}
1640	{"status": 0, "diaryID": "2021-12-03", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-12-03T07:30:00-03:00", "reminderSent": false}
1641	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-11-03T10:10:00-03:00", "reminderSent": false}
1642	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-11-10T10:10:00-03:00", "reminderSent": false}
1643	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-11-17T10:10:00-03:00", "reminderSent": false}
1644	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-11-24T10:10:00-03:00", "reminderSent": false}
1645	{"status": 0, "diaryID": "2021-12-01", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-12-01T10:10:00-03:00", "reminderSent": false}
1646	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-02T15:20:00-03:00", "reminderSent": false}
1647	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-09T15:20:00-03:00", "reminderSent": false}
1648	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-16T15:20:00-03:00", "reminderSent": false}
1649	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-23T15:20:00-03:00", "reminderSent": false}
1650	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-30T15:20:00-03:00", "reminderSent": false}
1651	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-04T15:20:00-03:00", "reminderSent": false}
1652	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-11T15:20:00-03:00", "reminderSent": false}
1653	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-18T15:20:00-03:00", "reminderSent": false}
1654	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-25T15:20:00-03:00", "reminderSent": false}
1655	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-12-02T15:20:00-03:00", "reminderSent": false}
1656	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-11-01T13:30:00-03:00", "reminderSent": false}
1657	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-11-08T13:30:00-03:00", "reminderSent": false}
1658	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-11-15T13:30:00-03:00", "reminderSent": false}
1659	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-11-22T13:30:00-03:00", "reminderSent": false}
1660	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-11-29T13:30:00-03:00", "reminderSent": false}
1661	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-12-06T13:30:00-03:00", "reminderSent": false}
1662	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-02T13:30:00-03:00", "reminderSent": false}
1663	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-09T13:30:00-03:00", "reminderSent": false}
1664	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-16T13:30:00-03:00", "reminderSent": false}
1665	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-23T13:30:00-03:00", "reminderSent": false}
1666	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-30T13:30:00-03:00", "reminderSent": false}
1667	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-04T13:30:00-03:00", "reminderSent": false}
1668	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-11T13:30:00-03:00", "reminderSent": false}
1669	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-18T13:30:00-03:00", "reminderSent": false}
1670	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-25T13:30:00-03:00", "reminderSent": false}
1671	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-12-02T13:30:00-03:00", "reminderSent": false}
1672	{"status": 0, "diaryID": "2022-04-22", "horario": {"inicio": "R22/2022-W15-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904607882153197628", "startTime": "2022-04-22T13:30:00-03:00", "reminderSent": false}
1673	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-03T17:00:00-03:00", "reminderSent": false}
1674	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-10T17:00:00-03:00", "reminderSent": false}
1675	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-17T17:00:00-03:00", "reminderSent": false}
1676	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-24T17:00:00-03:00", "reminderSent": false}
1677	{"status": 0, "diaryID": "2021-12-01", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-12-01T17:00:00-03:00", "reminderSent": false}
1678	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-04T17:00:00-03:00", "reminderSent": false}
1679	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-11T17:00:00-03:00", "reminderSent": false}
1680	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-18T17:00:00-03:00", "reminderSent": false}
1681	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-25T17:00:00-03:00", "reminderSent": false}
1682	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-12-02T17:00:00-03:00", "reminderSent": false}
1683	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-11-05T13:30:00-03:00", "reminderSent": false}
1684	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-11-12T13:30:00-03:00", "reminderSent": false}
1685	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-11-19T13:30:00-03:00", "reminderSent": false}
1686	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-11-26T13:30:00-03:00", "reminderSent": false}
1687	{"status": 0, "diaryID": "2021-12-03", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-12-03T13:30:00-03:00", "reminderSent": false}
1688	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-11-02T17:00:00-03:00", "reminderSent": false}
1689	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-11-09T17:00:00-03:00", "reminderSent": false}
1690	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-11-16T17:00:00-03:00", "reminderSent": false}
1691	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-11-23T17:00:00-03:00", "reminderSent": false}
1692	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-11-30T17:00:00-03:00", "reminderSent": false}
1693	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-11-01T16:10:00-03:00", "reminderSent": false}
1694	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-11-08T16:10:00-03:00", "reminderSent": false}
1695	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-11-15T16:10:00-03:00", "reminderSent": false}
1696	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-11-22T16:10:00-03:00", "reminderSent": false}
1697	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-11-29T16:10:00-03:00", "reminderSent": false}
1698	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-12-06T16:10:00-03:00", "reminderSent": false}
1699	{"status": 0, "diaryID": "2021-11-03", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-03T13:30:00-03:00", "reminderSent": false}
1700	{"status": 0, "diaryID": "2021-11-10", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-10T13:30:00-03:00", "reminderSent": false}
1701	{"status": 0, "diaryID": "2021-11-17", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-17T13:30:00-03:00", "reminderSent": false}
1702	{"status": 0, "diaryID": "2021-11-24", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-24T13:30:00-03:00", "reminderSent": false}
1703	{"status": 0, "diaryID": "2021-12-01", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-12-01T13:30:00-03:00", "reminderSent": false}
1704	{"status": 0, "diaryID": "2021-11-03", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-03T15:10:00-03:00", "reminderSent": false}
1705	{"status": 0, "diaryID": "2021-11-10", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-10T15:10:00-03:00", "reminderSent": false}
1706	{"status": 0, "diaryID": "2021-11-17", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-17T15:10:00-03:00", "reminderSent": false}
1707	{"status": 0, "diaryID": "2021-11-24", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-24T15:10:00-03:00", "reminderSent": false}
1708	{"status": 0, "diaryID": "2021-12-01", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-12-01T15:10:00-03:00", "reminderSent": false}
1709	{"status": 0, "diaryID": "2022-04-20", "horario": {"inicio": "R22/2022-W15-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904611834768814111", "startTime": "2022-04-20T17:00:00-03:00", "reminderSent": false}
1710	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-01T07:30:00-03:00", "reminderSent": false}
1711	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-08T07:30:00-03:00", "reminderSent": false}
1712	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-15T07:30:00-03:00", "reminderSent": false}
1713	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-22T07:30:00-03:00", "reminderSent": false}
1714	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-29T07:30:00-03:00", "reminderSent": false}
1715	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-12-06T07:30:00-03:00", "reminderSent": false}
1716	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-11-03T07:30:00-03:00", "reminderSent": false}
1717	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-11-10T07:30:00-03:00", "reminderSent": false}
1718	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-11-17T07:30:00-03:00", "reminderSent": false}
1719	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-11-24T07:30:00-03:00", "reminderSent": false}
1720	{"status": 0, "diaryID": "2021-12-01", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-12-01T07:30:00-03:00", "reminderSent": false}
1721	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-02T17:00:00-03:00", "reminderSent": false}
1722	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-09T17:00:00-03:00", "reminderSent": false}
1723	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-16T17:00:00-03:00", "reminderSent": false}
1724	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-23T17:00:00-03:00", "reminderSent": false}
1725	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-30T17:00:00-03:00", "reminderSent": false}
1726	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-05T07:30:00-03:00", "reminderSent": false}
1727	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-12T07:30:00-03:00", "reminderSent": false}
1728	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-19T07:30:00-03:00", "reminderSent": false}
1729	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-26T07:30:00-03:00", "reminderSent": false}
1730	{"status": 0, "diaryID": "2021-12-03", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-12-03T07:30:00-03:00", "reminderSent": false}
1731	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-11-03T09:20:00-03:00", "reminderSent": false}
1732	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-11-10T09:20:00-03:00", "reminderSent": false}
1733	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-11-17T09:20:00-03:00", "reminderSent": false}
1734	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-11-24T09:20:00-03:00", "reminderSent": false}
1735	{"status": 0, "diaryID": "2021-12-01", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-12-01T09:20:00-03:00", "reminderSent": false}
1736	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-11-05T09:20:00-03:00", "reminderSent": false}
1737	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-11-12T09:20:00-03:00", "reminderSent": false}
1738	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-11-19T09:20:00-03:00", "reminderSent": false}
1739	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-11-26T09:20:00-03:00", "reminderSent": false}
1740	{"status": 0, "diaryID": "2021-12-03", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-12-03T09:20:00-03:00", "reminderSent": false}
1741	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-02T09:20:00-03:00", "reminderSent": false}
1742	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-09T09:20:00-03:00", "reminderSent": false}
1743	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-16T09:20:00-03:00", "reminderSent": false}
1744	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-23T09:20:00-03:00", "reminderSent": false}
1745	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-30T09:20:00-03:00", "reminderSent": false}
1746	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-04T09:20:00-03:00", "reminderSent": false}
1747	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-11T09:20:00-03:00", "reminderSent": false}
1748	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-18T09:20:00-03:00", "reminderSent": false}
1749	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-25T09:20:00-03:00", "reminderSent": false}
1750	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-12-02T09:20:00-03:00", "reminderSent": false}
1751	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-02T07:30:00-03:00", "reminderSent": false}
1752	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-09T07:30:00-03:00", "reminderSent": false}
1753	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-16T07:30:00-03:00", "reminderSent": false}
1754	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-23T07:30:00-03:00", "reminderSent": false}
1755	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-30T07:30:00-03:00", "reminderSent": false}
1756	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-04T07:30:00-03:00", "reminderSent": false}
1757	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-11T07:30:00-03:00", "reminderSent": false}
1758	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-18T07:30:00-03:00", "reminderSent": false}
1759	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-25T07:30:00-03:00", "reminderSent": false}
1760	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-12-02T07:30:00-03:00", "reminderSent": false}
1761	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-01T10:10:00-03:00", "reminderSent": false}
1762	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-08T10:10:00-03:00", "reminderSent": false}
1763	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-15T10:10:00-03:00", "reminderSent": false}
1764	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-22T10:10:00-03:00", "reminderSent": false}
1765	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-29T10:10:00-03:00", "reminderSent": false}
1766	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-12-06T10:10:00-03:00", "reminderSent": false}
1767	{"status": 0, "diaryID": "2022-04-19", "horario": {"inicio": "R22/2022-W15-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802821499666433", "startTime": "2022-04-19T15:20:00-03:00", "reminderSent": false}
1768	{"status": 0, "diaryID": "2022-04-21", "horario": {"inicio": "R22/2022-W15-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802821499666433", "startTime": "2022-04-21T15:20:00-03:00", "reminderSent": false}
1769	{"status": 0, "diaryID": "2022-04-18", "horario": {"inicio": "R22/2022-W15-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802895520759808", "startTime": "2022-04-18T17:00:00-03:00", "reminderSent": false}
1770	{"status": 0, "diaryID": "2022-04-20", "horario": {"inicio": "R22/2022-W15-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802895520759808", "startTime": "2022-04-20T17:00:00-03:00", "reminderSent": false}
1771	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-02T13:30:00-03:00", "reminderSent": false}
1772	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-09T13:30:00-03:00", "reminderSent": false}
1773	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-16T13:30:00-03:00", "reminderSent": false}
1774	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-23T13:30:00-03:00", "reminderSent": false}
1775	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-30T13:30:00-03:00", "reminderSent": false}
1776	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-04T13:30:00-03:00", "reminderSent": false}
1777	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-11T13:30:00-03:00", "reminderSent": false}
1778	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-18T13:30:00-03:00", "reminderSent": false}
1779	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-25T13:30:00-03:00", "reminderSent": false}
1780	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-12-02T13:30:00-03:00", "reminderSent": false}
1781	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-01T15:20:00-03:00", "reminderSent": false}
1782	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-08T15:20:00-03:00", "reminderSent": false}
1783	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-15T15:20:00-03:00", "reminderSent": false}
1784	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-22T15:20:00-03:00", "reminderSent": false}
1785	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-29T15:20:00-03:00", "reminderSent": false}
1786	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-12-06T15:20:00-03:00", "reminderSent": false}
1787	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-03T15:20:00-03:00", "reminderSent": false}
1788	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-10T15:20:00-03:00", "reminderSent": false}
1789	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-17T15:20:00-03:00", "reminderSent": false}
1790	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-24T15:20:00-03:00", "reminderSent": false}
1791	{"status": 0, "diaryID": "2021-12-01", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-12-01T15:20:00-03:00", "reminderSent": false}
1792	{"status": 0, "diaryID": "2022-04-18", "horario": {"inicio": "R22/2022-W15-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803241123016824", "startTime": "2022-04-18T15:20:00-03:00", "reminderSent": false}
1793	{"status": 0, "diaryID": "2022-04-22", "horario": {"inicio": "R22/2022-W15-5T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803241123016824", "startTime": "2022-04-22T15:20:00-03:00", "reminderSent": false}
1794	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-11-05T13:30:00-03:00", "reminderSent": false}
1795	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-11-12T13:30:00-03:00", "reminderSent": false}
1796	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-11-19T13:30:00-03:00", "reminderSent": false}
1797	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-11-26T13:30:00-03:00", "reminderSent": false}
1798	{"status": 0, "diaryID": "2021-12-03", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-12-03T13:30:00-03:00", "reminderSent": false}
1799	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-01T13:30:00-03:00", "reminderSent": false}
1800	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-08T13:30:00-03:00", "reminderSent": false}
1801	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-15T13:30:00-03:00", "reminderSent": false}
1802	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-22T13:30:00-03:00", "reminderSent": false}
1803	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-29T13:30:00-03:00", "reminderSent": false}
1804	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-12-06T13:30:00-03:00", "reminderSent": false}
1805	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-03T13:30:00-03:00", "reminderSent": false}
1806	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-10T13:30:00-03:00", "reminderSent": false}
1807	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-17T13:30:00-03:00", "reminderSent": false}
1808	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-24T13:30:00-03:00", "reminderSent": false}
1809	{"status": 0, "diaryID": "2021-12-01", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-12-01T13:30:00-03:00", "reminderSent": false}
1810	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-02T17:00:00-03:00", "reminderSent": false}
1811	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-09T17:00:00-03:00", "reminderSent": false}
1812	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-16T17:00:00-03:00", "reminderSent": false}
1813	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-23T17:00:00-03:00", "reminderSent": false}
1814	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-30T17:00:00-03:00", "reminderSent": false}
1815	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-04T17:00:00-03:00", "reminderSent": false}
1816	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-11T17:00:00-03:00", "reminderSent": false}
1817	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-18T17:00:00-03:00", "reminderSent": false}
1818	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-25T17:00:00-03:00", "reminderSent": false}
1819	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-12-02T17:00:00-03:00", "reminderSent": false}
1820	{"status": 0, "diaryID": "2022-04-18", "horario": {"inicio": "R22/2022-W15-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803693965230101", "startTime": "2022-04-18T15:20:00-03:00", "reminderSent": false}
1821	{"status": 0, "diaryID": "2022-04-22", "horario": {"inicio": "R22/2022-W15-5T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803693965230101", "startTime": "2022-04-22T15:20:00-03:00", "reminderSent": false}
\.


--
-- Data for Name: Diary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Diary" ("dateID", "diaryData") FROM stdin;
2021-11-30	{"dailyReminderSent": true}
\.


--
-- Data for Name: Materia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Materia" ("materiaID", "materiaData") FROM stdin;
\.


--
-- Data for Name: Reminder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Reminder" ("reminderID", "reminderData") FROM stdin;
\.


--
-- Name: Class_classID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Class_classID_seq"', 1821, true);


--
-- Name: Reminder_reminderID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Reminder_reminderID_seq"', 31, true);


--
-- Name: Class Class_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Class"
    ADD CONSTRAINT "Class_pk" PRIMARY KEY ("classID");


--
-- Name: Diary Diary_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Diary"
    ADD CONSTRAINT "Diary_pk" PRIMARY KEY ("dateID");


--
-- Name: Materia Materia_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Materia"
    ADD CONSTRAINT "Materia_pk" PRIMARY KEY ("materiaID");


--
-- Name: Reminder Reminder_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reminder"
    ADD CONSTRAINT "Reminder_pk" PRIMARY KEY ("reminderID");


--
-- PostgreSQL database dump complete
--

