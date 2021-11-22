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
1337	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-01T10:10:00-03:00", "reminderSent": false}
1338	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-08T10:10:00-03:00", "reminderSent": false}
1339	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-15T10:10:00-03:00", "reminderSent": false}
1341	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-29T10:10:00-03:00", "reminderSent": false}
1342	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-02T10:10:00-03:00", "reminderSent": false}
1340	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-22T10:10:00-03:00", "reminderSent": false}
1343	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-09T10:10:00-03:00", "reminderSent": false}
1344	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-16T10:10:00-03:00", "reminderSent": false}
1345	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136184647778346", "startTime": "2021-11-23T10:10:00-03:00", "reminderSent": false}
1346	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-11-05T10:10:00-03:00", "reminderSent": false}
1347	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-11-12T10:10:00-03:00", "reminderSent": false}
1348	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-11-19T10:10:00-03:00", "reminderSent": false}
1349	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136257272184832", "startTime": "2021-11-26T10:10:00-03:00", "reminderSent": false}
1350	{"status": 0, "diaryID": "2021-11-01", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-01T17:00:00-03:00", "reminderSent": false}
1351	{"status": 0, "diaryID": "2021-11-08", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-08T17:00:00-03:00", "reminderSent": false}
1352	{"status": 0, "diaryID": "2021-11-15", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-15T17:00:00-03:00", "reminderSent": false}
1353	{"status": 0, "diaryID": "2021-11-22", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-22T17:00:00-03:00", "reminderSent": false}
1354	{"status": 0, "diaryID": "2021-11-01", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-01T15:20:00-03:00", "reminderSent": false}
1355	{"status": 0, "diaryID": "2021-11-08", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-08T15:20:00-03:00", "reminderSent": false}
1356	{"status": 0, "diaryID": "2021-11-15", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-15T15:20:00-03:00", "reminderSent": false}
1357	{"status": 0, "diaryID": "2021-11-22", "horario": {"turma": "P2", "inicio": "R42/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904136257272184832", "startTime": "2021-11-22T15:20:00-03:00", "reminderSent": false}
1358	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-11-02T07:30:00-03:00", "reminderSent": false}
1359	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-11-09T07:30:00-03:00", "reminderSent": false}
1360	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-11-16T07:30:00-03:00", "reminderSent": false}
1361	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904136309935833098", "startTime": "2021-11-23T07:30:00-03:00", "reminderSent": false}
1362	{"status": 0, "diaryID": "2021-11-04", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-04T08:20:00-03:00", "reminderSent": false}
1363	{"status": 0, "diaryID": "2021-11-11", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-11T08:20:00-03:00", "reminderSent": false}
1364	{"status": 0, "diaryID": "2021-11-18", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-18T08:20:00-03:00", "reminderSent": false}
1365	{"status": 0, "diaryID": "2021-11-25", "horario": {"turma": "P1", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-25T08:20:00-03:00", "reminderSent": false}
1366	{"status": 0, "diaryID": "2021-11-04", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-04T08:20:00-03:00", "reminderSent": false}
1367	{"status": 0, "diaryID": "2021-11-11", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-11T08:20:00-03:00", "reminderSent": false}
1368	{"status": 0, "diaryID": "2021-11-18", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-18T08:20:00-03:00", "reminderSent": false}
1369	{"status": 0, "diaryID": "2021-11-25", "horario": {"turma": "P2", "inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136309935833098", "startTime": "2021-11-25T08:20:00-03:00", "reminderSent": false}
1370	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-02T08:20:00-03:00", "reminderSent": false}
1371	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-09T08:20:00-03:00", "reminderSent": false}
1372	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-16T08:20:00-03:00", "reminderSent": false}
1373	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T08:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-23T08:20:00-03:00", "reminderSent": false}
1374	{"status": 0, "diaryID": "2021-11-02", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-11-02T10:00:00-03:00", "reminderSent": false}
1375	{"status": 0, "diaryID": "2021-11-09", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-11-09T10:00:00-03:00", "reminderSent": false}
1376	{"status": 0, "diaryID": "2021-11-16", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-11-16T10:00:00-03:00", "reminderSent": false}
1377	{"status": 0, "diaryID": "2021-11-23", "horario": {"turma": "P1", "inicio": "R42/2021-W43-2T10:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904136277278982144", "startTime": "2021-11-23T10:00:00-03:00", "reminderSent": false}
1378	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-04T08:20:00-03:00", "reminderSent": false}
1379	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-11T08:20:00-03:00", "reminderSent": false}
1380	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-18T08:20:00-03:00", "reminderSent": false}
1381	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T08:20:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904136277278982144", "startTime": "2021-11-25T08:20:00-03:00", "reminderSent": false}
1382	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-01T08:20:00-03:00", "reminderSent": false}
1383	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-08T08:20:00-03:00", "reminderSent": false}
1384	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-15T08:20:00-03:00", "reminderSent": false}
1386	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-29T08:20:00-03:00", "reminderSent": false}
1387	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-03T08:20:00-03:00", "reminderSent": false}
1388	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-10T08:20:00-03:00", "reminderSent": false}
1389	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-17T08:20:00-03:00", "reminderSent": false}
1390	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R42/2021-W43-3T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-24T08:20:00-03:00", "reminderSent": false}
1391	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-11-05T10:10:00-03:00", "reminderSent": false}
1392	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-11-12T10:10:00-03:00", "reminderSent": false}
1393	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-11-19T10:10:00-03:00", "reminderSent": false}
1394	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153195759157258", "startTime": "2021-11-26T10:10:00-03:00", "reminderSent": false}
1395	{"status": 0, "diaryID": "2021-11-01", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-11-01T17:00:00-03:00", "reminderSent": false}
1396	{"status": 0, "diaryID": "2021-11-08", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-11-08T17:00:00-03:00", "reminderSent": false}
1397	{"status": 0, "diaryID": "2021-11-15", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-11-15T17:00:00-03:00", "reminderSent": false}
1398	{"status": 0, "diaryID": "2021-11-22", "horario": {"turma": "P1", "inicio": "R42/2021-W43-1T17:00:00/P1W", "duracao": "PT50M", "tipoAula": "Prática"}, "materiaID": "904153195759157258", "startTime": "2021-11-22T17:00:00-03:00", "reminderSent": false}
1399	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-11-02T13:00:00-03:00", "reminderSent": false}
1400	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-11-09T13:00:00-03:00", "reminderSent": false}
1401	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-11-16T13:00:00-03:00", "reminderSent": false}
1402	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T13:00:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153227963035718", "startTime": "2021-11-23T13:00:00-03:00", "reminderSent": false}
1403	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-11-05T07:30:00-03:00", "reminderSent": false}
1404	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-11-12T07:30:00-03:00", "reminderSent": false}
1405	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-11-19T07:30:00-03:00", "reminderSent": false}
1406	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904153253091110962", "startTime": "2021-11-26T07:30:00-03:00", "reminderSent": false}
1407	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-11-03T10:10:00-03:00", "reminderSent": false}
1408	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-11-10T10:10:00-03:00", "reminderSent": false}
1409	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-11-17T10:10:00-03:00", "reminderSent": false}
1410	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R42/2021-W43-3T10:10:00/P1W", "duracao": "PT50M", "tipoAula": "Teórica"}, "materiaID": "904153266907144192", "startTime": "2021-11-24T10:10:00-03:00", "reminderSent": false}
1411	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-02T15:20:00-03:00", "reminderSent": false}
1412	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-09T15:20:00-03:00", "reminderSent": false}
1413	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-16T15:20:00-03:00", "reminderSent": false}
1414	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-23T15:20:00-03:00", "reminderSent": false}
1415	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-04T15:20:00-03:00", "reminderSent": false}
1416	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-11T15:20:00-03:00", "reminderSent": false}
1417	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-18T15:20:00-03:00", "reminderSent": false}
1418	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904153306539110410", "startTime": "2021-11-25T15:20:00-03:00", "reminderSent": false}
1419	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-11-01T13:30:00-03:00", "reminderSent": false}
1420	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-11-08T13:30:00-03:00", "reminderSent": false}
1421	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-11-15T13:30:00-03:00", "reminderSent": false}
1422	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904604403569418251", "startTime": "2021-11-22T13:30:00-03:00", "reminderSent": false}
1423	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-02T13:30:00-03:00", "reminderSent": false}
1424	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-09T13:30:00-03:00", "reminderSent": false}
1425	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-16T13:30:00-03:00", "reminderSent": false}
1426	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-23T13:30:00-03:00", "reminderSent": false}
1427	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-04T13:30:00-03:00", "reminderSent": false}
1428	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-11T13:30:00-03:00", "reminderSent": false}
1429	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-18T13:30:00-03:00", "reminderSent": false}
1430	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904604963668361226", "startTime": "2021-11-25T13:30:00-03:00", "reminderSent": false}
1431	{"status": 0, "diaryID": "2022-04-22", "horario": {"inicio": "R22/2022-W15-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904607882153197628", "startTime": "2022-04-22T13:30:00-03:00", "reminderSent": false}
1432	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-03T17:00:00-03:00", "reminderSent": false}
1433	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-10T17:00:00-03:00", "reminderSent": false}
1434	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-17T17:00:00-03:00", "reminderSent": false}
1435	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R22/2021-W43-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-24T17:00:00-03:00", "reminderSent": false}
1436	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-04T17:00:00-03:00", "reminderSent": false}
1437	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-11T17:00:00-03:00", "reminderSent": false}
1438	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-18T17:00:00-03:00", "reminderSent": false}
1439	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R22/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904608462305128448", "startTime": "2021-11-25T17:00:00-03:00", "reminderSent": false}
1440	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-11-05T13:30:00-03:00", "reminderSent": false}
1441	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-11-12T13:30:00-03:00", "reminderSent": false}
1442	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-11-19T13:30:00-03:00", "reminderSent": false}
1443	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904608574053945374", "startTime": "2021-11-26T13:30:00-03:00", "reminderSent": false}
1444	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-11-02T17:00:00-03:00", "reminderSent": false}
1445	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-11-09T17:00:00-03:00", "reminderSent": false}
1446	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-11-16T17:00:00-03:00", "reminderSent": false}
1447	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904610034900693073", "startTime": "2021-11-23T17:00:00-03:00", "reminderSent": false}
1448	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-11-01T16:10:00-03:00", "reminderSent": false}
1449	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-11-08T16:10:00-03:00", "reminderSent": false}
1450	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-11-15T16:10:00-03:00", "reminderSent": false}
1451	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T16:10:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904611398842195988", "startTime": "2021-11-22T16:10:00-03:00", "reminderSent": false}
1452	{"status": 0, "diaryID": "2021-11-03", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-03T13:30:00-03:00", "reminderSent": false}
1453	{"status": 0, "diaryID": "2021-11-10", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-10T13:30:00-03:00", "reminderSent": false}
1454	{"status": 0, "diaryID": "2021-11-17", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-17T13:30:00-03:00", "reminderSent": false}
1455	{"status": 0, "diaryID": "2021-11-24", "horario": {"turma": "P1", "inicio": "R42/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-24T13:30:00-03:00", "reminderSent": false}
1456	{"status": 0, "diaryID": "2021-11-03", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-03T15:10:00-03:00", "reminderSent": false}
1457	{"status": 0, "diaryID": "2021-11-10", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-10T15:10:00-03:00", "reminderSent": false}
1458	{"status": 0, "diaryID": "2021-11-17", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-17T15:10:00-03:00", "reminderSent": false}
1459	{"status": 0, "diaryID": "2021-11-24", "horario": {"turma": "P2", "inicio": "R42/2021-W43-3T15:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Prática"}, "materiaID": "904611398842195988", "startTime": "2021-11-24T15:10:00-03:00", "reminderSent": false}
1460	{"status": 0, "diaryID": "2022-04-20", "horario": {"inicio": "R22/2022-W15-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904611834768814111", "startTime": "2022-04-20T17:00:00-03:00", "reminderSent": false}
1461	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-01T07:30:00-03:00", "reminderSent": false}
1462	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-08T07:30:00-03:00", "reminderSent": false}
1463	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-15T07:30:00-03:00", "reminderSent": false}
1465	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-29T07:30:00-03:00", "reminderSent": false}
1466	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-11-03T07:30:00-03:00", "reminderSent": false}
1467	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-11-10T07:30:00-03:00", "reminderSent": false}
1468	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-11-17T07:30:00-03:00", "reminderSent": false}
1469	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R42/2021-W43-3T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904759994459762689", "startTime": "2021-11-24T07:30:00-03:00", "reminderSent": false}
1470	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-02T17:00:00-03:00", "reminderSent": false}
1471	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-09T17:00:00-03:00", "reminderSent": false}
1472	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-16T17:00:00-03:00", "reminderSent": false}
1473	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-23T17:00:00-03:00", "reminderSent": false}
1474	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-05T07:30:00-03:00", "reminderSent": false}
1475	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-12T07:30:00-03:00", "reminderSent": false}
1476	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-19T07:30:00-03:00", "reminderSent": false}
1477	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760047601614878", "startTime": "2021-11-26T07:30:00-03:00", "reminderSent": false}
1478	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-11-03T09:20:00-03:00", "reminderSent": false}
1479	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-11-10T09:20:00-03:00", "reminderSent": false}
1480	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-11-17T09:20:00-03:00", "reminderSent": false}
1481	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R42/2021-W43-3T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760189503287368", "startTime": "2021-11-24T09:20:00-03:00", "reminderSent": false}
1482	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-11-05T09:20:00-03:00", "reminderSent": false}
1483	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-11-12T09:20:00-03:00", "reminderSent": false}
1484	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-11-19T09:20:00-03:00", "reminderSent": false}
1485	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R42/2021-W43-5T09:20:00/P1W", "duracao": "PT2H30M", "tipoAula": "Teórica"}, "materiaID": "904760331493072916", "startTime": "2021-11-26T09:20:00-03:00", "reminderSent": false}
1486	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-02T09:20:00-03:00", "reminderSent": false}
1487	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-09T09:20:00-03:00", "reminderSent": false}
1488	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-16T09:20:00-03:00", "reminderSent": false}
1489	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-23T09:20:00-03:00", "reminderSent": false}
1490	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-04T09:20:00-03:00", "reminderSent": false}
1491	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-11T09:20:00-03:00", "reminderSent": false}
1492	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-18T09:20:00-03:00", "reminderSent": false}
1493	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T09:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760420177436702", "startTime": "2021-11-25T09:20:00-03:00", "reminderSent": false}
1494	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-02T07:30:00-03:00", "reminderSent": false}
1495	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-09T07:30:00-03:00", "reminderSent": false}
1496	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-16T07:30:00-03:00", "reminderSent": false}
1497	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-23T07:30:00-03:00", "reminderSent": false}
1498	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-04T07:30:00-03:00", "reminderSent": false}
1499	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-11T07:30:00-03:00", "reminderSent": false}
1500	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-18T07:30:00-03:00", "reminderSent": false}
1501	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T07:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760499550453770", "startTime": "2021-11-25T07:30:00-03:00", "reminderSent": false}
1502	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-01T10:10:00-03:00", "reminderSent": false}
1503	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-08T10:10:00-03:00", "reminderSent": false}
1504	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-15T10:10:00-03:00", "reminderSent": false}
1506	{"status": 0, "diaryID": "2021-11-29", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-29T10:10:00-03:00", "reminderSent": false}
1507	{"status": 0, "diaryID": "2022-04-19", "horario": {"inicio": "R22/2022-W15-2T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802821499666433", "startTime": "2022-04-19T15:20:00-03:00", "reminderSent": false}
1508	{"status": 0, "diaryID": "2022-04-21", "horario": {"inicio": "R22/2022-W15-4T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802821499666433", "startTime": "2022-04-21T15:20:00-03:00", "reminderSent": false}
1509	{"status": 0, "diaryID": "2022-04-18", "horario": {"inicio": "R22/2022-W15-1T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802895520759808", "startTime": "2022-04-18T17:00:00-03:00", "reminderSent": false}
1510	{"status": 0, "diaryID": "2022-04-20", "horario": {"inicio": "R22/2022-W15-3T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802895520759808", "startTime": "2022-04-20T17:00:00-03:00", "reminderSent": false}
1511	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-02T13:30:00-03:00", "reminderSent": false}
1512	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-09T13:30:00-03:00", "reminderSent": false}
1513	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-16T13:30:00-03:00", "reminderSent": false}
1514	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-23T13:30:00-03:00", "reminderSent": false}
1515	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-04T13:30:00-03:00", "reminderSent": false}
1516	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-11T13:30:00-03:00", "reminderSent": false}
1517	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-18T13:30:00-03:00", "reminderSent": false}
1518	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904802969889959946", "startTime": "2021-11-25T13:30:00-03:00", "reminderSent": false}
1519	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-01T15:20:00-03:00", "reminderSent": false}
1520	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-08T15:20:00-03:00", "reminderSent": false}
1521	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-15T15:20:00-03:00", "reminderSent": false}
1522	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R22/2021-W43-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-22T15:20:00-03:00", "reminderSent": false}
1523	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-03T15:20:00-03:00", "reminderSent": false}
1524	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-10T15:20:00-03:00", "reminderSent": false}
1525	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-17T15:20:00-03:00", "reminderSent": false}
1526	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R22/2021-W43-3T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803081206775879", "startTime": "2021-11-24T15:20:00-03:00", "reminderSent": false}
1527	{"status": 0, "diaryID": "2022-04-18", "horario": {"inicio": "R22/2022-W15-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803241123016824", "startTime": "2022-04-18T15:20:00-03:00", "reminderSent": false}
1528	{"status": 0, "diaryID": "2022-04-22", "horario": {"inicio": "R22/2022-W15-5T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803241123016824", "startTime": "2022-04-22T15:20:00-03:00", "reminderSent": false}
1529	{"status": 0, "diaryID": "2021-11-05", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-11-05T13:30:00-03:00", "reminderSent": false}
1530	{"status": 0, "diaryID": "2021-11-12", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-11-12T13:30:00-03:00", "reminderSent": false}
1531	{"status": 0, "diaryID": "2021-11-19", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-11-19T13:30:00-03:00", "reminderSent": false}
1532	{"status": 0, "diaryID": "2021-11-26", "horario": {"inicio": "R22/2021-W43-5T13:30:00/P1W", "duracao": "PT210M", "tipoAula": "Teórica"}, "materiaID": "904803385901973625", "startTime": "2021-11-26T13:30:00-03:00", "reminderSent": false}
1533	{"status": 0, "diaryID": "2021-11-01", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-01T13:30:00-03:00", "reminderSent": false}
1534	{"status": 0, "diaryID": "2021-11-08", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-08T13:30:00-03:00", "reminderSent": false}
1535	{"status": 0, "diaryID": "2021-11-15", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-15T13:30:00-03:00", "reminderSent": false}
1536	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R22/2021-W43-1T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-22T13:30:00-03:00", "reminderSent": false}
1537	{"status": 0, "diaryID": "2021-11-03", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-03T13:30:00-03:00", "reminderSent": false}
1538	{"status": 0, "diaryID": "2021-11-10", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-10T13:30:00-03:00", "reminderSent": false}
1539	{"status": 0, "diaryID": "2021-11-17", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-17T13:30:00-03:00", "reminderSent": false}
1540	{"status": 0, "diaryID": "2021-11-24", "horario": {"inicio": "R22/2021-W43-3T13:30:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803518332956692", "startTime": "2021-11-24T13:30:00-03:00", "reminderSent": false}
1541	{"status": 0, "diaryID": "2021-11-02", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-02T17:00:00-03:00", "reminderSent": false}
1542	{"status": 0, "diaryID": "2021-11-09", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-09T17:00:00-03:00", "reminderSent": false}
1543	{"status": 0, "diaryID": "2021-11-16", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-16T17:00:00-03:00", "reminderSent": false}
1544	{"status": 0, "diaryID": "2021-11-23", "horario": {"inicio": "R42/2021-W43-2T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-23T17:00:00-03:00", "reminderSent": false}
1545	{"status": 0, "diaryID": "2021-11-04", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-04T17:00:00-03:00", "reminderSent": false}
1546	{"status": 0, "diaryID": "2021-11-11", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-11T17:00:00-03:00", "reminderSent": false}
1547	{"status": 0, "diaryID": "2021-11-18", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-18T17:00:00-03:00", "reminderSent": false}
1548	{"status": 0, "diaryID": "2021-11-25", "horario": {"inicio": "R42/2021-W43-4T17:00:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803563803410502", "startTime": "2021-11-25T17:00:00-03:00", "reminderSent": false}
1549	{"status": 0, "diaryID": "2022-04-18", "horario": {"inicio": "R22/2022-W15-1T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803693965230101", "startTime": "2022-04-18T15:20:00-03:00", "reminderSent": false}
1550	{"status": 0, "diaryID": "2022-04-22", "horario": {"inicio": "R22/2022-W15-5T15:20:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904803693965230101", "startTime": "2022-04-22T15:20:00-03:00", "reminderSent": false}
1385	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T08:20:00/P1W", "duracao": "PT1H50M", "tipoAula": "Teórica"}, "materiaID": "904136370367373353", "startTime": "2021-11-22T08:20:00-03:00", "reminderSent": false}
1464	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T07:30:00/P1W", "duracao": "PT2H40M", "tipoAula": "Teórica"}, "materiaID": "904759919658561676", "startTime": "2021-11-22T07:30:00-03:00", "reminderSent": false}
1505	{"status": 0, "diaryID": "2021-11-22", "horario": {"inicio": "R42/2021-W43-1T10:10:00/P1W", "duracao": "PT1H40M", "tipoAula": "Teórica"}, "materiaID": "904760629846507590", "startTime": "2021-11-22T10:10:00-03:00", "reminderSent": false}
\.


--
-- Data for Name: Diary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Diary" ("dateID", "diaryData") FROM stdin;
2021-11-22	{"dailyReminderSent": true}
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

SELECT pg_catalog.setval('public."Class_classID_seq"', 1550, true);


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

