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
1822	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-01T10:10:00-03:00", "reminderSent": false}
1823	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-08T10:10:00-03:00", "reminderSent": false}
1824	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-15T10:10:00-03:00", "reminderSent": false}
1825	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-22T10:10:00-03:00", "reminderSent": false}
1826	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-29T10:10:00-03:00", "reminderSent": false}
1827	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-12-06T10:10:00-03:00", "reminderSent": false}
1828	{"status": 0, "diaryID": "2021-12-13", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-12-13T10:10:00-03:00", "reminderSent": false}
1829	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-02T10:10:00-03:00", "reminderSent": false}
1830	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-09T10:10:00-03:00", "reminderSent": false}
1831	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-16T10:10:00-03:00", "reminderSent": false}
1832	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-23T10:10:00-03:00", "reminderSent": false}
1833	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-30T10:10:00-03:00", "reminderSent": false}
1834	{"status": 0, "diaryID": "2021-12-07", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-12-07T10:10:00-03:00", "reminderSent": false}
1835	{"status": 0, "diaryID": "2021-12-14", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-12-14T10:10:00-03:00", "reminderSent": false}
1836	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-11-05T10:10:00-03:00", "reminderSent": false}
1837	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-11-12T10:10:00-03:00", "reminderSent": false}
1838	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-11-19T10:10:00-03:00", "reminderSent": false}
1839	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-11-26T10:10:00-03:00", "reminderSent": false}
1840	{"status": 0, "diaryID": "2021-12-03", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-12-03T10:10:00-03:00", "reminderSent": false}
1841	{"status": 0, "diaryID": "2021-12-10", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-12-10T10:10:00-03:00", "reminderSent": false}
1842	{"status": 0, "diaryID": "2021-11-01", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-01T17:00:00-03:00", "reminderSent": false}
1843	{"status": 0, "diaryID": "2021-11-08", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-08T17:00:00-03:00", "reminderSent": false}
1844	{"status": 0, "diaryID": "2021-11-15", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-15T17:00:00-03:00", "reminderSent": false}
1845	{"status": 0, "diaryID": "2021-11-22", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-22T17:00:00-03:00", "reminderSent": false}
1846	{"status": 0, "diaryID": "2021-11-29", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-29T17:00:00-03:00", "reminderSent": false}
1847	{"status": 0, "diaryID": "2021-12-06", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-12-06T17:00:00-03:00", "reminderSent": false}
1848	{"status": 0, "diaryID": "2021-12-13", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-12-13T17:00:00-03:00", "reminderSent": false}
1849	{"status": 0, "diaryID": "2021-11-01", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-01T15:20:00-03:00", "reminderSent": false}
1850	{"status": 0, "diaryID": "2021-11-08", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-08T15:20:00-03:00", "reminderSent": false}
1851	{"status": 0, "diaryID": "2021-11-15", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-15T15:20:00-03:00", "reminderSent": false}
1852	{"status": 0, "diaryID": "2021-11-22", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-22T15:20:00-03:00", "reminderSent": false}
1853	{"status": 0, "diaryID": "2021-11-29", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-29T15:20:00-03:00", "reminderSent": false}
1854	{"status": 0, "diaryID": "2021-12-06", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-12-06T15:20:00-03:00", "reminderSent": false}
1855	{"status": 0, "diaryID": "2021-12-13", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-12-13T15:20:00-03:00", "reminderSent": false}
1856	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-11-02T07:30:00-03:00", "reminderSent": false}
1857	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-11-09T07:30:00-03:00", "reminderSent": false}
1858	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-11-16T07:30:00-03:00", "reminderSent": false}
1859	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-11-23T07:30:00-03:00", "reminderSent": false}
1860	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-11-30T07:30:00-03:00", "reminderSent": false}
1861	{"status": 0, "diaryID": "2021-12-07", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-12-07T07:30:00-03:00", "reminderSent": false}
1862	{"status": 0, "diaryID": "2021-12-14", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-12-14T07:30:00-03:00", "reminderSent": false}
1863	{"status": 0, "diaryID": "2021-11-04", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-04T08:20:00-03:00", "reminderSent": false}
1864	{"status": 0, "diaryID": "2021-11-11", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-11T08:20:00-03:00", "reminderSent": false}
1865	{"status": 0, "diaryID": "2021-11-18", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-18T08:20:00-03:00", "reminderSent": false}
1866	{"status": 0, "diaryID": "2021-11-25", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-25T08:20:00-03:00", "reminderSent": false}
1867	{"status": 0, "diaryID": "2021-12-02", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-12-02T08:20:00-03:00", "reminderSent": false}
1868	{"status": 0, "diaryID": "2021-12-09", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-12-09T08:20:00-03:00", "reminderSent": false}
1869	{"status": 0, "diaryID": "2021-11-04", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-04T08:20:00-03:00", "reminderSent": false}
1870	{"status": 0, "diaryID": "2021-11-11", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-11T08:20:00-03:00", "reminderSent": false}
1871	{"status": 0, "diaryID": "2021-11-18", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-18T08:20:00-03:00", "reminderSent": false}
1872	{"status": 0, "diaryID": "2021-11-25", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-25T08:20:00-03:00", "reminderSent": false}
1873	{"status": 0, "diaryID": "2021-12-02", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-12-02T08:20:00-03:00", "reminderSent": false}
1874	{"status": 0, "diaryID": "2021-12-09", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-12-09T08:20:00-03:00", "reminderSent": false}
1875	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-02T08:20:00-03:00", "reminderSent": false}
1876	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-09T08:20:00-03:00", "reminderSent": false}
1877	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-16T08:20:00-03:00", "reminderSent": false}
1878	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-23T08:20:00-03:00", "reminderSent": false}
1879	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-30T08:20:00-03:00", "reminderSent": false}
1880	{"status": 0, "diaryID": "2021-12-07", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-12-07T08:20:00-03:00", "reminderSent": false}
1881	{"status": 0, "diaryID": "2021-12-14", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-12-14T08:20:00-03:00", "reminderSent": false}
1882	{"status": 0, "diaryID": "2021-11-02", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-11-02T10:00:00-03:00", "reminderSent": false}
1883	{"status": 0, "diaryID": "2021-11-09", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-11-09T10:00:00-03:00", "reminderSent": false}
1884	{"status": 0, "diaryID": "2021-11-16", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-11-16T10:00:00-03:00", "reminderSent": false}
1885	{"status": 0, "diaryID": "2021-11-23", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-11-23T10:00:00-03:00", "reminderSent": false}
1886	{"status": 0, "diaryID": "2021-11-30", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-11-30T10:00:00-03:00", "reminderSent": false}
1887	{"status": 0, "diaryID": "2021-12-07", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-12-07T10:00:00-03:00", "reminderSent": false}
1888	{"status": 0, "diaryID": "2021-12-14", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-12-14T10:00:00-03:00", "reminderSent": false}
1889	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-04T08:20:00-03:00", "reminderSent": false}
1890	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-11T08:20:00-03:00", "reminderSent": false}
1891	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-18T08:20:00-03:00", "reminderSent": false}
1892	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-25T08:20:00-03:00", "reminderSent": false}
1893	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-12-02T08:20:00-03:00", "reminderSent": false}
1894	{"status": 0, "diaryID": "2021-12-09", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-12-09T08:20:00-03:00", "reminderSent": false}
1895	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-01T08:20:00-03:00", "reminderSent": false}
1896	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-08T08:20:00-03:00", "reminderSent": false}
1897	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-15T08:20:00-03:00", "reminderSent": false}
1898	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-22T08:20:00-03:00", "reminderSent": false}
1899	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-29T08:20:00-03:00", "reminderSent": false}
1900	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-12-06T08:20:00-03:00", "reminderSent": false}
1901	{"status": 0, "diaryID": "2021-12-13", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-12-13T08:20:00-03:00", "reminderSent": false}
1902	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-03T08:20:00-03:00", "reminderSent": false}
1903	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-10T08:20:00-03:00", "reminderSent": false}
1904	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-17T08:20:00-03:00", "reminderSent": false}
1905	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-24T08:20:00-03:00", "reminderSent": false}
1906	{"status": 0, "diaryID": "2021-12-01", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-12-01T08:20:00-03:00", "reminderSent": false}
1907	{"status": 0, "diaryID": "2021-12-08", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-12-08T08:20:00-03:00", "reminderSent": false}
1908	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-11-05T10:10:00-03:00", "reminderSent": false}
1909	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-11-12T10:10:00-03:00", "reminderSent": false}
1910	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-11-19T10:10:00-03:00", "reminderSent": false}
1911	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-11-26T10:10:00-03:00", "reminderSent": false}
1912	{"status": 0, "diaryID": "2021-12-03", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-12-03T10:10:00-03:00", "reminderSent": false}
1913	{"status": 0, "diaryID": "2021-12-10", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-12-10T10:10:00-03:00", "reminderSent": false}
1914	{"status": 0, "diaryID": "2021-11-01", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-11-01T17:00:00-03:00", "reminderSent": false}
1915	{"status": 0, "diaryID": "2021-11-08", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-11-08T17:00:00-03:00", "reminderSent": false}
1916	{"status": 0, "diaryID": "2021-11-15", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-11-15T17:00:00-03:00", "reminderSent": false}
1917	{"status": 0, "diaryID": "2021-11-22", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-11-22T17:00:00-03:00", "reminderSent": false}
1918	{"status": 0, "diaryID": "2021-11-29", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-11-29T17:00:00-03:00", "reminderSent": false}
1919	{"status": 0, "diaryID": "2021-12-06", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-12-06T17:00:00-03:00", "reminderSent": false}
1920	{"status": 0, "diaryID": "2021-12-13", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-12-13T17:00:00-03:00", "reminderSent": false}
1921	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-11-02T13:00:00-03:00", "reminderSent": false}
1922	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-11-09T13:00:00-03:00", "reminderSent": false}
1923	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-11-16T13:00:00-03:00", "reminderSent": false}
1924	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-11-23T13:00:00-03:00", "reminderSent": false}
1925	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-11-30T13:00:00-03:00", "reminderSent": false}
1926	{"status": 0, "diaryID": "2021-12-07", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-12-07T13:00:00-03:00", "reminderSent": false}
1927	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-11-05T07:30:00-03:00", "reminderSent": false}
1928	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-11-12T07:30:00-03:00", "reminderSent": false}
1929	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-11-19T07:30:00-03:00", "reminderSent": false}
1930	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-11-26T07:30:00-03:00", "reminderSent": false}
1931	{"status": 0, "diaryID": "2021-12-03", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-12-03T07:30:00-03:00", "reminderSent": false}
1932	{"status": 0, "diaryID": "2021-12-10", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-12-10T07:30:00-03:00", "reminderSent": false}
1933	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-11-03T10:10:00-03:00", "reminderSent": false}
1934	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-11-10T10:10:00-03:00", "reminderSent": false}
1935	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-11-17T10:10:00-03:00", "reminderSent": false}
1936	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-11-24T10:10:00-03:00", "reminderSent": false}
1937	{"status": 0, "diaryID": "2021-12-01", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-12-01T10:10:00-03:00", "reminderSent": false}
1938	{"status": 0, "diaryID": "2021-12-08", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-12-08T10:10:00-03:00", "reminderSent": false}
1939	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-02T15:20:00-03:00", "reminderSent": false}
1940	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-09T15:20:00-03:00", "reminderSent": false}
1941	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-16T15:20:00-03:00", "reminderSent": false}
1942	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-23T15:20:00-03:00", "reminderSent": false}
1943	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-30T15:20:00-03:00", "reminderSent": false}
1944	{"status": 0, "diaryID": "2021-12-07", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-12-07T15:20:00-03:00", "reminderSent": false}
1945	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-04T15:20:00-03:00", "reminderSent": false}
1946	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-11T15:20:00-03:00", "reminderSent": false}
1947	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-18T15:20:00-03:00", "reminderSent": false}
1948	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-25T15:20:00-03:00", "reminderSent": false}
1949	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-12-02T15:20:00-03:00", "reminderSent": false}
1950	{"status": 0, "diaryID": "2021-12-09", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-12-09T15:20:00-03:00", "reminderSent": false}
1951	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-11-01T13:30:00-03:00", "reminderSent": false}
1952	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-11-08T13:30:00-03:00", "reminderSent": false}
1953	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-11-15T13:30:00-03:00", "reminderSent": false}
1954	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-11-22T13:30:00-03:00", "reminderSent": false}
1955	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-11-29T13:30:00-03:00", "reminderSent": false}
1956	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-12-06T13:30:00-03:00", "reminderSent": false}
1957	{"status": 0, "diaryID": "2021-12-13", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-12-13T13:30:00-03:00", "reminderSent": false}
1958	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-02T13:30:00-03:00", "reminderSent": false}
1959	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-09T13:30:00-03:00", "reminderSent": false}
1960	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-16T13:30:00-03:00", "reminderSent": false}
1961	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-23T13:30:00-03:00", "reminderSent": false}
1962	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-30T13:30:00-03:00", "reminderSent": false}
1963	{"status": 0, "diaryID": "2021-12-07", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-12-07T13:30:00-03:00", "reminderSent": false}
1964	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-04T13:30:00-03:00", "reminderSent": false}
1965	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-11T13:30:00-03:00", "reminderSent": false}
1966	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-18T13:30:00-03:00", "reminderSent": false}
1967	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-25T13:30:00-03:00", "reminderSent": false}
1968	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-12-02T13:30:00-03:00", "reminderSent": false}
1969	{"status": 0, "diaryID": "2021-12-09", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-12-09T13:30:00-03:00", "reminderSent": false}
1970	{"status": 0, "diaryID": "2022-04-22", "horario": {"inicio": "R22/2022-W15-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904607882153197628", "startTime": "2022-04-22T13:30:00-03:00", "reminderSent": false}
1971	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-03T17:00:00-03:00", "reminderSent": false}
1972	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-10T17:00:00-03:00", "reminderSent": false}
1973	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-17T17:00:00-03:00", "reminderSent": false}
1974	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-24T17:00:00-03:00", "reminderSent": false}
1975	{"status": 0, "diaryID": "2021-12-01", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-12-01T17:00:00-03:00", "reminderSent": false}
1976	{"status": 0, "diaryID": "2021-12-08", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-12-08T17:00:00-03:00", "reminderSent": false}
1977	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-04T17:00:00-03:00", "reminderSent": false}
1978	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-11T17:00:00-03:00", "reminderSent": false}
1979	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-18T17:00:00-03:00", "reminderSent": false}
1980	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-25T17:00:00-03:00", "reminderSent": false}
1981	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-12-02T17:00:00-03:00", "reminderSent": false}
1982	{"status": 0, "diaryID": "2021-12-09", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-12-09T17:00:00-03:00", "reminderSent": false}
1983	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-11-05T13:30:00-03:00", "reminderSent": false}
1984	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-11-12T13:30:00-03:00", "reminderSent": false}
1985	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-11-19T13:30:00-03:00", "reminderSent": false}
1986	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-11-26T13:30:00-03:00", "reminderSent": false}
1987	{"status": 0, "diaryID": "2021-12-03", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-12-03T13:30:00-03:00", "reminderSent": false}
1988	{"status": 0, "diaryID": "2021-12-10", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-12-10T13:30:00-03:00", "reminderSent": false}
1989	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-11-02T17:00:00-03:00", "reminderSent": false}
1990	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-11-09T17:00:00-03:00", "reminderSent": false}
1991	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-11-16T17:00:00-03:00", "reminderSent": false}
1992	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-11-23T17:00:00-03:00", "reminderSent": false}
1993	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-11-30T17:00:00-03:00", "reminderSent": false}
1994	{"status": 0, "diaryID": "2021-12-07", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-12-07T17:00:00-03:00", "reminderSent": false}
1995	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-11-01T16:10:00-03:00", "reminderSent": false}
1996	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-11-08T16:10:00-03:00", "reminderSent": false}
1997	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-11-15T16:10:00-03:00", "reminderSent": false}
1998	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-11-22T16:10:00-03:00", "reminderSent": false}
1999	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-11-29T16:10:00-03:00", "reminderSent": false}
2000	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-12-06T16:10:00-03:00", "reminderSent": false}
2001	{"status": 0, "diaryID": "2021-12-13", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-12-13T16:10:00-03:00", "reminderSent": false}
2002	{"status": 0, "diaryID": "2021-11-03", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-03T13:30:00-03:00", "reminderSent": false}
2003	{"status": 0, "diaryID": "2021-11-10", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-10T13:30:00-03:00", "reminderSent": false}
2004	{"status": 0, "diaryID": "2021-11-17", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-17T13:30:00-03:00", "reminderSent": false}
2005	{"status": 0, "diaryID": "2021-11-24", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-24T13:30:00-03:00", "reminderSent": false}
2006	{"status": 0, "diaryID": "2021-12-01", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-12-01T13:30:00-03:00", "reminderSent": false}
2007	{"status": 0, "diaryID": "2021-12-08", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-12-08T13:30:00-03:00", "reminderSent": false}
2008	{"status": 0, "diaryID": "2021-11-03", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-03T15:10:00-03:00", "reminderSent": false}
2009	{"status": 0, "diaryID": "2021-11-10", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-10T15:10:00-03:00", "reminderSent": false}
2010	{"status": 0, "diaryID": "2021-11-17", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-17T15:10:00-03:00", "reminderSent": false}
2011	{"status": 0, "diaryID": "2021-11-24", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-24T15:10:00-03:00", "reminderSent": false}
2012	{"status": 0, "diaryID": "2021-12-01", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-12-01T15:10:00-03:00", "reminderSent": false}
2013	{"status": 0, "diaryID": "2021-12-08", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-12-08T15:10:00-03:00", "reminderSent": false}
2014	{"status": 0, "diaryID": "2022-04-20", "horario": {"inicio": "R22/2022-W15-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904611834768814111", "startTime": "2022-04-20T17:00:00-03:00", "reminderSent": false}
2015	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-01T07:30:00-03:00", "reminderSent": false}
2016	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-08T07:30:00-03:00", "reminderSent": false}
2017	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-15T07:30:00-03:00", "reminderSent": false}
2018	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-22T07:30:00-03:00", "reminderSent": false}
2019	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-29T07:30:00-03:00", "reminderSent": false}
2020	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-12-06T07:30:00-03:00", "reminderSent": false}
2021	{"status": 0, "diaryID": "2021-12-13", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-12-13T07:30:00-03:00", "reminderSent": false}
2022	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-11-03T07:30:00-03:00", "reminderSent": false}
2023	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-11-10T07:30:00-03:00", "reminderSent": false}
2024	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-11-17T07:30:00-03:00", "reminderSent": false}
2025	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-11-24T07:30:00-03:00", "reminderSent": false}
2026	{"status": 0, "diaryID": "2021-12-01", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-12-01T07:30:00-03:00", "reminderSent": false}
2027	{"status": 0, "diaryID": "2021-12-08", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-12-08T07:30:00-03:00", "reminderSent": false}
2028	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-02T17:00:00-03:00", "reminderSent": false}
2029	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-09T17:00:00-03:00", "reminderSent": false}
2030	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-16T17:00:00-03:00", "reminderSent": false}
2031	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-23T17:00:00-03:00", "reminderSent": false}
2032	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-30T17:00:00-03:00", "reminderSent": false}
2033	{"status": 0, "diaryID": "2021-12-07", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-12-07T17:00:00-03:00", "reminderSent": false}
2034	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-05T07:30:00-03:00", "reminderSent": false}
2035	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-12T07:30:00-03:00", "reminderSent": false}
2036	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-19T07:30:00-03:00", "reminderSent": false}
2037	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-26T07:30:00-03:00", "reminderSent": false}
2038	{"status": 0, "diaryID": "2021-12-03", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-12-03T07:30:00-03:00", "reminderSent": false}
2039	{"status": 0, "diaryID": "2021-12-10", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-12-10T07:30:00-03:00", "reminderSent": false}
2040	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-11-03T09:20:00-03:00", "reminderSent": false}
2041	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-11-10T09:20:00-03:00", "reminderSent": false}
2042	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-11-17T09:20:00-03:00", "reminderSent": false}
2043	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-11-24T09:20:00-03:00", "reminderSent": false}
2044	{"status": 0, "diaryID": "2021-12-01", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-12-01T09:20:00-03:00", "reminderSent": false}
2045	{"status": 0, "diaryID": "2021-12-08", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-12-08T09:20:00-03:00", "reminderSent": false}
2046	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-11-05T09:20:00-03:00", "reminderSent": false}
2047	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-11-12T09:20:00-03:00", "reminderSent": false}
2048	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-11-19T09:20:00-03:00", "reminderSent": false}
2049	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-11-26T09:20:00-03:00", "reminderSent": false}
2050	{"status": 0, "diaryID": "2021-12-03", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-12-03T09:20:00-03:00", "reminderSent": false}
2051	{"status": 0, "diaryID": "2021-12-10", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-12-10T09:20:00-03:00", "reminderSent": false}
2052	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-02T09:20:00-03:00", "reminderSent": false}
2053	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-09T09:20:00-03:00", "reminderSent": false}
2054	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-16T09:20:00-03:00", "reminderSent": false}
2055	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-23T09:20:00-03:00", "reminderSent": false}
2056	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-30T09:20:00-03:00", "reminderSent": false}
2057	{"status": 0, "diaryID": "2021-12-07", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-12-07T09:20:00-03:00", "reminderSent": false}
2058	{"status": 0, "diaryID": "2021-12-14", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-12-14T09:20:00-03:00", "reminderSent": false}
2059	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-04T09:20:00-03:00", "reminderSent": false}
2060	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-11T09:20:00-03:00", "reminderSent": false}
2061	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-18T09:20:00-03:00", "reminderSent": false}
2062	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-25T09:20:00-03:00", "reminderSent": false}
2063	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-12-02T09:20:00-03:00", "reminderSent": false}
2064	{"status": 0, "diaryID": "2021-12-09", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-12-09T09:20:00-03:00", "reminderSent": false}
2065	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-02T07:30:00-03:00", "reminderSent": false}
2066	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-09T07:30:00-03:00", "reminderSent": false}
2067	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-16T07:30:00-03:00", "reminderSent": false}
2068	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-23T07:30:00-03:00", "reminderSent": false}
2069	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-30T07:30:00-03:00", "reminderSent": false}
2070	{"status": 0, "diaryID": "2021-12-07", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-12-07T07:30:00-03:00", "reminderSent": false}
2071	{"status": 0, "diaryID": "2021-12-14", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-12-14T07:30:00-03:00", "reminderSent": false}
2072	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-04T07:30:00-03:00", "reminderSent": false}
2073	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-11T07:30:00-03:00", "reminderSent": false}
2074	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-18T07:30:00-03:00", "reminderSent": false}
2075	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-25T07:30:00-03:00", "reminderSent": false}
2076	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-12-02T07:30:00-03:00", "reminderSent": false}
2077	{"status": 0, "diaryID": "2021-12-09", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-12-09T07:30:00-03:00", "reminderSent": false}
2078	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-01T10:10:00-03:00", "reminderSent": false}
2079	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-08T10:10:00-03:00", "reminderSent": false}
2080	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-15T10:10:00-03:00", "reminderSent": false}
2081	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-22T10:10:00-03:00", "reminderSent": false}
2082	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-29T10:10:00-03:00", "reminderSent": false}
2083	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-12-06T10:10:00-03:00", "reminderSent": false}
2084	{"status": 0, "diaryID": "2021-12-13", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-12-13T10:10:00-03:00", "reminderSent": false}
2085	{"status": 0, "diaryID": "2022-04-19", "horario": {"inicio": "R22/2022-W15-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802821499666433", "startTime": "2022-04-19T15:20:00-03:00", "reminderSent": false}
2086	{"status": 0, "diaryID": "2022-04-21", "horario": {"inicio": "R22/2022-W15-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802821499666433", "startTime": "2022-04-21T15:20:00-03:00", "reminderSent": false}
2087	{"status": 0, "diaryID": "2022-04-18", "horario": {"inicio": "R22/2022-W15-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802895520759808", "startTime": "2022-04-18T17:00:00-03:00", "reminderSent": false}
2088	{"status": 0, "diaryID": "2022-04-20", "horario": {"inicio": "R22/2022-W15-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802895520759808", "startTime": "2022-04-20T17:00:00-03:00", "reminderSent": false}
2089	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-02T13:30:00-03:00", "reminderSent": false}
2090	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-09T13:30:00-03:00", "reminderSent": false}
2091	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-16T13:30:00-03:00", "reminderSent": false}
2092	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-23T13:30:00-03:00", "reminderSent": false}
2093	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-30T13:30:00-03:00", "reminderSent": false}
2094	{"status": 0, "diaryID": "2021-12-07", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-12-07T13:30:00-03:00", "reminderSent": false}
2095	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-04T13:30:00-03:00", "reminderSent": false}
2096	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-11T13:30:00-03:00", "reminderSent": false}
2097	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-18T13:30:00-03:00", "reminderSent": false}
2098	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-25T13:30:00-03:00", "reminderSent": false}
2099	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-12-02T13:30:00-03:00", "reminderSent": false}
2100	{"status": 0, "diaryID": "2021-12-09", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-12-09T13:30:00-03:00", "reminderSent": false}
2101	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-01T15:20:00-03:00", "reminderSent": false}
2102	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-08T15:20:00-03:00", "reminderSent": false}
2103	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-15T15:20:00-03:00", "reminderSent": false}
2104	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-22T15:20:00-03:00", "reminderSent": false}
2105	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-29T15:20:00-03:00", "reminderSent": false}
2106	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-12-06T15:20:00-03:00", "reminderSent": false}
2107	{"status": 0, "diaryID": "2021-12-13", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-12-13T15:20:00-03:00", "reminderSent": false}
2108	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-03T15:20:00-03:00", "reminderSent": false}
2109	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-10T15:20:00-03:00", "reminderSent": false}
2110	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-17T15:20:00-03:00", "reminderSent": false}
2111	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-24T15:20:00-03:00", "reminderSent": false}
2112	{"status": 0, "diaryID": "2021-12-01", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-12-01T15:20:00-03:00", "reminderSent": false}
2113	{"status": 0, "diaryID": "2021-12-08", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-12-08T15:20:00-03:00", "reminderSent": false}
2114	{"status": 0, "diaryID": "2022-04-18", "horario": {"inicio": "R22/2022-W15-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803241123016824", "startTime": "2022-04-18T15:20:00-03:00", "reminderSent": false}
2115	{"status": 0, "diaryID": "2022-04-22", "horario": {"inicio": "R22/2022-W15-5T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803241123016824", "startTime": "2022-04-22T15:20:00-03:00", "reminderSent": false}
2116	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-11-05T13:30:00-03:00", "reminderSent": false}
2117	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-11-12T13:30:00-03:00", "reminderSent": false}
2118	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-11-19T13:30:00-03:00", "reminderSent": false}
2119	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-11-26T13:30:00-03:00", "reminderSent": false}
2120	{"status": 0, "diaryID": "2021-12-03", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-12-03T13:30:00-03:00", "reminderSent": false}
2121	{"status": 0, "diaryID": "2021-12-10", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-12-10T13:30:00-03:00", "reminderSent": false}
2122	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-01T13:30:00-03:00", "reminderSent": false}
2123	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-08T13:30:00-03:00", "reminderSent": false}
2124	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-15T13:30:00-03:00", "reminderSent": false}
2125	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-22T13:30:00-03:00", "reminderSent": false}
2126	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-29T13:30:00-03:00", "reminderSent": false}
2127	{"status": 0, "diaryID": "2021-12-06", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-12-06T13:30:00-03:00", "reminderSent": false}
2128	{"status": 0, "diaryID": "2021-12-13", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-12-13T13:30:00-03:00", "reminderSent": false}
2129	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-03T13:30:00-03:00", "reminderSent": false}
2130	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-10T13:30:00-03:00", "reminderSent": false}
2131	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-17T13:30:00-03:00", "reminderSent": false}
2132	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-24T13:30:00-03:00", "reminderSent": false}
2133	{"status": 0, "diaryID": "2021-12-01", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-12-01T13:30:00-03:00", "reminderSent": false}
2134	{"status": 0, "diaryID": "2021-12-08", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-12-08T13:30:00-03:00", "reminderSent": false}
2135	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-02T17:00:00-03:00", "reminderSent": false}
2136	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-09T17:00:00-03:00", "reminderSent": false}
2137	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-16T17:00:00-03:00", "reminderSent": false}
2138	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-23T17:00:00-03:00", "reminderSent": false}
2139	{"status": 0, "diaryID": "2021-11-30", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-30T17:00:00-03:00", "reminderSent": false}
2140	{"status": 0, "diaryID": "2021-12-07", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-12-07T17:00:00-03:00", "reminderSent": false}
2141	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-04T17:00:00-03:00", "reminderSent": false}
2142	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-11T17:00:00-03:00", "reminderSent": false}
2143	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-18T17:00:00-03:00", "reminderSent": false}
2144	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-25T17:00:00-03:00", "reminderSent": false}
2145	{"status": 0, "diaryID": "2021-12-02", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-12-02T17:00:00-03:00", "reminderSent": false}
2146	{"status": 0, "diaryID": "2021-12-09", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-12-09T17:00:00-03:00", "reminderSent": false}
2147	{"status": 0, "diaryID": "2022-04-18", "horario": {"inicio": "R22/2022-W15-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803693965230101", "startTime": "2022-04-18T15:20:00-03:00", "reminderSent": false}
2148	{"status": 0, "diaryID": "2022-04-22", "horario": {"inicio": "R22/2022-W15-5T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803693965230101", "startTime": "2022-04-22T15:20:00-03:00", "reminderSent": false}
\.


--
-- Data for Name: Diary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Diary" ("dateID", "diaryData") FROM stdin;
2021-11-30	{"dailyReminderSent": true}
2021-12-06	{"dailyReminderSent": true}
2021-12-07	{"dailyReminderSent": false}
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
32	{"type": "anotação", "scope": "público", "author": "139883836526821376", "dueDate": "2021-12-07T17:00:00-03:00", "disabled": false, "createdAt": 1638829073, "materiaID": "904760047601614878", "description": "123456 teste", "descriptionURL": "https://discord.com/channels/880436832104513586/904126370790117396/917540371196698635"}
33	{"type": "exercício", "scope": "pessoal", "author": "139883836526821376", "dueDate": "2021-12-25T23:59:59-03:00", "disabled": false, "createdAt": 1638829904, "materiaID": "904760047601614878", "description": "Natal maninho", "descriptionURL": "https://discord.com/channels/880436832104513586/904126370790117396/917543856159989841"}
\.


--
-- Name: Class_classID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Class_classID_seq"', 2148, true);


--
-- Name: Reminder_reminderID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Reminder_reminderID_seq"', 33, true);


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

