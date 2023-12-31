PGDMP                     
    {            estoquemaster    15.4    15.4 �    b           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            c           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            d           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            e           1262    17150    estoquemaster    DATABASE     �   CREATE DATABASE estoquemaster WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE estoquemaster;
                postgres    false                        2615    17152    estoquemaster    SCHEMA        CREATE SCHEMA estoquemaster;
    DROP SCHEMA estoquemaster;
                postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false            �            1259    17153    appuser    TABLE     �   CREATE TABLE estoquemaster.appuser (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(32) NOT NULL,
    ispremium smallint
);
 "   DROP TABLE estoquemaster.appuser;
       estoquemaster         heap    postgres    false    5            �            1259    17156    app_user_id_seq    SEQUENCE     �   CREATE SEQUENCE estoquemaster.app_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE estoquemaster.app_user_id_seq;
       estoquemaster          postgres    false    215    5            f           0    0    app_user_id_seq    SEQUENCE OWNED BY     P   ALTER SEQUENCE estoquemaster.app_user_id_seq OWNED BY estoquemaster.appuser.id;
          estoquemaster          postgres    false    216            �            1259    17157    buyer    TABLE     �   CREATE TABLE estoquemaster.buyer (
    cpf integer NOT NULL,
    name character varying(45),
    address character varying(45),
    contact_info character varying(45),
    user_id bigint
);
     DROP TABLE estoquemaster.buyer;
       estoquemaster         heap    postgres    false    5            �            1259    17160    products    TABLE     z  CREATE TABLE estoquemaster.products (
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
 #   DROP TABLE estoquemaster.products;
       estoquemaster         heap    postgres    false    5            �            1259    17165    products_id_seq    SEQUENCE     �   CREATE SEQUENCE estoquemaster.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE estoquemaster.products_id_seq;
       estoquemaster          postgres    false    5    218            g           0    0    products_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE estoquemaster.products_id_seq OWNED BY estoquemaster.products.id;
          estoquemaster          postgres    false    219            �            1259    17166    provider    TABLE     �   CREATE TABLE estoquemaster.provider (
    cnpj bigint NOT NULL,
    name character varying(45),
    contact_info character varying(45)
);
 #   DROP TABLE estoquemaster.provider;
       estoquemaster         heap    postgres    false    5            �            1259    17169    transaction    TABLE     �   CREATE TABLE estoquemaster.transaction (
    id integer NOT NULL,
    date date,
    buyer_cpf integer NOT NULL,
    products_id integer NOT NULL,
    products_user_id integer NOT NULL,
    amount_sold integer,
    price double precision
);
 &   DROP TABLE estoquemaster.transaction;
       estoquemaster         heap    postgres    false    5            �            1259    17172    transaction_id_seq    SEQUENCE     �   CREATE SEQUENCE estoquemaster.transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE estoquemaster.transaction_id_seq;
       estoquemaster          postgres    false    221    5            h           0    0    transaction_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE estoquemaster.transaction_id_seq OWNED BY estoquemaster.transaction.id;
          estoquemaster          postgres    false    222            i           0    0    COLUMN pg_config.name    ACL     >   GRANT SELECT(name) ON TABLE pg_catalog.pg_config TO postgres;
       
   pg_catalog          postgres    false    99            j           0    0    COLUMN pg_config.setting    ACL     A   GRANT SELECT(setting) ON TABLE pg_catalog.pg_config TO postgres;
       
   pg_catalog          postgres    false    99            k           0    0 $   COLUMN pg_hba_file_rules.line_number    ACL     M   GRANT SELECT(line_number) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;
       
   pg_catalog          postgres    false    95            l           0    0    COLUMN pg_hba_file_rules.type    ACL     F   GRANT SELECT(type) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;
       
   pg_catalog          postgres    false    95            m           0    0 !   COLUMN pg_hba_file_rules.database    ACL     J   GRANT SELECT(database) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;
       
   pg_catalog          postgres    false    95            n           0    0 "   COLUMN pg_hba_file_rules.user_name    ACL     K   GRANT SELECT(user_name) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;
       
   pg_catalog          postgres    false    95            o           0    0     COLUMN pg_hba_file_rules.address    ACL     I   GRANT SELECT(address) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;
       
   pg_catalog          postgres    false    95            p           0    0     COLUMN pg_hba_file_rules.netmask    ACL     I   GRANT SELECT(netmask) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;
       
   pg_catalog          postgres    false    95            q           0    0 $   COLUMN pg_hba_file_rules.auth_method    ACL     M   GRANT SELECT(auth_method) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;
       
   pg_catalog          postgres    false    95            r           0    0     COLUMN pg_hba_file_rules.options    ACL     I   GRANT SELECT(options) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;
       
   pg_catalog          postgres    false    95            s           0    0    COLUMN pg_hba_file_rules.error    ACL     G   GRANT SELECT(error) ON TABLE pg_catalog.pg_hba_file_rules TO postgres;
       
   pg_catalog          postgres    false    95            t           0    0 ,   COLUMN pg_replication_origin_status.local_id    ACL     U   GRANT SELECT(local_id) ON TABLE pg_catalog.pg_replication_origin_status TO postgres;
       
   pg_catalog          postgres    false    144            u           0    0 /   COLUMN pg_replication_origin_status.external_id    ACL     X   GRANT SELECT(external_id) ON TABLE pg_catalog.pg_replication_origin_status TO postgres;
       
   pg_catalog          postgres    false    144            v           0    0 .   COLUMN pg_replication_origin_status.remote_lsn    ACL     W   GRANT SELECT(remote_lsn) ON TABLE pg_catalog.pg_replication_origin_status TO postgres;
       
   pg_catalog          postgres    false    144            w           0    0 -   COLUMN pg_replication_origin_status.local_lsn    ACL     V   GRANT SELECT(local_lsn) ON TABLE pg_catalog.pg_replication_origin_status TO postgres;
       
   pg_catalog          postgres    false    144            x           0    0     COLUMN pg_shmem_allocations.name    ACL     I   GRANT SELECT(name) ON TABLE pg_catalog.pg_shmem_allocations TO postgres;
       
   pg_catalog          postgres    false    100            y           0    0    COLUMN pg_shmem_allocations.off    ACL     H   GRANT SELECT(off) ON TABLE pg_catalog.pg_shmem_allocations TO postgres;
       
   pg_catalog          postgres    false    100            z           0    0     COLUMN pg_shmem_allocations.size    ACL     I   GRANT SELECT(size) ON TABLE pg_catalog.pg_shmem_allocations TO postgres;
       
   pg_catalog          postgres    false    100            {           0    0 *   COLUMN pg_shmem_allocations.allocated_size    ACL     S   GRANT SELECT(allocated_size) ON TABLE pg_catalog.pg_shmem_allocations TO postgres;
       
   pg_catalog          postgres    false    100            |           0    0    COLUMN pg_statistic.starelid    ACL     E   GRANT SELECT(starelid) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            }           0    0    COLUMN pg_statistic.staattnum    ACL     F   GRANT SELECT(staattnum) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            ~           0    0    COLUMN pg_statistic.stainherit    ACL     G   GRANT SELECT(stainherit) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40                       0    0    COLUMN pg_statistic.stanullfrac    ACL     H   GRANT SELECT(stanullfrac) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stawidth    ACL     E   GRANT SELECT(stawidth) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stadistinct    ACL     H   GRANT SELECT(stadistinct) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stakind1    ACL     E   GRANT SELECT(stakind1) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stakind2    ACL     E   GRANT SELECT(stakind2) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stakind3    ACL     E   GRANT SELECT(stakind3) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stakind4    ACL     E   GRANT SELECT(stakind4) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stakind5    ACL     E   GRANT SELECT(stakind5) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.staop1    ACL     C   GRANT SELECT(staop1) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.staop2    ACL     C   GRANT SELECT(staop2) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.staop3    ACL     C   GRANT SELECT(staop3) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.staop4    ACL     C   GRANT SELECT(staop4) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.staop5    ACL     C   GRANT SELECT(staop5) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stacoll1    ACL     E   GRANT SELECT(stacoll1) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stacoll2    ACL     E   GRANT SELECT(stacoll2) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stacoll3    ACL     E   GRANT SELECT(stacoll3) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stacoll4    ACL     E   GRANT SELECT(stacoll4) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stacoll5    ACL     E   GRANT SELECT(stacoll5) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stanumbers1    ACL     H   GRANT SELECT(stanumbers1) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stanumbers2    ACL     H   GRANT SELECT(stanumbers2) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stanumbers3    ACL     H   GRANT SELECT(stanumbers3) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stanumbers4    ACL     H   GRANT SELECT(stanumbers4) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stanumbers5    ACL     H   GRANT SELECT(stanumbers5) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stavalues1    ACL     G   GRANT SELECT(stavalues1) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stavalues2    ACL     G   GRANT SELECT(stavalues2) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stavalues3    ACL     G   GRANT SELECT(stavalues3) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stavalues4    ACL     G   GRANT SELECT(stavalues4) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_statistic.stavalues5    ACL     G   GRANT SELECT(stavalues5) ON TABLE pg_catalog.pg_statistic TO postgres;
       
   pg_catalog          postgres    false    40            �           0    0    COLUMN pg_subscription.oid    ACL     C   GRANT SELECT(oid) ON TABLE pg_catalog.pg_subscription TO postgres;
       
   pg_catalog          postgres    false    65            �           0    0    COLUMN pg_subscription.subdbid    ACL     G   GRANT SELECT(subdbid) ON TABLE pg_catalog.pg_subscription TO postgres;
       
   pg_catalog          postgres    false    65            �           0    0    COLUMN pg_subscription.subname    ACL     G   GRANT SELECT(subname) ON TABLE pg_catalog.pg_subscription TO postgres;
       
   pg_catalog          postgres    false    65            �           0    0    COLUMN pg_subscription.subowner    ACL     H   GRANT SELECT(subowner) ON TABLE pg_catalog.pg_subscription TO postgres;
       
   pg_catalog          postgres    false    65            �           0    0 !   COLUMN pg_subscription.subenabled    ACL     J   GRANT SELECT(subenabled) ON TABLE pg_catalog.pg_subscription TO postgres;
       
   pg_catalog          postgres    false    65            �           0    0 "   COLUMN pg_subscription.subconninfo    ACL     K   GRANT SELECT(subconninfo) ON TABLE pg_catalog.pg_subscription TO postgres;
       
   pg_catalog          postgres    false    65            �           0    0 "   COLUMN pg_subscription.subslotname    ACL     K   GRANT SELECT(subslotname) ON TABLE pg_catalog.pg_subscription TO postgres;
       
   pg_catalog          postgres    false    65            �           0    0 $   COLUMN pg_subscription.subsynccommit    ACL     M   GRANT SELECT(subsynccommit) ON TABLE pg_catalog.pg_subscription TO postgres;
       
   pg_catalog          postgres    false    65            �           0    0 &   COLUMN pg_subscription.subpublications    ACL     O   GRANT SELECT(subpublications) ON TABLE pg_catalog.pg_subscription TO postgres;
       
   pg_catalog          postgres    false    65            �            1259    17173    app_user    TABLE     �   CREATE TABLE public.app_user (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(32) NOT NULL,
    ispremium boolean,
    buyer_cpf integer NOT NULL
);
    DROP TABLE public.app_user;
       public         heap    postgres    false    6            �            1259    17176    app_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.app_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.app_user_id_seq;
       public          postgres    false    223    6            �           0    0    app_user_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.app_user_id_seq OWNED BY public.app_user.id;
          public          postgres    false    224            �            1259    17177    buyer    TABLE     �   CREATE TABLE public.buyer (
    cpf integer NOT NULL,
    nome character varying(45),
    address character varying(45),
    contact_info character varying(45)
);
    DROP TABLE public.buyer;
       public         heap    postgres    false    6            �            1259    17180    product    TABLE     j   CREATE TABLE public.product (
    id integer NOT NULL,
    nome character varying(50),
    qtd integer
);
    DROP TABLE public.product;
       public         heap    postgres    false    6            �            1259    17183    product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.product_id_seq;
       public          postgres    false    226    6            �           0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
          public          postgres    false    227            �            1259    17184    products    TABLE     Q  CREATE TABLE public.products (
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
    DROP TABLE public.products;
       public         heap    postgres    false    6            �            1259    17187    products_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.products_id_seq;
       public          postgres    false    6    228            �           0    0    products_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;
          public          postgres    false    229            �            1259    17188    provider    TABLE     �   CREATE TABLE public.provider (
    cnpj integer NOT NULL,
    nome character varying(45),
    contact_info character varying(45)
);
    DROP TABLE public.provider;
       public         heap    postgres    false    6            �            1259    17191    transaction    TABLE     J  CREATE TABLE public.transaction (
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
    DROP TABLE public.transaction;
       public         heap    postgres    false    6            �            1259    17194    transaction_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.transaction_id_seq;
       public          postgres    false    231    6            �           0    0    transaction_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.transaction_id_seq OWNED BY public.transaction.id;
          public          postgres    false    232            �           2604    17195 
   appuser id    DEFAULT     w   ALTER TABLE ONLY estoquemaster.appuser ALTER COLUMN id SET DEFAULT nextval('estoquemaster.app_user_id_seq'::regclass);
 @   ALTER TABLE estoquemaster.appuser ALTER COLUMN id DROP DEFAULT;
       estoquemaster          postgres    false    216    215            �           2604    17196    products id    DEFAULT     x   ALTER TABLE ONLY estoquemaster.products ALTER COLUMN id SET DEFAULT nextval('estoquemaster.products_id_seq'::regclass);
 A   ALTER TABLE estoquemaster.products ALTER COLUMN id DROP DEFAULT;
       estoquemaster          postgres    false    219    218            �           2604    17197    transaction id    DEFAULT     ~   ALTER TABLE ONLY estoquemaster.transaction ALTER COLUMN id SET DEFAULT nextval('estoquemaster.transaction_id_seq'::regclass);
 D   ALTER TABLE estoquemaster.transaction ALTER COLUMN id DROP DEFAULT;
       estoquemaster          postgres    false    222    221            �           2604    17198    app_user id    DEFAULT     j   ALTER TABLE ONLY public.app_user ALTER COLUMN id SET DEFAULT nextval('public.app_user_id_seq'::regclass);
 :   ALTER TABLE public.app_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223            �           2604    17199 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    226            �           2604    17200    products id    DEFAULT     j   ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);
 :   ALTER TABLE public.products ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228            �           2604    17201    transaction id    DEFAULT     p   ALTER TABLE ONLY public.transaction ALTER COLUMN id SET DEFAULT nextval('public.transaction_id_seq'::regclass);
 =   ALTER TABLE public.transaction ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    231            N          0    17153    appuser 
   TABLE DATA           H   COPY estoquemaster.appuser (id, email, password, ispremium) FROM stdin;
    estoquemaster          postgres    false    215   5�       P          0    17157    buyer 
   TABLE DATA           Q   COPY estoquemaster.buyer (cpf, name, address, contact_info, user_id) FROM stdin;
    estoquemaster          postgres    false    217   i�       Q          0    17160    products 
   TABLE DATA           �   COPY estoquemaster.products (id, nome, amount, description, buying_price, selling_price, vality, user_id, provider_cnpj, min_amount, img_url) FROM stdin;
    estoquemaster          postgres    false    218   ��       S          0    17166    provider 
   TABLE DATA           C   COPY estoquemaster.provider (cnpj, name, contact_info) FROM stdin;
    estoquemaster          postgres    false    220   �       T          0    17169    transaction 
   TABLE DATA           t   COPY estoquemaster.transaction (id, date, buyer_cpf, products_id, products_user_id, amount_sold, price) FROM stdin;
    estoquemaster          postgres    false    221   L�       V          0    17173    app_user 
   TABLE DATA           M   COPY public.app_user (id, email, password, ispremium, buyer_cpf) FROM stdin;
    public          postgres    false    223   ��       X          0    17177    buyer 
   TABLE DATA           A   COPY public.buyer (cpf, nome, address, contact_info) FROM stdin;
    public          postgres    false    225   ��       Y          0    17180    product 
   TABLE DATA           0   COPY public.product (id, nome, qtd) FROM stdin;
    public          postgres    false    226   Ȕ       [          0    17184    products 
   TABLE DATA           �   COPY public.products (id, nome, quantidade, description, price_compra, price_venda, validade, user_id, provider_cnpj) FROM stdin;
    public          postgres    false    228   �       ]          0    17188    provider 
   TABLE DATA           <   COPY public.provider (cnpj, nome, contact_info) FROM stdin;
    public          postgres    false    230   �       ^          0    17191    transaction 
   TABLE DATA           �   COPY public.transaction (id, productid, date, buyer_cpf, products_id, products_user_id, products_provider_cnpj, user_id, user_buyer_cpf) FROM stdin;
    public          postgres    false    231   �       �           0    0    app_user_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('estoquemaster.app_user_id_seq', 1, true);
          estoquemaster          postgres    false    216            �           0    0    products_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('estoquemaster.products_id_seq', 5, true);
          estoquemaster          postgres    false    219            �           0    0    transaction_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('estoquemaster.transaction_id_seq', 2, true);
          estoquemaster          postgres    false    222            �           0    0    app_user_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.app_user_id_seq', 1, false);
          public          postgres    false    224            �           0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 1, false);
          public          postgres    false    227            �           0    0    products_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.products_id_seq', 1, false);
          public          postgres    false    229            �           0    0    transaction_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.transaction_id_seq', 1, false);
          public          postgres    false    232            �           2606    17203    appuser app_user_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY estoquemaster.appuser
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY estoquemaster.appuser DROP CONSTRAINT app_user_pkey;
       estoquemaster            postgres    false    215            �           2606    17205    buyer buyer_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY estoquemaster.buyer
    ADD CONSTRAINT buyer_pkey PRIMARY KEY (cpf);
 A   ALTER TABLE ONLY estoquemaster.buyer DROP CONSTRAINT buyer_pkey;
       estoquemaster            postgres    false    217            �           2606    17207    products products_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY estoquemaster.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
 G   ALTER TABLE ONLY estoquemaster.products DROP CONSTRAINT products_pkey;
       estoquemaster            postgres    false    218            �           2606    17209    provider provider_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY estoquemaster.provider
    ADD CONSTRAINT provider_pkey PRIMARY KEY (cnpj);
 G   ALTER TABLE ONLY estoquemaster.provider DROP CONSTRAINT provider_pkey;
       estoquemaster            postgres    false    220            �           2606    17211    transaction transaction_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY estoquemaster.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);
 M   ALTER TABLE ONLY estoquemaster.transaction DROP CONSTRAINT transaction_pkey;
       estoquemaster            postgres    false    221            �           2606    17213 %   products uc_products_id_user_provider 
   CONSTRAINT     }   ALTER TABLE ONLY estoquemaster.products
    ADD CONSTRAINT uc_products_id_user_provider UNIQUE (id, user_id, provider_cnpj);
 V   ALTER TABLE ONLY estoquemaster.products DROP CONSTRAINT uc_products_id_user_provider;
       estoquemaster            postgres    false    218    218    218            �           2606    17215    app_user app_user_email_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_email_key UNIQUE (email);
 E   ALTER TABLE ONLY public.app_user DROP CONSTRAINT app_user_email_key;
       public            postgres    false    223            �           2606    17217    app_user app_user_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.app_user DROP CONSTRAINT app_user_pkey;
       public            postgres    false    223            �           2606    17219    buyer buyer_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.buyer
    ADD CONSTRAINT buyer_pkey PRIMARY KEY (cpf);
 :   ALTER TABLE ONLY public.buyer DROP CONSTRAINT buyer_pkey;
       public            postgres    false    225            �           2606    17221    product product_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    226            �           2606    17223 .   products products_id_user_id_provider_cnpj_key 
   CONSTRAINT        ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_id_user_id_provider_cnpj_key UNIQUE (id, user_id, provider_cnpj);
 X   ALTER TABLE ONLY public.products DROP CONSTRAINT products_id_user_id_provider_cnpj_key;
       public            postgres    false    228    228    228            �           2606    17225    products products_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    228            �           2606    17227    provider provider_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.provider
    ADD CONSTRAINT provider_pkey PRIMARY KEY (cnpj);
 @   ALTER TABLE ONLY public.provider DROP CONSTRAINT provider_pkey;
       public            postgres    false    230            �           2606    17229    transaction transaction_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.transaction DROP CONSTRAINT transaction_pkey;
       public            postgres    false    231            �           1259    17230    email_unique    INDEX     O   CREATE UNIQUE INDEX email_unique ON estoquemaster.appuser USING btree (email);
 '   DROP INDEX estoquemaster.email_unique;
       estoquemaster            postgres    false    215            �           2606    17231    products fk_products_app_user    FK CONSTRAINT     �   ALTER TABLE ONLY estoquemaster.products
    ADD CONSTRAINT fk_products_app_user FOREIGN KEY (user_id) REFERENCES estoquemaster.appuser(id);
 N   ALTER TABLE ONLY estoquemaster.products DROP CONSTRAINT fk_products_app_user;
       estoquemaster          postgres    false    3228    215    218            �           2606    17236    products fk_products_provider1    FK CONSTRAINT     �   ALTER TABLE ONLY estoquemaster.products
    ADD CONSTRAINT fk_products_provider1 FOREIGN KEY (provider_cnpj) REFERENCES estoquemaster.provider(cnpj);
 O   ALTER TABLE ONLY estoquemaster.products DROP CONSTRAINT fk_products_provider1;
       estoquemaster          postgres    false    3237    218    220            �           2606    17241 !   transaction fk_transaction_buyer1    FK CONSTRAINT     �   ALTER TABLE ONLY estoquemaster.transaction
    ADD CONSTRAINT fk_transaction_buyer1 FOREIGN KEY (buyer_cpf) REFERENCES estoquemaster.buyer(cpf);
 R   ALTER TABLE ONLY estoquemaster.transaction DROP CONSTRAINT fk_transaction_buyer1;
       estoquemaster          postgres    false    3231    217    221            �           2606    17246     app_user app_user_buyer_cpf_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_buyer_cpf_fkey FOREIGN KEY (buyer_cpf) REFERENCES public.buyer(cpf);
 J   ALTER TABLE ONLY public.app_user DROP CONSTRAINT app_user_buyer_cpf_fkey;
       public          postgres    false    3245    225    223            �           2606    17251 $   products products_provider_cnpj_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_provider_cnpj_fkey FOREIGN KEY (provider_cnpj) REFERENCES public.provider(cnpj);
 N   ALTER TABLE ONLY public.products DROP CONSTRAINT products_provider_cnpj_fkey;
       public          postgres    false    228    3253    230            �           2606    17256    products products_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.app_user(id);
 H   ALTER TABLE ONLY public.products DROP CONSTRAINT products_user_id_fkey;
       public          postgres    false    228    3243    223            �           2606    17261 &   transaction transaction_buyer_cpf_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_buyer_cpf_fkey FOREIGN KEY (buyer_cpf) REFERENCES public.buyer(cpf);
 P   ALTER TABLE ONLY public.transaction DROP CONSTRAINT transaction_buyer_cpf_fkey;
       public          postgres    false    225    231    3245            �           2606    17266 K   transaction transaction_products_id_products_user_id_products_provider_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_products_id_products_user_id_products_provider_fkey FOREIGN KEY (products_id, products_user_id, products_provider_cnpj) REFERENCES public.products(id, user_id, provider_cnpj);
 u   ALTER TABLE ONLY public.transaction DROP CONSTRAINT transaction_products_id_products_user_id_products_provider_fkey;
       public          postgres    false    231    231    3249    228    228    228    231            N   $   x�3�L�+�����K-�w���442�4������ ���      P   *   x�3426153���L�+���̏���K-���"�=... �S	�      Q   f   x��A� ���\@�����i	�h��x�6&o�5��~���������� O>�0؇I������8��;�	�r����c�f��Ƙ��      S   #   x�3426153����M-JNL�/������� `&�      T   2   x�3�4202�54�54�4426153���4�4B.#<���\1z\\\ �      V      x������ � �      X      x������ � �      Y      x������ � �      [      x������ � �      ]      x������ � �      ^      x������ � �     