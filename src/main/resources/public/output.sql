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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

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
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id integer NOT NULL,
    nome character varying(50),
    qtd integer
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_id_seq OWNER TO postgres;

--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


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
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: transaction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction ALTER COLUMN id SET DEFAULT nextval('public.transaction_id_seq'::regclass);


--
-- Data for Name: appuser; Type: TABLE DATA; Schema: estoquemaster; Owner: postgres
--

COPY estoquemaster.appuser (id, email, password, ispremium) FROM stdin;
5	antoniooi@oi	202cb962ac59075b964b07152d234b70	1
1	antonioneto@oi	202cb962ac59075b964b07152d234b70	1
\.


--
-- Data for Name: buyer; Type: TABLE DATA; Schema: estoquemaster; Owner: postgres
--

COPY estoquemaster.buyer (cpf, name, address, contact_info, user_id) FROM stdin;
123456789	antonio\n	neto	\N	\N
1234	aantonio	pangu	123	1
1	1	1	1	1
12345	anto	123	123	1
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: estoquemaster; Owner: postgres
--

COPY estoquemaster.products (id, nome, amount, description, buying_price, selling_price, vality, user_id, provider_cnpj, min_amount, img_url) FROM stdin;
6	teste precisao	0	123	3	4	2023-11-21	1	123456789	2	http://localhost:5050/imgs/logo.png
8	oi	0	1	2	3	2023-11-23	5	123456789	0	http://localhost:5050/imgs/logo.png
5	grafico	2	grafico	3	20	2023-11-23	1	123456789	2	https://avatars.githubusercontent.com/u/102884486?v=4
\.


--
-- Data for Name: provider; Type: TABLE DATA; Schema: estoquemaster; Owner: postgres
--

COPY estoquemaster.provider (cnpj, name, contact_info) FROM stdin;
123456789	mercador	\N
\.


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: estoquemaster; Owner: postgres
--

COPY estoquemaster.transaction (id, date, buyer_cpf, products_id, products_user_id, amount_sold, price) FROM stdin;
333	2023-04-10	123456789	5	1	1	10
555	2023-02-10	123456789	5	1	1	6
444	2023-03-10	123456789	5	1	1	4
999	2023-07-08	123456789	5	1	1	8
16	2023-11-17	123456789	5	1	1	100
20	2023-11-18	123456789	5	1	1	20
23	2023-11-01	123456789	6	1	10	20.5
24	2023-11-02	123456789	6	1	15	22.3
25	2023-11-03	123456789	6	1	8	18.7
26	2023-11-04	123456789	6	1	20	25
27	2023-11-05	123456789	6	1	12	21.2
28	2023-11-06	123456789	6	1	18	24.8
29	2023-11-07	123456789	6	1	14	23.1
30	2023-11-08	123456789	6	1	25	30.5
31	2023-11-09	123456789	6	1	9	19.4
32	2023-11-10	123456789	6	1	22	27.3
33	2023-11-23	123456789	8	5	1	3
1	2023-11-13	123456789	5	1	1	4
2	2023-11-13	123456789	5	1	10	50
\.


--
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_user (id, email, password, ispremium, buyer_cpf) FROM stdin;
\.


--
-- Data for Name: buyer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buyer (cpf, nome, address, contact_info) FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, nome, qtd) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, nome, quantidade, description, price_compra, price_venda, validade, user_id, provider_cnpj) FROM stdin;
\.


--
-- Data for Name: provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider (cnpj, nome, contact_info) FROM stdin;
\.


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction (id, productid, date, buyer_cpf, products_id, products_user_id, products_provider_cnpj, user_id, user_buyer_cpf) FROM stdin;
\.


--
-- Name: app_user_id_seq; Type: SEQUENCE SET; Schema: estoquemaster; Owner: postgres
--

SELECT pg_catalog.setval('estoquemaster.app_user_id_seq', 1, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: estoquemaster; Owner: postgres
--

SELECT pg_catalog.setval('estoquemaster.products_id_seq', 5, true);


--
-- Name: transaction_id_seq; Type: SEQUENCE SET; Schema: estoquemaster; Owner: postgres
--

SELECT pg_catalog.setval('estoquemaster.transaction_id_seq', 2, true);


--
-- Name: app_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.app_user_id_seq', 1, false);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 1, false);


--
-- Name: transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaction_id_seq', 1, false);


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
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


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
-- Name: COLUMN pg_config.name; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(name) ON TABLE pg_catalog.pg_config TO postgres;


--
-- Name: COLUMN pg_config.setting; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(setting) ON TABLE pg_catalog.pg_config TO postgres;


--
-- Name: COLUMN pg_hba_file_rules.line_number; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(line_number) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;


--
-- Name: COLUMN pg_hba_file_rules.type; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(type) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;


--
-- Name: COLUMN pg_hba_file_rules.database; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(database) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;


--
-- Name: COLUMN pg_hba_file_rules.user_name; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(user_name) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;


--
-- Name: COLUMN pg_hba_file_rules.address; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(address) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;


--
-- Name: COLUMN pg_hba_file_rules.netmask; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(netmask) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;


--
-- Name: COLUMN pg_hba_file_rules.auth_method; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(auth_method) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;


--
-- Name: COLUMN pg_hba_file_rules.options; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(options) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;


--
-- Name: COLUMN pg_hba_file_rules.error; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(error) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;


--
-- Name: COLUMN pg_replication_origin_status.local_id; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(local_id) ON TABLE pg_catalog.pg_replication_origin_status TO postgres;


--
-- Name: COLUMN pg_replication_origin_status.external_id; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(external_id) ON TABLE pg_catalog.pg_replication_origin_status TO postgres;


--
-- Name: COLUMN pg_replication_origin_status.remote_lsn; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(remote_lsn) ON TABLE pg_catalog.pg_replication_origin_status TO postgres;


--
-- Name: COLUMN pg_replication_origin_status.local_lsn; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(local_lsn) ON TABLE pg_catalog.pg_replication_origin_status TO postgres;


--
-- Name: COLUMN pg_shmem_allocations.name; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(name) ON TABLE pg_catalog.pg_shmem_allocations TO postgres;


--
-- Name: COLUMN pg_shmem_allocations.off; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(off) ON TABLE pg_catalog.pg_shmem_allocations TO postgres;


--
-- Name: COLUMN pg_shmem_allocations.size; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(size) ON TABLE pg_catalog.pg_shmem_allocations TO postgres;


--
-- Name: COLUMN pg_shmem_allocations.allocated_size; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(allocated_size) ON TABLE pg_catalog.pg_shmem_allocations TO postgres;


--
-- Name: COLUMN pg_statistic.starelid; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(starelid) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.staattnum; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(staattnum) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stainherit; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stainherit) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stanullfrac; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stanullfrac) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stawidth; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stawidth) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stadistinct; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stadistinct) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stakind1; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stakind1) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stakind2; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stakind2) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stakind3; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stakind3) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stakind4; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stakind4) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stakind5; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stakind5) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.staop1; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(staop1) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.staop2; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(staop2) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.staop3; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(staop3) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.staop4; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(staop4) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.staop5; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(staop5) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stacoll1; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stacoll1) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stacoll2; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stacoll2) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stacoll3; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stacoll3) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stacoll4; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stacoll4) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stacoll5; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stacoll5) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stanumbers1; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stanumbers1) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stanumbers2; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stanumbers2) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stanumbers3; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stanumbers3) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stanumbers4; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stanumbers4) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stanumbers5; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stanumbers5) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stavalues1; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stavalues1) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stavalues2; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stavalues2) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stavalues3; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stavalues3) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stavalues4; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stavalues4) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_statistic.stavalues5; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(stavalues5) ON TABLE pg_catalog.pg_statistic TO postgres;


--
-- Name: COLUMN pg_subscription.oid; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(oid) ON TABLE pg_catalog.pg_subscription TO postgres;


--
-- Name: COLUMN pg_subscription.subdbid; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(subdbid) ON TABLE pg_catalog.pg_subscription TO postgres;


--
-- Name: COLUMN pg_subscription.subname; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(subname) ON TABLE pg_catalog.pg_subscription TO postgres;


--
-- Name: COLUMN pg_subscription.subowner; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(subowner) ON TABLE pg_catalog.pg_subscription TO postgres;


--
-- Name: COLUMN pg_subscription.subenabled; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(subenabled) ON TABLE pg_catalog.pg_subscription TO postgres;


--
-- Name: COLUMN pg_subscription.subconninfo; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(subconninfo) ON TABLE pg_catalog.pg_subscription TO postgres;


--
-- Name: COLUMN pg_subscription.subslotname; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(subslotname) ON TABLE pg_catalog.pg_subscription TO postgres;


--
-- Name: COLUMN pg_subscription.subsynccommit; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(subsynccommit) ON TABLE pg_catalog.pg_subscription TO postgres;


--
-- Name: COLUMN pg_subscription.subpublications; Type: ACL; Schema: pg_catalog; Owner: postgres
--

GRANT SELECT(subpublications) ON TABLE pg_catalog.pg_subscription TO postgres;


--
-- PostgreSQL database dump complete
--

