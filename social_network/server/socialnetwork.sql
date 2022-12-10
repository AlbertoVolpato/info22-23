--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

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

--
-- Name: socialnetwork; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE socialnetwork WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Italian_Italy.1252';


ALTER DATABASE socialnetwork OWNER TO postgres;

\connect socialnetwork

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

--
-- Name: data; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA data;


ALTER SCHEMA data OWNER TO postgres;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: comment_likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment_likes (
    id uuid DEFAULT public.uuid_generate_v4(),
    user_id text,
    comment_id text
);


ALTER TABLE public.comment_likes OWNER TO postgres;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    user_id text,
    post_id text,
    content text,
    id uuid DEFAULT public.uuid_generate_v4(),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- Name: post_likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_likes (
    id uuid DEFAULT public.uuid_generate_v4(),
    user_id text,
    post_id text
);


ALTER TABLE public.post_likes OWNER TO postgres;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    id uuid DEFAULT public.uuid_generate_v4(),
    content text NOT NULL,
    user_id text NOT NULL,
    image text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4(),
    username text,
    email text,
    password text,
    created_at timestamp without time zone DEFAULT now(),
    google_token text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: comment_likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment_likes (id, user_id, comment_id) FROM stdin;
d71b5826-ccb2-42a0-bcab-036428d973e3	tony	Cisao
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (user_id, post_id, content, id, created_at) FROM stdin;
tony	\N	Ciadadasao	783e5c19-8943-405f-9883-36343a237b47	2022-11-25 11:09:02.724546
\.


--
-- Data for Name: post_likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_likes (id, user_id, post_id) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, content, user_id, image, created_at) FROM stdin;
972ed481-6ff6-4604-84a1-350a0e9b0e5c	Ciao	tony		\N
34208dee-868f-4a7d-9f92-a72d8cb13a9e	Ciadadasao	tony	\N	2022-11-25 11:08:39.068197
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password, created_at, google_token) FROM stdin;
f94cd303-e037-4765-9fb0-60f7427997dc	CiccoSudato	ciccio@gmail.com	Ciccio	\N	\N
e8f645ba-93e3-4ac7-a4d3-360cf136f843	TonyBueghin	tony@gmail.com	Tonyyy	\N	\N
\.


--
-- PostgreSQL database dump complete
--

