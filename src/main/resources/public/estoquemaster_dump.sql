--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

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
-- Name: estoquemaster; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA estoquemaster;


ALTER SCHEMA estoquemaster OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: appuser; Type: TABLE; Schema: estoquemaster; Owner: postgres
--

CREATE TABLE estoquemaster.appuser (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(32) NOT NULL,
    ispremium smallint
);


ALTER TABLE estoquemaster.appuser OWNER TO postgres;

--
-- Name: app_user_id_seq; Type: SEQUENCE; Schema: estoquemaster; Owner: postgres
--

CREATE SEQUENCE estoquemaster.app_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estoquemaster.app_user_id_seq OWNER TO postgres;

--
-- Name: app_user_id_seq; Type: SEQUENCE OWNED BY; Schema: estoquemaster; Owner: postgres
--

ALTER SEQUENCE estoquemaster.app_user_id_seq OWNED BY estoquemaster.appuser.id;


--
-- Name: buyer; Type: TABLE; Schema: estoquemaster; Owner: postgres
--

CREATE TABLE estoquemaster.buyer (
    cpf integer NOT NULL,
    name character varying(45),
    address character varying(45),
    contact_info character varying(45),
    user_id bigint
);


ALTER TABLE estoquemaster.buyer OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: estoquemaster; Owner: postgres
--

CREATE TABLE estoquemaster.products (
    id integer NOT NULL,
    nome character varying(45) NOT NULL,
    amount integer,
    description character varying(255),
    buying_price double precision,
    selling_price double precision,
    vality date,
    user_id bigint NOT NULL,
    provider_cnpj bigint NOT NULL,
    min_amount integer,
    img_url character varying(255)
);


ALTER TABLE estoquemaster.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: estoquemaster; Owner: postgres
--

CREATE SEQUENCE estoquemaster.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estoquemaster.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: estoquemaster; Owner: postgres
--

ALTER SEQUENCE estoquemaster.products_id_seq OWNED BY estoquemaster.products.id;


--
-- Name: provider; Type: TABLE; Schema: estoquemaster; Owner: postgres
--

CREATE TABLE estoquemaster.provider (
    cnpj bigint NOT NULL,
    name character varying(45),
    contact_info character varying(45)
);


ALTER TABLE estoquemaster.provider OWNER TO postgres;

--
-- Name: transaction; Type: TABLE; Schema: estoquemaster; Owner: postgres
--

CREATE TABLE estoquemaster.transaction (
    id integer NOT NULL,
    date date,
    buyer_cpf integer NOT NULL,
    products_id integer NOT NULL,
    products_user_id integer NOT NULL,
    amount_sold integer,
    price double precision
);


ALTER TABLE estoquemaster.transaction OWNER TO postgres;

--
-- Name: transaction_id_seq; Type: SEQUENCE; Schema: estoquemaster; Owner: postgres
--

CREATE SEQUENCE estoquemaster.transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estoquemaster.transaction_id_seq OWNER TO postgres;

--
-- Name: transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: estoquemaster; Owner: postgres
--

ALTER SEQUENCE estoquemaster.transaction_id_seq OWNED BY estoquemaster.transaction.id;


--
-- Name: app_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_user (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(32) NOT NULL,
    ispremium boolean,
    buyer_cpf integer NOT NULL
);


ALTER TABLE public.app_user OWNER TO postgres;

--
-- Name: app_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.app_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_user_id_seq OWNER TO postgres;

--
-- Name: app_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.app_user_id_seq OWNED BY public.app_user.id;


--
-- Name: buyer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buyer (
    cpf integer NOT NULL,
    nome character varying(45),
    address character varying(45),
    contact_info character varying(45)
);


ALTER TABLE public.buyer OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    nome character varying(45) NOT NULL,
    quantidade integer,
    description character varying(255),
    price_compra double precision,
    price_venda double precision,
    validade timestamp with time zone,
    user_id integer NOT NULL,
    provider_cnpj integer NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider (
    cnpj integer NOT NULL,
    nome character varying(45),
    contact_info character varying(45)
);


ALTER TABLE public.provider OWNER TO postgres;

--
-- Name: transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction (
    id integer NOT NULL,
    productid character varying(45),
    date date,
    buyer_cpf integer NOT NULL,
    products_id integer NOT NULL,
    products_user_id integer NOT NULL,
    products_provider_cnpj integer NOT NULL,
    user_id integer NOT NULL,
    user_buyer_cpf integer NOT NULL
);


ALTER TABLE public.transaction OWNER TO postgres;

--
-- Name: transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_id_seq OWNER TO postgres;

--
-- Name: transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaction_id_seq OWNED BY public.transaction.id;


--
-- Name: appuser id; Type: DEFAULT; Schema: estoquemaster; Owner: postgres
--

ALTER TABLE ONLY estoquemaster.appuser ALTER COLUMN id SET DEFAULT nextval('estoquemaster.app_user_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: estoquemaster; Owner: postgres
--

ALTER TABLE ONLY estoquemaster.products ALTER COLUMN id SET DEFAULT nextval('estoquemaster.products_id_seq'::regclass);


--
-- Name: transaction id; Type: DEFAULT; Schema: estoquemaster; Owner: postgres
--

ALTER TABLE ONLY estoquemaster.transaction ALTER COLUMN id SET DEFAULT nextval('estoquemaster.transaction_id_seq'::regclass);


--
-- Name: app_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user ALTER COLUMN id SET DEFAULT nextval('public.app_user_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: transaction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction ALTER COLUMN id SET DEFAULT nextval('public.transaction_id_seq'::regclass);


--
-- Name: appuser app_user_pkey; Type: CONSTRAINT; Schema: estoquemaster; Owner: postgres
--

ALTER TABLE ONLY estoquemaster.appuser
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);


--
-- Name: buyer buyer_pkey; Type: CONSTRAINT; Schema: estoquemaster; Owner: postgres
--

ALTER TABLE ONLY estoquemaster.buyer
    ADD CONSTRAINT buyer_pkey PRIMARY KEY (cpf);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: estoquemaster; Owner: postgres
--

ALTER TABLE ONLY estoquemaster.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: provider provider_pkey; Type: CONSTRAINT; Schema: estoquemaster; Owner: postgres
--

ALTER TABLE ONLY estoquemaster.provider
    ADD CONSTRAINT provider_pkey PRIMARY KEY (cnpj);


--
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: estoquemaster; Owner: postgres
--

ALTER TABLE ONLY estoquemaster.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);


--
-- Name: products uc_products_id_user_provider; Type: CONSTRAINT; Schema: estoquemaster; Owner: postgres
--

ALTER TABLE ONLY estoquemaster.products
    ADD CONSTRAINT uc_products_id_user_provider UNIQUE (id, user_id, provider_cnpj);


--
-- Name: app_user app_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_email_key UNIQUE (email);


--
-- Name: app_user app_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);


--
-- Name: buyer buyer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buyer
    ADD CONSTRAINT buyer_pkey PRIMARY KEY (cpf);


--
-- Name: products products_id_user_id_provider_cnpj_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_id_user_id_provider_cnpj_key UNIQUE (id, user_id, provider_cnpj);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: provider provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider
    ADD CONSTRAINT provider_pkey PRIMARY KEY (cnpj);


--
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);


--
-- Name: email_unique; Type: INDEX; Schema: estoquemaster; Owner: postgres
--

CREATE UNIQUE INDEX email_unique ON estoquemaster.appuser USING btree (email);


--
-- Name: products fk_products_app_user; Type: FK CONSTRAINT; Schema: estoquemaster; Owner: postgres
--

ALTER TABLE ONLY estoquemaster.products
    ADD CONSTRAINT fk_products_app_user FOREIGN KEY (user_id) REFERENCES estoquemaster.appuser(id);


--
-- Name: products fk_products_provider1; Type: FK CONSTRAINT; Schema: estoquemaster; Owner: postgres
--

ALTER TABLE ONLY estoquemaster.products
    ADD CONSTRAINT fk_products_provider1 FOREIGN KEY (provider_cnpj) REFERENCES estoquemaster.provider(cnpj);


--
-- Name: transaction fk_transaction_buyer1; Type: FK CONSTRAINT; Schema: estoquemaster; Owner: postgres
--

ALTER TABLE ONLY estoquemaster.transaction
    ADD CONSTRAINT fk_transaction_buyer1 FOREIGN KEY (buyer_cpf) REFERENCES estoquemaster.buyer(cpf);


--
-- Name: app_user app_user_buyer_cpf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_buyer_cpf_fkey FOREIGN KEY (buyer_cpf) REFERENCES public.buyer(cpf);


--
-- Name: products products_provider_cnpj_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_provider_cnpj_fkey FOREIGN KEY (provider_cnpj) REFERENCES public.provider(cnpj);


--
-- Name: products products_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.app_user(id);


--
-- Name: transaction transaction_buyer_cpf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_buyer_cpf_fkey FOREIGN KEY (buyer_cpf) REFERENCES public.buyer(cpf);


--
-- Name: transaction transaction_products_id_products_user_id_products_provider_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_products_id_products_user_id_products_provider_fkey FOREIGN KEY (products_id, products_user_id, products_provider_cnpj) REFERENCES public.products(id, user_id, provider_cnpj);


--
-- PostgreSQL database dump complete
--

