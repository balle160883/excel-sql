--
-- PostgreSQL database dump
--

\restrict 0z9EVLmJHWhh2gpXnhge1GeQV41oY8yLigrepbHiyKyqexPD5U7iv9GozYQMOy6

-- Dumped from database version 15.15
-- Dumped by pg_dump version 15.15

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

ALTER TABLE IF EXISTS ONLY public.user_permissions DROP CONSTRAINT IF EXISTS user_permissions_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.audit_logs DROP CONSTRAINT IF EXISTS audit_logs_user_id_fkey;
DROP INDEX IF EXISTS public.ix_users_username;
DROP INDEX IF EXISTS public.ix_users_id;
DROP INDEX IF EXISTS public.ix_user_permissions_id;
DROP INDEX IF EXISTS public.ix_audit_logs_id;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.user_permissions DROP CONSTRAINT IF EXISTS user_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.tramites_y_servicios DROP CONSTRAINT IF EXISTS tramites_y_servicios_pkey;
ALTER TABLE IF EXISTS ONLY public.tasas_inversiones DROP CONSTRAINT IF EXISTS tasas_inversiones_pkey;
ALTER TABLE IF EXISTS ONLY public.talleres_culturales DROP CONSTRAINT IF EXISTS talleres_culturales_pkey;
ALTER TABLE IF EXISTS ONLY public.tablas_inversiones DROP CONSTRAINT IF EXISTS tablas_inversiones_pkey;
ALTER TABLE IF EXISTS ONLY public.tablas_credito DROP CONSTRAINT IF EXISTS tablas_credito_pkey;
ALTER TABLE IF EXISTS ONLY public.tabla_sucursales DROP CONSTRAINT IF EXISTS tabla_sucursales_pkey;
ALTER TABLE IF EXISTS ONLY public.tabla_servicios DROP CONSTRAINT IF EXISTS tabla_servicios_pkey;
ALTER TABLE IF EXISTS ONLY public.tabla_requisitos DROP CONSTRAINT IF EXISTS tabla_requisitos_pkey;
ALTER TABLE IF EXISTS ONLY public.tabla_protecciones DROP CONSTRAINT IF EXISTS tabla_protecciones_pkey;
ALTER TABLE IF EXISTS ONLY public.tabla_promociones DROP CONSTRAINT IF EXISTS tabla_promociones_pkey;
ALTER TABLE IF EXISTS ONLY public.tabla_horarios DROP CONSTRAINT IF EXISTS tabla_horarios_pkey;
ALTER TABLE IF EXISTS ONLY public.tabla_atm DROP CONSTRAINT IF EXISTS tabla_atm_pkey;
ALTER TABLE IF EXISTS ONLY public.tabla_ahorro DROP CONSTRAINT IF EXISTS tabla_ahorro_pkey;
ALTER TABLE IF EXISTS ONLY public.limites_transaccionales DROP CONSTRAINT IF EXISTS limites_transaccionales_pkey;
ALTER TABLE IF EXISTS ONLY public.dias_inhabiles DROP CONSTRAINT IF EXISTS dias_inhabiles_pkey;
ALTER TABLE IF EXISTS ONLY public.descripciones_tablas DROP CONSTRAINT IF EXISTS descripciones_tablas_pkey;
ALTER TABLE IF EXISTS ONLY public.catalogo_vacantes DROP CONSTRAINT IF EXISTS catalogo_vacantes_pkey;
ALTER TABLE IF EXISTS ONLY public.catalogo_soporte DROP CONSTRAINT IF EXISTS catalogo_soporte_pkey;
ALTER TABLE IF EXISTS ONLY public.catalogo_inversiones DROP CONSTRAINT IF EXISTS catalogo_inversiones_pkey;
ALTER TABLE IF EXISTS ONLY public.catalogo_conceptos_cooperativos DROP CONSTRAINT IF EXISTS catalogo_conceptos_cooperativos_pkey;
ALTER TABLE IF EXISTS ONLY public.catalago_soporte DROP CONSTRAINT IF EXISTS catalago_soporte_pkey;
ALTER TABLE IF EXISTS ONLY public.audit_logs DROP CONSTRAINT IF EXISTS audit_logs_pkey;
ALTER TABLE IF EXISTS ONLY public."01.-matriz_de_conocimiento" DROP CONSTRAINT IF EXISTS "01.-matriz_de_conocimiento_pkey";
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.user_permissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tabla_requisitos ALTER COLUMN _rowid DROP DEFAULT;
ALTER TABLE IF EXISTS public.descripciones_tablas ALTER COLUMN _rowid DROP DEFAULT;
ALTER TABLE IF EXISTS public.catalogo_vacantes ALTER COLUMN _rowid DROP DEFAULT;
ALTER TABLE IF EXISTS public.audit_logs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public."01.-matriz_de_conocimiento" ALTER COLUMN id DROP DEFAULT;
DROP VIEW IF EXISTS public.vista_sucursales;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.user_permissions_id_seq;
DROP TABLE IF EXISTS public.user_permissions;
DROP TABLE IF EXISTS public.tramites_y_servicios;
DROP TABLE IF EXISTS public.tasas_inversiones;
DROP TABLE IF EXISTS public.talleres_culturales;
DROP TABLE IF EXISTS public.tablas_inversiones;
DROP TABLE IF EXISTS public.tablas_credito;
DROP TABLE IF EXISTS public.tabla_sucursales;
DROP TABLE IF EXISTS public.tabla_servicios;
DROP SEQUENCE IF EXISTS public.tabla_requisitos__rowid_seq;
DROP TABLE IF EXISTS public.tabla_requisitos;
DROP TABLE IF EXISTS public.tabla_protecciones;
DROP TABLE IF EXISTS public.tabla_promociones;
DROP TABLE IF EXISTS public.tabla_horarios;
DROP TABLE IF EXISTS public.tabla_atm;
DROP TABLE IF EXISTS public.tabla_ahorro;
DROP TABLE IF EXISTS public.limites_transaccionales;
DROP TABLE IF EXISTS public.dias_inhabiles;
DROP SEQUENCE IF EXISTS public.descripciones_tablas__rowid_seq;
DROP TABLE IF EXISTS public.descripciones_tablas;
DROP SEQUENCE IF EXISTS public.catalogo_vacantes__rowid_seq;
DROP TABLE IF EXISTS public.catalogo_vacantes;
DROP TABLE IF EXISTS public.catalogo_soporte;
DROP TABLE IF EXISTS public.catalogo_inversiones;
DROP TABLE IF EXISTS public.catalogo_conceptos_cooperativos;
DROP TABLE IF EXISTS public.catalago_soporte;
DROP SEQUENCE IF EXISTS public.audit_logs_id_seq;
DROP TABLE IF EXISTS public.audit_logs;
DROP SEQUENCE IF EXISTS public."01.-matriz_de_conocimiento_id_seq";
DROP TABLE IF EXISTS public."01.-matriz_de_conocimiento";
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: 01.-matriz_de_conocimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."01.-matriz_de_conocimiento" (
    id integer NOT NULL,
    tabla_ahorro character varying,
    "unnamed:_1" character varying,
    "unnamed:_2" character varying
);


ALTER TABLE public."01.-matriz_de_conocimiento" OWNER TO postgres;

--
-- Name: 01.-matriz_de_conocimiento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."01.-matriz_de_conocimiento_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."01.-matriz_de_conocimiento_id_seq" OWNER TO postgres;

--
-- Name: 01.-matriz_de_conocimiento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."01.-matriz_de_conocimiento_id_seq" OWNED BY public."01.-matriz_de_conocimiento".id;


--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit_logs (
    id integer NOT NULL,
    user_id integer,
    action character varying,
    table_name character varying,
    record_id character varying,
    details json,
    "timestamp" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.audit_logs OWNER TO postgres;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.audit_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audit_logs_id_seq OWNER TO postgres;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- Name: catalago_soporte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalago_soporte (
    id text NOT NULL,
    problema text,
    categoria text,
    paso_1 text,
    paso_2 text,
    docs_req text,
    tiempo text,
    contacto text,
    keywords text
);


ALTER TABLE public.catalago_soporte OWNER TO postgres;

--
-- Name: catalogo_conceptos_cooperativos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalogo_conceptos_cooperativos (
    id text NOT NULL,
    tema_principal text,
    definicion_bot text,
    analogia_ejemplo text
);


ALTER TABLE public.catalogo_conceptos_cooperativos OWNER TO postgres;

--
-- Name: catalogo_inversiones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalogo_inversiones (
    id_producto text NOT NULL,
    nombre_comercial text,
    plazo_dias bigint,
    liquidez text,
    moneda text,
    descripcion_corta text
);


ALTER TABLE public.catalogo_inversiones OWNER TO postgres;

--
-- Name: catalogo_soporte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalogo_soporte (
    id text NOT NULL,
    problema text,
    categoria text,
    paso_1 text,
    paso_2 text,
    docs_req text,
    tiempo text,
    contacto text,
    keywords text
);


ALTER TABLE public.catalogo_soporte OWNER TO postgres;

--
-- Name: catalogo_vacantes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalogo_vacantes (
    id text,
    puesto_titulo text,
    area text,
    ubicacion text,
    descripcion text,
    requisitos text,
    sueldo_beneficios text,
    contacto text,
    status text,
    keywords text,
    _rowid integer NOT NULL
);


ALTER TABLE public.catalogo_vacantes OWNER TO postgres;

--
-- Name: catalogo_vacantes__rowid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catalogo_vacantes__rowid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogo_vacantes__rowid_seq OWNER TO postgres;

--
-- Name: catalogo_vacantes__rowid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catalogo_vacantes__rowid_seq OWNED BY public.catalogo_vacantes._rowid;


--
-- Name: descripciones_tablas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.descripciones_tablas (
    nombre_del_campo text,
    tipo_de_dato text,
    por_que_lo_necesita_el_bot text,
    _rowid integer NOT NULL
);


ALTER TABLE public.descripciones_tablas OWNER TO postgres;

--
-- Name: descripciones_tablas__rowid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.descripciones_tablas__rowid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.descripciones_tablas__rowid_seq OWNER TO postgres;

--
-- Name: descripciones_tablas__rowid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.descripciones_tablas__rowid_seq OWNED BY public.descripciones_tablas._rowid;


--
-- Name: dias_inhabiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dias_inhabiles (
    id text NOT NULL,
    fecha_inhabila timestamp without time zone,
    motivo_festivo text,
    tipo_excepcion text,
    sucursales_afectadas text,
    hora_apertura_esp time without time zone,
    hora_cierre_esp time without time zone,
    alternativa_bot text
);


ALTER TABLE public.dias_inhabiles OWNER TO postgres;

--
-- Name: limites_transaccionales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.limites_transaccionales (
    id_limite text NOT NULL,
    producto_servicio text,
    canal_de_operacion text,
    tipo_de_operacion text,
    limite_maximo_transacciones text,
    limite_maximo_diario text,
    limite_maximo_mensual text,
    observaciones_y_reglas_de_negocio text
);


ALTER TABLE public.limites_transaccionales OWNER TO postgres;

--
-- Name: tabla_ahorro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabla_ahorro (
    id text NOT NULL,
    nombre_producto text,
    tipo_publico text,
    monto_apertura bigint,
    saldo_minimo bigint,
    tasa_rendimiento text,
    disponibilidad text,
    medios_acceso text,
    requisitos_clave text,
    beneficio_principal text,
    keywords text
);


ALTER TABLE public.tabla_ahorro OWNER TO postgres;

--
-- Name: tabla_atm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabla_atm (
    id_cajero text NOT NULL,
    descripcion_atm text,
    tipo text,
    domicilio text,
    no_exterior text,
    colonia text,
    estado text,
    municipio text,
    ciudad text,
    c_p bigint,
    geolocalizacion text,
    tiene_sucursal_asignada text,
    sucursal text,
    estatus text,
    opera_las_24_hrs text,
    monto_minimo_operacion bigint,
    costo_consulta_saldo text,
    costo_retiro_nacional text,
    incluir_retiro_internacional text,
    costo_retiro_internacional text,
    servicios text,
    idioma text,
    accesibilidad text,
    locacion_espacio_geografico text,
    abierto_al_publico text
);


ALTER TABLE public.tabla_atm OWNER TO postgres;

--
-- Name: tabla_horarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabla_horarios (
    id_horario text NOT NULL,
    descripcion text,
    dias_semana text,
    hora_apertura time without time zone,
    hora_cierre time without time zone,
    dias_sabado text,
    hora_apertura_sab time without time zone,
    hora_cierre_sab time without time zone,
    zona_horaria text,
    aplica_a_ejemplos text
);


ALTER TABLE public.tabla_horarios OWNER TO postgres;

--
-- Name: tabla_promociones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabla_promociones (
    id text NOT NULL,
    nombre_campana text,
    tipo text,
    publico text,
    descripcion_hook text,
    condicion text,
    beneficio text,
    vigencia text,
    status text
);


ALTER TABLE public.tabla_promociones OWNER TO postgres;

--
-- Name: tabla_protecciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabla_protecciones (
    id text NOT NULL,
    nombre_oficial text,
    tipo_riesgo text,
    monto_cobertura text,
    condicion_activacion text,
    costo_socio text,
    beneficiarios text,
    keywords text,
    restricciones text,
    requisitos text
);


ALTER TABLE public.tabla_protecciones OWNER TO postgres;

--
-- Name: tabla_requisitos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabla_requisitos (
    id text,
    nombre_corto text,
    instruccion_usuario text,
    documentos_validos text,
    vigencia_meses double precision,
    formato text,
    tips_error text,
    _rowid integer NOT NULL
);


ALTER TABLE public.tabla_requisitos OWNER TO postgres;

--
-- Name: tabla_requisitos__rowid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tabla_requisitos__rowid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tabla_requisitos__rowid_seq OWNER TO postgres;

--
-- Name: tabla_requisitos__rowid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tabla_requisitos__rowid_seq OWNED BY public.tabla_requisitos._rowid;


--
-- Name: tabla_servicios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabla_servicios (
    id text NOT NULL,
    nombre_servicio text,
    categoria_bot text,
    descripcion_corta text,
    ubicacion_contacto text,
    costo_socio text,
    requisitos text,
    accion_sugerida text,
    keywords text
);


ALTER TABLE public.tabla_servicios OWNER TO postgres;

--
-- Name: tabla_sucursales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabla_sucursales (
    id text NOT NULL,
    nombre_sucursal text,
    calle text,
    colonia text,
    ciudad text,
    cp bigint,
    telefono text,
    geolocalizacion text,
    estado text,
    id_cajero text,
    id_horario text
);


ALTER TABLE public.tabla_sucursales OWNER TO postgres;

--
-- Name: tablas_credito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tablas_credito (
    id text NOT NULL,
    nombre_comercial text,
    categoria_bot text,
    keywords text,
    beneficio_principal text,
    tasa_anual double precision,
    cat_prom double precision,
    plazo_max bigint,
    monto_max text,
    req_aval text,
    condiciones_especiales text,
    req_garantia text,
    recip_pct text,
    perfil_cliente text,
    status_credito text,
    requisitos_necesarios text,
    regla_adicional text
);


ALTER TABLE public.tablas_credito OWNER TO postgres;

--
-- Name: tablas_inversiones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tablas_inversiones (
    catalogo_inversiones text NOT NULL
);


ALTER TABLE public.tablas_inversiones OWNER TO postgres;

--
-- Name: talleres_culturales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.talleres_culturales (
    id text NOT NULL,
    nombre_taller text,
    descripcion_corta text,
    edades text,
    lunes text,
    martes text,
    miercoles text,
    jueves text,
    viernes text,
    sabado text,
    ubicacion text
);


ALTER TABLE public.talleres_culturales OWNER TO postgres;

--
-- Name: tasas_inversiones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasas_inversiones (
    id_tasa text NOT NULL,
    id_producto_rel text,
    monto_min double precision,
    monto_max bigint,
    tasa_anual_pct double precision
);


ALTER TABLE public.tasas_inversiones OWNER TO postgres;

--
-- Name: tramites_y_servicios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tramites_y_servicios (
    id_tramite text NOT NULL,
    nombre_tramite text,
    publico_objetivo text,
    canal_atencion text,
    requisitos_minimos text,
    costo_o_monto_minimo text,
    beneficio_directo text,
    keywords text
);


ALTER TABLE public.tramites_y_servicios OWNER TO postgres;

--
-- Name: user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_permissions (
    id integer NOT NULL,
    user_id integer,
    table_name character varying,
    can_edit boolean
);


ALTER TABLE public.user_permissions OWNER TO postgres;

--
-- Name: user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_permissions_id_seq OWNER TO postgres;

--
-- Name: user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_permissions_id_seq OWNED BY public.user_permissions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying,
    hashed_password character varying,
    is_active boolean,
    is_admin boolean
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: vista_sucursales; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_sucursales AS
 SELECT s.id,
    s.nombre_sucursal,
    s.calle,
    s.colonia,
    s.ciudad,
    s.cp,
    s.telefono,
    s.geolocalizacion,
    s.estado,
    s.id_cajero,
    s.id_horario,
    h.descripcion AS horario_descripcion,
    h.hora_apertura,
    h.hora_cierre,
    h.hora_apertura_sab,
    h.hora_cierre_sab
   FROM (public.tabla_sucursales s
     LEFT JOIN public.tabla_horarios h ON ((s.id_horario = h.id_horario)));


ALTER TABLE public.vista_sucursales OWNER TO postgres;

--
-- Name: 01.-matriz_de_conocimiento id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."01.-matriz_de_conocimiento" ALTER COLUMN id SET DEFAULT nextval('public."01.-matriz_de_conocimiento_id_seq"'::regclass);


--
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- Name: catalogo_vacantes _rowid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_vacantes ALTER COLUMN _rowid SET DEFAULT nextval('public.catalogo_vacantes__rowid_seq'::regclass);


--
-- Name: descripciones_tablas _rowid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.descripciones_tablas ALTER COLUMN _rowid SET DEFAULT nextval('public.descripciones_tablas__rowid_seq'::regclass);


--
-- Name: tabla_requisitos _rowid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabla_requisitos ALTER COLUMN _rowid SET DEFAULT nextval('public.tabla_requisitos__rowid_seq'::regclass);


--
-- Name: user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions ALTER COLUMN id SET DEFAULT nextval('public.user_permissions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: 01.-matriz_de_conocimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."01.-matriz_de_conocimiento" (id, tabla_ahorro, "unnamed:_1", "unnamed:_2") FROM stdin;
1	Nombre del Campo	Tipo de Dato	¿Por qué lo necesita el Bot?
2	id	Numérico / Texto	Identificador único (ej. 1, 2, 3). Sirve para que el sistema enlace esta cuenta con otras tablas sin confundirse.
3	nombre_producto	Texto	El nombre oficial que el bot mostrará al usuario (ej. "Ahorro Menores").
4	tipo_publico	Texto	Filtro Crítico. Permite al bot saber qué ofrecer si el usuario dice "soy menor de edad" o "es para mi hijo". (ej. "Menores", "Adultos/Socios").
5	monto_apertura	Moneda / Texto	Responde a la pregunta frecuente "¿cuánto cuesta abrirla?". Debe incluir el signo de pesos.
6	saldo_minimo	Moneda / Texto	Informa al usuario cuánto debe dejar en la cuenta para que no se la cancelen.
7	tasa_rendimiento	Texto	El beneficio económico. Es importante ponerlo como texto (ej. "1.50% Anual") para que el bot lo lea natural.
8	disponibilidad	Texto	Define la liquidez. El bot usará esto para diferenciar una cuenta "a la vista" de un "plazo fijo".
9	medios_acceso	Texto	Explica cómo se usa el dinero (Tarjeta, App, Ventanilla). Vital para dudas operativas.
10	requisitos_clave	Texto Largo	Lista de documentos. El bot puede extraer de aquí la respuesta a "¿qué papeles necesito?".
11	beneficio_principal	Texto Largo	El argumento de venta. Si el usuario pregunta "¿por qué me conviene?", el bot lee este campo.
12	keywords_busqueda	Texto (Separado por comas)	Inteligencia del Bot. Aquí pones sinónimos (ej. "niños, hijos, infantil, bebe") para que el bot entienda variaciones del lenguaje humano.
13	\N	\N	\N
14	Tabla de crédito	\N	\N
15	Campo	Tipo	Función (El "Cerebro" del Bot)
16	id_credito	ID	Identificador único.
17	nombre_comercial	Texto	Nombre oficial a mostrar.
18	categoria_bot	Texto	Agrupador lógico (Consumo, Vivienda, etc.).
19	keywords	Texto	(Nuevo) Palabras clave para detectar intención del usuario.
20	beneficio_principal	Texto	(Nuevo) El "Gancho" de venta para convencer al usuario.
21	tasa_anual_fija	%	Dato para fórmula de pago mensual.
22	cat_promedio	Texto	Dato legal obligatorio.
23	plazo_max_meses	Num	Límite para el simulador.
24	monto_maximo	Texto	Límite del préstamo.
25	req_aval	Bool	Filtro duro (¿Requiere Aval? Sí/No).
26	req_garantia	Texto	Qué deja en garantía (Firma, Casa, Auto, Ahorro).
27	reciprocidad_pct	%	Cuánto ahorro debe tener antes de pedirlo.
28	perfil_cliente	Texto	Quién puede pedirlo (Socio, Empleado, Dueño).
29	\N	\N	\N
30	Tabla de requisitos	\N	\N
31	Nombre del Campo	Tipo de Dato	Función para el Bot (Validación)
32	id_requisito	ID	Identificador único (ej. REQ-01).
33	nombre_corto	Texto	Nombre interno (ej. "INE").
34	instruccion_usuario	Texto	El guion del bot: cómo pedirlo amablemente.
35	documentos_validos	Texto	Qué papeles sirven (ej. "CFE, Telmex, Predial").
36	vigencia_maxima_meses	Numérico	Regla de caducidad (ej. 3 meses). 0 = Sin caducidad.
37	formato_aceptado	Texto	Restricción técnica (PDF, JPG, PNG).
38	es_biometrico	Bool	¿Requiere selfie o huella? (Para validación de identidad).
39	tips_error	Texto	Qué decir si el usuario falla (ej. "La foto sale borrosa").
40	\N	\N	\N
41	Servicios y Beneficios Caja Oblatos	\N	\N
42	Nombre del Campo	Tipo de Dato	Función para el Chatbot
43	id_beneficio	ID	Identificador único (ej. BEN-01).
44	nombre_servicio	Texto	El nombre oficial (ej. "Consultorio Médico").
45	categoria_bot	Texto	Agrupador (Salud, Educación, Tecnología, Protección, Lealtad).
46	descripcion_corta	Texto	El script que el bot leerá para explicar qué es.
47	ubicacion_contacto	Texto	Datos de acción: Dirección, Teléfono o URL.
48	costo_socio	Texto	Precio o ventaja económica (ej. "Gratis", "Costo Preferencial").
49	horario_atencion	Texto	Cuándo está disponible.
50	accion_sugerida	Texto	Call to Action. ¿Qué debe proponer el bot? (Llamar, Ir al Mapa, Descargar).
51	keywords	Texto	Palabras clave para la búsqueda.
52	\N	\N	\N
53	Tabla Promociones	\N	\N
54	Nombre del Campo	Tipo de Dato	Función para el Chatbot (Lógica de Campaña)
55	id_promo	ID	Identificador único (ej. PROM-2026-01).
56	nombre_campana	Texto	Nombre interno (ej. "Inver-Aguinaldo").
57	tipo_producto	Texto	¿A qué aplica? (Ahorro, Crédito, Inversión, Ingreso).
58	publico_objetivo	Texto	Filtro Clave: Socio (Ya existe) o Aspirante (Nuevo).
59	descripcion_hook	Texto	El "Gancho" comercial que dirá el bot.
60	condicion_activacion	Texto	Regla para ganar (ej. "Invertir más de $10,000").
61	beneficio_otorgado	Texto	El premio (Tasa extra, Regalo, 0% Comisión).
62	fecha_inicio	Fecha	Cuándo empieza a mostrarse.
63	fecha_fin	Fecha	Cuándo deja de mostrarse (Caducidad automática).
64	status	Bool	Activa / Inactiva (Interruptor manual).
65	\N	\N	\N
66	Catalogo_Conceptos_Coop  - EDUCACION	\N	\N
67	Nombre del Campo	Tipo de Dato	Función para el Bot (NLP)
68	id_concepto	ID	Identificador (ej. EDU-01).
69	tema_principal	Texto	Concepto clave (ej. "Parte Social", "Asamblea").
70	definicion_bot	Texto	La Respuesta: Explicación sencilla, sin tecnicismos legales.
71	analogia_ejemplo	Texto	El "Como sí": Una comparación vida real para que se entienda mejor.
72	preguntas_usuario	Texto	Training Data: Qué suele preguntar la gente para activar esto.
73	nivel_complejidad	Texto	Básico (para todos) / Avanzado (para delegados).
74	\N	\N	\N
75	Catalogo_Vacantes - RHUMANOS	\N	\N
76	Nombre del Campo	Tipo de Dato	Función para el Bot
77	id_vacante	ID	Identificador (ej. VAC-01).
78	puesto_titulo	Texto	El nombre del trabajo (ej. "Operador sucursal").
79	area_departamento	Texto	Para categorizar (Sucursal, Corporativo, Cobranza).
80	ubicacion	Texto	¿En qué ciudad o sucursal es? (Vital para filtrar).
81	descripcion_breve	Texto	1 o 2 frases de lo que hará (el "Pitch").
82	requisitos_min	Texto	Filtro rápido (ej. "Prepa terminada, Exp. 6 meses").
83	sueldo_beneficios	Texto	El gancho (ej. "Sueldo base + Bonos + Fondo Ahorro").
84	correo_contacto	Email	A dónde llega el CV específico de esa zona.
85	status	Bool	Activa / Inactiva. (Si está inactiva, el bot no la muestra).
86	keywords	Texto	Palabras clave para búsqueda.
\.


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_logs (id, user_id, action, table_name, record_id, details, "timestamp") FROM stdin;
1	1	DELETE_USER	users	2	{"username_deleted": "howard"}	2026-06-16 15:56:13.906148+00
2	3	UPDATE	tabla_requisitos	REQ-39	{"id": "REQ-39", "nombre_corto": "Comprobante de ingresos oficial", "instruccion_usuario": "Necesitamos validar cu\\u00e1nto ganas. Sube tus recibos oficiales.", "documentos_validos": "Recibos de N\\u00f3mina (PDF), Declaraci\\u00f3n de ingresos/gastos, Estado de Cuenta Bancario o declaraciones ante el sat y pago de honorarios", "vigencia_meses": "6", "formato": "Impreso", "tips_error": "Los documentos deben ser legibles y vigentes"}	2026-06-16 16:42:18.884448+00
3	3	UPDATE	tabla_sucursales	SUC-40	{"id": "SUC-40", "nombre_sucursal": "Talpita", "calle": "Juan de Dios Robledo 949", "colonia": " Talpita", "ciudad": "Guadalajara", "cp": 44719, "telefono": "3336443997", "geolocalizacion": "20.6861636183655, -103.309277035296", "estado": "Activo", "id_cajero": "no", "id_horario": "HOR-01"}	2026-06-16 16:43:06.044335+00
4	3	CREATE	catalogo_conceptos_cooperativos	NUEVO	{"id": "", "tema_principal": "Socio", "definicion_bot": "Un socio de una cooperativa es una persona (f\\u00edsica o jur\\u00eddica) que, mediante libre adhesi\\u00f3n y baja voluntaria, se asocia para participar en una organizaci\\u00f3n democr\\u00e1tica que busca satisfacer necesidades econ\\u00f3micas, sociales y culturales comunes. ", "analogia_ejemplo": ""}	2026-06-16 17:35:23.022695+00
5	3	CREATE	tramites_y_servicios	NUEVO	{"id_tramite": "TRAM-04", "nombre_tramite": "Alta de Ahorrador Menor", "publico_objetivo": "Ni\\u00f1os (1 a 17 a\\u00f1os) a trav\\u00e9s de su Tutor", "canal_atencion": "Sucursal (Presencial)", "requisitos_minimos": "1. Acta de nacimiento del menor.2. Identificaci\\u00f3n oficial vigente del padre o tutor (Socio).3. Comprobante de domicilio (no mayor a 3 meses).4. Realizar el dep\\u00f3sito de apertura en ventanilla.", "costo_o_monto_minimo": "$21.00\\n\\n($20.00 monto de apertura + $1.00 saldo m\\u00ednimo).", "beneficio_directo": "Fomenta el h\\u00e1bito del ahorro desde la infancia en la cuenta de Ahorro Menores, con rendimientos y sin comisiones.", "keywords": "dar de alta ni\\u00f1o, cuenta infantil, ahorro menores, registrar hijo, kids coop, menor"}	2026-06-16 23:34:56.988229+00
6	3	UPDATE	tabla_ahorro	AH03	{"id": "AH03", "nombre_producto": "Ahorro Menores", "tipo_publico": "Ni\\u00f1os (1 a 17 a\\u00f1os)", "monto_apertura": 50, "saldo_minimo": 1, "tasa_rendimiento": "1.50% Anual", "disponibilidad": "Restringida (Tutor)", "medios_acceso": "Ventanilla (solo tutor)", "requisitos_clave": "Acta de Nacimiento e Identificaci\\u00f3n oficial del Padre/Tutor. Comprobante de domicilio (no mayor a 3 meses).", "beneficio_principal": "Fomenta el h\\u00e1bito del ahorro desde la infancia con rendimientos y sin cobro de comisiones.", "keywords": "ahorro ni\\u00f1os, cuenta infantil, kids coop, menor"}	2026-06-16 23:36:28.949303+00
7	3	CREATE	catalogo_conceptos_cooperativos	NUEVO	{"id": "", "tema_principal": "Aanty", "definicion_bot": "Aanty no es una hormiga cualquiera; es la mascota y la compa\\u00f1era de viaje m\\u00e1s din\\u00e1mica, amigable y trabajadora de Caja Oblatos. Con su energ\\u00eda joven y siempre dispuesta a echar una mano, Aanty nos recuerda todos los d\\u00edas que las cosas grandes se logran trabajando en equipo.  Lleva en su ADN el esp\\u00edritu de aquellos 13 fundadores originales y lo contagia a los miles de socios actuales. Para ella, la f\\u00f3rmula del \\u00e9xito es sencilla: la uni\\u00f3n de nuestros esfuerzos individuales es lo que nos hace una organizaci\\u00f3n fuerte, democr\\u00e1tica y aut\\u00f3noma.  Como toda buena hormiga, sabe que el trabajo constante y la acumulaci\\u00f3n inteligente de recursos hoy, son la clave para disfrutar de un ma\\u00f1ana s\\u00faper tranquilo. Ella es la inspiraci\\u00f3n perfecta para aprovechar nuestros servicios de ahorro y cr\\u00e9dito.  Para Aanty, el \\"yo\\" no existe; aqu\\u00ed todo es \\"nosotros\\". Es la embajadora oficial de la Ayuda Mutua y la Solidaridad, demostrando que el bienestar de nuestra comunidad siempre ser\\u00e1 m\\u00e1s importante que el individualismo.  \\u00a1Aanty no se qued\\u00f3 en el pasado! Es la fan n\\u00famero uno de la innovaci\\u00f3n y es quien lidera la evoluci\\u00f3n de los servicios de la cooperativa. Con su mochila lista y siempre conectada, Aanty es la gu\\u00eda perfecta para que los socios naveguen por la nueva era de pagos electr\\u00f3nicos, utilicen las aplicaciones m\\u00f3viles y disfruten de soluciones financieras modernas, r\\u00e1pidas y seguras.", "analogia_ejemplo": "Aanty no es una hormiga cualquiera; es la mascota y la compa\\u00f1era de viaje m\\u00e1s din\\u00e1mica, amigable y trabajadora de Caja Oblatos. "}	2026-06-17 15:35:43.938387+00
8	3	CREATE	tabla_atm	NUEVO	{"id_cajero": "XC010301", "descripcion_atm": "C.B.A.", "tipo": "Cajero dispensador", "domicilio": "Constituci\\u00f3n Entre Hidalgo e Ignacio Romo", "no_exterior": "7 A", "colonia": "Centro", "estado": "Jalisco", "municipio": "Concepcion de Buenos Aires", "ciudad": "Concepcion de Buenos aires", "cp": 49170, "geolocalizacion": "19.9792251, -103.2601463", "tiene_sucursal_asignada": "SI", "sucursal": "Concepci\\u00f3n de Buenos Aires", "estatus": "Activo", "opera_las_24_hrs": "si", "monto_minimo_operacion": 50, "costo_consulta_saldo": "14 + iva", "costo_retiro_nacional": "20 + iva", "incluir_retiro_internacional": "si", "costo_retiro_internacional": "20 + iva", "servicios": "consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente", "idioma": "espa\\u00f1ol / ingl\\u00e9s", "accesibilidad": "Rampa de acceso externa, Acceso con silla de ruedas", "locacion_espacio_geografico": "Con acceso independiente a sucursal", "abierto_al_publico": "si"}	2026-06-17 15:50:42.328988+00
9	3	CREATE	tabla_atm	NUEVO	{"id_cajero": "XC010201", "descripcion_atm": "Joaquin amaro", "tipo": "Cajero dispensador", "domicilio": "Av Joaquin amaro", "no_exterior": "2179", "colonia": "Santa Cecilia", "estado": "Jalisco", "municipio": "Guadalajara", "ciudad": "Guadalajara", "cp": 44700, "geolocalizacion": "20.70255197709, -103.292208097536", "tiene_sucursal_asignada": "SI", "sucursal": "Joaquin amaro", "estatus": "Activo", "opera_las_24_hrs": "si", "monto_minimo_operacion": 50, "costo_consulta_saldo": "14 + iva", "costo_retiro_nacional": "20 + iva", "incluir_retiro_internacional": "si", "costo_retiro_internacional": "20 + iva", "servicios": "consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente", "idioma": "espa\\u00f1ol / ingl\\u00e9s", "accesibilidad": "Rampa de acceso externa, Acceso con silla de ruedas", "locacion_espacio_geografico": "Con acceso independiente a sucursal", "abierto_al_publico": "si"}	2026-06-17 15:52:13.609211+00
10	3	CREATE	tabla_atm	NUEVO	{"id_cajero": "XC010201", "descripcion_atm": "Joaquin amaro", "tipo": "Cajero dispensador", "domicilio": "Av Joaquin amaro", "no_exterior": "2179", "colonia": "Santa Cecilia", "estado": "Jalisco", "municipio": "Guadalajara", "ciudad": "Guadalajara", "cp": 44700, "geolocalizacion": "20.70255197709, -103.292208097536", "tiene_sucursal_asignada": "SI", "sucursal": "Joaquin amaro", "estatus": "Activo", "opera_las_24_hrs": "si", "monto_minimo_operacion": 50, "costo_consulta_saldo": "14 + iva", "costo_retiro_nacional": "20 + iva", "incluir_retiro_internacional": "si", "costo_retiro_internacional": "20 + iva", "servicios": "consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente", "idioma": "espa\\u00f1ol / ingl\\u00e9s", "accesibilidad": "Rampa de acceso externa, Acceso con silla de ruedas", "locacion_espacio_geografico": "Con acceso independiente a sucursal", "abierto_al_publico": "si"}	2026-06-17 15:53:00.854514+00
11	3	DELETE	catalogo_soporte	SOP-31	{"info": "Registro eliminado"}	2026-06-17 15:53:54.838644+00
12	3	CREATE	tabla_atm	NUEVO	{"id_cajero": "XC010201", "descripcion_atm": "Joaquin amaro", "tipo": "Cajero dispensador", "domicilio": "Av Joaquin amaro", "no_exterior": "2179", "colonia": "Santa Cecilia", "estado": "Jalisco", "municipio": "Guadalajara", "ciudad": "Guadalajara", "cp": 44700, "geolocalizacion": "20.70255197709, -103.292208097536", "tiene_sucursal_asignada": "SI", "sucursal": "Joaquin amaro", "estatus": "Activo", "opera_las_24_hrs": "si", "monto_minimo_operacion": 50, "costo_consulta_saldo": "14 + iva", "costo_retiro_nacional": "20 + iva", "incluir_retiro_internacional": "si", "costo_retiro_internacional": "20 + iva", "servicios": "consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente", "idioma": "espa\\u00f1ol / ingl\\u00e9s", "accesibilidad": "Rampa de acceso externa, Acceso con silla de ruedas", "locacion_espacio_geografico": "Con acceso independiente a sucursal", "abierto_al_publico": "si"}	2026-06-17 15:54:25.545109+00
13	1	DELETE	tabla_atm	14	{"info": "Registro eliminado"}	2026-06-17 16:37:20.130484+00
14	1	DELETE	tabla_atm	13	{"info": "Registro eliminado"}	2026-06-17 16:38:09.047771+00
15	1	DELETE	tabla_atm	12	{"info": "Registro eliminado"}	2026-06-17 16:38:22.65505+00
16	3	UPDATE	tabla_atm	10	{"id_cajero": "XC011001", "descripcion_atm": "Santo Santiago", "tipo": "Cajero dispensador", "domicilio": "Calle Zaragoza", "no_exterior": "84", "colonia": "Centro", "estado": "Jalisco", "municipio": "Tonala", "ciudad": "Tonala", "cp": 45400, "geolocalizacion": "20.623261, -103.2434328", "tiene_sucursal_asignada": "SI", "sucursal": "Santo Santiago, Tonala", "estatus": "Activo", "opera_las_24_hrs": "si", "monto_minimo_operacion": 50, "costo_consulta_saldo": "14 + iva", "costo_retiro_nacional": "20 + iva", "incluir_retiro_internacional": "si", "costo_retiro_internacional": "20 + iva", "servicios": "consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente", "idioma": "espa\\u00f1ol / ingl\\u00e9s", "accesibilidad": "Rampa de acceso externa, Acceso con silla de ruedas", "locacion_espacio_geografico": "Con acceso independiente a sucursal", "abierto_al_publico": "si", "_rowid": 10}	2026-06-17 17:18:05.538683+00
17	3	DELETE	tabla_atm	11	{"info": "Registro eliminado"}	2026-06-17 17:19:59.102795+00
18	3	UPDATE	tabla_protecciones	PROT-03	{"id": "PROT-03", "nombre_oficial": "Fondo Solidario", "tipo_riesgo": "FALLECIMIENTO", "monto_cobertura": "Apoyo econ\\u00f3mico (monto variable).", "condicion_activacion": "Socio vigente + Antig\\u00fcedad min 2 a\\u00f1os + Contratar el servicio", "costo_socio": "Contrataci\\u00f3n de $150; se descuentan $5 por cada fallecimiento de socio participante.", "beneficiarios": "Beneficiarios Designados", "keywords": "ayuda, dinero familia, muerte, beneficiario", "restricciones": "En el caso de los socios que ingresan con una edad de 70 a\\u00f1os en adelante, ser\\u00e1 requisito indispensable tener una antig\\u00fcedad de al menos 2 a\\u00f1os como socio y 1 a\\u00f1o perteneciendo al Fondo Solidario; asimismo, su saldo en la cuenta de ahorro de dicho fondo no deber\\u00e1 de ser menor a $100.00 MXN.", "requisitos": "REQ-01,REQ-33, REQ-29"}	2026-06-17 17:23:00.866927+00
19	3	UPDATE	tabla_protecciones	PROT-03	{"id": "PROT-03", "nombre_oficial": "Fondo Solidario", "tipo_riesgo": "FALLECIMIENTO", "monto_cobertura": "Apoyo econ\\u00f3mico (monto variable).", "condicion_activacion": "Socio vigente + Antig\\u00fcedad min 2 a\\u00f1os + Realizar la contrataci\\u00f3n en sucursal", "costo_socio": "Contrataci\\u00f3n de $150; se descuentan $5 por cada fallecimiento de socio participante.", "beneficiarios": "Beneficiarios Designados", "keywords": "ayuda, dinero familia, muerte, beneficiario", "restricciones": "En el caso de los socios que ingresan con una edad de 70 a\\u00f1os en adelante, ser\\u00e1 requisito indispensable tener una antig\\u00fcedad de al menos 2 a\\u00f1os como socio y 1 a\\u00f1o perteneciendo al Fondo Solidario; asimismo, su saldo en la cuenta de ahorro de dicho fondo no deber\\u00e1 de ser menor a $100.00 MXN.", "requisitos": "REQ-01,REQ-33, REQ-29"}	2026-06-17 17:24:25.550158+00
20	3	UPDATE	tabla_sucursales	SUC-38	{"id": "SUC-38", "nombre_sucursal": "Santo Santiago (Tonal\\u00e1)", "calle": "Zaragoza No.84", "colonia": "Centro", "ciudad": "Tonal\\u00e1", "cp": 45400, "telefono": "3336834080", "geolocalizacion": "20.6237413, -103.2413723", "estado": "Activo", "id_cajero": "XC011001", "id_horario": "HOR-01"}	2026-06-17 17:25:32.066924+00
21	3	UPDATE	tabla_sucursales	SUC-28	{"id": "SUC-28", "nombre_sucursal": "Navojoa", "calle": "Garc\\u00eda Morales Sur No. 500", "colonia": " Reforma", "ciudad": "Navojoa", "estado_republica": "Sonora", "cp": 85870, "telefono": "6424224595", "geolocalizacion": "27.0765201, -109.4466148", "estado": "Activo", "id_cajero": "no", "id_horario": "HOR-03"}	2026-06-17 17:59:41.93573+00
22	1	UPDATE	tabla_servicios	Serv_10	{"id": "Serv_10", "nombre_servicio": "DIMO", "categoria_bot": "Servicios Digitales", "descripcion_corta": "Env\\u00eda y recibe dinero usando solo el n\\u00famero de celular vinculado a tu cuenta.", "ubicacion_/_contacto": "App Caja Oblatos M\\u00f3vil.", "costo_socio": "$5.80 por env\\u00edo.", "requisitos": "Tener activa la aplicaci\\u00f3n Caja Oblatos M\\u00f3vil y registro en DIMO.", "accion_sugerida": " \\"Configurar DIMO ahora\\"", "keywords": "dimo, transferencia celular, n\\u00famero, banco"}	2026-06-17 18:44:54.721769+00
23	3	UPDATE	tramites_y_servicios	5	{"id_tramite": "TRAM-05", "nombre_tramite": "Solicitud de Tarjeta de D\\u00e9bito", "publico_objetivo": "Socio Vigente", "canal_atencion": "Sucursal (Presencial)", "requisitos_minimos": "1. Ser socio activo con la Parte Social completa.\\n2. Presentar identificaci\\u00f3n oficial vigente.\\n3. Contar con una cuenta de Ahorro D\\u00e9bito.\\n4. Firmar el contrato de medios electr\\u00f3nicos en la sucursal.", "costo_o_monto_minimo": "Apertura gratuita con un dep\\u00f3sito inicial de $50.00 en tu cuenta de ahorro d\\u00e9bito. / Reposici\\u00f3n: $50.00.", "beneficio_directo": "Entrega inmediata del pl\\u00e1stico Carnet para realizar compras en comercios, e-commerce, retiros en cajeros y acceso a CashBack.", "keywords": "solicitar tarjeta, tramitar pl\\u00e1stico, mi tarjeta d\\u00e9bito, renovar tarjeta, carnet", "_rowid": 5}	2026-06-17 18:47:34.096123+00
24	3	UPDATE	tabla_atm	3	{"id_cajero": "XC010201", "descripcion_atm": "Joaquin amaro", "tipo": "Cajero dispensador", "domicilio": "Av Joaquin amaro", "no_exterior": "2179", "colonia": "Santa Cecilia", "estado": "Jalisco", "municipio": "Guadalajara", "ciudad": "Guadalajara", "cp": 44700, "geolocalizacion": "20.70255197709, -103.292208097536", "tiene_sucursal_asignada": "SI", "sucursal": "Joaquin amaro", "estatus": "Activo", "opera_las_24_hrs": "si", "monto_minimo_operacion": 50, "costo_consulta_saldo": "14 + iva", "costo_retiro_nacional": "20 + iva", "incluir_retiro_internacional": "si", "costo_retiro_internacional": "20 + iva", "servicios": "consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente", "idioma": "espa\\u00f1ol / ingl\\u00e9s", "accesibilidad": "Rampa de acceso externa, Acceso con silla de ruedas", "locacion_espacio_geografico": "Con acceso independiente a sucursal", "abierto_al_publico": "si", "_rowid": 3}	2026-06-17 18:49:42.159225+00
26	3	UPDATE	tabla_servicios	Serv_11	{"id": "Serv_11", "nombre_servicio": "Aclaraciones (UNE)", "categoria_bot": "Soporte T\\u00e9cnico", "descripcion_corta": "Atenci\\u00f3n especializada para consultas, quejas o reclamaciones de servicios financieros.", "ubicacion_/_contacto": "Sucursales de Caja Oblatos", "costo_socio": "Improcedentes: $250 + IVA.", "requisitos": "Ser socio y presentar identificaci\\u00f3n oficial vigente (INE).", "accion_sugerida": "\\"Ver horarios de atenci\\u00f3n\\"", "keywords": "aclaraci\\u00f3n, queja, sugerencia, une, fallo"}	2026-06-17 21:17:18.806078+00
25	3	UPDATE	tabla_atm	6	{"id_cajero": "XC010501", "descripcion_atm": "Ixtlahuac\\u00e1n del Rio", "tipo": "Cajero dispensador", "domicilio": "calle independencia", "no_exterior": "48", "colonia": "centro", "estado": "Jalisco", "municipio": "Ixtlahuac\\u00e1n del R\\u00edo", "ciudad": "Ixtlahuac\\u00e1n del R\\u00edo", "cp": 45270, "geolocalizacion": "20.862684158145, -103.2388607949489", "tiene_sucursal_asignada": "SI", "sucursal": "Ixtlahuac\\u00e1n del R\\u00edo", "estatus": "Activo", "opera_las_24_hrs": "si", "monto_minimo_operacion": 50, "costo_consulta_saldo": "14 + iva", "costo_retiro_nacional": "20 + iva", "incluir_retiro_internacional": "si", "costo_retiro_internacional": "20 + iva", "servicios": "consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente", "idioma": "espa\\u00f1ol / ingl\\u00e9s", "accesibilidad": "Rampa de acceso externa, Acceso con silla de ruedas", "locacion_espacio_geografico": "Con acceso independiente a sucursal", "abierto_al_publico": "si", "_rowid": 6}	2026-06-17 18:49:59.494708+00
28	1	UPDATE	tabla_servicios	Serv_9	{"id": "Serv_9", "nombre_servicio": "Tarjeta de D\\u00e9bito", "categoria_bot": "Medios de Pago", "descripcion_corta": "Acceso inmediato a tu dinero para compras en comercios, internet (CVV Digital) y cajeros.", "ubicacion_/_contacto": "Todas las Sucursales.", "costo_socio": "Apertura/Reposici\\u00f3n: $50.00 pesos.", "requisitos": "Ser socio y contar con una cuenta de ahorro activa.", "accion_sugerida": "\\"Ver beneficios de mi tarjeta\\"", "keywords": "compras, tpv, e-commerce, d\\u00e9bito, tarjeta fisica"}	2026-06-17 22:00:03.263392+00
29	1	UPDATE	tabla_servicios	Serv_9	{"id": "Serv_9", "nombre_servicio": "Tarjeta de D\\u00e9bito", "categoria_bot": "Medios de Pago", "descripcion_corta": "Acceso inmediato a tu dinero para compras en comercios, internet (CVV Digital) y cajeros.", "ubicacion_/_contacto": "Todas las Sucursale", "costo_socio": "Apertura/Reposici\\u00f3n: $50.00 pesos.", "requisitos": "Ser socio y contar con una cuenta de ahorro activa.", "accion_sugerida": "\\"Ver beneficios de mi tarjeta\\"", "keywords": "compras, tpv, e-commerce, d\\u00e9bito, tarjeta fisica"}	2026-06-17 22:01:51.552302+00
30	3	UPDATE	tramites_y_servicios	12	{"id_tramite": "TRAM-12", "nombre_tramite": "Solicitud de Aclaraciones", "publico_objetivo": "Socio Vigente", "canal_atencion": "Sucursal", "requisitos_minimos": "1. Presentar identificaci\\u00f3n oficial vigente del socio.\\n2. Llenar y firmar el formato oficial de reclamaci\\u00f3n (cargos no reconocidos, fallas en cajero o SPEI).\\n3. Proporcionar estado de cuenta, comprobante f\\u00edsico del cajero o captura de la App M\\u00f3vil.\\n4. En caso de robo o extrav\\u00edo, presentar folio de bloqueo.", "costo_o_monto_minimo": "Gratuito", "beneficio_directo": "An\\u00e1lisis t\\u00e9cnico de la transacci\\u00f3n, resoluci\\u00f3n formal del caso y, de ser procedente, el reembolso de los fondos correspondientes.", "keywords": "aclaraci\\u00f3n, cargo no reconocido, clonaron tarjeta, no me dio dinero el cajero, reclamaci\\u00f3n, fraude, spei fallido", "_rowid": 12}	2026-06-17 22:50:11.757561+00
31	3	UPDATE	tramites_y_servicios	3	{"id_tramite": "TRAM-03", "nombre_tramite": "Participaci\\u00f3n en Asamblea", "publico_objetivo": "Socio Vigente", "canal_atencion": "Oficina Matriz, Calz. Juan Pablo II 2015, Col. Oblatos. Guadalajara", "requisitos_minimos": "1. Ser socio con Parte Social completa. 2. Estar al corriente con sus obligaciones (ahorros y cr\\u00e9ditos).3. Presentar credencial de socio e identificaci\\u00f3n oficial el d\\u00eda del evento.", "costo_o_monto_minimo": "Gratuito", "beneficio_directo": "Ejercer el derecho a voz y voto en las decisiones, elecciones y distribuci\\u00f3n de remanentes de la cooperativa.", "keywords": "asamblea, junta de socios, votar, delegados, participar, reuni\\u00f3n anual", "_rowid": 3}	2026-06-17 22:51:15.098123+00
33	3	CREATE	tabla_protecciones	NUEVO	{"id": "", "nombre_oficial": "Funeraria Funecoop", "tipo_riesgo": "", "monto_cobertura": "", "condicion_activacion": "", "costo_socio": "", "beneficiarios": "", "keywords": "", "restricciones": "", "requisitos": ""}	2026-06-19 17:39:39.246484+00
27	1	UPDATE	tabla_servicios	Serv_9	{"id": "Serv_9", "nombre_servicio": "Tarjeta de D\\u00e9bito", "categoria_bot": "Medios de Pago", "descripcion_corta": "Acceso inmediato a tu dinero para compras en comercios, internet (CVV Digital) y cajeros.", "ubicacion_/_contacto": "Todas las Sucursale", "costo_socio": "Apertura/Reposici\\u00f3n: $50.00 pesos.", "requisitos": "Ser socio y contar con una cuenta de ahorro activa.", "accion_sugerida": "\\"Ver beneficios de mi tarjeta\\"", "keywords": "compras, tpv, e-commerce, d\\u00e9bito, tarjeta fisica"}	2026-06-17 21:59:21.380223+00
32	3	UPDATE	tabla_servicios	Serv_9	{"id": "Serv_9", "nombre_servicio": "Tarjeta de D\\u00e9bito", "categoria_bot": "Medios de Pago", "descripcion_corta": "Acceso inmediato a tu dinero para compras en comercios, internet (CVV Digital) y cajeros.", "ubicacion_/_contacto": "Todas las Sucursale", "costo_socio": "Apertura gratuita con un dep\\u00f3sito inicial de $50.00 en tu cuenta de ahorro. / Reposici\\u00f3n: $50.00.", "requisitos": "Ser socio y contar con una cuenta de ahorro activa.", "accion_sugerida": "\\"Ver beneficios de mi tarjeta\\"", "keywords": "compras, tpv, e-commerce, d\\u00e9bito, tarjeta fisica"}	2026-06-17 23:08:46.687552+00
34	3	CREATE	tramites_y_servicios	NUEVO	{"id_tramite": "TRAM-13", "nombre_tramite": "Servicio Funerario Gratuito FUNECOOP (PROFUN)", "publico_objetivo": "Beneficiarios o Familiares Directos del Socio (Adultos y Menores)", "canal_atencion": "Funeraria FUNECOOP Esteban Loera #199-A, Guadalajara, Jalisco./ L\\u00ednea de Emergencia 24/7 3333306370 y 3333307189", "requisitos_minimos": "1. Partes Sociales cubiertas.   2. Antig\\u00fcedad m\\u00ednima de 3 meses como socio.   3. Al corriente en obligaciones: no haber dejado de ahorrar ni de abonar a pr\\u00e9stamos en los \\u00faltimos 6 meses inmediatos anteriores al deceso (salvedad de 1 falla mensual).   4. Sin retiros de ahorro en los \\u00faltimos 6 meses (12 meses si es Ahorro Anticipado).    DOCUMENTOS EN SUCURSAL/FUNERARIA:   \\u2022 Tarjeta pl\\u00e1stica del socio fallecido o del solicitante. ", "costo_o_monto_minimo": "Totalmente Gratuito (Beneficio absorbido al 100% por Caja Oblatos para socios que cumplan las condiciones).", "beneficio_directo": "Servicio funerario completo en la infraestructura de FUNECOOP (funeraria cofundada por la cooperativa).", "keywords": "funecoop, profun, servicio funerario gratuito, funeraria caja oblatos, gastos funerarios, velorio socio, auxilio fallecimiento, facturaci\\u00f3n funeraria, correos seguros, muerte socio", "_rowid": ""}	2026-06-19 23:29:53.054597+00
35	4	UPDATE	tabla_promociones	PROM-12	{"id": "PROM-12", "nombre_campana": "Becacoop", "tipo": "Registro", "publico": "Socios y menores estudiantes", "descripcion_hook": "\\"\\u00a1Financiamos tus metas! Inscribete y participa para obtener una beca econ\\u00f3mica para tus estudios, sujeta a autorizaci\\u00f3n.\\"", "condicion": "Antig\\u00fcedad de 1 a\\u00f1o (Socio/Menor); sujeto a autorizaci\\u00f3n del Consejo de Administraci\\u00f3n.", "beneficio": "Apoyo econ\\u00f3mico estudiantil.", "vigencia": "Temporada", "status": "Active"}	2026-07-15 22:53:54.62479+00
36	4	UPDATE	tabla_promociones	PROM-12	{"id": "PROM-12", "nombre_campana": "Becacoop", "tipo": "Registro", "publico": "Socios y menores estudiantes", "descripcion_hook": "\\"\\u00a1Financiamos tus metas! Inscribete y participa para obtener una beca econ\\u00f3mica para tus estudios, sujeta a autorizaci\\u00f3n.\\"", "condicion": "Antig\\u00fcedad de 1 a\\u00f1o (Socio/Menor); sujeto a autorizaci\\u00f3n del Consejo de Administraci\\u00f3n.", "beneficio": "Apoyo econ\\u00f3mico estudiantil.", "vigencia": "Temporada", "status": "Activa"}	2026-07-15 22:54:08.585172+00
37	1	CREATE	tabla_promociones	NUEVO	{"id": "PROM-14", "nombre_campana": "test", "tipo": "test", "publico": "test", "descripcion_hook": "test", "condicion": "test", "beneficio": "test", "vigencia": "test", "status": "Activa"}	2026-07-21 17:08:17.10039+00
38	1	DELETE	tabla_promociones	PROM-14	{"info": "Registro eliminado"}	2026-07-21 17:09:47.34965+00
39	4	CREATE	tabla_promociones	NUEVO	{"id": "PROM-13", "nombre_campana": "Guardianes del Ahorro", "tipo": "Ahorro", "publico": "Menores", "descripcion_hook": "Convi\\u00e9rtete en un Guardi\\u00e1n del Ahorro y participa por un viaje todo pagado a Six Flags.", "condicion": "La promoci\\u00f3n es v\\u00e1lida \\u00fanicamente para ahorradores menores registrados en Caja Oblatos que tengan entre 6 y 17 a\\u00f1os cumplidos al momento del registro.", "beneficio": "Al completar la planilla, los ahorradores menores obtendr\\u00e1n un regalo especial y podr\\u00e1n participar en la rifa por fabulosos premios, incluyendo un viaje para el menor y un acompa\\u00f1ante a Six Flags.", "vigencia": "Temporada", "status": "Activa"}	2026-07-21 17:22:32.79745+00
40	4	UPDATE	tabla_promociones	PROM-13	{"id": "PROM-13", "nombre_campana": "Guardianes del Ahorro", "tipo": "Ahorro", "publico": "Menores", "descripcion_hook": "\\"Convi\\u00e9rtete en un Guardi\\u00e1n del Ahorro y participa por un viaje todo pagado a Six Flags\\".", "condicion": "La promoci\\u00f3n es v\\u00e1lida \\u00fanicamente para ahorradores menores registrados en Caja Oblatos que tengan entre 6 y 17 a\\u00f1os cumplidos al momento del registro.", "beneficio": "Al completar la planilla, los ahorradores menores obtendr\\u00e1n un regalo especial y podr\\u00e1n participar en la rifa por fabulosos premios, incluyendo un viaje para el menor y un acompa\\u00f1ante a Six Flags.", "vigencia": "Temporada", "status": "Activa"}	2026-07-21 17:23:00.139581+00
41	4	CREATE	tabla_promociones	NUEVO	{"id": "PROM-14", "nombre_campana": "Credim\\u00e1s Agua Premia", "tipo": "Cr\\u00e9dito", "publico": "Socios", "descripcion_hook": "Ll\\u00e9vate un obsequio con tu cr\\u00e9dito autorizado y participa en un sorteo bimestral de grandes premios.", "condicion": "\\u2022\\tContar con su parte social completa. \\u2022\\tEstar al corriente en sus pr\\u00e9stamos, en caso de tenerlos. \\u2022\\tHaber solicitado y recibido la autorizaci\\u00f3n de un cr\\u00e9dito destinado a proyectos relacionados con el acceso, saneamiento o abastecimiento de agua.", "beneficio": "Los socios participantes que comprueben cualquiera de los destinos antes mencionados recibir\\u00e1n un obsequio especial, sujeto a existencia. Adem\\u00e1s, participar\\u00e1n en un sorteo bimestral de premios especiales.", "vigencia": "13 de julio de 2026 y finalizar\\u00e1 al agotarse las existencias de los art\\u00edculos promocionales", "status": "Activa"}	2026-07-21 17:26:44.967193+00
42	4	CREATE	tabla_promociones	NUEVO	{"id": "PROM-15", "nombre_campana": "Feria del cr\\u00e9dito", "tipo": "Cr\\u00e9dito", "publico": "Socios", "descripcion_hook": "Cr\\u00e9ditos con condiciones especiales durante la promoci\\u00f3n ", "condicion": "Cr\\u00e9ditos sin aval cumpliendo los siguientes requisitos: -Calificaci\\u00f3n en Bur\\u00f3 de Cr\\u00e9dito (BC SCORE) mayor a 640. -Ingresos oficialmente comprobables. -Antig\\u00fcedad laboral m\\u00ednima de 6 meses. -Arraigo domiciliario m\\u00ednimo de 12 meses.", "beneficio": "Cr\\u00e9ditos sin aval cumpliendo las condiciones ", "vigencia": "Temporada", "status": "pendiente"}	2026-07-21 18:09:55.291475+00
43	4	UPDATE	tabla_promociones	PROM-15	{"id": "PROM-15", "nombre_campana": "Feria del cr\\u00e9dito", "tipo": "Cr\\u00e9dito", "publico": "Socios", "descripcion_hook": "Cr\\u00e9ditos con condiciones especiales durante la promoci\\u00f3n ", "condicion": "Cr\\u00e9ditos sin aval cumpliendo los siguientes requisitos: -Calificaci\\u00f3n en Bur\\u00f3 de Cr\\u00e9dito (BC SCORE) mayor a 640. -Ingresos oficialmente comprobables. -Antig\\u00fcedad laboral m\\u00ednima de 6 meses. -Arraigo domiciliario m\\u00ednimo de 12 meses.", "beneficio": "Cr\\u00e9ditos sin aval cumpliendo las condiciones ", "vigencia": "Temporada", "status": "Activa"}	2026-07-22 16:17:10.642638+00
44	4	UPDATE	tabla_promociones	PROM-14	{"id": "PROM-14", "nombre_campana": "Credim\\u00e1s Agua Premia", "tipo": "Cr\\u00e9dito", "publico": "Socios", "descripcion_hook": "Ll\\u00e9vate un obsequio con tu cr\\u00e9dito autorizado y participa en un sorteo bimestral de grandes premios.", "condicion": "\\u2022\\tContar con su parte social completa. \\u2022\\tEstar al corriente en sus pr\\u00e9stamos, en caso de tenerlos. \\u2022\\tHaber solicitado y recibido la autorizaci\\u00f3n de un cr\\u00e9dito destinado a proyectos relacionados con el acceso, saneamiento o abastecimiento de agua.", "beneficio": "Los socios participantes que comprueben cualquiera de los destinos antes mencionados recibir\\u00e1n un obsequio especial, sujeto a existencia. Adem\\u00e1s, participar\\u00e1n en un sorteo bimestral de premios especiales.", "vigencia": "Temporada", "status": "Activa"}	2026-07-22 16:18:55.494839+00
45	4	UPDATE	tabla_promociones	PROM-13	{"id": "PROM-13", "nombre_campana": "Guardianes del Ahorro", "tipo": "Ahorro", "publico": "Menores", "descripcion_hook": "\\"Convi\\u00e9rtete en un Guardi\\u00e1n del Ahorro y participa por un viaje todo pagado a Six Flags\\".", "condicion": "La promoci\\u00f3n es v\\u00e1lida \\u00fanicamente para ahorradores menores registrados en Caja Oblatos que tengan entre 6 y 17 a\\u00f1os cumplidos al momento del registro.", "beneficio": "Al completar la planilla, los ahorradores menores obtendr\\u00e1n un regalo especial y podr\\u00e1n participar en la rifa por fabulosos premios, incluyendo un viaje para el menor y un acompa\\u00f1ante a Six Flags.", "vigencia": "Del 13 de Julio al 14 de Noviembre del 2026", "status": "Activa"}	2026-07-22 16:23:07.261522+00
46	3	UPDATE	tabla_promociones	PROM-15	{"id": "PROM-15", "nombre_campana": "Feria del cr\\u00e9dito", "tipo": "Cr\\u00e9dito", "publico": "Socios", "descripcion_hook": "Cr\\u00e9ditos con condiciones especiales durante la promoci\\u00f3n ", "condicion": "Requisitos: -Calificaci\\u00f3n en Bur\\u00f3 de Cr\\u00e9dito (BC SCORE) mayor a 640. -Ingresos oficialmente comprobables. -Antig\\u00fcedad laboral m\\u00ednima de 6 meses. -Arraigo domiciliario m\\u00ednimo de 12 meses.", "beneficio": "Cr\\u00e9ditos sin aval: aplican los cr\\u00e9ditos Ordinario, Credi Socio Cumplido, Credi Auto Comercial y de Consumo, Credi Solar, Credi Comercio, Credi Aliado y Credi M\\u00e1s Agua, cumpliendo con las bases y requisitos.", "vigencia": "Temporada", "status": "Activa"}	2026-07-22 18:45:57.480999+00
\.


--
-- Data for Name: catalago_soporte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalago_soporte (id, problema, categoria, paso_1, paso_2, docs_req, tiempo, contacto, keywords) FROM stdin;
SOP-01	Cargo No Reconocido	Tarjetas	Entra a tu App y apaga/bloquea tu tarjeta inmediatamente para evitar más cargos.	Acude a cualquiera de nuestras sucursales e inicia un proceso de aclaración.	Formato UNE, INE, Captura del movimiento.	Hasta 90 días naturales	Este trámite requiere atención presencial. Por favor, preséntese en la sucursal más próxima a su domicilio.	cargo raro, me robaron dinero, compra que no hice, clonada, aclaración
SOP-02	Robo/Extravío de Tarjeta	Seguridad	Si cuentas con tu app activada, bloquea tu tarjeta desde el menú "Mi Tarjeta"; de lo contrario, llama al 800 890 7442.	Acude a cualquiera de nuestras sucursales para solicitar la reposición del plástico ($50.00).	INE vigente.	Inmediato (Bloqueo)	tdd2@cajaoblatos.com.mx, admin_atm@cajaoblatos.com.mx, contacto_cpomovil@cajaoblatos.com.mx	perdi mi tarjeta, me robaron la cartera, tarjeta perdida, reposición
SOP-03	Cajero no entregó dinero	Cajeros ATM	Guarda el ticket. Si no hay, anota la hora, número de cajero y ubicación del ATM.	Acude a cualquiera de nuestras sucursales e inicia un proceso de aclaración.	Ticket o datos, Formato UNE, INE.	Hasta 90 días naturales	Este trámite requiere atención presencial. Por favor, preséntese en la sucursal más próxima a su domicilio.	cajero se trago dinero, no me dio dinero, falla cajero, atm error
SOP-04	Bloqueo de App Móvil	App / Digital	Acude a cualquiera de nuestras sucursales e inicia un proceso de reseteo de NIP.	El personal te asignará un nuevo NIP, el cual deberás cambiar por tu seguridad.	INE vigente.	Inmediato en ventanilla	tdd2@cajaoblatos.com.mx, admin_atm@cajaoblatos.com.mx, contacto_cpomovil@cajaoblatos.com.mx	no entra mi app, usuario bloqueado, contraseña olvidada, error app
SOP-05	Transferencia SPEI no llega	Digital	Esto es muy raro, pero si te llega a pasar, verifica el estado de tu SPEI en banxico.org.mx/cep.	Si aparece como 'Liquidado' y no cae, envía el comprobante CEP para realizar un rastreo interno.	Comprobante CEP (Banxico).	24 a 48 horas	tdd2@cajaoblatos.com.mx, admin_atm@cajaoblatos.com.mx, contacto_cpomovil@cajaoblatos.com.mx	spei no llega, transferencia pendiente, donde está mi dinero, depósito
SOP-06	Activación de Remesas Directo a Cuenta	Digital	Ingresa al aplicativo móvil, ve al menú principal "Recibe Dinero EUA", relaciona tu cuenta Ahorro Débito y listo.	Una vez activo, proporciona tu número de folio al familiar en EUA para el envío de la remesa.	App Móvil activa.	Inmediato	\N	\N
SOP-07	CVV Digital	App / Digital	Entra a la App y selecciona el apartado de "Mi Tarjeta".	Pulsa el botón "Ver CVV" (se requiere contraseña o huella).	App Móvil activa.	Inmediato	contacto_cpomovil@cajaoblatos.com.mx	cvv, código seguridad, comprar en linea, tarjeta digital
SOP-08	Olvido de NIP Débito	Tarjetas	Desde tu aplicación puedes verificar tu NIP actual en el apartado de "Mi Tarjeta".	En caso contrario, acude a sucursal y solicita al ejecutivo el reseteo de tu NIP.	INE vigente y Tarjeta física.	5 a 10 min	Atención en ventanilla / sucursal.	no se mi nip, cambiar pin, contraseña cajero
SOP-09	Activación Tarjeta Nueva	Tarjetas	Acude a un cajero automático de Caja Oblatos.	Realiza una consulta de saldo y cambio de NIP para activar el chip.	Tarjeta física y NIP asignado.	Inmediato	admin_atm@cajaoblatos.com.mx	activar tarjeta, tarjeta nueva, desbloquear plástico
SOP-10	Remesadoras directo a cuenta	Digital	Consulta en el menú "Recibe Dinero USA" las opciones vigentes.	Las remesadoras actuales son: Intermex, Maxi Send, Intercambio Express, Ria, ViaAmericas.	Número de folio de envío.	Inmediato	contacto_cpomovil@cajaoblatos.com.mx	remesas, dinero estados unidos, cobrar remesa, xoro
SOP-11	Bloqueo de tarjeta de débito desde App	Seguridad	Ve al menú de "Tarjetas" dentro de tu sesión en la App.	Desliza el interruptor a "Apagado".	App Móvil activa.	Inmediato	contacto_cpomovil@cajaoblatos.com.mx	apagar tarjeta, bloquear, seguridad, extravío temporal
SOP-12	Realizar SPEI	App / Digital	Ve al menú "Transferencias" y selecciona "Interbancarias".	Si no cuentas con la cuenta registrada, regístrate antes de proceder con el envío.	CLABE destino y Token activo.	30 seg	contacto_cpomovil@cajaoblatos.com.mx	transferencia, mandar dinero, spei, enviar pago
SOP-13	Ubicar Cuenta CLABE	App / Digital	Entra al detalle de tu cuenta de Ahorro Débito en la App.	Selecciona "Ver más" para que se muestre el detalle de la cuenta.	App Móvil activa.	Inmediato	contacto_cpomovil@cajaoblatos.com.mx	clabe, interbancaria, número de cuenta, depósitos
SOP-14	Transferencia DIMO	Digital	En el menú principal selecciona "DIMO".	Elige "Enviar dinero" e ingresa el número celular del beneficiario.	Número celular del destino.	Inmediato	contacto_cpomovil@cajaoblatos.com.mx	dimo, transferencia celular, sin cable, pago rapido
SOP-15	Alta Cuenta DIMO	Digital	Entra a la sección "Administración" en tu App Móvil y presiona "Administrar" en el menú DIMO.	Acepta los términos y condiciones para vincular tu número celular a tu cuenta de ahorros.	Número celular registrado.	Inmediato	contacto_cpomovil@cajaoblatos.com.mx	registrar dimo, vincular celular, alta dimo
SOP-16	Pago de Servicios	App / Digital	Ve al menú "Compras y Pagos", selecciona la cuenta "Ahorro Débito" y elige la opción "Pago de Servicios".	Busca el convenio (Luz, Agua, Teléfono) y escanea el código de barras; si no aparece el servicio, presiona "Agregar servicio".	Recibo vigente.	5 min	contacto_cpomovil@cajaoblatos.com.mx	pagar luz, cfe, telmex, pagar agua, servicios app
SOP-17	Pago de Préstamo Propio	Préstamos	Entra a "Préstamos" y selecciona el crédito a pagar.	Selecciona "Realizar Pago" y elige la cuenta de origen (Ahorro Débito).	Saldo disponible en cuenta.	Inmediato	tdd2@cajaoblatos.com.mx	pagar mi credito, abono prestamo, mensualidad
SOP-18	Agregar Préstamo Terceros	Préstamos	Ve a "Pagos" -> "Préstamos de otros socios".	Es necesario que el préstamo esté al corriente; de lo contrario, no aparecerá para realizar el pago.	Número de crédito.	5 min	contacto_cpomovil@cajaoblatos.com.mx	pagar a otro socio, crédito ajeno, transferencia prestamo
SOP-19	Recarga Telefónica	App / Digital	Ve al menú "Pagos" y selecciona "Tiempo Aire".	Elige la compañía, ingresa el número a 10 dígitos y el monto.	Número telefónico.	Inmediato	contacto_cpomovil@cajaoblatos.com.mx	saldo, recarga, telcel, movistar, tiempo aire
SOP-20	Call Center	Soporte	Llama al 800 890 74 42 (exclusivo para bloqueo de tarjeta de débito y atención inmediata).	Proporciona tus datos personales para agilizar la validación.	Número de socio y Número de cuenta.	Inmediato	Call Center: 800 890 74 42	teléfono, hablar con alguien, soporte técnico
SOP-21	Servicio Vencido	App / Digital	Verifica si el convenio permite pagos extemporáneos en la App.	Si la App lo rechaza, deberás acudir directamente a la sucursal o al comercio.	Recibo vencido.	Variable	contacto_cpomovil@cajaoblatos.com.mx	recibo vencido, pago atrasado, no pasa mi servicio
SOP-22	Crédito no aparece	Préstamos	Si el crédito tiene más de 90 días de vencimiento, por seguridad y políticas de cobranza, sale de la banca móvil.	Acude a tu sucursal para consultar el saldo pendiente y realizar tu pago directamente en ventanilla.	INE y Número de Socio.	Inmediato	tdd2@cajaoblatos.com.mx	préstamo desaparecido, no veo mi deuda, credito mora
SOP-23	Domiciliación y Compras en Línea	Tarjetas	Ingresa los 16 dígitos de tu tarjeta en el portal del proveedor (ej. CFE) para domiciliar tus pagos.	Para compras en línea, deberás usar tu CVV digital generado desde tu aplicación móvil por seguridad.	Tarjeta de Débito.	Inmediato	tdd2@cajaoblatos.com.mx	domiciliación, pago automatico, cargo recurrente
SOP-24	Tarjeta no aparece	App / Digital	Revisa que tu tarjeta esté vinculada a tu número de socio actual.	Acude a sucursal si acabas de renovar tu plástico para su sincronización.	INE y Tarjeta.	24 horas	contacto_cpomovil@cajaoblatos.com.mx	no veo mi tarjeta, activar app, error cuenta
SOP-25	No puede comprar/retirar	Tarjetas	Verifica que la tarjeta no esté "Apagada" o "Capturada" en la App.	Revisa si el monto excede tu saldo disponible o tu límite diario.	Saldo suficiente.	Inmediato	tdd2@cajaoblatos.com.mx	rechazada, falla tarjeta, limite excedido, no da dinero
SOP-26	Fallo en terminal (TPV)	Tarjetas	Solicita el ticket de "Transacción Declinada" al comercio.	Si se hizo el cargo, acude a sucursal para iniciar la aclaración.	Ticket de rechazo e INE.	Hasta 90 días	tdd2@cajaoblatos.com.mx	no pasó la tarjeta, pague doble, fallo tpv
SOP-27	Token ya utilizado	Seguridad	Cierra la aplicación por completo y espera 2 minutos.	Genera un nuevo código dinámico; recuerda que cada código expira pronto.	App Móvil.	2 min	contacto_cpomovil@cajaoblatos.com.mx	error token, token usado, clave dinámica fallo
SOP-28	Elimine App Token	Seguridad	Descarga nuevamente la aplicación "Caja Oblatos Token".	Acude a sucursal para solicitar un nuevo código de vinculación.	INE y dispositivo.	10 min	contacto_cpomovil@cajaoblatos.com.mx	borre el token, reactivar token, nueva instalación
SOP-29	Usuario Externo: ATM no entregó efectivo	Cajeros ATM	Guarda el ticket; si no hay, anota la hora, número de cajero y ubicación.	Deberás acudir directamente a tu banco (el emisor de tu tarjeta) para iniciar el proceso de aclaración.	Según el banco emisor.	Según el banco	\N	\N
SOP-30	El Token no se vincula en automático	Seguridad	El Token no se vincula en automático debido a la falta de permisos. Cerciórate de que la App tenga todos los permisos activos.	Si el error persiste, desinstala la aplicación Token, vuelve a ingresar con tus credenciales y acepta los permisos; si falla, acude a sucursal.	App Móvil.	2 min	contacto_cpomovil@cajaoblatos.com.mx	error token, token usado, clave dinámica fallo
\.


--
-- Data for Name: catalogo_conceptos_cooperativos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalogo_conceptos_cooperativos (id, tema_principal, definicion_bot, analogia_ejemplo) FROM stdin;
EDU-01	Cooperativa vs Banco	Una cooperativa es una organización sin fines de lucro propiedad de sus mismos socios. A diferencia de un banco (que es una institución lucrativa), aquí no eres un cliente, eres uno de los dueños.	En un banco eres como un inquilino (pagas renta). En la Caja eres como un copropietario del edificio.
EDU-02	Parte Social	Es la aportación económica única que haces al entrar. No es una comisión, es tu capital que te convierte en socio con voz y voto.	Es como comprar una acción de una empresa. Ese dinero sigue siendo tuyo y le da fuerza a la Caja. Cuando decidas retirarte de la cooperativa, te será devuelto junto con todo el ahorro que hayas realizado.
EDU-03	Socio vs Cliente	Al ser socio tienes derechos: utilizar las diferentes cuentas de ahorro y préstamo, protección a tus fondos, servicio funerario gratuito, votar en asambleas y pedir cuentas. Un cliente solo usa un servicio.	Como socio, tienes derechos y obligaciones; como cliente, solo tienes obligaciones.
EDU-04	Asamblea	Es la máxima autoridad en la Caja Popular. Es donde se toman las decisiones importantes y, como socio, tienes derecho a participar en ella, ejerciendo tu voto y opinando sobre los puntos que se tratan.	Es como la junta de vecinos donde se decide qué hacer con el presupuesto del edificio.
EDU-05	Representante	Es un socio que participa en una convención seccional y es elegido por otros socios para representarlos en una Asamblea final. Es la voz de tu sucursal o zona.	Es como el jefe de grupo en la escuela o el representante de tu colonia.
EDU-06	Ayuda Mutua	Es nuestro valor principal: los ahorros de unos sirven para prestarle a otros que lo necesitan. El dinero circula entre nosotros.	Hoy por ti, mañana por mí. Es una cadena de favores financiera.
EDU-07	Excedentes	Son las ganancias que generó la Caja en el año. Al no tener dueños externos, este dinero se reinvierte en objetivos que beneficien a todos los socios.	El sobrante es de los socios y a ellos debe regresar en forma de servicios.
EDU-08	Fondo de Protección	Es un seguro que protege tus ahorros hasta por 25,000 UDIS en caso de cualquier eventualidad.	Es como el seguro del auto: esperas no usarlo, pero viajas tranquilo sabiendo que está ahí.
EDU-09	Federación	Es el organismo que agrupa y supervisa a varias cajas (como la nuestra) para asegurar que operemos bien y cumplamos la ley.	Es como la liga de fútbol a la que pertenece nuestro equipo.
EDU-10	Historia / Fundación	Caja Oblatos se fundó el 11 de mayo de 1966 por el Sr. J. Refugio Soto Gallo. Somos una entidad autorizada por la CNBV y tu ahorro está protegido por el Fondo de Protección (FOCOOP) hasta por 25,000 UDIS.	En Caja Oblatos tu dinero está seguro. Tu cooperativa paga una cuota para proteger tu dinero.
EDU-11	Convención Seccional	Es una reunión anual de socios que reciben los informes de los directivos y del director general. En ella se nombra al menos al 10% de los asistentes para que acudan a la Asamblea Final como representantes.	Es como si los vecinos de cada edificio de un conjunto residencial se reúnen primero por grupos y luego mandan representantes a una reunión general para tomar decisiones en común.
EDU-12	Directivo	Es un socio que recibe autoridad en una Asamblea para representar y cuidar los intereses de todos los socios.	Es como cuando en una junta de vecinos se nombra a alguien para que, junto con otros, decida y resuelva situaciones mientras no haya una nueva reunión.
EDU-13	Consejo de Administración	Órgano que representa a los socios y es nombrado por la Asamblea para dirigir y controlar todas las operaciones de la Caja Popular.	Es como un comité de vecinos elegidos para tomar decisiones y administrar las situaciones del día a día del edificio.
EDU-14	Consejo de Vigilancia	Órgano nombrado por la Asamblea para supervisar la actuación de los miembros del Consejo de Administración y del personal operativo.	Este Consejo representa los ojos de todas las personas que los nombraron.
EDU-15	GAT (Ganancia Anual Total)	Es el indicador de lo que ganará anualmente tu dinero invertido en cualquier institución autorizada.	Esta cifra te señala cuánto rendimiento obtendrás en tus cuentas de ahorro o inversión en todo un año.
EDU-16	CAT (Costo Anual Total)	Es el costo total (incluyendo intereses y comisiones) que te cobrará anualmente la institución a la que le solicites un crédito.	Esta cifra te enseña cuánto pagarás realmente por el préstamo al finalizar el año.
EDU-17	Cursos de Educoop	Curso de Educación Cooperativa donde aprenderás conceptos importantes de tu Caja Popular Oblatos: historia, principios cooperativos y sus servicios en general.	Es un curso especial para conocer a fondo cómo funciona tu Caja Popular.
\.


--
-- Data for Name: catalogo_inversiones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalogo_inversiones (id_producto, nombre_comercial, plazo_dias, liquidez, moneda, descripcion_corta) FROM stdin;
INV-01	InverDinámica	1	Diaria	MXN	Disponibilidad diaria. Tu dinero crece cada 24 horas.
INV-30	Inver Plus	30	Al Vencimiento	MXN	Inversión mensual. Ideal para comenzar.
INV-60	Inver-60	60	Al Vencimiento	MXN	Plazo bimestral. Equilibrio entre tiempo y ganancia.
INV-90	Inver-90	90	Al Vencimiento	MXN	Plazo trimestral. Planea tus metas a corto plazo.
INV-180	Inver-180	180	Al Vencimiento	MXN	Plazo semestral. Planea tus metas a mediano plazo.
INV-360	Inver-360	360	Al Vencimiento	MXN	Plazo anual. El plazo más alto para maximizar ganancias.
\.


--
-- Data for Name: catalogo_soporte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalogo_soporte (id, problema, categoria, paso_1, paso_2, docs_req, tiempo, contacto, keywords) FROM stdin;
SOP-01	Cargo No Reconocido	Tarjetas	Entra a tu App y apaga/bloquea tu tarjeta inmediatamente para evitar más cargos.	Acude a cualquiera de nuestras sucursales e inicia un proceso de aclaración.	Formato UNE, INE, Captura del movimiento.	Hasta 90 días naturales	Este trámite requiere atención presencial. Por favor, preséntese en la sucursal más próxima a su domicilio.	cargo raro, me robaron dinero, compra que no hice, clonada, aclaración
SOP-02	Robo/Extravío de Tarjeta	Seguridad	Si cuentas con tu app activada, bloquea tu tarjeta desde el menú "Mi Tarjeta"; de lo contrario, llama al 800 890 7442.	Acude a cualquiera de nuestras sucursales para solicitar la reposición del plástico ($50.00).	INE vigente.	Inmediato (Bloqueo)	tdd2@cajaoblatos.com.mx, admin_atm@cajaoblatos.com.mx, contacto_cpomovil@cajaoblatos.com.mx	perdi mi tarjeta, me robaron la cartera, tarjeta perdida, reposición
SOP-03	Cajero no entregó dinero	Cajeros ATM	Guarda el ticket. Si no hay, anota la hora, número de cajero y ubicación del ATM.	Acude a cualquiera de nuestras sucursales e inicia un proceso de aclaración.	Ticket o datos, Formato UNE, INE.	Hasta 90 días naturales	Este trámite requiere atención presencial. Por favor, preséntese en la sucursal más próxima a su domicilio.	cajero se trago dinero, no me dio dinero, falla cajero, atm error
SOP-04	Bloqueo de App Móvil	App / Digital	Acude a cualquiera de nuestras sucursales e inicia un proceso de reseteo de NIP.	El personal te asignará un nuevo NIP, el cual deberás cambiar por tu seguridad.	INE vigente.	Inmediato en ventanilla	tdd2@cajaoblatos.com.mx, admin_atm@cajaoblatos.com.mx, contacto_cpomovil@cajaoblatos.com.mx	no entra mi app, usuario bloqueado, contraseña olvidada, error app
SOP-05	Transferencia SPEI no llega	Digital	Esto es muy raro, pero si te llega a pasar, verifica el estado de tu SPEI en banxico.org.mx/cep.	Si aparece como 'Liquidado' y no cae, envía el comprobante CEP para realizar un rastreo interno.	Comprobante CEP (Banxico).	24 a 48 horas	tdd2@cajaoblatos.com.mx, admin_atm@cajaoblatos.com.mx, contacto_cpomovil@cajaoblatos.com.mx	spei no llega, transferencia pendiente, donde está mi dinero, depósito
SOP-06	Activación de Remesas Directo a Cuenta	Digital	Ingresa al aplicativo móvil, ve al menú principal "Recibe Dinero EUA", relaciona tu cuenta Ahorro Débito y listo.	Una vez activo, proporciona tu número de folio al familiar en EUA para el envío de la remesa.	App Móvil activa.	Inmediato	\N	\N
SOP-07	CVV Digital	App / Digital	Entra a la App y selecciona el apartado de "Mi Tarjeta".	Pulsa el botón "Ver CVV" (se requiere contraseña o huella).	App Móvil activa.	Inmediato	contacto_cpomovil@cajaoblatos.com.mx	cvv, código seguridad, comprar en linea, tarjeta digital
SOP-08	Olvido de NIP Débito	Tarjetas	Desde tu aplicación puedes verificar tu NIP actual en el apartado de "Mi Tarjeta".	En caso contrario, acude a sucursal y solicita al ejecutivo el reseteo de tu NIP.	INE vigente y Tarjeta física.	5 a 10 min	Atención en ventanilla / sucursal.	no se mi nip, cambiar pin, contraseña cajero
SOP-09	Activación Tarjeta Nueva	Tarjetas	Acude a un cajero automático de Caja Oblatos.	Realiza una consulta de saldo y cambio de NIP para activar el chip.	Tarjeta física y NIP asignado.	Inmediato	admin_atm@cajaoblatos.com.mx	activar tarjeta, tarjeta nueva, desbloquear plástico
SOP-10	Remesadoras directo a cuenta	Digital	Consulta en el menú "Recibe Dinero USA" las opciones vigentes.	Las remesadoras actuales son: Intermex, Maxi Send, Intercambio Express, Ria, ViaAmericas.	Número de folio de envío.	Inmediato	contacto_cpomovil@cajaoblatos.com.mx	remesas, dinero estados unidos, cobrar remesa, xoro
SOP-11	Bloqueo de tarjeta de débito desde App	Seguridad	Ve al menú de "Tarjetas" dentro de tu sesión en la App.	Desliza el interruptor a "Apagado".	App Móvil activa.	Inmediato	contacto_cpomovil@cajaoblatos.com.mx	apagar tarjeta, bloquear, seguridad, extravío temporal
SOP-12	Realizar SPEI	App / Digital	Ve al menú "Transferencias" y selecciona "Interbancarias".	Si no cuentas con la cuenta registrada, regístrate antes de proceder con el envío.	CLABE destino y Token activo.	30 seg	contacto_cpomovil@cajaoblatos.com.mx	transferencia, mandar dinero, spei, enviar pago
SOP-13	Ubicar Cuenta CLABE	App / Digital	Entra al detalle de tu cuenta de Ahorro Débito en la App.	Selecciona "Ver más" para que se muestre el detalle de la cuenta.	App Móvil activa.	Inmediato	contacto_cpomovil@cajaoblatos.com.mx	clabe, interbancaria, número de cuenta, depósitos
SOP-14	Transferencia DIMO	Digital	En el menú principal selecciona "DIMO".	Elige "Enviar dinero" e ingresa el número celular del beneficiario.	Número celular del destino.	Inmediato	contacto_cpomovil@cajaoblatos.com.mx	dimo, transferencia celular, sin cable, pago rapido
SOP-15	Alta Cuenta DIMO	Digital	Entra a la sección "Administración" en tu App Móvil y presiona "Administrar" en el menú DIMO.	Acepta los términos y condiciones para vincular tu número celular a tu cuenta de ahorros.	Número celular registrado.	Inmediato	contacto_cpomovil@cajaoblatos.com.mx	registrar dimo, vincular celular, alta dimo
SOP-16	Pago de Servicios	App / Digital	Ve al menú "Compras y Pagos", selecciona la cuenta "Ahorro Débito" y elige la opción "Pago de Servicios".	Busca el convenio (Luz, Agua, Teléfono) y escanea el código de barras; si no aparece el servicio, presiona "Agregar servicio".	Recibo vigente.	5 min	contacto_cpomovil@cajaoblatos.com.mx	pagar luz, cfe, telmex, pagar agua, servicios app
SOP-17	Pago de Préstamo Propio	Préstamos	Entra a "Préstamos" y selecciona el crédito a pagar.	Selecciona "Realizar Pago" y elige la cuenta de origen (Ahorro Débito).	Saldo disponible en cuenta.	Inmediato	tdd2@cajaoblatos.com.mx	pagar mi credito, abono prestamo, mensualidad
SOP-18	Agregar Préstamo Terceros	Préstamos	Ve a "Pagos" -> "Préstamos de otros socios".	Es necesario que el préstamo esté al corriente; de lo contrario, no aparecerá para realizar el pago.	Número de crédito.	5 min	contacto_cpomovil@cajaoblatos.com.mx	pagar a otro socio, crédito ajeno, transferencia prestamo
SOP-19	Recarga Telefónica	App / Digital	Ve al menú "Pagos" y selecciona "Tiempo Aire".	Elige la compañía, ingresa el número a 10 dígitos y el monto.	Número telefónico.	Inmediato	contacto_cpomovil@cajaoblatos.com.mx	saldo, recarga, telcel, movistar, tiempo aire
SOP-20	Call Center	Soporte	Llama al 800 890 74 42 (exclusivo para bloqueo de tarjeta de débito y atención inmediata).	Proporciona tus datos personales para agilizar la validación.	Número de socio y Número de cuenta.	Inmediato	Call Center: 800 890 74 42	teléfono, hablar con alguien, soporte técnico
SOP-21	Servicio Vencido	App / Digital	Verifica si el convenio permite pagos extemporáneos en la App.	Si la App lo rechaza, deberás acudir directamente a la sucursal o al comercio.	Recibo vencido.	Variable	contacto_cpomovil@cajaoblatos.com.mx	recibo vencido, pago atrasado, no pasa mi servicio
SOP-22	Crédito no aparece	Préstamos	Si el crédito tiene más de 90 días de vencimiento, por seguridad y políticas de cobranza, sale de la banca móvil.	Acude a tu sucursal para consultar el saldo pendiente y realizar tu pago directamente en ventanilla.	INE y Número de Socio.	Inmediato	tdd2@cajaoblatos.com.mx	préstamo desaparecido, no veo mi deuda, credito mora
SOP-23	Domiciliación y Compras en Línea	Tarjetas	Ingresa los 16 dígitos de tu tarjeta en el portal del proveedor (ej. CFE) para domiciliar tus pagos.	Para compras en línea, deberás usar tu CVV digital generado desde tu aplicación móvil por seguridad.	Tarjeta de Débito.	Inmediato	tdd2@cajaoblatos.com.mx	domiciliación, pago automatico, cargo recurrente
SOP-24	Tarjeta no aparece	App / Digital	Revisa que tu tarjeta esté vinculada a tu número de socio actual.	Acude a sucursal si acabas de renovar tu plástico para su sincronización.	INE y Tarjeta.	24 horas	contacto_cpomovil@cajaoblatos.com.mx	no veo mi tarjeta, activar app, error cuenta
SOP-25	No puede comprar/retirar	Tarjetas	Verifica que la tarjeta no esté "Apagada" o "Capturada" en la App.	Revisa si el monto excede tu saldo disponible o tu límite diario.	Saldo suficiente.	Inmediato	tdd2@cajaoblatos.com.mx	rechazada, falla tarjeta, limite excedido, no da dinero
SOP-26	Fallo en terminal (TPV)	Tarjetas	Solicita el ticket de "Transacción Declinada" al comercio.	Si se hizo el cargo, acude a sucursal para iniciar la aclaración.	Ticket de rechazo e INE.	Hasta 90 días	tdd2@cajaoblatos.com.mx	no pasó la tarjeta, pague doble, fallo tpv
SOP-27	Token ya utilizado	Seguridad	Cierra la aplicación por completo y espera 2 minutos.	Genera un nuevo código dinámico; recuerda que cada código expira pronto.	App Móvil.	2 min	contacto_cpomovil@cajaoblatos.com.mx	error token, token usado, clave dinámica fallo
SOP-28	Elimine App Token	Seguridad	Descarga nuevamente la aplicación "Caja Oblatos Token".	Acude a sucursal para solicitar un nuevo código de vinculación.	INE y dispositivo.	10 min	contacto_cpomovil@cajaoblatos.com.mx	borre el token, reactivar token, nueva instalación
SOP-29	Usuario Externo: ATM no entregó efectivo	Cajeros ATM	Guarda el ticket; si no hay, anota la hora, número de cajero y ubicación.	Deberás acudir directamente a tu banco (el emisor de tu tarjeta) para iniciar el proceso de aclaración.	Según el banco emisor.	Según el banco	\N	\N
SOP-30	El Token no se vincula en automático	Seguridad	El Token no se vincula en automático debido a la falta de permisos. Cerciórate de que la App tenga todos los permisos activos.	Si el error persiste, desinstala la aplicación Token, vuelve a ingresar con tus credenciales y acepta los permisos; si falla, acude a sucursal.	App Móvil.	2 min	contacto_cpomovil@cajaoblatos.com.mx	error token, token usado, clave dinámica fallo
SOP-31	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: catalogo_vacantes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalogo_vacantes (id, puesto_titulo, area, ubicacion, descripcion, requisitos, sueldo_beneficios, contacto, status, keywords, _rowid) FROM stdin;
VAC-01	Operador de sucursal	Operativa	ZMG (Guadalajara)	Atención en ventanilla, manejo de efectivo, cobro de servicios y apoyo general en sucursal.	Bachillerato terminado, experiencia mínima de 6 meses en atención a clientes, cajera o ventas	$10,000 mensuales + aumentos salariales + vales + fondo de ahorro + becas de estudio + oportunidad de crecimiento	33 1466 7820	activa	cajero, operador, ventanilla, efectivo, banco, sucursal, atención a clientes	1
VAC-02	Gestor de Cobranza	Recuperación	Zona Foránea (Sur)	Gestión domiciliaria de cuentas vencidas, negociación de convenios y recuperación de pagos.	Recién egresado de leyes, licencia vigente, gusto por el trabajo en campo	Sueldo base +  aumentos salariales + vales + fondo de ahorro	33 1466 7820	activa	cobranza, gestor, moto, recuperación, visitas, cuentas vencidas	2
VAC-03	Generalista de Recursos Humanos	Talento	ZMG (Guadalajara)	Apoyo al área de nóminas, y actividades de RH	Licenciatura en Psicología, RH o afín, experiencia mínima de 2 años en nóminas	$15,000 mensuales + Vales + Fondo de Ahorro + Becas + Aumentos Salariales + Desarrollo y oportunidad de crecimiento	33 1466 7820	activa	recursos humanos, nominas, rh, talento humano, selección	3
VAC-04	Community Manager	Mercadotecnia	ZMG (Guadalajara)	Gestión de redes sociales, creación de contenido y atención a mensajes digitales.	Licenciatura en Mercadotecnia o afín, manejo de redes sociales, redacción, mínimo 1 año de experiencia	Sueldo competitivo + prestaciones.	33 1466 7820	activa	community manager, redes sociales, marketing digital, contenido, social media	4
\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5
\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6
\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7
\N	\N	\N	\N	 	\N	\N	\N	\N	\N	8
\.


--
-- Data for Name: descripciones_tablas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.descripciones_tablas (nombre_del_campo, tipo_de_dato, por_que_lo_necesita_el_bot, _rowid) FROM stdin;
id	Numérico / Texto	Identificador único (ej. 1, 2, 3). Sirve para que el sistema enlace esta cuenta con otras tablas sin confundirse.	1
nombre_producto	Texto	El nombre oficial que el bot mostrará al usuario (ej. "Ahorro Menores").	2
tipo_publico	Texto	Filtro Crítico. Permite al bot saber qué ofrecer si el usuario dice "soy menor de edad" o "es para mi hijo". (ej. "Menores", "Adultos/Socios").	3
monto_apertura	Moneda / Texto	Responde a la pregunta frecuente "¿cuánto cuesta abrirla?". Debe incluir el signo de pesos.	4
saldo_minimo	Moneda / Texto	Informa al usuario cuánto debe dejar en la cuenta para que no se la cancelen.	5
tasa_rendimiento	Texto	El beneficio económico. Es importante ponerlo como texto (ej. "1.50% Anual") para que el bot lo lea natural.	6
disponibilidad	Texto	Define la liquidez. El bot usará esto para diferenciar una cuenta "a la vista" de un "plazo fijo".	7
medios_acceso	Texto	Explica cómo se usa el dinero (Tarjeta, App, Ventanilla). Vital para dudas operativas.	8
requisitos_clave	Texto Largo	Lista de documentos. El bot puede extraer de aquí la respuesta a "¿qué papeles necesito?".	9
beneficio_principal	Texto Largo	El argumento de venta. Si el usuario pregunta "¿por qué me conviene?", el bot lee este campo.	10
keywords_busqueda	Texto (Separado por comas)	Inteligencia del Bot. Aquí pones sinónimos (ej. "niños, hijos, infantil, bebe") para que el bot entienda variaciones del lenguaje humano.	11
Tabla de crédito	\N	\N	12
Campo	Tipo	Función (El "Cerebro" del Bot)	13
id_credito	ID	Identificador único.	14
nombre_comercial	Texto	Nombre oficial a mostrar.	15
categoria_bot	Texto	Agrupador lógico (Consumo, Vivienda, etc.).	16
keywords	Texto	(Nuevo) Palabras clave para detectar intención del usuario.	17
beneficio_principal	Texto	(Nuevo) El "Gancho" de venta para convencer al usuario.	18
tasa_anual_fija	%	Dato para fórmula de pago mensual.	19
cat_promedio	Texto	Dato legal obligatorio.	20
plazo_max_meses	Num	Límite para el simulador.	21
monto_maximo	Texto	Límite del préstamo.	22
req_aval	Bool	Filtro duro (¿Requiere Aval? Sí/No).	23
req_garantia	Texto	Qué deja en garantía (Firma, Casa, Auto, Ahorro).	24
reciprocidad_pct	%	Cuánto ahorro debe tener antes de pedirlo.	25
perfil_cliente	Texto	Quién puede pedirlo (Socio, Empleado, Dueño).	26
Tabla de requisitos	\N	\N	27
Nombre del Campo	Tipo de Dato	Función para el Bot (Validación)	28
id_requisito	ID	Identificador único (ej. REQ-01).	29
nombre_corto	Texto	Nombre interno (ej. "INE").	30
instruccion_usuario	Texto	El guion del bot: cómo pedirlo amablemente.	31
documentos_validos	Texto	Qué papeles sirven (ej. "CFE, Telmex, Predial").	32
vigencia_maxima_meses	Numérico	Regla de caducidad (ej. 3 meses). 0 = Sin caducidad.	33
formato_aceptado	Texto	Restricción técnica (PDF, JPG, PNG).	34
es_biometrico	Bool	¿Requiere selfie o huella? (Para validación de identidad).	35
tips_error	Texto	Qué decir si el usuario falla (ej. "La foto sale borrosa").	36
Servicios y Beneficios Caja Oblatos	\N	\N	37
Nombre del Campo	Tipo de Dato	Función para el Chatbot	38
id_beneficio	ID	Identificador único (ej. BEN-01).	39
nombre_servicio	Texto	El nombre oficial (ej. "Consultorio Médico").	40
categoria_bot	Texto	Agrupador (Salud, Educación, Tecnología, Protección, Lealtad).	41
descripcion_corta	Texto	El script que el bot leerá para explicar qué es.	42
ubicacion_contacto	Texto	Datos de acción: Dirección, Teléfono o URL.	43
costo_socio	Texto	Precio o ventaja económica (ej. "Gratis", "Costo Preferencial").	44
horario_atencion	Texto	Cuándo está disponible.	45
accion_sugerida	Texto	Call to Action. ¿Qué debe proponer el bot? (Llamar, Ir al Mapa, Descargar).	46
keywords	Texto	Palabras clave para la búsqueda.	47
Tabla Promociones	\N	\N	48
Nombre del Campo	Tipo de Dato	Función para el Chatbot (Lógica de Campaña)	49
id_promo	ID	Identificador único (ej. PROM-2026-01).	50
nombre_campana	Texto	Nombre interno (ej. "Inver-Aguinaldo").	51
tipo_producto	Texto	¿A qué aplica? (Ahorro, Crédito, Inversión, Ingreso).	52
publico_objetivo	Texto	Filtro Clave: Socio (Ya existe) o Aspirante (Nuevo).	53
descripcion_hook	Texto	El "Gancho" comercial que dirá el bot.	54
condicion_activacion	Texto	Regla para ganar (ej. "Invertir más de $10,000").	55
beneficio_otorgado	Texto	El premio (Tasa extra, Regalo, 0% Comisión).	56
fecha_inicio	Fecha	Cuándo empieza a mostrarse.	57
fecha_fin	Fecha	Cuándo deja de mostrarse (Caducidad automática).	58
status	Bool	Activa / Inactiva (Interruptor manual).	59
Catalogo_Conceptos_Coop  - EDUCACION	\N	\N	60
Nombre del Campo	Tipo de Dato	Función para el Bot (NLP)	61
id_concepto	ID	Identificador (ej. EDU-01).	62
tema_principal	Texto	Concepto clave (ej. "Parte Social", "Asamblea").	63
definicion_bot	Texto	La Respuesta: Explicación sencilla, sin tecnicismos legales.	64
analogia_ejemplo	Texto	El "Como sí": Una comparación vida real para que se entienda mejor.	65
preguntas_usuario	Texto	Training Data: Qué suele preguntar la gente para activar esto.	66
nivel_complejidad	Texto	Básico (para todos) / Avanzado (para delegados).	67
Catalogo_Vacantes - RHUMANOS	\N	\N	68
Nombre del Campo	Tipo de Dato	Función para el Bot	69
id_vacante	ID	Identificador (ej. VAC-01).	70
puesto_titulo	Texto	El nombre del trabajo (ej. "Operador sucursal").	71
area_departamento	Texto	Para categorizar (Sucursal, Corporativo, Cobranza).	72
ubicacion	Texto	¿En qué ciudad o sucursal es? (Vital para filtrar).	73
descripcion_breve	Texto	1 o 2 frases de lo que hará (el "Pitch").	74
requisitos_min	Texto	Filtro rápido (ej. "Prepa terminada, Exp. 6 meses").	75
sueldo_beneficios	Texto	El gancho (ej. "Sueldo base + Bonos + Fondo Ahorro").	76
correo_contacto	Email	A dónde llega el CV específico de esa zona.	77
status	Bool	Activa / Inactiva. (Si está inactiva, el bot no la muestra).	78
keywords	Texto	Palabras clave para búsqueda.	79
\.


--
-- Data for Name: dias_inhabiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dias_inhabiles (id, fecha_inhabila, motivo_festivo, tipo_excepcion, sucursales_afectadas, hora_apertura_esp, hora_cierre_esp, alternativa_bot) FROM stdin;
FEST-01	2026-01-01 00:00:00	Año Nuevo	Cierre Total	Todas	\N	\N	"¡Feliz Año Nuevo! Las sucursales están cerradas, pero puedes usar nuestros servicios digitales."
FEST-02	2026-02-02 00:00:00	Día de la Constitución (Puente)	Cierre Total	Todas	\N	\N	"Nuestras sucursales físicas se encuentran cerradas, pero te recordamos que tu App Móvil está disponible para tus operaciones. Si necesitas efectivo, puedes disponer de él utilizando tu Tarjeta de Débito en cualquier momento. ¡Ahorra tiempo y realiza tus movimientos desde donde estés!"
FEST-03	2026-03-16 00:00:00	Natalicio Benito Juárez (Puente)	Cierre Total	Todas	\N	\N	"Nuestras sucursales físicas se encuentran cerradas, pero te recordamos que tu App Móvil está disponible para tus operaciones. Si necesitas efectivo, puedes disponer de él utilizando tu Tarjeta de Débito en cualquier momento. ¡Ahorra tiempo y realiza tus movimientos desde donde estés!"
FEST-04	2026-04-02 00:00:00	Jueves Santo	Cierre Total	Todas	\N	\N	"Nuestras sucursales físicas se encuentran cerradas, pero te recordamos que tu App Móvil está disponible para tus operaciones. Si necesitas efectivo, puedes disponer de él utilizando tu Tarjeta de Débito en cualquier momento. ¡Ahorra tiempo y realiza tus movimientos desde donde estés!"
FEST-05	2026-04-03 00:00:00	Viernes Santo	Cierre Total	Todas	\N	\N	"Nuestras sucursales físicas se encuentran cerradas, pero te recordamos que tu App Móvil está disponible para tus operaciones. Si necesitas efectivo, puedes disponer de él utilizando tu Tarjeta de Débito en cualquier momento. ¡Ahorra tiempo y realiza tus movimientos desde donde estés!"
FEST-06	2026-04-04 00:00:00	Sábado Santa	Cierre Total	todas	\N	\N	"Nuestras sucursales físicas se encuentran cerradas, pero te recordamos que tu App Móvil está disponible para tus operaciones. Si necesitas efectivo, puedes disponer de él utilizando tu Tarjeta de Débito en cualquier momento. ¡Ahorra tiempo y realiza tus movimientos desde donde estés!"
FEST-07	2026-05-01 00:00:00	Día del Trabajo	Cierre Total	Todas	\N	\N	"Nuestras sucursales físicas se encuentran cerradas, pero te recordamos que tu App Móvil está disponible para tus operaciones. Si necesitas efectivo, puedes disponer de él utilizando tu Tarjeta de Débito en cualquier momento. ¡Ahorra tiempo y realiza tus movimientos desde donde estés!"
FEST-08	2026-09-16 00:00:00	Día de la Independencia	Cierre Total	Todas	\N	\N	"¡Viva México! Hoy descansamos, pero tu App Móvil sigue trabajando para ti."
FEST-09	2026-11-02 00:00:00	Día de Muertos	Cierre Total	Todas	\N	\N	"Nuestra red de cajeros y aplicación móvil están a tu disposición."
FEST-10	2026-11-16 00:00:00	Revolución Mexicana (Puente)	Cierre Total	Todas	\N	\N	"Nuestros servicios digitales operan con normalidad."
FEST-11	2026-12-12 00:00:00	Día del Empleado Bancario	Cierre Total	Todas	\N	\N	"Por ser día del empleado bancario, no hay servicio en ventanilla. Usa la App."
FEST-12	2026-12-24 00:00:00	Nochebuena	Horario Especial	Todas	09:00:00	13:15:00	"Por ser Nochebuena, hoy laboramos en horario especial de 9:00 AM a 1:15 PM."
FEST-13	2026-12-25 00:00:00	Navidad	Cierre Total	Todas	\N	\N	"¡Feliz Navidad! Las sucursales están cerradas, pero puedes usar nuestros servicios digitales."
FEST-14	2026-12-31 00:00:00	Fin de Año	Horario Especial	Todas	09:00:00	13:15:00	"Por cierre de año, hoy laboramos en horario especial de 9:00 AM a 1:15 PM."
FEST-15	2026-05-10 00:00:00	día de la Madre	Horario Especial	Todas	08:00:00	13:15:00	"¡Feliz día Mamá!, hoy laboramos en horario especial de 8:00 AM a 1:15 PM."
\.


--
-- Data for Name: limites_transaccionales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.limites_transaccionales (id_limite, producto_servicio, canal_de_operacion, tipo_de_operacion, limite_maximo_transacciones, limite_maximo_diario, limite_maximo_mensual, observaciones_y_reglas_de_negocio) FROM stdin;
LIM-01	Tarjeta de Débito	Cajero Automático (ATM)	Retiro de Efectivo	Máximo 10 eventos diarios (Límite global del plástico)	$10,200.00 MXN	$306,000.00 MXN	El monto máximo incluye obligatoriamente las comisiones por operaciones en RED del banco operador. Se requiere saldo disponible y liberado en la cuenta de Ahorro Débito; no se otorgan sobregiros automáticos. El ciclo se renueva cada 24 horas.
LIM-02	Tarjeta de Débito	Terminal (TPV) / E-commerce	Compras y Pagos	Máximo 10 eventos diarios (Límite global del plástico)	$10,200.00 MXN	Sin tope (sujeto a saldo)	Para compras en línea requiere el CVV dinámico desde la App. El sistema rechazará transacciones posteriores al alcanzar el monto o los 10 eventos diarios. Sin sobregiros automáticos. Ciclo de renovación de 24 horas.
LIM-03	Caja Oblatos Móvil	Banca Móvil	Transferencia SPEI	Sujeto a acumulado diario	$350,000.00 MXN	$750,000.00 MXN	Requiere obligatoriamente tener la cuenta CLABE registrada previamente en la aplicación.
LIM-04	Caja Oblatos Móvil	Banca Móvil	Envío DIMO	Sujeto a acumulado diario	$12,514.67 MXN	$24,000.00 MXN	Límite normativo al vincular con el número de teléfono celular a través de la aplicación oficial de Caja Oblatos.
LIM-05	Caja Oblatos Móvil	Banca Móvil	Transferencias entre cuentas propias	Sujeto a acumulado diario	$200,000.00 MXN	Sujeto a saldo	Permite mover fondos de forma inmediata entre cuentas del mismo titular.
LIM-06	Caja Oblatos Móvil	Banca Móvil	Transferencias a cuentas de otro socio (tercero)	Sujeto a acumulado diario	$200,000.00 MXN	Sujeto a saldo	Requiere el registro y validación previa de la cuenta del tercero en la aplicación móvil.
LIM-07	Caja Oblatos Móvil	Banca Móvil	Pago de servicios	Sujeto a acumulado diario	$2,500.00 MXN	Sujeto a saldo	Límite máximo acumulado por día para la liquidación de convenios vigentes (luz, agua, teléfono, etc.).
LIM-08	Caja Oblatos Móvil	Banca Móvil	Compra de tiempo aire	Sujeto a acumulado diario	$1,000.00 MXN	Sujeto a saldo	Límite máximo autorizado de $500.00 MXN por operación individual, hasta alcanzar el tope acumulado diario.
\.


--
-- Data for Name: tabla_ahorro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabla_ahorro (id, nombre_producto, tipo_publico, monto_apertura, saldo_minimo, tasa_rendimiento, disponibilidad, medios_acceso, requisitos_clave, beneficio_principal, keywords) FROM stdin;
AH01	Ahorro Ordinario	Adultos (Socios)	50	1	1.50% Anual	Trámite de retiro	Ventanilla	Ser Socio con Parte Social completa.	Ofrece rendimientos, acceso a promociones anuales y préstamos; incluye Servicio de Protección al Ahorro y PROFUN (bajo cumplimiento de requisitos).	ahorro socio, cuenta base, garantia credito, profun
AH02	Ahorro Débito	Adultos (Socios)	50	1	1.00% Anual	Inmediata	Ventanilla, Tarjeta y App Móvil.	Ser Socio con Parte Social completa; contratación presencial en sucursal.	Acceso total a ecosistema digital: App móvil, Tarjeta Carnet, SPEI, DIMO, compras en línea y retiros en cajeros.	tarjeta débito, banca móvil, compras internet, dimo
AH03	Ahorro Menores	Niños (1 a 17 años)	50	1	1.50% Anual	Restringida (Tutor)	Ventanilla (solo tutor)	Acta de Nacimiento e Identificación oficial del Padre/Tutor.	Fomenta el hábito del ahorro desde la infancia con rendimientos y sin cobro de comisiones.	ahorro niños, cuenta infantil, kids coop, menor
AH04	Parte Social	Aspirante mayor de edad	1000	1000	0	Trámite de retiro	Ventanilla	IDENTIFICACIÓN OFICIAL, ACTA DE NACIMIENTO, CURP, COMPROBANTE DE DOMICILIO	Adquirir los derechos de socio de la cooperativa, utilización de servicios, beneficios y protecciones.	parte social, certificado, ser socio, capital social
AH05	Ahorro fondo solidario	Adultos (Socios)	150	100	0	Trámite de retiro	Ventanilla	Ser Socio con Parte Social completa.	Una mutualidad de protección de seguro de vida con fondo solidario es una forma de previsión social sin fines de lucro, basada en la cooperación mutua.	Fondo solidario, seguro de vida.
\.


--
-- Data for Name: tabla_atm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabla_atm (id_cajero, descripcion_atm, tipo, domicilio, no_exterior, colonia, estado, municipio, ciudad, c_p, geolocalizacion, tiene_sucursal_asignada, sucursal, estatus, opera_las_24_hrs, monto_minimo_operacion, costo_consulta_saldo, costo_retiro_nacional, incluir_retiro_internacional, costo_retiro_internacional, servicios, idioma, accesibilidad, locacion_espacio_geografico, abierto_al_publico) FROM stdin;
XC010101	Matriz	Cajero dispensador	Calz Juan Pablo II	2015	Oblatos	Jalisco	Guadalajara	Guadalajara	44700	20.695566527644, -103.3021355835	SI	Matriz	Activo	si	50	14 + iva	20 + iva	si	20 + iva	consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente	español / inglés	Rampa de acceso externa, Acceso con silla de ruedas	Con acceso independiente a sucursal	si
XC010102	Matriz multifuncional	Cajero dispensador/receptor	Calz Juan Pablo II	2015	Oblatos	Jalisco	Guadalajara	Guadalajara	44700	20.695566527644, -103.3021355835	SI	Matriz	Activo	si	50	14 + iva	20 + iva	si	20 + iva	consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente	español / inglés	Rampa de acceso externa, Acceso con silla de ruedas	Con acceso independiente a sucursal	si
XC010201	Joaquin amaro	Cajero dispensador	Av Joaquin amaro	2179	santa cecilia	Jalisco	Guadalajara	Guadalajara	44700	20.70255197709, -103.292208097536	SI	Joaquin amaro	Activo	si	50	14 + iva	20 + iva	si	20 + iva	consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente	español / inglés	Rampa de acceso externa, Acceso con silla de ruedas	Con acceso independiente a sucursal	si
XC010301	C.B.A.	Cajero dispensador	Constitución Entre Hidalgo e Ignacio Romo	7 A	Centro	Jalisco	Concepcion de Buenos Aires	Concepcion de Buenos aires	49170	19.9792251, -103.2601463	NO	\N	Activo	si	50	14 + iva	20 + iva	si	20 + iva	consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente	español / inglés	Rampa de acceso externa, Acceso con silla de ruedas	Con acceso independiente a sucursal	si
XC010401	Mazamitla	Cajero dispensador	Portales de Reforma	12	Centro	Jalisco	Mazamitla	Mazamitla	49500	19.9162359291296, -103.020100352327	NO	\N	Activo	si	50	14 + iva	20 + iva	si	20 + iva	consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente	español / inglés	Rampa de acceso externa, Acceso con silla de ruedas	Con acceso independiente a sucursal	si
XC010501	Ixtlahuacan del Rio	Cajero dispensador	calle independencia	48	centro	Jalisco	Ixtlahuacán del Río	Ixtlahuacán del Río	45270	20.862684158145, -103.2388607949489	SI	Ixtlahuacán del Río	Activo	si	50	14 + iva	20 + iva	si	20 + iva	consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente	español / inglés	Rampa de acceso externa, Acceso con silla de ruedas	Con acceso independiente a sucursal	si
XC010601	Concordia	Cajero dispensador	Calle Vicente Guerrero	9	centro	Sinaloa	Concordia	Concordia	82600	23.2879129, -106.0675429	NO	\N	Activo	si	50	14 + iva	20 + iva	si	20 + iva	consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente	español / inglés	Rampa de acceso externa, Acceso con silla de ruedas	Con acceso independiente a sucursal	si
XC010801	Cuquio	Cajero dispensador	Calle Aldama	40-b	centro	Jalisco	Cuquio	Cuquio	45480	20.9306226, -103.0243503	SI	Cuquio	Activo	si	50	14 + iva	20 + iva	si	20 + iva	consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente	español / inglés	Rampa de acceso externa, Acceso con silla de ruedas	Con acceso independiente a sucursal	si
XC010901	Salvador Hinojosa	Cajero dispensador	Calle Salvador Hinojosa 	23	Nueva Central Camionera	Jalisco	Tonala	Tonala	45400	20.6190897, -103.2819408	NO	\N	Activo	si	50	14 + iva	20 + iva	si	20 + iva	consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente	español / inglés	Rampa de acceso externa, Acceso con silla de ruedas	Con acceso independiente a sucursal	no
XC011001	Santo Santiago	Cajero dispensador	Calle Zaragoza	84	Centro	Jalisco	Tonala	Tonala	45400	20.623261, -103.2434328	SI	Santo Santiago	Activo	si	50	14 + iva	20 + iva	si	20 + iva	consulta de saldo, retiro con tarjeta, cambio de NIP, compra de tiempo Aire socio o cliente	español / inglés	Rampa de acceso externa, Acceso con silla de ruedas	Con acceso independiente a sucursal	si
\.


--
-- Data for Name: tabla_horarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabla_horarios (id_horario, descripcion, dias_semana, hora_apertura, hora_cierre, dias_sabado, hora_apertura_sab, hora_cierre_sab, zona_horaria, aplica_a_ejemplos) FROM stdin;
HOR-01	Estándar ZMG/Foraneo	Lun-Vie	09:00:00	18:15:00	Sábado	08:00:00	13:15:00	UTC-6	Zapopan, Tonalá, Tlaquepaque, Tlajomulco de zuñiga, Zona Mazamitla, Zona Ixtlahuacan, Zona los Altos, Zona el Salto, Servicio médicos
HOR-02	Horario Matriz	Lun-Vie	09:00:00	18:15:00	Sábado-Domingo	08:00:00	13:15:00	UTC-6	Sucursal Matriz
HOR-03	Horario Sinaloa	Lun-Vie	09:00:00	18:15:00	Sábado	08:00:00	13:15:00	UTC-7	Zona Norte, Zona Noroeste
\.


--
-- Data for Name: tabla_promociones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabla_promociones (id, nombre_campana, tipo, publico, descripcion_hook, condicion, beneficio, vigencia, status) FROM stdin;
PROM-01	Socios Coop	Ingreso	Aspirante	"¡Únete a la familia Oblatos! Regístrate hoy y recibe un obsequio especial para ti y para quien te recomendó."	Alta en sucursal.	Obsequio para socio y recomendado al completar su parte social $1,000 pesos 	Permanente	Activa
PROM-02	Kids Coop	Ingreso	Menores	"¡Inicia el hábito del ahorro! Regístrate como Ahorrador Menor y llévate un regalo de bienvenida."	Alta en sucursal.	Obsequio para socio y ahorrador menor recomendado.	Permanente	Activa
PROM-03	Socios Oro	Registro	Socios	"¡Premiamos tu lealtad! Regístrate y obtén un obsequio especial al realizar nuestras dinámicas cooperativas."	Registro y capacitación cooperativa.	Obsequio especial de lealtad.	Permanente	Activa
PROM-04	Invierte y Gana	Inversión	Socios	"¡Haz crecer tu dinero! Invierte a plazo fijo y llévate premios increíbles según tu inversión."	Contrata tu inversión en plazos de 90, 180 y 360 días; el obsequio se asignará según el monto de tu inversión.	Obsequio según monto y plazo. Consulta  el catálogo de premios en sucursal.	Permanente	Activa
PROM-05	Ahorro Navideño	Depósito	Socios	"¡Prepara tu Navidad! Ahorra con anticipación y llévate un fabuloso obsequio para las fiestas."	Deposita la cantidad marcada en el juguete exhibido en nuestra sucursal y llévatelo gratis.	Obsequio navideño en sucursal.	Temporada	Pausa
PROM-06	Despensa Socio Cumplido	Crédito	Socios	"¡Tu puntualidad tiene recompensa! Recibe una despensa al liquidar tu crédito puntualmente."	Pago puntual del crédito y un ahorro de $200 al mes durante toda la vigencia del mismo.	Despensa al liquidar el crédito.	Permanente	Activa
PROM-07	Incrementa y Gana	Ahorro	Socios	"¡Tu ahorro rinde más! Incrementa tu saldo y gana obsequios por cada meta alcanzada."	Incremento mínimo de $5,000 en ahorro ordinario.	Obsequio por cada incremento.	Permanente	Activa
PROM-08	Credi Premia	Crédito	Socios	"¡Estrena y gana! Solicita tu crédito desde $15,000 y recibe un regalo de acuerdo al monto."	Crédito mayor a $15,000.	Obsequio según monto autorizado.	Permanente	Activa
PROM-10	Educacoop	Ingreso	Escuelas	"Apoyamos el crecimiento de tu escuela con equipo, materiales y tecnología para tus alumnos."	Alianza institucional y charlas informativas.	Apoyo en especie a institución educativa con alianza.	Permanente	Activa
PROM-11	Ahorro Escolar	Registro	Menores	"¡Prepárate para el regreso a clases! Ahorra mensualmente y obtén tu paquete de útiles."	Inscripciones en septiembre de cada año. Ahorro mínimo de $80 mensuales hasta la entrega.	Paquete de útiles escolares (Entrega en julio de cada ciclo).	Permanente	Activa
PROM-13	Guardianes del Ahorro	Ahorro	Menores	"Conviértete en un Guardián del Ahorro y participa por un viaje todo pagado a Six Flags".	La promoción es válida únicamente para ahorradores menores registrados en Caja Oblatos que tengan entre 6 y 17 años cumplidos al momento del registro.	Al completar la planilla, los ahorradores menores obtendrán un regalo especial y podrán participar en la rifa por fabulosos premios, incluyendo un viaje para el menor y un acompañante a Six Flags.	Del 13 de Julio al 14 de Noviembre del 2026	Activa
PROM-12	Becacoop	Registro	Socios y menores estudiantes	"¡Financiamos tus metas! Inscribete y participa para obtener una beca económica para tus estudios, sujeta a autorización."	Antigüedad de 1 año (Socio/Menor); sujeto a autorización del Consejo de Administración.	Apoyo económico estudiantil.	Temporada	Activa
PROM-14	Credimás Agua Premia	Crédito	Socios	Llévate un obsequio con tu crédito autorizado y participa en un sorteo bimestral de grandes premios.	•\tContar con su parte social completa. •\tEstar al corriente en sus préstamos, en caso de tenerlos. •\tHaber solicitado y recibido la autorización de un crédito destinado a proyectos relacionados con el acceso, saneamiento o abastecimiento de agua.	Los socios participantes que comprueben cualquiera de los destinos antes mencionados recibirán un obsequio especial, sujeto a existencia. Además, participarán en un sorteo bimestral de premios especiales.	Temporada	Activa
PROM-15	Feria del crédito	Crédito	Socios	Créditos con condiciones especiales durante la promoción 	Requisitos: -Calificación en Buró de Crédito (BC SCORE) mayor a 640. -Ingresos oficialmente comprobables. -Antigüedad laboral mínima de 6 meses. -Arraigo domiciliario mínimo de 12 meses.	Créditos sin aval: aplican los créditos Ordinario, Credi Socio Cumplido, Credi Auto Comercial y de Consumo, Credi Solar, Credi Comercio, Credi Aliado y Credi Más Agua, cumpliendo con las bases y requisitos.	Temporada	Activa
\.


--
-- Data for Name: tabla_protecciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabla_protecciones (id, nombre_oficial, tipo_riesgo, monto_cobertura, condicion_activacion, costo_socio, beneficiarios, keywords, restricciones, requisitos) FROM stdin;
PROT-01	Protección al Ahorro	AHORRO	Al fallecimiento del socio, se duplica la cantidad de su ahorro hasta $80,000 MXN.	Socio al corriente + Antigüedad min.	Gratuito 	Beneficiarios designados	seguro, protección al ahorro	Tener cubiertas sus partes sociales y una antigüedad de al menos 3 meses como socio, para los socios que ingresen a la cooperativa con 70 años de edad o más, será requisito indispensable contar con una antigüedad mínima de 2 años como socio. Esta protección se aplicará siempre y cuando el socio no haya interrumpido sus ahorros durante los últimos 6 meses inmediatos anteriores a su fallecimiento. Asimismo, el socio no deberá haber realizado retiros de sus ahorros, en ese mismo periodo de 6 meses. En los casos de ahorro anticipado, la restricción de retiros se extiende a los últimos 12 meses anteriores al deceso. No se considerarán como depósitos de ahorro los descuentos de tasa de interés derivados de préstamos. El ahorro anticipado deberá constituirse previo a la entrega de cualquier préstamo y cubrirá un periodo de un año. Al momento del deceso, se auditarán los movimientos: si se detectan depósitos que superen los promedios habituales del socio, dichos montos no se tomarán en cuenta para la protección. Si se identifican depósitos mayores a los ordinarios realizados con el fin de alcanzar montos específicos para solicitudes de crédito, la protección no se pagará sobre el saldo final, sino únicamente sobre el saldo registrado antes de dicho depósito atípico. Tampoco se considerarán los ahorros efectuados para participar en promociones u obtener beneficios adicionales. La protección quedará anulada si se detecta que el socio omitió informar a la institución sobre una enfermedad terminal preexistente. *Nota: Se entiende por enfermedad terminal: VIH (SIDA), CÁNCER (manifestación de tumor maligno con capacidad de infiltrar y causar metástasis, incluyendo leucemia y la enfermedad de Hodgkin), Hepatitis C y Cirrosis Hepática.	REQ-01,REQ-02,REQ-29,REQ-10, REQ-30,REQ-31,REQ-32,REQ-34,REQ-35,REQ-36,REQ-37.
PROT-02	Protección Funeraria (PROFUN)	FALLECIMIENTO	Servicio funerario completo con las funerarias en convenio.	Socio al corriente + Antigüedad min.	Gratuito 	El Socio (Titular)	funeral, fallecimiento, velatorio, entierro	Para ser beneficiario de este servicio, es indispensable contar con una antigüedad de al menos 3 meses como socio y tener la Parte Social totalmente cubierta; asimismo, se requiere haber cumplido puntualmente con los abonos de su crédito, en caso de haberlo tenido, durante los 6 meses anteriores, mantener constancia en su ahorro en los últimos 6 meses y no haber realizado retiros de su cuenta en los últimos 6 meses.	REQ-01, REQ-31.
PROT-03	Fondo Solidario	FALLECIMIENTO	Apoyo económico (monto variable).	Socio vigente + Antigüedad min 2 años.	Contratación de $150; se descuentan $5 por cada fallecimiento de socio participante.	Beneficiarios Designados	ayuda, dinero familia, muerte, beneficiario	En el caso de los socios que ingresan con una edad de 70 años en adelante, será requisito indispensable tener una antigüedad de al menos 2 años como socio y 1 año perteneciendo al Fondo Solidario; asimismo, su saldo en la cuenta de ahorro de dicho fondo no deberá de ser menor a $100.00 MXN.	REQ-01,REQ-33, REQ-29
PROT-04	Protección al préstamo	CRÉDITO	Se libera del adeudo del socio por el saldo insoluto de hasta $400,000.	Fallecimiento del titular del crédito.	Aplicación de factor según el tipo de crédito.	Beneficiarios Designados	deuda muerte, saldo insoluto, perdón deuda	Esta protección se cubrirá siempre y cuando el socio no haya dejado de abonar durante los últimos 6 meses inmediatos anteriores a su fallecimiento; no obstante, los préstamos a un solo pago deberán ser cubiertos exactamente en las condiciones pactadas, ya que un solo día de atraso generará la pérdida de esta protección. Es importante notificar inmediatamente el deceso de cualquier socio, ya que los intereses generados a la fecha de entrega de la documentación completa deberán estar cubiertos para tener derecho al beneficio. En el caso de los préstamos superiores a $400,000.00, se deberá contratar un seguro de vida adicional por el excedente, a nombre del acreditado y/o su cónyuge, quedando como beneficiario en primer término Caja Popular Oblatos, S.C. de A.P. de R.L. de C.V., a excepción de los créditos Agropecuario y Credi-Auto (Consumo, Comercial).  Asimismo, la protección quedará anulada si se detecta que el socio omitió informar sobre una enfermedad terminal preexistente. * Entiéndase por enfermedad terminal: VIH (SIDA), CÁNCER (entiéndase por cáncer manifestación de tumor maligno, tumores con capacidad de infiltrar y causar metástasis, incluyendo leucemia y la enfermedad de Hodgkin), Hepatitis C y Cirrosis Hepática.	REQ-01,REQ-02,REQ-29,REQ-10, REQ-30,REQ-31,REQ-32,REQ-34,REQ-35,REQ-36,REQ-37.
PROT-05	Protección al Ahorro de Menores	AHORRO	Se duplica el ahorro del menor (hasta $30,000 MXN).	Menor activo + 6 meses de ahorro constante.	Gratuito 	Tutor 	seguro, ahorro niños, fallecimiento menor	Esta protección se cubrirá siempre y cuando el ahorrador menor no haya dejado de ahorrar en los últimos 6 meses anteriores inmediatos a su fallecimiento, teniendo la salvedad de una sola falla en el ahorro mensual; asimismo, se requiere que el ahorrador menor no haya realizado retiros de su cuenta durante ese mismo periodo. En el caso de que el saldo sea mayor a $30,000.00, el excedente se le entregará a los beneficiarios sin el pago de protección. La protección quedará anulada si se detecta que el ahorrador menor y/o su tutor omitieron informar a la institución sobre una enfermedad terminal preexistente. * Entiéndase por enfermedad terminal: VIH (SIDA), CÁNCER (entiéndase por cáncer manifestación de tumor maligno, tumores con capacidad de infiltrar y causar metástasis, incluyendo leucemia y la enfermedad de Hodgkin), Hepatitis C y Cirrosis Hepática	REQ-29,REQ-10,REQ-02,REQ-30,REQ-31,REQ-36,REQ-37.
\.


--
-- Data for Name: tabla_requisitos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabla_requisitos (id, nombre_corto, instruccion_usuario, documentos_validos, vigencia_meses, formato, tips_error, _rowid) FROM stdin;
REQ-01	Identificación	Por favor, tu Identificación Oficial por ambos lados.	INE, Pasaporte, cédula profesional, Cartilla de servicio militar, Matrícula consular, Licencia de conducir, Tarjeta única de identidad militar, Identificación del INAPAM y Carta de Identidad expedida por correos y Tarjeta expedida por el Instituto Mexicano del Seguro Social.	0	JPG/PNG/IMG	El documento debe estar vigente y legible	1
REQ-02	Comp. Domicilio	Necesitamos un comprobante de tu domicilio actual, no mayor a 90 días	Recibo de Luz, telefonía, servicio de televisión por cable, recibos de gas natural, suministro de agua. Se podrán recibir Estados de cuenta bancarios y de tiendas departamentales siempre y cuando estén a nombre del solicitante o aval, así mismo se podrá aceptar carta expedida de la autoridad competente.	3	PDF/IMG	El documento debe estar vigente y legible	2
REQ-03	CURP	Sube tu constancia de CURP (formato nuevo).	Formato oficial RENAPO (QR).	0	PDF	Si no la tienes, descárgala gratis en gob.mx/curp	3
REQ-04	Acta Nacimiento	Sube una foto o PDF de tu Acta de Nacimiento.	Copia Acta de Nacimiento o del Certificado de Nacimiento.	0	PDF/IMG	Debe ser legible y no estar rota o manchada.	4
REQ-05	Comprobante Ingresos	Necesitamos validar cuánto ganas. Sube tus recibos, en su caso	Recibos de Nómina no timbradas, Carta de ingresos en hoja membretada, firmada y sellada que contenga número telefónico de la empresa, Notas foliadas y selladas.	2	PDF	Sube los últimos de 60 días (2 meses completos).	5
REQ-06	Acta Matrimonio	Si estás casado(a), requerimos tu Acta de Matrimonio.	Copia certificada Registro Civil.	0	PDF/IMG	Requerida si tu cónyuge firmará como aval.	6
REQ-07	Buró de Crédito	Autorización para consultar tu Historial Crediticio.	Formato de Consulta firmado.	1	PDF	Firma igual que en tu INE para que proceda.	7
REQ-08	Aval	Identificación y datos de tu Aval (Obligado Solidario).	Identificación del Aval + Comprobante de Domicilio del Aval + Predial del Aval en caso de no ser Socio o documento que acredite propiedad de manera oficial	3	IMG	El aval puede ser socio o no socio de la Cooperativa	8
REQ-09	Cotización	Sube la cotización formal de lo que vas a comprar.	Hoja membretada Agencia/Proveedor.	1	PDF	Debe incluir IVA y datos fiscales del proveedor.	9
REQ-10	Acta de Nacimiento en Copia Certificada	Copia Certificada  (socio y beneficiario)	Acta de Nacimiento en Copia Certificada.	3	Impreso	No se aceptan copias simples.	10
REQ-11	Selfie (Liveness)	Tómate una selfie ahora mismo para validar que eres tú.	Foto en vivo (Cámara).	0	JPG	Sin lentes, sin gorra y con buena luz.	11
REQ-12	Carta de Vo. Bo. por la empresa	Si tu empresa tiene convenio con Caja Oblatos, solicita la carta a recursos humanos de tu empresa.	Carta firmada por la persona que firmó el convenio o quien realice la función de administración de Recursos Humanos	1	IMG	Asegurate que la carta contenga firma y tu nombre completo y correcto	12
REQ-13	Predial a nombre del solicitante o cónyuge	Necesitamos un comprobante de tu predial actual, del año en curso	Recibo de pago del predial o documento que acredite propiedad	0	IMG	El predial deber ser del año en curso	13
REQ-14	Licencia Municipal	Necesitamos un comprobante permiso de giro actual, del año en curso	Licencia municipal o permiso de giro comercial	0	IMG	Asegurarse de que sea del año en curso	14
REQ-15	Constancia de Situación Fiscal	Necesitamos validar el giro comercial ante el SAT	Cédula de identificación o constancia de situación fiscal	1	IMG	En donde el registro de la actividad coincida con el destino del crédito	15
REQ-16	Escrituras	Se necesita validar que las escrituras estén debidamente registradas	Escritura pública debidamente registrada en el Registro Público de la Propiedad o segundo testimonio	0	IMG	Las últimas escrituras y sus antecedentes	16
REQ-17	Certificado de NO Adeudo Catastro	Se necesita validar que no se tenga adeudo en las oficinas de catastro municipal	Certificado de no adeudo	1	IMG	Reciente y sin errores con respecto al domicilio	17
REQ-18	Recibo Agua Potable	Comprobaremos el registro ante la dependencia que dota el agua potable	Recibo de sistema intermunicipal de agua potable pagado	3	IMG	Reciente y sin adeudos	18
REQ-19	Certificado de NO Adeudo Agua Potable	Comprobaremos que no se tiene adeudo en el servicio intermunicipal de agua potable	Certificado de no adeudo	1	IMG	Reciente y sin errores con respecto al domicilio	19
REQ-20	Avalúo Comercial	Comprobaremos las medidas y colindancias así como el valor comercial del bien inmueble	Peritaje de avalúo comercial	6	IMG	Realizado por perito registrado ante la municipalidad	20
REQ-21	Certificado de libertad de gravamen	Necesitamos validar que el bien inmueble se encuentre libre de gravamen	Certificado de existencia o inexistencia de gravamen	1	IMG	Libre para compra o liquidez o gravado para traslado de hipoteca	21
REQ-22	Comprobante de actividad primaria	Necesitamos validar la actividad a financiar por el destino del crédito	Comprobante de actividad agrícola, ganadera, pesca o silvicultura	0	IMG	Debe estar a nombre del titular del crédito	22
REQ-23	Comprobante de la actividad económica	Necesitamos validar la actividad a financiar por el destino del crédito	Documento que acredite la actividad comercial, productiva, servicios o de transformación	0	IMG	Debe estar a nombre del titular del crédito	23
REQ-24	Constancia de trabajo	Se requiere validar la antigüedad, el tipo de contrato y sueldo que se percibe	Carta laboral o constancia de empleo	1	IMG	Reciente y al menos debe tener 6 meses en el empleo	24
REQ-25	Promesa o Contrato de compra-venta	Se requiere promesa formal de la compraventa y transmisión patrominial	Contrato de compraventa simple o notariado	0	IMG	Se debe especificar claramente las condiciones de la compraventa	25
REQ-26	Dictamen de viabilidad, para sistemas de agua	Se requiere validar la viabilidad otorgada para la instalación del sistema de captación de agua	Dictamen del sistema intermunicipal de agua potable	3	IMG	Debe ser positivo para la viabilidad de la instalación de los equipos	26
REQ-27	Declaraciones anuales del SAT	Se requiere verificar que se realizan las declaraciones ante el SAT y de estas, los ingresos y gastos declarados	Declaraciones anuales del SAT	0	IMG	Las más recientes	27
REQ-28	Garante Hipotecario	Identificación y datos de tu Aval Hipotecario.	Identificación + Comprobante de Domicilio + Datos y Documentos de la Garantía Hipotecaria	0	IMG	Los documentos deben ser legibles y vigentes	28
REQ-28	Predial	Necesitamos un comprobante de tu predial actual, del año en curso	Recibo de pago del predial o documento que acredite propiedad	0	IMG	El predial deber ser del año en curso	29
REQ-29	Acta de Defunción	Acta de Defunción en Copia Certificada	Acta de Defunción en Copia Certificada	6	Impreso	Los documentos deben ser legibles y vigentes	30
REQ-30	 Acta de Ministerio Público	 En caso de muerte accidental, violenta u homicidio	 Acta de Ministerio Público	6	Impreso	Los documentos deben ser legibles y vigentes	31
REQ-31	Tarjeta plástica o Libreta de socio 	Presenta tu identificación de la cooperativa.	Presenta tu identificación de la cooperativa.	\N	Medio físico	Los documentos deben ser legibles y vigentes	32
REQ-32	Tarjeta de débito 	Presenta tu tarjeta de la cooperativa.	Presenta tu tarjeta de la cooperativa.	\N	Impreso	Los documentos deben ser legibles y vigentes	33
REQ-33	Contrato de Fondo Solidario	Presenta tu contrato de fondo solidario.	Presenta tu contrato de fondo solidario.	\N	Impreso	Los documentos deben ser legibles y vigentes	34
REQ-34	Contrato de Inversión	Presenta tu contrato de inversión.	Presenta tu contrato de inversión.	\N	Impreso	Los documentos deben ser legibles y vigentes	35
REQ-35	 Boleta de Credi Prenda	Presenta tu boleta de empeño.	Presenta tu boleta de empeño.	\N	Impreso	Los documentos deben ser legibles y vigentes	36
REQ-36	Certificado Médico de Defunción.	Certificado Médico de Defunción.	Certificado Médico de Defunción.	6	Impreso	Los documentos deben ser legibles y vigentes	37
REQ-37	Parte Médico.	Solo en enfermedades terminales.	Solo en enfermedades terminales.	6	Impreso	Los documentos deben ser legibles y vigentes	38
REQ-38	Cotización de póliza de seguro	Cotización de seguro	Cotización por aseguradora	1	Impreso	Los documentos deben ser legibles y vigentes	39
REQ-39	Comprobante de ingresos oficial	Necesitamos validar cuánto ganas. Sube tus recibos oficiales.	Recibos de Nómina (PDF), Declaración de ingresos/gastos, Estado de Cuenta Bancario o declaraciones ante el sat y pago de honorarios	6	Impreso	Los documentos deben ser legibles y vigentes	40
\.


--
-- Data for Name: tabla_servicios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabla_servicios (id, nombre_servicio, categoria_bot, descripcion_corta, ubicacion_contacto, costo_socio, requisitos, accion_sugerida, keywords) FROM stdin;
Serv_1	Servicios Médicos	Salud y Bienestar	Consultas en Ginecología, Pediatría, Nutrición y Medicina General exclusivas para socios.	Hacienda Santiago #2020. Citas: 33-3637-6447	Variable según la especialidad.	Ser socio y presentar identificación oficial vigente (INE).	"Llamar para agendar cita médica"	doctor, medico, salud, ginecólogo, pediatra, cita
Serv_2	App Móvil	Servicios Digitales	Consulta saldos, transfiere, paga servicios y accede a tu tarjeta digital 24/7.	PlayStore / AppStore	Uso sin costo (algunos servicios aplican comisión).	Ser socio, cuenta de débito activa, INE y activar App Token en sucursal.	Link: Descarga Caja Oblatos Móvil	app, aplicacion, celular, móvil, saldo, banca
Serv_3	SPEI	Servicios Digitales	Transferencias electrónicas en tiempo real a cualquier banco, disponibles los 365 días del año.	App Móvil / Banca en línea.	$5.80 por envío.	Tener activa la aplicación Caja Oblatos Móvil y el Token.	Link: Realizar transferencia SPEI	spei, transferencia, banco, depósito, clabe
Serv_4	Talleres Culturales	Educación	Clases de baile, inglés, música, pintura y computación para toda la familia.	Hacienda Santiago #2020. Citas: 33-3637-6447	Variable según el taller.	Ser socio o ahorrador menor y presentar identificación vigente.	"Ver catálogo de talleres"	taller, curso, inglés, baile, danza, aprender
Serv_5	Cajeros Automáticos	Tecnología	Red de cajeros (ATM) para retiro de efectivo sin comisiones con tu tarjeta Oblatos.	Red de sucursales y puntos estratégicos.	Sin comisión con Tarjeta Oblatos. Otras: $16 - $20 + IVA.	Contar con tarjeta de débito activa y NIP de seguridad.	"Ver cajero más cercano"	cajero, retiro, efectivo, dinero, atm
Serv_6	Pago de Servicios	Servicios Digitales	Pago de luz (CFE), teléfono, cable y recargas de tiempo aire desde tu celular.	App Caja Oblatos Móvil	Pago servicio: $8.00. Recargas: Sin costo.	Tener activa la aplicación Caja Oblatos Móvil y el Token.	"Ir a Compras y Pagos"	luz, cfe, telmex, recarga, saldo, pagar
Serv_7	Seguros	Protección y Seguridad	Protección para auto, moto, vida y hogar con aseguradoras aliadas (GNP, Mapfre).	Cotización en Sucursal.	Según póliza cotizada.	Ser socio y presentar identificación oficial vigente (INE).	"Solicitar cotización"	seguro, auto, choque, póliza, asegurar
Serv_9	Tarjeta de Débito	Medios de Pago	Acceso inmediato a tu dinero para compras en comercios, internet (CVV Digital) y cajeros.	Todas las Sucursales.	Apertura/Reposición: $50.00 pesos.	Ser socio y contar con una cuenta de ahorro activa.	"Ver beneficios de mi tarjeta"	compras, tpv, e-commerce, débito, tarjeta fisica
Serv_10	DIMO	Servicios Digitales	Envía y recibe dinero usando solo el número de celular vinculado a tu cuenta.	App Caja Oblatos Móvil.	$5.80 por envío.	Tener activa la aplicación Caja Oblatos Móvil y registro en DIMO.	 "Configurar DIMO ahora"	dimo, transferencia celular, número, banco
Serv_11	Aclaraciones (UNE)	Soporte Técnico	Atención especializada para consultas, quejas o reclamaciones de servicios financieros.	Sucursales de Caja Oblatos o correos de contactos de representantes regionales a tráves de: https://cajaoblatos.com.mx/attachments/article/18/UNE.pdf	Improcedentes: $250 + IVA.	Ser socio y presentar identificación oficial vigente (INE).	"Ver horarios de atención"	aclaración, queja, sugerencia, une, fallo
Serv_12	Remesas directo a Cuenta	Servicios Digitales	Recibe dinero de EUA y Canadá directamente en tu cuenta de ahorro sin ir a sucursal.	App Móvil (Menú Recibe Dinero EUA).	Sin costo de recepción.	Tener activa la aplicación móvil y cuenta relacionada al servicio.	"Activar recepción de remesas"	remesas, app, eua, canadá, xoro, depositar
Serv_13	Remesas pago en ventanilla	Servicios Digitales	Recibe dinero de EUA y Canadá en sucursal.	Todas las Sucursales.	Sin costo de recepción.	Ser socio y presentar identificación oficial vigente (INE).	\N	remesas, app, eua, canadá
\.


--
-- Data for Name: tabla_sucursales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabla_sucursales (id, nombre_sucursal, calle, colonia, ciudad, cp, telefono, geolocalizacion, estado, id_cajero, id_horario) FROM stdin;
SUC-01	Matriz	Calz. Juan Pablo II 2015	 Oblatos	Guadalajara	44700	3339421050	20.6956158016175, -103.302040100098	Activo	XC010101, XC010102	HOR-02
SUC-02	Tuxpan	Querétaro Norte No. 20	 Centro	Tuxpan	63207	3192320573	20.6038088564415, -100.410985518677	Activo	no	HOR-03
SUC-03	Servicios Médicos, educativos y culturales	Hacienda Santiago No. 2020	 Oblatos	Guadalajara	44700	3336376447	20.6931618536508, -103.30143392086	Activo	no	HOR-01
SUC-04	Agua Blanca	Vicente Guerrero No. 112	Agua Blanca Industrial	Zapopan	45235	3336845767	20.6038088564415, -100.410985518677	Activo	no	HOR-01
SUC-05	Aguascalientes	Blvd. Siglo XXI No. 5235	 Hacienda de Aguascalientes	Aguascalientes	20196	4499932647 y Fax 4499932284	21.8852933, -102.2506397	Activo	no	HOR-01
SUC-06	Alamedas	Av. San Gaspar No. 191	Jalisco IV Secc	Tonalá	45408	3336072759	20.6774979540357, -103.256818187091	Activo	no	HOR-01
SUC-07	El Briseño	López Portillo No. 27-A	 El Briseño	Zapopan	45236	3336842598	20.6235766795754, -103.435761630535	Activo	no	HOR-01
SUC-08	Centro Joyero	República No. 97	 San Juan de Dios	Guadalajara	44360	3336181736	20.6776947, -103.3384091	Activo	no	HOR-01
SUC-09	Concepción De Buenos Aires	Calle Hidalgo Norte No. 15 	 Centro	Concepción de Buenos Aires	49170	3724260843	19.9790618, -103.2602455	Activo	no	HOR-01
SUC-10	Concordia	Ignacio Zaragoza No. 17	 Centro	Concordia	82600	6949680118	23.2886262, -106.0702226	Activo	no	HOR-03
SUC-11	Cuquío	Aldama No. 40-A	 Centro	Cuquío	45480	3737966736	20.9306235705586, -103.024351000786	Activo	XC010801	HOR-01
SUC-12	El Colli	Av. Moctezuma No. 5485	 El Colli	Zapopan	45010	3331251993	20.6503142461257, -103.429601937532	Activo	no	HOR-01
SUC-13	Guamúchil	Jesus Rodriguez No. 429	Juarez Guamúchil	Salvador Alvarado	81430	6737350660	25.4605281629629, -108.077989518642	Activo	no	HOR-03
SUC-14	Guasave	Calle Dr. Luis G. de la torre 48\n	 Centro	Guasave	81000	6876881218	25.5686122353133, -108.463507443666	Activo	no	HOR-03
SUC-15	Heliodoro Hernández Loza	Hacienda La Calera No. 3341	 San José Rio Verde	Guadalajara	44720	3336043205 y 3336043267	20.694430233554, -103.281352221966	Activo	no	HOR-01
SUC-16	Hermosa Provincia	Presa Osorio No. 3599-A	 Hermosa Provincia	Guadalajara	44770	3336080852	20.6690317608679, -103.282272219658	Activo	no	HOR-01
SUC-17	Huajote	Mártires del agrarismo s/n	 Centro	Concordia	82625	6949528146	23.1289942814535, -106.05953335762	Activo	no	HOR-03
SUC-18	Industria	Porfirio Díaz No. 445	 Reforma	Guadalajara	44360	3336186738	20.6779128640382, -103.32207351923	Activo	no	HOR-01
SUC-19	Ixtlahuacán De Los Membrillos	Santiago No. 186	Centro	Ixtlahuacán de los Membrillos	45850	3767620692	20.3514283103328, -103.191484808922	Activo	no	HOR-01
SUC-20	Ixtlahuacán Del Río	Independencia No. 48 y 54	 Centro	Ixtlahuacán del Río	45270	3737347349	20.8626835315565, -103.238608539104	Activo	XC010501	HOR-01
SUC-21	Jalisco	Ciudad Guzmán No. 112	 Jalisco I Sección	Tonalá	45412	3336071520	20.6857822065214, -103.263982236385	Activo	no	HOR-01
SUC-22	Joaquín Amaro	Av. Joaquín Amaro No. 2179	 Santa Cecilia	Guadalajara	44700	3336093625 y 3336995755	20.7025389576424, -103.292160853744	Activo	XC010201	HOR-01
SUC-23	Lomas De San Miguel	Av. Salvador Orozco Loreto No. 1319 Local 1  Planta Baja Plaza comercial “Plaza Ventura”	 Las Huertas	San Pedro Tlaquepaque	45589	3336394843	20.6140911446072, -103.303686976433	Activo	no	HOR-01
SUC-24	Loreto	Francisco Villa No. 408 	 Centro	Loreto	98830	4969620454	22.2715638879255, -101.986660659313	Activo	no	HOR-01
SUC-25	Los Altos	Marcelino Álvarez No. 104	 Centro	Arandas	47180	3487832429 y 3487831956	20.7077594, -102.3452874	Activo	no	HOR-01
SUC-26	Los Mochis	Av. Gral. Gabriel Leyva No. 109 Sur	 Centro	Ahome	81200	6688154055	25.7917686, -108.9931503	Activo	no	HOR-03
SUC-27	Mazamitla	Emiliano Zapata No. 10	 Centro	Mazamitla	49500	3825381200	19.9146530820332, -103.019443899393	Activo	no	HOR-01
SUC-28	Navojoa	García Morales Sur No. 500	 Reforma	Navojoa	85870	6424224595	27.0765201, -109.4466148	Activo	no	HOR-03
SUC-29	Polanco	Longinos Cadena No. 1723-A	 Lomas de Polanco	Guadalajara	44960	3331441179	20.6300243, -103.3766258	Activo	no	HOR-01
SUC-30	Poncitlán	Calle Cuauhtemoc No.286 D	 Centro	Poncitlán	45950	3919214571	20.3843116, -102.9275571	Activo	no	HOR-01
SUC-31	Rio Presidio	20 de Noviembre #102	 Centro	Villa Unión	82210	6699670336, 6699670729 y 6699670715	23.1869738395328, -106.219502314925	Activo	no	HOR-03
SUC-32	Rioverde	Nicolás Bravo No. 409	 Centro	Rioverde	79610	4878712088	21.9271612809689, -99.9910005927086	Activo	no	HOR-01
SUC-33	Rosamorada	México No. 21-B	 Centro	Rosamorada	63630	3192340121	22.1232575734935, -105.205749347806	Activo	no	HOR-03
SUC-34	San Isidro	Carr. a San Esteban No. 1018-A	 San Isidro	Zapopan	45135	3336850778	20.7910555629633, -103.352833092213	Activo	no	HOR-01
SUC-35	San Luis Soyatlán	Álvaro Obregón No. 216	 Centro	San Luis soyatlán	49440	3767640434	20.199745646255, -103.308712765574	Activo	no	HOR-01
SUC-36	San Marcos	Mesa Central No. 774	 San Marcos	Guadalajara	44330	3336092269	20.7008974260867, -103.31355214119	Activo	no	HOR-01
SUC-37	Santa Fe	Av. Concepción No. 19 Plaza Santa Fe Local No. 4	 Hacienda Santa Fe	Tlajomulco de Zúñiga	45655	3311891910	20.5294279, -103.3776307	Activo	no	HOR-01
SUC-38	Santo Santiago	Zaragoza No.84	Centro	Tonalá	45400	3336834080	20.6237413, -103.2413723	Activo	XC011001	HOR-01
SUC-39	Tabachines	Av. Tabachines No. 1265	 Tabachines	Zapopan	45188	3336724173	20.740654245809, -103.364174477756	Activo	no	HOR-01
SUC-40	Talpita	Santa Clemencia No. 1799	 Talpita	Guadalajara	44719	3336443997	20.6861636183655, -103.309277035296	Activo	no	HOR-01
SUC-41	Tepeyac	Av. Juan Carrasco No.845	 Reforma	Mazatlán	82030	6699853890 y 6699854713	23.2121848266034, -106.416591703892	Activo	no	HOR-03
SUC-42	Tres Arcángeles	María Elena Maza No.911	 Echeverría	Guadalajara	44970	3336638990	20.6301554553666, -103.359057828784	Activo	no	HOR-01
SUC-43	Tulipanes	Rosal No. 1221	 Los Tulipanes	Tlajomulco de Zúñiga	45647	3336127897	20.5853472592319, -103.432438373566	Activo	no	HOR-01
SUC-44	XI De Mayo	José María Iglesias No. 3157	 Lomas de San Eugenio	Guadalajara	44720	3336496703	20.6797472402245, -103.289801180363	Activo	no	HOR-01
SUC-45	Zapopan	C. López Cotilla No.47	 Centro	Zapopan	45100	3336361047	20.7238910477038, -103.389942795038	Activo	no	HOR-01
SUC-46	Zapotiltic	Hidalgo Oriente No. 39	 Zapotiltic Centro	Zapotiltic	49600	3414142157	19.6265369933945, -103.417521268129	Activo	no	HOR-01
SUC-47	Mazatlán	Av. Ejército Mexicano Sección "L" No. 158	López Mateos	Mazatlán	82140	6699903713	23.2373058248328, -106.423433622754	Activo	no	HOR-03
SUC-48	Margarita Maza de Juárez	Belisario Domínguez No. 3080	 Margarita Maza de Juárez	Guadalajara	44300	3336743330	20.7130312927048, -103.303220272064	Activo	no	HOR-01
SUC-49	Teocuitatlán	Hidalgo No. 60	 Centro	Teocuitatlán de Corona	49250	3724280182	20.092762838539, -103.377061486244	Activo	no	HOR-01
SUC-50	La Cruz	Saúl Aguilar Picos 81 local 1	Centro	Elota	82707	6969611730	23.9192004, -106.8957435	Activo	no	HOR-03
SUC-51	El Salto	Heliodoro Hernández Loza 951-A	 Centro	El Salto	45680	3337321241	20.5162114774527, -103.179468512535	Activo	no	HOR-01
SUC-52	Acaponeta	México Sur 28  Esq. Juan Espinoza Bávara\n	 Centro	Acaponeta	63430	3256880025	22.4901288, -105.3609861	Activo	no	HOR-03
SUC-53	Arcos de Zapopan	Avenida Tesistán 1250 local 3. C.P. en Zapopan Jalisco	 Colonia Arcos de Zapopan.	Zapopan	45130	3338344265	20.7396263, -103.4134159	Activo	no	HOR-01
SUC-54	Tesistán	Calle Hidalgo 261 int 3	 Tesistán	Zapopan	45200	3315616274	20.7994038, -103.4825378	Activo	no	HOR-01
SUC-55	Tepic	Av. Prisciliano Sánchez sur 36	 Centro	Tepic	63000	3116881286	21.506146, -104.8887113	Activo	no	HOR-03
SUC-56	Santa Cruz del Valle	Av. Juan de la Barrera #865 Local 6 Planta baja	 Fraccionamiento Mision Magnolias	San Pedro Tlaquepaque	45615	3312245547	20.5904803, -103.3330497	Activo	no	HOR-01
SUC-57	Santa Teresita	C. Gabriel Ramos Millán 430	Santa Teresita	Guadalajara	44200	\N	\N	Activo	no	HOR-01
\.


--
-- Data for Name: tablas_credito; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tablas_credito (id, nombre_comercial, categoria_bot, keywords, beneficio_principal, tasa_anual, cat_prom, plazo_max, monto_max, req_aval, condiciones_especiales, req_garantia, recip_pct, perfil_cliente, status_credito, requisitos_necesarios, regla_adicional) FROM stdin;
CR-01	CRÉDITO AUTOMÁTICO	CONSUMO	mis ahorros, urgente, rápido, barato, sin aval, entrega inmediata	Crédito simple para solventar necesidades de consumo.	0.12	0.137	60	100% Ahorro	No	Entrega al instante	Financiera	1	Socio con Ahorro	activo	REQ-01, REQ-02	En caso de que el domicilio registrado en sistema coincida con la INE se omite solicitar comprobante de domicilio.
CR-02	CREDI-PRENDA OBLATOS	CONSUMO	oro amarillo, empeño, anillo de oro, monedas de oro	Crédito simple para solventar necesidades de consumo.	0.2796	0.33	12	100000	No	Entrega al instante	Prendaria y Financiera	0	Socio General	activo	REQ-01, REQ-02, REQ-07	Préstamo condicionado a la calidad de oro en la prenda.
CR-03	CREDIALIADO OBLATOS	CONSUMO	emergencia, apoyo,urgente	Crédito simple para solventar necesidades de consumo.	0.24	0.279	24	30000	Sí	Perfil socio cumplido no requiere aval 	Quirografaria y Financiera	0.1	Socio General	activo	REQ-01, REQ-02,  REQ-07, REQ-08	\N
CR-04	CREDI-NOMINA	CONSUMO	nomina, sueldo, empleado	Crédito simple para solventar necesidades de consumo para socios que sean empleados cuya fuente de empleo tenga convenio con Caja Oblatos.	0.18	0.206	48	100000	No	Descuento vía nómina, se requiere convenio con la empresa y la cooperativa	Financiera	0	Empleado Convenio	activo	REQ-01, REQ-02, REQ-39, REQ-07, REQ-12	\N
CR-05	CREDI-SOCIO CUMPLIDO	CONSUMO	cumplido, lealtad, sin aval	Crédito simple para solventar necesidades de consumo a los socios cumplidos con Caja Oblatos.	0.18	0.205	72	400000	No	Excelente historial, no realizar retiros, constancia en el ahorro, predial a su nombre	Financiera	0.1	Socio General	activo	REQ-01, REQ-02, REQ-07, REQ-13	Sie el recibo predial del bien inmueble esta a nombre del conyuge debera de firmar como obligado solidario con regimen de sociedad legal o conyugal
CR-06	CREDI-SEGUROBLATOS	CONSUMO	seguro, póliza, protección, auto	Crédito simple para financiar seguros de automotores	0.18	0.206	12	50000	Sí	En caso de que el préstamo sea para cubrir el seguro de alguna garantia prendaria de Caja Oblatos, el beneficiario preferente en todos los casos debe ser, Caja Popular Oblatos, S.C. DE A.P. DE RL. DE C.V.	Quirografaria y Financiera	0.1	Socio General	activo	REQ-01, REQ-02, REQ-07, REQ-08, REQ-09	En caso de que el préstamo sea para cubrir el seguro de un Credi-Auto Consumo o Credi-Auto Comercial previamente autorizado o en proceso de pago, en donde presentó predial o documento que acredite la propiedad manera oficial a su nombre, no se solicitará garantía quirografaria.
CR-07	CRÉDITO ORDINARIO	CONSUMO	gastos personales, adquisición de bienes de consumo duradero	Crédito simple para solventar necesidades de consumo a los socios cumplidos con Caja Oblatos.	0.216	0.249	72	400000	Sí	Perfil socio cumplido no se tomara en cuenta la carga financiera de Buro de credito	Quirografaria y Financiera	0.1	Socio General	activo	REQ-01, REQ-02, REQ-07, REQ-08	\N
CR-08	CREDI-AUTO CONSUMO	CONSUMO	carro, agencia, estrenar, coche, seminuevos	Crédito simple para la adquisición de vehículo automotor nuevo o usado para fines de consumo	0.156	0.178	60	450000	Sí	Si eres socio y cuentas con casa propia, no necesitas presentar un aval; solamente se requeriría la firma de tu cónyuge si así corresponde según tu estado civil.	Prendaria y Financiera	$6,000 para Automóvil o 10% para Motocicleta	Socio General	activo	REQ-01, REQ-02, REQ-39, REQ-07, REQ-08, REQ-09	Este Crédito requiere la contratación de una póliza de seguros, como beneficiario preferencial la cooperativa. 
CR-09	CRÉDITO COMERCIAL	COMERCIAL	taxi, carga, transporte	Crédito simple para la adquisición de vehículo automotor nuevo o seminuevo para fines comerciales o de servicio público, a excepción de plataformas digitales	0.156	0.178	60	450000	Sí	Si eres socio y cuentas con casa propia, no necesitas presentar un aval; solamente se requeriría la firma de tu cónyuge si así corresponde según tu estado civil.	Prendaria y Financiera	$6,000 para Automóvil o 10% para Motocicleta	Socio con actividad comercial.	activo	REQ-01, REQ-02, REQ-39, REQ-07, REQ-08, REQ-09, REQ-38	Este Crédito requiere la contratación de una póliza de seguros, como beneficiario preferencial la cooperativa. 
CR-10	CRÉDITO CON GARANTÍA HIPOTECARIA CONSUMO	CONSUMO	hipoteca, liquidez, crédito de consumo	Crédito simple para solventar necesidades de consumo.	0.105	0.118	360	3000000	No	Socio o tercero con propiedad de valor equivalente al monto del crédito.	Hipotecaria y Financiera	20000	Dueño Inmueble o presentar garante hipotecario.	activo	REQ-01, REQ-02, REQ-03, REQ-04, REQ-39, REQ-06, REQ-07, REQ-13, REQ-16, REQ-17, REQ-18, REQ-19, REQ-20, REQ-21, REQ-28	Si el inmueble es de varias personas o si tú (o quien deja la garantía) tienen un estado civil que requiera trámites extra, aquí te decimos qué más necesitas entregar.
CR-11	CRÉDITO CON GARANTÍA HIPOTECARIA COMERCIAL	COMERCIAL	empresa, fabrica, inversión grande	Crédito destinado para solventar necesidades de liquidez que requieran mayor inyección de capital para tu empresa.	0.105	0.118	360	3000000	No	El otorgamiento del crédito está sujeto a la presentación de una garantía (propia o de un tercero) por un valor igual al monto financiado. Además, el acreditado deberá proporcionar los comprobantes necesarios para validar el destino final del crédito.	Hipotecaria y Financiera	20000	Socio con actividad comercial y/o profesional.	activo	REQ-01, REQ-02, REQ-03, REQ-04, REQ-39, REQ-06, REQ-07, REQ-13, REQ-14, REQ-15, REQ-16, REQ-17, REQ-18, REQ-19, REQ-20, REQ-21	Si el inmueble es de varias personas o si tú (o quien deja la garantía) tienen un estado civil que requiera trámites extra, aquí te decimos qué más necesitas entregar.
CR-12	CREDI-AGRO	COMERCIAL	campo, ciclo, ganadería, cosecha, apicultura, porcicultura, piscicultura	Crédito simple para financiar capital de trabajo e insumos a socios con actividad agropecuaria.	0.18	0.206	60	450000	Sí	\N	Quirografaria y Financiera	0.1	Socio agricultor o ganadero	activo	REQ-01, REQ-02, REQ-03, REQ-07, REQ-08, REQ-15, REQ-22	\N
CR-13	CREDI-COMERCIO	COMERCIAL	mercancía, inventario, surtir	Capital de trabajo para surtir tu negocio.	0.192	0.22	72	400000	Sí	Si eres socio y cuentas con casa propia, no necesitas presentar un aval; solamente se requeriría la firma de tu cónyuge si así corresponde según tu estado civil.	Quirografaria y Financiera	0.1	Socio General	activo	REQ-01, REQ-02, REQ-07, REQ-08, REQ-15, REQ-23	\N
CR-14	MI CASA	VIVIENDA	casa, terreno, construir, hipoteca	Crédito para la adquisición de vivienda nueva, usada, compra de terreno, o pagos de pasivos  hipotecarios.	0.095	0.107	360	3000000	No	Compra de vivienda o traspaso de hipoteca	Hipotecaria y Financiera	20000	Socio General	activo	REQ-01, REQ-02, REQ-03, REQ-04, REQ-39, REQ-06, REQ-07, REQ-13, REQ-16, REQ-17, REQ-18, REQ-19, REQ-20, REQ-21, REQ-24, REQ-25, REQ-39	Cuando la fuente de ingresos provenga de una actividad comercial, deberá de presentar la cédula de identificación fiscal, del último mes.
CR-15	CRÉDI-SOLAR CONSUMO	CONSUMO	paneles, solar, luz, energía	Crédito simple destinado para la adquisición e instalación de paneles y calentadores solares	0.18	0.206	84	400000	Sí	Paneles solares para la vivienda	Quirografaria y Financiera	0.1	Socio General	activo	REQ-01, REQ-02, REQ-07, REQ-08, REQ-09, REQ-13	Si el socio presenta predial o documento que acredite la propiedad de manera oficial a su nombre o de su cónyuge con acta de matrimonio en sociedad legal o conyugal, no se pedirá la garantía quirografaria debiendo firmar ambos
CR-16	CRÉDI-SOLAR COMERCIAL	COMERCIAL	paneles, solar, luz, energía, empresas	Crédito simple destinado para la adquisición e instalación de paneles y calentadores solares, para negocio.	0.18	0.206	84	400000	Sí	Paneles solares para el negocio	Quirografaria y Financiera	0.1	Socio con actividad comercial y/o profesional.	activo	REQ-01, REQ-02, REQ-07, REQ-08, REQ-09, REQ-13, REQ-14, REQ-15	Si el socio presenta predial o documento que acredite la propiedad de manera oficial a su nombre o de su cónyuge con acta de matrimonio en sociedad legal o conyugal, no se pedirá la garantía quirografaria debiendo firmar ambos
CR-17	CREDI-MI VIAJE CPO	CONSUMO	viaje, vacaciones, playa, avión	Crédito simple para el financiamiento de viajes.	0.216	0.249	72	200000	Sí	Para viajes nacionales e internacionales	Quirografaria y Financiera	0.1	Socio General	activo	REQ-01, REQ-02, REQ-07, REQ-08, REQ-09	\N
CR-18	CREDI-MÁS AGUA	CONSUMO	agua, tinaco, aljibe, cisterna	Crédito simple destinado para la adquisición e instalación de sistemas de captación de agua de lluvia, agua y saneamiento, compra de accesorios y muebles para baño, remodelación y construcción de baños, así como productos para la sustentabilidad de viviendas e incremento en la calidad de vida de nuestros socios.	0.12	0.137	60	100000	Sí	Equipamiento para la vivienda	Quirografaria y Financiera	0.1	Socio General	activo	REQ-01, REQ-02, REQ-07, REQ-08, REQ-13	El solicitante deberá de presentar comprobante que acredite la propiedad (sólo para sistemas de captación de lluvia y biodigestores). En caso de que el Crédito se destine para la adquisición de sistemas de captación de agua de lluvia, se requiere cotización y dictamen de viabilidad.
CR-19	CREDI-PENSIONADO	CONSUMO	sueldo, pensión, comprobantes	Crédito simple para pensionados o jubilados.	0.24	0.278	60	100000	No	Sin comprobar destino del crédito	Financiera	0.1	Socio Pensionado o Jubilado	activo	REQ-01, REQ-02, REQ-07, REQ-39	Ingresos mínimos de $3,000, se pueden complementar con los ingresos oficiales del cónyuge, quien en su caso firmará como obligado solidario.
CR-20	CREDI - LÍNEA OBLATOS	CONSUMO	personal, gastos, libre, dinero	La solución flexible para tus necesidades de consumo. Con esta línea podrás disponer de tu dinero las veces que lo necesites, ya sea en montos parciales o por el total autorizado, durante toda la vigencia de tu crédito. ¡Tú decides cuándo y cuánto usar!	0.24	0.279	36	100000	No	Crédito revolvente personal	Financiera	0.1	Socio General	activo	REQ-01, REQ-02, REQ-07, REQ-39	\N
CR-21	LÍNEA COMERCIAL OBLATOS	COMERCIAL	empresa, fabrica, gastos, libre, dinero	Línea de Crédito comercial, que le permite al socio mantener una operación constante, destinado para capital de trabajo para cualquier actividad productiva, el cual le permite disponer al socio cuantas veces lo requiera mediante disposiciones parciales o totales durante la vigencia de la línea.	0.24	0.279	48	350000	No	Crédito revolvente productivo	Financiera	0.1	Socio con actividad empresarial y/o profesional.	activo	REQ-01, REQ-02, REQ-07, REQ-14, REQ-15, REQ-23, REQ-27	\N
\.


--
-- Data for Name: tablas_inversiones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tablas_inversiones (catalogo_inversiones) FROM stdin;
id_producto
INV-01
INV-30
INV-60
INV-90
INV-180
INV-360
Tasas Inversión
id_tasa
T-01-A
T-01-B
T-01-C
T-01-D
T-01-E
T-01-F
T-01-G
T-30-A
T-30-B
T-30-C
T-30-D
T-30-E
T-30-F
T-30-G
T-60-A
T-60-B
T-60-C
T-60-D
T-60-E
T-60-F
T-60-G
T-90-A
T-90-B
T-90-C
T-90-D
T-90-E
T-90-F
T-90-G
T-180-A
T-180-B
T-180-C
T-180-D
T-180-E
T-180-F
T-180-G
T-360-A
T-360-B
T-360-C
T-360-D
T-360-E
T-360-F
T-360-G
\.


--
-- Data for Name: talleres_culturales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.talleres_culturales (id, nombre_taller, descripcion_corta, edades, lunes, martes, miercoles, jueves, viernes, sabado, ubicacion) FROM stdin;
01_taller	karate	Desarrollo de la disciplina y respeto. Mejora la concentración y coordinación. Fomenta la confianza y la autoestima. Habilidades de defensa personal.	A partir de 6 años.	4:00 pm a 5:00 pm	\N	\N	\N	4:00 pm a 5:00 pm	\N	Hacienda Santiago #2020. Inscripciones: 33-3637-6447
02_taller	Música	Espacio creativo para descubrir el lenguaje universal de los sonidos. Desarrolla oído, ritmo y expresión artística a través de instrumentos y canto.	A partir de 13 años.	\N	\N	\N	\N	\N	9:00 am a 11:00 am	Hacienda Santiago #2020. Inscripciones: 33-3637-6447
03_taller	Computación	Introducción práctica al mundo digital: desde el manejo básico de programas hasta herramientas útiles para la vida académica y laboral.	A partir de 10 años.	\N	\N	\N	4:00 pm a 6:00 pm	\N	\N	Hacienda Santiago #2020. Inscripciones: 33-3637-6447
04_taller	Jazz	Taller de danza enfocado en aprender coreografías dinámicas y expresivas. Favorece la coordinación, el ritmo y la confianza en el movimiento, combinando técnica y diversión.	A partir de 6 años.	\N	4:00 pm a 5:00 pm	\N	\N	4:00 pm a 5:00 pm	\N	Hacienda Santiago #2020. Inscripciones: 33-3637-6447
05_taller	Yoga	Práctica integral que une cuerpo y mente. Mejora la flexibilidad, reduce el estrés y promueve el bienestar personal.	A partir de 18 años.	5:00 pm a 6:00 pm	\N	5:00 pm a 6:00 pm	\N	\N	\N	Hacienda Santiago #2020. Inscripciones: 33-3637-6447
06_taller	inglés Básico	Curso diseñado para adquirir vocabulario y estructuras esenciales. Ideal para quienes inician su camino en el aprendizaje del idioma.	A partir de 6 años.	\N	\N	\N	\N	\N	9:00 am a 11:00 am	Hacienda Santiago #2020. Inscripciones: 33-3637-6447
07_taller	inglés Avanzado	Taller para perfeccionar habilidades de comunicación, comprensión y escritura en contextos académicos y profesionales.	A partir de 6 años.	\N	\N	\N	\N	\N	11:00 am a 1:00 pm	Hacienda Santiago #2020. Inscripciones: 33-3637-6447
08_taller	Ajedrez	Juego de estrategia que estimula la memoria, la concentración y el pensamiento crítico. Una forma divertida de ejercitar la mente.	A partir de 6 años.	\N	\N	\N	\N	\N	9:00 am a 11:00 am	Hacienda Santiago #2020. Inscripciones: 33-3637-6447
09_taller	Dibujo y Pintura	Espacio artístico para desarrollar la creatividad y aprender técnicas plásticas. Se fomenta la expresión personal a través del color y la forma.	A partir de 6 años.	4:00 pm a 6:00 pm	\N	\N	\N	4:00 pm a 6:00 pm	\N	Hacienda Santiago #2020. Inscripciones: 33-3637-6447
10_taller	Fútbol	Actividad deportiva que impulsa el trabajo en equipo, la disciplina y la condición física. Perfecta para quienes disfrutan la competencia y la camaradería.	A partir de 6 años.	4:00 pm a 6:00 pm	3:00 a 5:00 pm	4:00 pm a 6:00 pm	\N	\N	\N	Unidad 17 - Cancha "La Mayates" Inscripciones: 33-3637-6447
\.


--
-- Data for Name: tasas_inversiones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasas_inversiones (id_tasa, id_producto_rel, monto_min, monto_max, tasa_anual_pct) FROM stdin;
T-01-A	INV-01	1000	10000	0
T-01-B	INV-01	10000.01	20000	0.0164
T-01-C	INV-01	20000.01	100000	0.0167
T-01-D	INV-01	100000.01	150000	0.0175
T-01-E	INV-01	150001	250000	0.0186
T-01-F	INV-01	250001	1000000	0.0216
T-01-G	INV-01	1000001	5000000	0.0252
T-30-A	INV-30	1000	10000	0.0159
T-30-B	INV-30	10000.01	20000	0.0255
T-30-C	INV-30	20000.01	100000	0.0258
T-30-D	INV-30	100000.01	150000	0.0278
T-30-E	INV-30	150001	250000	0.0284
T-30-F	INV-30	250001	1000000	0.0315
T-30-G	INV-30	1000001	5000000	0.0357
T-60-A	INV-60	1000	10000	0.0182
T-60-B	INV-60	10000.01	20000	0.0278
T-60-C	INV-60	20000.01	100000	0.0281
T-60-D	INV-60	100000.01	150000	0.0313
T-60-E	INV-60	150001	250000	0.0319
T-60-F	INV-60	250001	1000000	0.035
T-60-G	INV-60	1000001	5000000	0.0387
T-90-A	INV-90	1000	10000	0.0194
T-90-B	INV-90	10000.01	20000	0.028
T-90-C	INV-90	20000.01	100000	0.015
T-90-D	INV-90	100000.01	150000	0.025
T-90-E	INV-90	150001	250000	0.025
T-90-F	INV-90	250001	1000000	0.038
T-90-G	INV-90	1000001	5000000	0.05
T-180-A	INV-180	1000	10000	0.0229
T-180-B	INV-180	10000.01	20000	0.03
T-180-C	INV-180	20000.01	100000	0.018
T-180-D	INV-180	100000.01	150000	0.025
T-180-E	INV-180	150001	250000	0.0317
T-180-F	INV-180	250001	1000000	0.046
T-180-G	INV-180	1000001	5000000	0.05
T-360-A	INV-360	1000	10000	0.0258
T-360-B	INV-360	10000.01	20000	0.035
T-360-C	INV-360	20000.01	100000	0.02
T-360-D	INV-360	100000.01	150000	0.03
T-360-E	INV-360	150001	250000	0.0383
T-360-F	INV-360	250001	1000000	0.05
T-360-G	INV-360	1000001	5000000	0.05
\.


--
-- Data for Name: tramites_y_servicios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tramites_y_servicios (id_tramite, nombre_tramite, publico_objetivo, canal_atencion, requisitos_minimos, costo_o_monto_minimo, beneficio_directo, keywords) FROM stdin;
TRAM-01	Alta de Socio Nuevo	Aspirante	Sucursal (Presencial)	1. CURP.\n2. Nombre, domicilio y teléfono de un familiar (que no viva en el mismo domicilio).\n3. Acta de nacimiento.\n4. Comprobante de domicilio (no mayor a 3 meses).\n5. Identificación oficial vigente (con fotografía).\n6. Cubrir el monto de la Parte Social.	$1,050.00\n($1,000.00 Parte Social + $50.00 de apertura en Ahorro Ordinario).	Adquirir la calidad de Socio, acceso a créditos, inversiones, promociones y el sistema de protecciones.	quiero ser socio, afiliarme, unirme, requisitos ingreso, abrir cuenta, registrarme
TRAM-02	Apertura de Inversión	Socio Vigente	Sucursal (Presencial)	1. Ser socio con Parte Social completa.\n2. Contar con saldo disponible en la cuenta débito.\n3. Elegir el plazo (90, 180 o 360 días).\n4. Firmar el contrato de inversión solo presencial.	Monto mínimo según el producto de inversión elegido.	Rendimiento garantizado a plazo fijo y participación en la campaña promocional correspondiente, en caso de aplicar.	invertir, poner a plazo, plazo fijo, rendimiento, hacer crecer dinero, inversiones
TRAM-03	Participación en Asamblea	Socio Vigente	Sede designada / Convocatoria	1. Ser socio con Parte Social completa.\n2. Estar al corriente con sus obligaciones (ahorros y créditos).\n3. Presentar credencial de socio e identificación oficial el día del evento.	Gratuito	Ejercer el derecho a voz y voto en las decisiones, elecciones y distribución de remanentes de la cooperativa.	asamblea, junta de socios, votar, delegados, participar, reunión anual
TRAM-04	Alta de Ahorrador Menor	Niños (1 a 17 años) a través de su Tutor	Sucursal (Presencial)	1. Acta de nacimiento del menor.\n2. Identificación oficial vigente del padre o tutor (Socio).\n3. Comprobante de domicilio del tutor (no mayor a 3 meses).\n4. Realizar el depósito de apertura en ventanilla.	$21.00\n\n($20.00 monto de apertura + $1.00 saldo mínimo).	Fomenta el hábito del ahorro desde la infancia en la cuenta de Ahorro Menores, con rendimientos y sin comisiones.	dar de alta niño, cuenta infantil, ahorro menores, registrar hijo, kids coop, menor
TRAM-05	Solicitud de Tarjeta de Débito	Socio Vigente	Sucursal (Presencial)	1. Ser socio activo con la Parte Social completa.\n2. Presentar identificación oficial vigente.\n3. Contar con una cuenta de Ahorro Débito.\n4. Firmar el contrato de medios electrónicos en la sucursal.	Gratuito (En su primera emisión).\n\nApertura de cuenta base: $50.00	Entrega inmediata del plástico Carnet para realizar compras en comercios, e-commerce, retiros en cajeros y acceso a CashBack.	solicitar tarjeta, tramitar plástico, mi tarjeta débito, renovar tarjeta, carnet
TRAM-06	Configuración de Aplicación Móvil	Socio Vigente	Sucursal (Presencial)	1. Contar con una cuenta de Ahorro Débito activa.\n2. Tener un teléfono inteligente con número celular validado en el sistema.\n3. Descargar la aplicación oficial.\n4. Acudir a sucursal para vinculación.	Gratuito	Acceso total a la banca digital de Caja Oblatos para consultar saldos, realizar transferencias SPEI, usar DIMO y gestionar cuentas 24/7.	activar app, configurar aplicación, banca móvil, no puedo entrar app, registro digital
TRAM-07	Crédito Prendario (Empeño de Joyas)	Socio Vigente o Público General	Sucursal con módulo de valuación prendario	1. Presentar identificación oficial vigente y comprobante de domicilio.\n2. Entregar las piezas o joyas de oro para su valuación física por el perito.\n3. Firmar el contrato de prenda.\n4. Recibir el efectivo en ventanilla.	Costo de valuación gratuito.\n\nMonto otorgado según el quilataje y peso de la prenda.	Financiamiento inmediato en efectivo sin necesidad de aval ni comprobar ingresos, resguardando las joyas de forma segura.	empeño, empeñar oro, préstamo joyas, prendario, dinero rápido, empeñar cadena
TRAM-08	Reclamación de Protecciones	Beneficiarios Designados	Oficina protecciones / Sucursal	1. Acta de defunción: original certificada.\n2. Acta de nacimiento del socio y del/los beneficiario(s): original certificada y reciente.\n3. Comprobante de domicilio reciente del socio y del/los beneficiario(s): copia simple.\n4. Certificado médico de defunción: copia simple.\n5. Identificación oficial vigente del socio y del/los beneficiario(s): copia simple.\n6. Tarjeta plástica o libreta.\n7. Tarjeta de débito (si aplica).\n8. Contrato del Fondo Solidario (solo en caso de contar con uno).\n9. Contrato de inversión (solo si tiene cuenta de inversión).\n10. Boleta Credi-Prenda (solo si tiene crédito prendario).\n11. Acta del Ministerio Público (en caso de muerte accidental u homicidio).	Gratuito	Liberación automática de deudas de hasta $400,000 (Préstamo) o entrega del doble del ahorro acumulado de hasta $80,000 (Ahorro).	cobrar seguro, falleció socio, ayuda muerte, tramitar protección, seguro de vida
TRAM-09	Recepción de Remesas Internacionales	Socio Vigente	Ventanilla en Sucursal	1. Presentar identificación oficial vigente (INE o Pasaporte).\n2. Proporcionar el número de clave o código de transferencia de la remesa.\n3. Indicar el nombre completo del remitente y país de origen.\n4. Firmar el recibo de cobro en ventanilla.	Gratuito para quien recibe el dinero.	Cobro rápido y seguro de su dinero enviado desde el extranjero directamente en su sucursal de confianza.	cobrar remesa, dinero de estados unidos, western union, recibir dinero, envíos
TRAM-10	Recepción de Remesas Internacionales via aplicacion Caja Oblatos Móvil	Socio Vigente	App Móvil	1 Socio con cuenta aplicacion Movil activada\n2. Genera o consulta tu folio único de remesa desde el módulo de 24 xoro en la app Caja Oblatos Móvil.\n3. Comparte ese folio con tu familiar para que acuda a una agencia de envío o ingrese al portal web o app del trasmisor de dinero, consulta las remesadoras en la app.\n4. El dinero se deposita directamente en tu cuenta de ahorro débito.	Gratuito para quien recibe el dinero.	Cobro rápido y seguro de su dinero enviado desde el extranjero directamente en su aplicacion Móvil.	\N
TRAM-11	Alta de Escuela en Programa Educacoop	Directivos o Representantes Escolares	Oficina de Dirección / Promoción Institucional	1. Solicitud formal por escrito firmada por el director de la institución educativa.\n2. Identificación oficial del director y Clave del Centro de Trabajo (CCT).\n3. Agendar y coordinar la realización de charlas de educación financiera.\n4. Firmar el convenio de alianza institucional.	Gratuito	Vinculación con la cooperativa para recibir apoyos mensuales en especie (equipo, materiales y tecnología) que beneficien el crecimiento de la escuela.	registrar escuela, convenio educacoop, apoyo escuelas, dar de alta colegio, donación
TRAM-12	Solicitud de Aclaraciones	Socio Vigente	Sucursal (Módulo de UNE) o Línea de Soporte	1. Presentar identificación oficial vigente del socio.\n2. Llenar y firmar el formato oficial de reclamación (cargos no reconocidos, fallas en cajero o SPEI).\n3. Proporcionar estado de cuenta, comprobante físico del cajero o captura de la App Móvil.\n4. En caso de robo o extravío, presentar folio de bloqueo.	Gratuito	Análisis técnico de la transacción, resolución formal del caso y, de ser procedente, el reembolso de los fondos correspondientes.	aclaración, cargo no reconocido, clonaron tarjeta, no me dio dinero el cajero, reclamación, fraude, spei fallido
\.


--
-- Data for Name: user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_permissions (id, user_id, table_name, can_edit) FROM stdin;
16	4	tabla_promociones	t
17	4	tabla_servicios	t
18	4	talleres_culturales	t
19	4	catalogo_vacantes	t
20	4	tramites_y_servicios	t
21	4	catalago_soporte	t
22	4	tabla_sucursales	t
23	4	tabla_requisitos	t
24	4	catalogo_conceptos_cooperativos	t
25	4	catalogo_inversiones	t
26	4	tasas_inversiones	t
27	4	vista_sucursales	t
28	4	catalogo_soporte	t
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, hashed_password, is_active, is_admin) FROM stdin;
1	admin	$pbkdf2-sha256$29000$vpcSAmDsXeu9V6p1TuldSw$yNs1gaBfNBVxW9QlAmBUuVuXMiBlxGrRSxt7IB0TZgg	t	t
3	howard	$pbkdf2-sha256$29000$vRfCeK9Vam1NSUlJiZHyvg$.z9npmEO.zMVzxgBUrFa2HB74x1mHEXm/iKa6fefddk	t	t
4	Zulim	$pbkdf2-sha256$29000$au1dSynl3NsbA.C81zrH.A$qrf/rcsVMAGOtxaRyUbKTRhyQ7YYGKnjinPROb8cCzE	t	f
\.


--
-- Name: 01.-matriz_de_conocimiento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."01.-matriz_de_conocimiento_id_seq"', 86, true);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 46, true);


--
-- Name: catalogo_vacantes__rowid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catalogo_vacantes__rowid_seq', 8, true);


--
-- Name: descripciones_tablas__rowid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.descripciones_tablas__rowid_seq', 79, true);


--
-- Name: tabla_requisitos__rowid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tabla_requisitos__rowid_seq', 40, true);


--
-- Name: user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_permissions_id_seq', 28, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- Name: 01.-matriz_de_conocimiento 01.-matriz_de_conocimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."01.-matriz_de_conocimiento"
    ADD CONSTRAINT "01.-matriz_de_conocimiento_pkey" PRIMARY KEY (id);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: catalago_soporte catalago_soporte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalago_soporte
    ADD CONSTRAINT catalago_soporte_pkey PRIMARY KEY (id);


--
-- Name: catalogo_conceptos_cooperativos catalogo_conceptos_cooperativos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_conceptos_cooperativos
    ADD CONSTRAINT catalogo_conceptos_cooperativos_pkey PRIMARY KEY (id);


--
-- Name: catalogo_inversiones catalogo_inversiones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_inversiones
    ADD CONSTRAINT catalogo_inversiones_pkey PRIMARY KEY (id_producto);


--
-- Name: catalogo_soporte catalogo_soporte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_soporte
    ADD CONSTRAINT catalogo_soporte_pkey PRIMARY KEY (id);


--
-- Name: catalogo_vacantes catalogo_vacantes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_vacantes
    ADD CONSTRAINT catalogo_vacantes_pkey PRIMARY KEY (_rowid);


--
-- Name: descripciones_tablas descripciones_tablas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.descripciones_tablas
    ADD CONSTRAINT descripciones_tablas_pkey PRIMARY KEY (_rowid);


--
-- Name: dias_inhabiles dias_inhabiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dias_inhabiles
    ADD CONSTRAINT dias_inhabiles_pkey PRIMARY KEY (id);


--
-- Name: limites_transaccionales limites_transaccionales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.limites_transaccionales
    ADD CONSTRAINT limites_transaccionales_pkey PRIMARY KEY (id_limite);


--
-- Name: tabla_ahorro tabla_ahorro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabla_ahorro
    ADD CONSTRAINT tabla_ahorro_pkey PRIMARY KEY (id);


--
-- Name: tabla_atm tabla_atm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabla_atm
    ADD CONSTRAINT tabla_atm_pkey PRIMARY KEY (id_cajero);


--
-- Name: tabla_horarios tabla_horarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabla_horarios
    ADD CONSTRAINT tabla_horarios_pkey PRIMARY KEY (id_horario);


--
-- Name: tabla_promociones tabla_promociones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabla_promociones
    ADD CONSTRAINT tabla_promociones_pkey PRIMARY KEY (id);


--
-- Name: tabla_protecciones tabla_protecciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabla_protecciones
    ADD CONSTRAINT tabla_protecciones_pkey PRIMARY KEY (id);


--
-- Name: tabla_requisitos tabla_requisitos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabla_requisitos
    ADD CONSTRAINT tabla_requisitos_pkey PRIMARY KEY (_rowid);


--
-- Name: tabla_servicios tabla_servicios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabla_servicios
    ADD CONSTRAINT tabla_servicios_pkey PRIMARY KEY (id);


--
-- Name: tabla_sucursales tabla_sucursales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabla_sucursales
    ADD CONSTRAINT tabla_sucursales_pkey PRIMARY KEY (id);


--
-- Name: tablas_credito tablas_credito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tablas_credito
    ADD CONSTRAINT tablas_credito_pkey PRIMARY KEY (id);


--
-- Name: tablas_inversiones tablas_inversiones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tablas_inversiones
    ADD CONSTRAINT tablas_inversiones_pkey PRIMARY KEY (catalogo_inversiones);


--
-- Name: talleres_culturales talleres_culturales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.talleres_culturales
    ADD CONSTRAINT talleres_culturales_pkey PRIMARY KEY (id);


--
-- Name: tasas_inversiones tasas_inversiones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasas_inversiones
    ADD CONSTRAINT tasas_inversiones_pkey PRIMARY KEY (id_tasa);


--
-- Name: tramites_y_servicios tramites_y_servicios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tramites_y_servicios
    ADD CONSTRAINT tramites_y_servicios_pkey PRIMARY KEY (id_tramite);


--
-- Name: user_permissions user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ix_audit_logs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_audit_logs_id ON public.audit_logs USING btree (id);


--
-- Name: ix_user_permissions_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_user_permissions_id ON public.user_permissions USING btree (id);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: ix_users_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_users_username ON public.users USING btree (username);


--
-- Name: audit_logs audit_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_permissions user_permissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 0z9EVLmJHWhh2gpXnhge1GeQV41oY8yLigrepbHiyKyqexPD5U7iv9GozYQMOy6

