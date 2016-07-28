--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE activities (
    id integer NOT NULL,
    name character varying,
    description character varying,
    logo character varying,
    start_date date,
    end_date date,
    term text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    papers_count integer DEFAULT 0,
    event_start_date date,
    event_end_date date
);


--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE activities_id_seq OWNED BY activities.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying,
    activity_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: custom_fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE custom_fields (
    id integer NOT NULL,
    sort_order integer DEFAULT 0,
    name character varying(64),
    activity_id integer,
    field_type character varying(48),
    required boolean DEFAULT false,
    options jsonb DEFAULT '{}'::jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: custom_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE custom_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE custom_fields_id_seq OWNED BY custom_fields.id;


--
-- Name: papers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE papers (
    id integer NOT NULL,
    title character varying,
    abstract text,
    outline text,
    speaker_avatar character varying,
    state character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    activity_id integer,
    user_id integer,
    inviting_email character varying,
    answer_of_custom_fields jsonb DEFAULT '{}'::jsonb
);


--
-- Name: papers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE papers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: papers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE papers_id_seq OWNED BY papers.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: user_activity_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_activity_relationships (
    id integer NOT NULL,
    user_id integer,
    activity_id integer,
    is_reviewer boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_activity_relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_activity_relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_activity_relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_activity_relationships_id_seq OWNED BY user_activity_relationships.id;


--
-- Name: user_paper_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_paper_relationships (
    id integer NOT NULL,
    user_id integer,
    paper_id integer,
    is_author boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_paper_relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_paper_relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_paper_relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_paper_relationships_id_seq OWNED BY user_paper_relationships.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    name character varying,
    firstname character varying,
    lastname character varying,
    phone character varying,
    title character varying,
    company character varying,
    country character varying,
    photo character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    provider character varying,
    uid character varying,
    is_admin boolean
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY activities ALTER COLUMN id SET DEFAULT nextval('activities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY custom_fields ALTER COLUMN id SET DEFAULT nextval('custom_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY papers ALTER COLUMN id SET DEFAULT nextval('papers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_activity_relationships ALTER COLUMN id SET DEFAULT nextval('user_activity_relationships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_paper_relationships ALTER COLUMN id SET DEFAULT nextval('user_paper_relationships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: activities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: custom_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY custom_fields
    ADD CONSTRAINT custom_fields_pkey PRIMARY KEY (id);


--
-- Name: papers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY papers
    ADD CONSTRAINT papers_pkey PRIMARY KEY (id);


--
-- Name: user_activity_relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_activity_relationships
    ADD CONSTRAINT user_activity_relationships_pkey PRIMARY KEY (id);


--
-- Name: user_paper_relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_paper_relationships
    ADD CONSTRAINT user_paper_relationships_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_papers_on_activity_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_papers_on_activity_id ON papers USING btree (activity_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_efa6e5d1dd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY papers
    ADD CONSTRAINT fk_rails_efa6e5d1dd FOREIGN KEY (activity_id) REFERENCES activities(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20160420061757');

INSERT INTO schema_migrations (version) VALUES ('20160503040959');

INSERT INTO schema_migrations (version) VALUES ('20160504025516');

INSERT INTO schema_migrations (version) VALUES ('20160504031653');

INSERT INTO schema_migrations (version) VALUES ('20160510061610');

INSERT INTO schema_migrations (version) VALUES ('20160510063041');

INSERT INTO schema_migrations (version) VALUES ('20160511082609');

INSERT INTO schema_migrations (version) VALUES ('20160513021650');

INSERT INTO schema_migrations (version) VALUES ('20160517074516');

INSERT INTO schema_migrations (version) VALUES ('20160517080249');

INSERT INTO schema_migrations (version) VALUES ('20160518054332');

INSERT INTO schema_migrations (version) VALUES ('20160518080743');

INSERT INTO schema_migrations (version) VALUES ('20160524032057');

INSERT INTO schema_migrations (version) VALUES ('20160531032018');

INSERT INTO schema_migrations (version) VALUES ('20160601083808');

INSERT INTO schema_migrations (version) VALUES ('20160622033006');

INSERT INTO schema_migrations (version) VALUES ('20160622054610');

INSERT INTO schema_migrations (version) VALUES ('20160725102035');

INSERT INTO schema_migrations (version) VALUES ('20160725103142');

INSERT INTO schema_migrations (version) VALUES ('20160727160050');

INSERT INTO schema_migrations (version) VALUES ('20160727160547');

INSERT INTO schema_migrations (version) VALUES ('20160728060308');

