--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4
-- Dumped by pg_dump version 14.4

-- Started on 2022-07-21 23:20:20

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
-- TOC entry 238 (class 1259 OID 16560)
-- Name: account_academic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_academic (
    id integer NOT NULL,
    degree character varying(200),
    name_board_university character varying(200),
    year_passing integer,
    marks_obtained numeric(5,2),
    div_class_grade character varying(200),
    subject character varying(500),
    pdf character varying(100),
    email_id integer,
    doc_link character varying(700)
);


ALTER TABLE public.account_academic OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16559)
-- Name: account_academic_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_academic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_academic_id_seq OWNER TO postgres;

--
-- TOC entry 3669 (class 0 OID 0)
-- Dependencies: 237
-- Name: account_academic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_academic_id_seq OWNED BY public.account_academic.id;


--
-- TOC entry 220 (class 1259 OID 16463)
-- Name: account_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_account (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    email character varying(60) NOT NULL,
    username character varying(100) NOT NULL,
    date_joined date,
    last_login timestamp with time zone NOT NULL,
    is_admin boolean NOT NULL,
    is_active boolean NOT NULL,
    is_staff boolean NOT NULL,
    is_superuser boolean NOT NULL,
    hide_email boolean NOT NULL,
    "Designation" character varying(30),
    addr_corres text,
    addr_perm text,
    agp integer,
    catg character varying(6),
    current_dsg character varying(30),
    dt_eligibility date,
    dt_last_promo date,
    dt_ob date,
    facult character varying(100),
    faculty character varying(100),
    from_dsg character varying(30),
    gender character varying(6),
    highest_quali character varying(200),
    is_carry boolean NOT NULL,
    is_dean boolean NOT NULL,
    is_hod boolean NOT NULL,
    mobile character varying(10),
    pan_no character varying(10),
    parent character varying(100),
    pdf character varying(100),
    post character varying(30),
    quali_year character varying(4),
    to_dsg character varying(30),
    tot_experience integer NOT NULL,
    "Department_id" integer,
    is_applicant boolean NOT NULL,
    frm_approved boolean NOT NULL,
    frm_resubmission boolean NOT NULL,
    frm_submitted boolean NOT NULL,
    frm_rejected boolean NOT NULL,
    approved_date timestamp with time zone NOT NULL,
    frm_general_info boolean NOT NULL,
    general_info_date timestamp with time zone NOT NULL,
    rejected_date boolean NOT NULL,
    resubmission_date timestamp with time zone NOT NULL,
    submitted_date timestamp with time zone NOT NULL,
    doc_link character varying(700),
    ass_yr integer,
    emp_id character varying(6) NOT NULL,
    is_pwd boolean NOT NULL,
    pwd_link character varying(700),
    fwd_link character varying(700)
);


ALTER TABLE public.account_account OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16487)
-- Name: account_account_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_account_groups (
    id integer NOT NULL,
    account_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.account_account_groups OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16486)
-- Name: account_account_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_account_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_account_groups_id_seq OWNER TO postgres;

--
-- TOC entry 3670 (class 0 OID 0)
-- Dependencies: 223
-- Name: account_account_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_account_groups_id_seq OWNED BY public.account_account_groups.id;


--
-- TOC entry 219 (class 1259 OID 16462)
-- Name: account_account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_account_id_seq OWNER TO postgres;

--
-- TOC entry 3671 (class 0 OID 0)
-- Dependencies: 219
-- Name: account_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_account_id_seq OWNED BY public.account_account.id;


--
-- TOC entry 226 (class 1259 OID 16499)
-- Name: account_account_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_account_user_permissions (
    id integer NOT NULL,
    account_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.account_account_user_permissions OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16498)
-- Name: account_account_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_account_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_account_user_permissions_id_seq OWNER TO postgres;

--
-- TOC entry 3672 (class 0 OID 0)
-- Dependencies: 225
-- Name: account_account_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_account_user_permissions_id_seq OWNED BY public.account_account_user_permissions.id;


--
-- TOC entry 240 (class 1259 OID 16647)
-- Name: account_apicatg_i; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_apicatg_i (
    id integer NOT NULL,
    direct_teaching integer,
    self_api_dt numeric(4,2),
    pdf_dt character varying(100),
    veri_api_dt numeric(4,2),
    exam_duties integer,
    self_api_ed numeric(4,2),
    pdf_ed character varying(100),
    veri_api_ed numeric(4,2),
    innovating_teaching integer,
    self_api_it numeric(4,2),
    pdf_it character varying(100),
    veri_api_it numeric(4,2),
    email_id integer,
    actl_api_dt numeric(6,2),
    actl_api_ed numeric(6,2),
    actl_api_it numeric(6,2),
    url_dt character varying(500),
    url_ed character varying(500),
    url_it character varying(500),
    CONSTRAINT account_apicatg_i_direct_teaching_bf09e05d_check CHECK ((direct_teaching >= 0))
);


ALTER TABLE public.account_apicatg_i OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16646)
-- Name: account_apicatg_i_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_apicatg_i_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_apicatg_i_id_seq OWNER TO postgres;

--
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 239
-- Name: account_apicatg_i_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_apicatg_i_id_seq OWNED BY public.account_apicatg_i.id;


--
-- TOC entry 242 (class 1259 OID 16671)
-- Name: account_apicatg_ii; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_apicatg_ii (
    id integer NOT NULL,
    field_based_activities integer,
    actl_api_fba numeric(6,2),
    self_api_fba numeric(4,2),
    pdf_fba character varying(100),
    veri_api_fba numeric(4,2),
    corp_life_management integer,
    actl_api_clm numeric(6,2),
    self_api_clm numeric(4,2),
    pdf_clm character varying(100),
    veri_api_clm numeric(4,2),
    prof_dev_activity integer,
    actl_api_pda numeric(6,2),
    self_api_pda numeric(4,2),
    pdf_pda character varying(100),
    veri_api_pda numeric(4,2),
    email_id integer,
    url_clm character varying(500),
    url_pda character varying(500),
    url_fba character varying(500),
    CONSTRAINT account_apicatg_ii_field_based_activities_check CHECK ((field_based_activities >= 0))
);


ALTER TABLE public.account_apicatg_ii OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16670)
-- Name: account_apicatg_ii_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_apicatg_ii_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_apicatg_ii_id_seq OWNER TO postgres;

--
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 241
-- Name: account_apicatg_ii_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_apicatg_ii_id_seq OWNED BY public.account_apicatg_ii.id;


--
-- TOC entry 222 (class 1259 OID 16476)
-- Name: account_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_department (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    faculty character varying(20)
);


ALTER TABLE public.account_department OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16475)
-- Name: account_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_department_id_seq OWNER TO postgres;

--
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 221
-- Name: account_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_department_id_seq OWNED BY public.account_department.id;


--
-- TOC entry 236 (class 1259 OID 16551)
-- Name: account_orientation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_orientation (
    id integer NOT NULL,
    title character varying(300),
    place character varying(200),
    duration character varying(100),
    period character varying(200),
    pdf character varying(100),
    email_id integer,
    url_link character varying(500)
);


ALTER TABLE public.account_orientation OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16550)
-- Name: account_orientation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_orientation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_orientation_id_seq OWNER TO postgres;

--
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 235
-- Name: account_orientation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_orientation_id_seq OWNED BY public.account_orientation.id;


--
-- TOC entry 234 (class 1259 OID 16544)
-- Name: account_presentpost; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_presentpost (
    id integer NOT NULL,
    designation character varying(30),
    period_from date,
    period_to date,
    pay_scale character varying(20),
    agp character varying(30),
    pdf character varying(100),
    department_id integer,
    email_id integer,
    url_link character varying(500)
);


ALTER TABLE public.account_presentpost OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16543)
-- Name: account_presentpost_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_presentpost_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_presentpost_id_seq OWNER TO postgres;

--
-- TOC entry 3677 (class 0 OID 0)
-- Dependencies: 233
-- Name: account_presentpost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_presentpost_id_seq OWNED BY public.account_presentpost.id;


--
-- TOC entry 232 (class 1259 OID 16535)
-- Name: account_priorpost; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_priorpost (
    id integer NOT NULL,
    designation character varying(400),
    employer character varying(400),
    dt_join date,
    dt_leav date,
    gross_salary character varying(20),
    agp integer,
    reason_leaving character varying(400),
    pdf character varying(100),
    email_id integer,
    url_link character varying(500)
);


ALTER TABLE public.account_priorpost OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16534)
-- Name: account_priorpost_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_priorpost_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_priorpost_id_seq OWNER TO postgres;

--
-- TOC entry 3678 (class 0 OID 0)
-- Dependencies: 231
-- Name: account_priorpost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_priorpost_id_seq OWNED BY public.account_priorpost.id;


--
-- TOC entry 230 (class 1259 OID 16526)
-- Name: account_research; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_research (
    id integer NOT NULL,
    degree character varying(200),
    thesis character varying(500),
    dt_award date,
    institute character varying(200),
    pdf character varying(100),
    email_id integer,
    url_link character varying(500)
);


ALTER TABLE public.account_research OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16525)
-- Name: account_research_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_research_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_research_id_seq OWNER TO postgres;

--
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 229
-- Name: account_research_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_research_id_seq OWNED BY public.account_research.id;


--
-- TOC entry 228 (class 1259 OID 16517)
-- Name: account_teachingexp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_teachingexp (
    id integer NOT NULL,
    pg_class integer,
    ug_class integer,
    specialisation character varying(400),
    pdf character varying(100),
    email_id integer,
    url_link character varying(500),
    doc_yrs integer,
    postdoc_yrs integer
);


ALTER TABLE public.account_teachingexp OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16516)
-- Name: account_teachingexp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_teachingexp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_teachingexp_id_seq OWNER TO postgres;

--
-- TOC entry 3680 (class 0 OID 0)
-- Dependencies: 227
-- Name: account_teachingexp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_teachingexp_id_seq OWNED BY public.account_teachingexp.id;


--
-- TOC entry 216 (class 1259 OID 16421)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16420)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- TOC entry 3681 (class 0 OID 0)
-- Dependencies: 215
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- TOC entry 218 (class 1259 OID 16430)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16429)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- TOC entry 3682 (class 0 OID 0)
-- Dependencies: 217
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- TOC entry 214 (class 1259 OID 16414)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16413)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- TOC entry 3683 (class 0 OID 0)
-- Dependencies: 213
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- TOC entry 260 (class 1259 OID 16896)
-- Name: catg_3_e_learning; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catg_3_e_learning (
    id integer NOT NULL,
    model_name character varying(200),
    course_name character varying(200),
    program_name character varying(200),
    prj_url character varying(500),
    self_api_score numeric(5,2),
    veri_api_score numeric(5,2),
    email_id integer
);


ALTER TABLE public.catg_3_e_learning OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 16895)
-- Name: catg_3_e_learning_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catg_3_e_learning_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catg_3_e_learning_id_seq OWNER TO postgres;

--
-- TOC entry 3684 (class 0 OID 0)
-- Dependencies: 259
-- Name: catg_3_e_learning_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catg_3_e_learning_id_seq OWNED BY public.catg_3_e_learning.id;


--
-- TOC entry 256 (class 1259 OID 16866)
-- Name: catg_3_fellow_award; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catg_3_fellow_award (
    id integer NOT NULL,
    fellow_type character varying(50),
    name_fellow character varying(300),
    name_body character varying(300),
    prj_lvl character varying(50),
    prj_url character varying(500),
    self_api_score numeric(5,2),
    veri_api_score numeric(5,2),
    email_id integer
);


ALTER TABLE public.catg_3_fellow_award OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 16865)
-- Name: catg_3_fellow_award_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catg_3_fellow_award_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catg_3_fellow_award_id_seq OWNER TO postgres;

--
-- TOC entry 3685 (class 0 OID 0)
-- Dependencies: 255
-- Name: catg_3_fellow_award_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catg_3_fellow_award_id_seq OWNED BY public.catg_3_fellow_award.id;


--
-- TOC entry 246 (class 1259 OID 16743)
-- Name: catg_3_jrnl_pub; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catg_3_jrnl_pub (
    id integer NOT NULL,
    yr_pub integer,
    title_pub character varying(300),
    no_auth integer,
    role_appl character varying(50),
    jrnl_name character varying(200),
    vl_pg character varying(300),
    jrnl_type character varying(50),
    imp_fac numeric(5,2) NOT NULL,
    jrnl_url character varying(500),
    email_id integer,
    self_api_score numeric(5,2),
    veri_api_score numeric(5,2),
    jrnl_link character varying(700),
    jrnl_oth integer,
    CONSTRAINT catg_3_jrnl_pub_jrnl_oth_check CHECK ((jrnl_oth >= 0)),
    CONSTRAINT catg_3_jrnl_pub_no_auth_check CHECK ((no_auth >= 0)),
    CONSTRAINT catg_3_jrnl_pub_yr_pub_check CHECK ((yr_pub >= 0))
);


ALTER TABLE public.catg_3_jrnl_pub OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16742)
-- Name: catg_3_jrnl_pub_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catg_3_jrnl_pub_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catg_3_jrnl_pub_id_seq OWNER TO postgres;

--
-- TOC entry 3686 (class 0 OID 0)
-- Dependencies: 245
-- Name: catg_3_jrnl_pub_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catg_3_jrnl_pub_id_seq OWNED BY public.catg_3_jrnl_pub.id;


--
-- TOC entry 258 (class 1259 OID 16881)
-- Name: catg_3_lecture_paper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catg_3_lecture_paper (
    id integer NOT NULL,
    invitation_type character varying(50),
    title_lecture character varying(300),
    seminer character varying(300),
    organizer character varying(200),
    venue character varying(300),
    duration character varying(200),
    prj_lvl character varying(50),
    prj_url character varying(500),
    self_api_score numeric(5,2),
    veri_api_score numeric(5,2),
    email_id integer
);


ALTER TABLE public.catg_3_lecture_paper OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 16880)
-- Name: catg_3_lecture_paper_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catg_3_lecture_paper_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catg_3_lecture_paper_id_seq OWNER TO postgres;

--
-- TOC entry 3687 (class 0 OID 0)
-- Dependencies: 257
-- Name: catg_3_lecture_paper_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catg_3_lecture_paper_id_seq OWNED BY public.catg_3_lecture_paper.id;


--
-- TOC entry 252 (class 1259 OID 16813)
-- Name: catg_3_prj_outcm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catg_3_prj_outcm (
    id integer NOT NULL,
    faculty_app character varying(50),
    prj_type character varying(50),
    proj_title character varying(300),
    prj_lvl character varying(50),
    ref_no character varying(100),
    ptnt_sts character varying(50),
    prj_url character varying(500),
    prj_pdf character varying(100),
    email_id integer,
    self_api_score numeric(5,2),
    veri_api_score numeric(5,2)
);


ALTER TABLE public.catg_3_prj_outcm OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 16812)
-- Name: catg_3_prj_outcm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catg_3_prj_outcm_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catg_3_prj_outcm_id_seq OWNER TO postgres;

--
-- TOC entry 3688 (class 0 OID 0)
-- Dependencies: 251
-- Name: catg_3_prj_outcm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catg_3_prj_outcm_id_seq OWNED BY public.catg_3_prj_outcm.id;


--
-- TOC entry 248 (class 1259 OID 16762)
-- Name: catg_3_pub_other; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catg_3_pub_other (
    id integer NOT NULL,
    yr_pub integer,
    pub_type character varying(50),
    chap_title character varying(300),
    bk_title character varying(300),
    no_auth integer,
    name_pub character varying(300),
    sts_pub character varying(50),
    isbn_no character varying(100),
    pub_url character varying(500),
    pub_pdf character varying(100),
    email_id integer,
    self_api_score numeric(5,2),
    veri_api_score numeric(5,2),
    CONSTRAINT catg_3_pub_other_no_auth_check CHECK ((no_auth >= 0)),
    CONSTRAINT catg_3_pub_other_yr_pub_check CHECK ((yr_pub >= 0))
);


ALTER TABLE public.catg_3_pub_other OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16761)
-- Name: catg_3_pub_other_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catg_3_pub_other_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catg_3_pub_other_id_seq OWNER TO postgres;

--
-- TOC entry 3689 (class 0 OID 0)
-- Dependencies: 247
-- Name: catg_3_pub_other_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catg_3_pub_other_id_seq OWNED BY public.catg_3_pub_other.id;


--
-- TOC entry 262 (class 1259 OID 16911)
-- Name: catg_3_resch_cons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catg_3_resch_cons (
    id integer NOT NULL,
    proj_tag character varying(5),
    faculty_app character varying(50),
    proj_title character varying(300),
    fund_agnc character varying(300),
    no_yrs integer,
    prj_amt numeric(6,2),
    prj_url character varying(500),
    prj_pdf character varying(100),
    self_api_score numeric(5,2),
    veri_api_score numeric(5,2),
    email_id integer,
    CONSTRAINT catg_3_resch_cons_no_yrs_check CHECK ((no_yrs >= 0))
);


ALTER TABLE public.catg_3_resch_cons OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 16910)
-- Name: catg_3_resch_cons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catg_3_resch_cons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catg_3_resch_cons_id_seq OWNER TO postgres;

--
-- TOC entry 3690 (class 0 OID 0)
-- Dependencies: 261
-- Name: catg_3_resch_cons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catg_3_resch_cons_id_seq OWNED BY public.catg_3_resch_cons.id;


--
-- TOC entry 254 (class 1259 OID 16851)
-- Name: catg_3_resch_guide; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catg_3_resch_guide (
    id integer NOT NULL,
    student_name character varying(100),
    degree character varying(20),
    title_thesis character varying(300),
    status character varying(50),
    prj_url character varying(500),
    self_api_score numeric(5,2),
    veri_api_score numeric(5,2),
    email_id integer
);


ALTER TABLE public.catg_3_resch_guide OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 16850)
-- Name: catg_3_resch_guide_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catg_3_resch_guide_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catg_3_resch_guide_id_seq OWNER TO postgres;

--
-- TOC entry 3691 (class 0 OID 0)
-- Dependencies: 253
-- Name: catg_3_resch_guide_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catg_3_resch_guide_id_seq OWNED BY public.catg_3_resch_guide.id;


--
-- TOC entry 250 (class 1259 OID 16779)
-- Name: catg_3_resch_proj; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catg_3_resch_proj (
    id integer NOT NULL,
    faculty_app character varying(50),
    proj_title character varying(300),
    fund_agnc character varying(300),
    no_yrs integer,
    prj_amt numeric(6,2),
    prj_url character varying(500),
    prj_pdf character varying(100),
    email_id integer,
    self_api_score numeric(5,2),
    veri_api_score numeric(5,2),
    proj_tag character varying(5),
    CONSTRAINT catg_3_resch_proj_no_yrs_check CHECK ((no_yrs >= 0))
);


ALTER TABLE public.catg_3_resch_proj OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16778)
-- Name: catg_3_resch_proj_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catg_3_resch_proj_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catg_3_resch_proj_id_seq OWNER TO postgres;

--
-- TOC entry 3692 (class 0 OID 0)
-- Dependencies: 249
-- Name: catg_3_resch_proj_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catg_3_resch_proj_id_seq OWNED BY public.catg_3_resch_proj.id;


--
-- TOC entry 244 (class 1259 OID 16721)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16720)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- TOC entry 3693 (class 0 OID 0)
-- Dependencies: 243
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- TOC entry 212 (class 1259 OID 16405)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16404)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- TOC entry 3694 (class 0 OID 0)
-- Dependencies: 211
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- TOC entry 210 (class 1259 OID 16396)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16395)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- TOC entry 3695 (class 0 OID 0)
-- Dependencies: 209
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- TOC entry 263 (class 1259 OID 16934)
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- TOC entry 3312 (class 2604 OID 16563)
-- Name: account_academic id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_academic ALTER COLUMN id SET DEFAULT nextval('public.account_academic_id_seq'::regclass);


--
-- TOC entry 3303 (class 2604 OID 16466)
-- Name: account_account id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account ALTER COLUMN id SET DEFAULT nextval('public.account_account_id_seq'::regclass);


--
-- TOC entry 3305 (class 2604 OID 16490)
-- Name: account_account_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account_groups ALTER COLUMN id SET DEFAULT nextval('public.account_account_groups_id_seq'::regclass);


--
-- TOC entry 3306 (class 2604 OID 16502)
-- Name: account_account_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.account_account_user_permissions_id_seq'::regclass);


--
-- TOC entry 3313 (class 2604 OID 16650)
-- Name: account_apicatg_i id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_apicatg_i ALTER COLUMN id SET DEFAULT nextval('public.account_apicatg_i_id_seq'::regclass);


--
-- TOC entry 3315 (class 2604 OID 16674)
-- Name: account_apicatg_ii id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_apicatg_ii ALTER COLUMN id SET DEFAULT nextval('public.account_apicatg_ii_id_seq'::regclass);


--
-- TOC entry 3304 (class 2604 OID 16479)
-- Name: account_department id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_department ALTER COLUMN id SET DEFAULT nextval('public.account_department_id_seq'::regclass);


--
-- TOC entry 3311 (class 2604 OID 16554)
-- Name: account_orientation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_orientation ALTER COLUMN id SET DEFAULT nextval('public.account_orientation_id_seq'::regclass);


--
-- TOC entry 3310 (class 2604 OID 16547)
-- Name: account_presentpost id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_presentpost ALTER COLUMN id SET DEFAULT nextval('public.account_presentpost_id_seq'::regclass);


--
-- TOC entry 3309 (class 2604 OID 16538)
-- Name: account_priorpost id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_priorpost ALTER COLUMN id SET DEFAULT nextval('public.account_priorpost_id_seq'::regclass);


--
-- TOC entry 3308 (class 2604 OID 16529)
-- Name: account_research id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_research ALTER COLUMN id SET DEFAULT nextval('public.account_research_id_seq'::regclass);


--
-- TOC entry 3307 (class 2604 OID 16520)
-- Name: account_teachingexp id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_teachingexp ALTER COLUMN id SET DEFAULT nextval('public.account_teachingexp_id_seq'::regclass);


--
-- TOC entry 3301 (class 2604 OID 16424)
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- TOC entry 3302 (class 2604 OID 16433)
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- TOC entry 3300 (class 2604 OID 16417)
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- TOC entry 3332 (class 2604 OID 16899)
-- Name: catg_3_e_learning id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_e_learning ALTER COLUMN id SET DEFAULT nextval('public.catg_3_e_learning_id_seq'::regclass);


--
-- TOC entry 3330 (class 2604 OID 16869)
-- Name: catg_3_fellow_award id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_fellow_award ALTER COLUMN id SET DEFAULT nextval('public.catg_3_fellow_award_id_seq'::regclass);


--
-- TOC entry 3319 (class 2604 OID 16746)
-- Name: catg_3_jrnl_pub id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_jrnl_pub ALTER COLUMN id SET DEFAULT nextval('public.catg_3_jrnl_pub_id_seq'::regclass);


--
-- TOC entry 3331 (class 2604 OID 16884)
-- Name: catg_3_lecture_paper id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_lecture_paper ALTER COLUMN id SET DEFAULT nextval('public.catg_3_lecture_paper_id_seq'::regclass);


--
-- TOC entry 3328 (class 2604 OID 16816)
-- Name: catg_3_prj_outcm id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_prj_outcm ALTER COLUMN id SET DEFAULT nextval('public.catg_3_prj_outcm_id_seq'::regclass);


--
-- TOC entry 3323 (class 2604 OID 16765)
-- Name: catg_3_pub_other id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_pub_other ALTER COLUMN id SET DEFAULT nextval('public.catg_3_pub_other_id_seq'::regclass);


--
-- TOC entry 3333 (class 2604 OID 16914)
-- Name: catg_3_resch_cons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_resch_cons ALTER COLUMN id SET DEFAULT nextval('public.catg_3_resch_cons_id_seq'::regclass);


--
-- TOC entry 3329 (class 2604 OID 16854)
-- Name: catg_3_resch_guide id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_resch_guide ALTER COLUMN id SET DEFAULT nextval('public.catg_3_resch_guide_id_seq'::regclass);


--
-- TOC entry 3326 (class 2604 OID 16782)
-- Name: catg_3_resch_proj id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_resch_proj ALTER COLUMN id SET DEFAULT nextval('public.catg_3_resch_proj_id_seq'::regclass);


--
-- TOC entry 3317 (class 2604 OID 16724)
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- TOC entry 3299 (class 2604 OID 16408)
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- TOC entry 3298 (class 2604 OID 16399)
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- TOC entry 3638 (class 0 OID 16560)
-- Dependencies: 238
-- Data for Name: account_academic; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_academic (id, degree, name_board_university, year_passing, marks_obtained, div_class_grade, subject, pdf, email_id, doc_link) FROM stdin;
4	\N	\N	\N	\N	\N	\N		4	\N
1	B. PHARM.	DIBRUGARH UNIVERSITY	2002	67.90	1ST CLASS\r\nWITH\r\nHONOURS\r\n(2ND RANK IN\r\nDU)	PHARMACEUTICS,\r\nPHARMACOGNOSY,\r\nPHARMACOLOGY,\r\nMICROBIOLOGY,\r\nBIOCHEMISTRY,\r\nPHARMACEUTICAL\r\nCHEMISTRY,\r\nPHARMACEUTICAL\r\nENNGINEERING		4	\N
2	M. PHARM.	JADAVPUR UNIVERSITY	2004	73.33	1ST CLASS	PHARMACEUTICS,\r\nPHARMACOGNOSY,\r\nPHARMACOLOGY,		4	\N
\.


--
-- TOC entry 3620 (class 0 OID 16463)
-- Dependencies: 220
-- Data for Name: account_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_account (id, password, email, username, date_joined, last_login, is_admin, is_active, is_staff, is_superuser, hide_email, "Designation", addr_corres, addr_perm, agp, catg, current_dsg, dt_eligibility, dt_last_promo, dt_ob, facult, faculty, from_dsg, gender, highest_quali, is_carry, is_dean, is_hod, mobile, pan_no, parent, pdf, post, quali_year, to_dsg, tot_experience, "Department_id", is_applicant, frm_approved, frm_resubmission, frm_submitted, frm_rejected, approved_date, frm_general_info, general_info_date, rejected_date, resubmission_date, submitted_date, doc_link, ass_yr, emp_id, is_pwd, pwd_link, fwd_link) FROM stdin;
1	pbkdf2_sha256$150000$nH5xwMGOYdwK$PLnuoDB3ae9oKMR++ion+RMbNa83KkbsmAboeVpiMIQ=	admin@jdvu.in	Admin_JU	\N	2022-07-21 11:29:36.31108+05:30	t	t	t	t	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	Individual	\N	\N		\N	\N	\N	0	\N	t	f	f	f	f	2022-07-21 11:01:18.738982+05:30	f	2022-07-21 11:01:18.738982+05:30	f	2022-07-21 11:01:18.738982+05:30	2022-07-21 11:01:18.738982+05:30	\N	\N		f	\N	\N
2	pbkdf2_sha256$150000$twPEya9U45gK$CmUw1gJOWzGeSb0fux8UZararL0qogEu3+B+8k0kdZo=	abc@jadavpuruniversity.in	Abc Xyz	\N	2022-07-21 18:02:17.125178+05:30	f	t	f	f	t	dsg-1	\N	\N	\N	\N	\N	\N	\N	\N	\N	fac-3	\N	\N	\N	f	f	f	Individual	\N	\N		\N	\N	\N	0	2	t	f	f	f	f	2022-07-21 18:02:15.900933+05:30	f	2022-07-21 18:02:15.900933+05:30	f	2022-07-21 18:02:15.900933+05:30	2022-07-21 18:02:15.900933+05:30	\N	\N	01230	f	\N	\N
4	pbkdf2_sha256$150000$H5meVjynWx8b$bgamgcDejBbWXuGajXk6axX983oaHjRDYfFanPu1W14=	xyz@jadavpuruniversity.in	Abc Xyz	\N	2022-07-21 18:16:21.443943+05:30	f	t	f	f	t	dsg-1	JADAVPUR UNIVERSITY, KOLKATA 700032	H. NO. 480, BELOW MEZHIIR HIGHER SECONDARY\r\nSCHOOL, LOWER MIDLAND, KOHIMA, NAGALAND - 797001	3	cast-2	\N	2020-05-15	2017-05-16	1979-06-16	\N	fac-3	Stage 3	\N	q1	f	f	f	8981099151	\N	asd xyz		\N	\N	Stage 4	0	2	t	f	f	f	f	2022-07-21 18:16:21.443943+05:30	t	2022-07-21 18:16:21.443943+05:30	f	2022-07-21 18:16:21.443943+05:30	2022-07-21 18:16:21.443943+05:30	https://spoken-tutorial.org/tutorial-search/?search_foss=PHP%20and%20MySQL&search_language=English&page=1	3	12340	f	\N	\N
\.


--
-- TOC entry 3624 (class 0 OID 16487)
-- Dependencies: 224
-- Data for Name: account_account_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_account_groups (id, account_id, group_id) FROM stdin;
\.


--
-- TOC entry 3626 (class 0 OID 16499)
-- Dependencies: 226
-- Data for Name: account_account_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_account_user_permissions (id, account_id, permission_id) FROM stdin;
\.


--
-- TOC entry 3640 (class 0 OID 16647)
-- Dependencies: 240
-- Data for Name: account_apicatg_i; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_apicatg_i (id, direct_teaching, self_api_dt, pdf_dt, veri_api_dt, exam_duties, self_api_ed, pdf_ed, veri_api_ed, innovating_teaching, self_api_it, pdf_it, veri_api_it, email_id, actl_api_dt, actl_api_ed, actl_api_it, url_dt, url_ed, url_it) FROM stdin;
4	700	60.00		60.00	250	20.00		20.00	250	15.00		15.00	4	90.32	25.00	25.00	\N	\N	\N
\.


--
-- TOC entry 3642 (class 0 OID 16671)
-- Dependencies: 242
-- Data for Name: account_apicatg_ii; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_apicatg_ii (id, field_based_activities, actl_api_fba, self_api_fba, pdf_fba, veri_api_fba, corp_life_management, actl_api_clm, self_api_clm, pdf_clm, veri_api_clm, prof_dev_activity, actl_api_pda, self_api_pda, pdf_pda, veri_api_pda, email_id, url_clm, url_pda, url_fba) FROM stdin;
4	250	25.00	15.00		15.00	300	30.00	15.00		15.00	150	15.00	15.00		15.00	4	\N	\N	\N
\.


--
-- TOC entry 3622 (class 0 OID 16476)
-- Dependencies: 222
-- Data for Name: account_department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_department (id, name, faculty) FROM stdin;
1	ADULT AND CONTINUING EDUCATION & EXTENSION	ISLM
2	ARCHITECTURE	ENGINEERING
3	BENGALI	ARTS
4	CHEMICAL ENGINEERING	ENGINEERING
5	CHEMISTRY	SCIENCE
6	CIVIL ENGINEERING	ENGINEERING
7	COMPARATIVE LITERATURE	ARTS
8	COMPUTER SCIENCE & ENGINEERING	ENGINEERING
9	CONSTRUCTION ENGINEERING	ENGINEERING
10	ECONOMICS	ARTS
11	EDUCATION	ARTS
12	ELECTRICAL ENGINEERING	ENGINEERING
13	ELECTRONICS & TELE-COMMUNICATION ENGINEERING	ENGINEERING
14	ENGLISH	ARTS
15	FILM STUDIES	ARTS
16	FOOD TECHNOLOGY & BIOCHEMICAL ENGINEERING	ENGINEERING
17	GEOLOGICAL SCIENCES	SCIENCE
18	HISTORY	ARTS
19	INFORMATION TECHNOLOGY	ENGINEERING
20	INSTRUMENTATION & ELECTRONICS ENGINEERING	ENGINEERING
21	INSTRUMENTATION SCIENCE	SCIENCE
22	INTERNATIONAL RELATIONS	ARTS
23	LIBRARY & INFORMATION SCIENCE	ARTS
24	LIFE SCIENCE & BIO-TECHNOLOGY	SCIENCE
25	MECHANICAL ENGINEERING	ENGINEERING
26	METALLURGICAL & MATERIAL ENGINEERING	ENGINEERING
27	PHARMACEUTICAL TECHNOLOGY	ENGINEERING
28	PHILOSOPHY	ARTS
29	PHYSICAL EDUCATION	ARTS
30	POWER ENGINEERING	ENGINEERING
31	PRINTING ENGINEERING	ENGINEERING
32	PRODUCTION ENGINEERING	ENGINEERING
33	SANSKRIT	ARTS
34	SCHOOL OF BIO-SCIENCE AND ENGINEERING	ISLM
35	SCHOOL OF COGNITIVE SCIENCE	ISLM
36	SCHOOL OF ENERGY STUDIES	ISLM
37	SCHOOL OF ENVIRONMENTAL STUDIES	ISLM
38	SCHOOL OF ILLUMINATION SCIENCE ENGINEERING & DESIGN	ISLM
39	SCHOOL OF LASER SCIENCE AND ENGINEERING	ISLM
40	SCHOOL OF MATERIAL SCIENCE AND TECHNOLOGY	ISLM
41	SCHOOL OF MOBILE COMPUTING AND COMMUNICATION	ISLM
42	SCHOOL OF NUCLEAR STUDIES AND APPLICATION	ISLM
43	SCHOOL OF OCEANOGRAPHIC STUDIES	ISLM
44	SCHOOL OF WATER RESOURCE ENGINEERING	ISLM
45	SCHOOL OF WOMEN'S STUDIES	ISLM
46	SOCIOLOGY	ARTS
\.


--
-- TOC entry 3636 (class 0 OID 16551)
-- Dependencies: 236
-- Data for Name: account_orientation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_orientation (id, title, place, duration, period, pdf, email_id, url_link) FROM stdin;
4	\N	\N	\N	\N		4	\N
1	REFRESHERS COURSE\r\nENTITLED, “PROGRESS\r\nIN PHARMACEUTICAL\r\nRESEARCH AND\r\nTECHNOLOGY” OF QIP\r\nUNDER THE AUSPICES\r\nA.I.C.T.E., NEW DELHI	JADAVPUR\r\nUNIVERSITY	4 WEEKS	18TH AUGUST 2008 TO 13TH\r\nSEPTEMBER 2008.		4	\N
2	REFRESHERS COURSE\r\nENTITLED, "THRUST\r\nAREAS ON\r\nDEVELOPMENT OF\r\nNATURAL PRODUCTS"\r\nOF QIP UNDER U.G.C.,\r\nNEW DELHI.	JADAVPUR\r\nUNIVERSITY	4 WEEKS	20TH NOVEMBER 2008 TO\r\n10TH DECEMBER 2008.		4	\N
\.


--
-- TOC entry 3634 (class 0 OID 16544)
-- Dependencies: 234
-- Data for Name: account_presentpost; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_presentpost (id, designation, period_from, period_to, pay_scale, agp, pdf, department_id, email_id, url_link) FROM stdin;
4	\N	\N	\N	\N	\N		\N	4	\N
1	Stage 1	2008-05-16	2012-05-15	RS. 15600-39100	1st		2	4	\N
2	Stage 2	2008-05-16	2017-05-15	RS. 15600-39100	2nd		2	4	\N
3	Stage 3	2008-05-16	2022-07-21	RS. 15600-39100	3rd		2	4	\N
\.


--
-- TOC entry 3632 (class 0 OID 16535)
-- Dependencies: 232
-- Data for Name: account_priorpost; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_priorpost (id, designation, employer, dt_join, dt_leav, gross_salary, agp, reason_leaving, pdf, email_id, url_link) FROM stdin;
4	\N	\N	\N	\N	\N	\N	\N		4	\N
1	Research Scientist	Macleods Pharmaceuticals LTD	2007-08-01	2008-05-12	27084	\N	Opportunity to joinJadavpur University as Lecturer		4	https://spoken-tutorial.org/tutorial-search/?search_foss=PHP%20and%20MySQL&search_language=English&page=1
\.


--
-- TOC entry 3630 (class 0 OID 16526)
-- Dependencies: 230
-- Data for Name: account_research; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_research (id, degree, thesis, dt_award, institute, pdf, email_id, url_link) FROM stdin;
4	\N	\N	\N	\N		4	\N
1	PH. D. / D. PHIL.	DEVELOPMENT AND EVALUATION OF\r\nMUCOADHESIVE NASAL DRUG DELIVERY\r\nSYSTEMS OF OXYTOCIN	2008-02-08	JADAVPUR UNIVERSITY		4	\N
\.


--
-- TOC entry 3628 (class 0 OID 16517)
-- Dependencies: 228
-- Data for Name: account_teachingexp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_teachingexp (id, pg_class, ug_class, specialisation, pdf, email_id, url_link, doc_yrs, postdoc_yrs) FROM stdin;
4	12	12	(A) PHARMACEUTICAL JURISPRUDENCE\r\n(B) PHARMACEUTICS\r\n(C) CLINICAL PHARMACY\r\n(D) INDUSTRIAL PHARMACY\r\n(E) PHARMACEUTICAL TECHNOLOGY		4	\N	2	1
\.


--
-- TOC entry 3616 (class 0 OID 16421)
-- Dependencies: 216
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- TOC entry 3618 (class 0 OID 16430)
-- Dependencies: 218
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- TOC entry 3614 (class 0 OID 16414)
-- Dependencies: 214
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add account	1	add_account
2	Can change account	1	change_account
3	Can delete account	1	delete_account
4	Can view account	1	view_account
5	Can add department	2	add_department
6	Can change department	2	change_department
7	Can delete department	2	delete_department
8	Can view department	2	view_department
9	Can add teaching exp	3	add_teachingexp
10	Can change teaching exp	3	change_teachingexp
11	Can delete teaching exp	3	delete_teachingexp
12	Can view teaching exp	3	view_teachingexp
13	Can add research	4	add_research
14	Can change research	4	change_research
15	Can delete research	4	delete_research
16	Can view research	4	view_research
17	Can add prior post	5	add_priorpost
18	Can change prior post	5	change_priorpost
19	Can delete prior post	5	delete_priorpost
20	Can view prior post	5	view_priorpost
21	Can add present post	6	add_presentpost
22	Can change present post	6	change_presentpost
23	Can delete present post	6	delete_presentpost
24	Can view present post	6	view_presentpost
25	Can add orientation	7	add_orientation
26	Can change orientation	7	change_orientation
27	Can delete orientation	7	delete_orientation
28	Can view orientation	7	view_orientation
29	Can add academic	8	add_academic
30	Can change academic	8	change_academic
31	Can delete academic	8	delete_academic
32	Can view academic	8	view_academic
33	Can add api catg_i	9	add_apicatg_i
34	Can change api catg_i	9	change_apicatg_i
35	Can delete api catg_i	9	delete_apicatg_i
36	Can view api catg_i	9	view_apicatg_i
37	Can add api catg_ii	10	add_apicatg_ii
38	Can change api catg_ii	10	change_apicatg_ii
39	Can delete api catg_ii	10	delete_apicatg_ii
40	Can view api catg_ii	10	view_apicatg_ii
41	Can add jrnl_pub	11	add_jrnl_pub
42	Can change jrnl_pub	11	change_jrnl_pub
43	Can delete jrnl_pub	11	delete_jrnl_pub
44	Can view jrnl_pub	11	view_jrnl_pub
45	Can add pub_other	12	add_pub_other
46	Can change pub_other	12	change_pub_other
47	Can delete pub_other	12	delete_pub_other
48	Can view pub_other	12	view_pub_other
49	Can add resch_proj	13	add_resch_proj
50	Can change resch_proj	13	change_resch_proj
51	Can delete resch_proj	13	delete_resch_proj
52	Can view resch_proj	13	view_resch_proj
53	Can add prj_outcm	14	add_prj_outcm
54	Can change prj_outcm	14	change_prj_outcm
55	Can delete prj_outcm	14	delete_prj_outcm
56	Can view prj_outcm	14	view_prj_outcm
57	Can add resch_guide	15	add_resch_guide
58	Can change resch_guide	15	change_resch_guide
59	Can delete resch_guide	15	delete_resch_guide
60	Can view resch_guide	15	view_resch_guide
61	Can add fellow_ award	16	add_fellow_award
62	Can change fellow_ award	16	change_fellow_award
63	Can delete fellow_ award	16	delete_fellow_award
64	Can view fellow_ award	16	view_fellow_award
65	Can add lecture_ paper	17	add_lecture_paper
66	Can change lecture_ paper	17	change_lecture_paper
67	Can delete lecture_ paper	17	delete_lecture_paper
68	Can view lecture_ paper	17	view_lecture_paper
69	Can add e_ learning	18	add_e_learning
70	Can change e_ learning	18	change_e_learning
71	Can delete e_ learning	18	delete_e_learning
72	Can view e_ learning	18	view_e_learning
73	Can add resch_cons	19	add_resch_cons
74	Can change resch_cons	19	change_resch_cons
75	Can delete resch_cons	19	delete_resch_cons
76	Can view resch_cons	19	view_resch_cons
77	Can add log entry	20	add_logentry
78	Can change log entry	20	change_logentry
79	Can delete log entry	20	delete_logentry
80	Can view log entry	20	view_logentry
81	Can add permission	21	add_permission
82	Can change permission	21	change_permission
83	Can delete permission	21	delete_permission
84	Can view permission	21	view_permission
85	Can add group	22	add_group
86	Can change group	22	change_group
87	Can delete group	22	delete_group
88	Can view group	22	view_group
89	Can add content type	23	add_contenttype
90	Can change content type	23	change_contenttype
91	Can delete content type	23	delete_contenttype
92	Can view content type	23	view_contenttype
93	Can add session	24	add_session
94	Can change session	24	change_session
95	Can delete session	24	delete_session
96	Can view session	24	view_session
\.


--
-- TOC entry 3660 (class 0 OID 16896)
-- Dependencies: 260
-- Data for Name: catg_3_e_learning; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catg_3_e_learning (id, model_name, course_name, program_name, prj_url, self_api_score, veri_api_score, email_id) FROM stdin;
1	addadada	xzxzxzx	wqwqwq	\N	10.00	10.00	4
\.


--
-- TOC entry 3656 (class 0 OID 16866)
-- Dependencies: 256
-- Data for Name: catg_3_fellow_award; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catg_3_fellow_award (id, fellow_type, name_fellow, name_body, prj_lvl, prj_url, self_api_score, veri_api_score, email_id) FROM stdin;
4	\N	\N	\N	\N	\N	\N	\N	4
1	FELLOW	dsdsdsd	dsdsds	NATL	\N	10.00	10.00	4
\.


--
-- TOC entry 3646 (class 0 OID 16743)
-- Dependencies: 246
-- Data for Name: catg_3_jrnl_pub; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catg_3_jrnl_pub (id, yr_pub, title_pub, no_auth, role_appl, jrnl_name, vl_pg, jrnl_type, imp_fac, jrnl_url, email_id, self_api_score, veri_api_score, jrnl_link, jrnl_oth) FROM stdin;
4	\N	\N	\N	\N	\N	\N	\N	0.00	\N	4	\N	\N	\N	\N
1	2020	Metronomic chemotherapy of carboplatin-loaded PEGylated MWCNTs: Synthesis, characterization and in-vitro toxicity in human breast cancer	3	O_A	Carbon Letters	30, 435-447	UGC	1.99	http://127.0.0.1:59591/help/help/editgrid.html	4	28.00	28.00	\N	1
2	2020	Ketousetuo\r\nKuotsu Smart and Intelligent Stimuli Responsive Materials: An Innovative\r\nStep in Drug Delivery System	4	FC_A	Current Biochemical Engineering	, 6, 41-52	OTHER	0.00	\N	4	10.00	10.00	\N	0
\.


--
-- TOC entry 3658 (class 0 OID 16881)
-- Dependencies: 258
-- Data for Name: catg_3_lecture_paper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catg_3_lecture_paper (id, invitation_type, title_lecture, seminer, organizer, venue, duration, prj_lvl, prj_url, self_api_score, veri_api_score, email_id) FROM stdin;
1	LECT	lklklklklklk	gdgdgdg	gdgdgdiooo	dasf	2 days	INTR	\N	7.00	7.00	4
\.


--
-- TOC entry 3652 (class 0 OID 16813)
-- Dependencies: 252
-- Data for Name: catg_3_prj_outcm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catg_3_prj_outcm (id, faculty_app, prj_type, proj_title, prj_lvl, ref_no, ptnt_sts, prj_url, prj_pdf, email_id, self_api_score, veri_api_score) FROM stdin;
1	ENGG	MPD	tyuioplj	NATL	212121	\N	\N		4	0.00	0.00
\.


--
-- TOC entry 3648 (class 0 OID 16762)
-- Dependencies: 248
-- Data for Name: catg_3_pub_other; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catg_3_pub_other (id, yr_pub, pub_type, chap_title, bk_title, no_auth, name_pub, sts_pub, isbn_no, pub_url, pub_pdf, email_id, self_api_score, veri_api_score) FROM stdin;
4	\N	\N	\N	\N	\N	\N	\N	\N	\N		4	\N	\N
1	2021	REF_BK	ssaasasa	dserf	2	qwerty	NATL	\N	\N		4	10.00	10.00
\.


--
-- TOC entry 3662 (class 0 OID 16911)
-- Dependencies: 262
-- Data for Name: catg_3_resch_cons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catg_3_resch_cons (id, proj_tag, faculty_app, proj_title, fund_agnc, no_yrs, prj_amt, prj_url, prj_pdf, self_api_score, veri_api_score, email_id) FROM stdin;
1	cons	ENGG	kjhjgfgdfdfdfdddfdfdf	aasadad	2	10.90	\N		10.00	10.00	4
\.


--
-- TOC entry 3654 (class 0 OID 16851)
-- Dependencies: 254
-- Data for Name: catg_3_resch_guide; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catg_3_resch_guide (id, student_name, degree, title_thesis, status, prj_url, self_api_score, veri_api_score, email_id) FROM stdin;
4	\N	\N	\N	\N	\N	\N	\N	4
1	asdfr tyuio	MTECH	dgghhhj hfjgjh ghhgjhj	DEGR	\N	5.00	5.00	4
\.


--
-- TOC entry 3650 (class 0 OID 16779)
-- Dependencies: 250
-- Data for Name: catg_3_resch_proj; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catg_3_resch_proj (id, faculty_app, proj_title, fund_agnc, no_yrs, prj_amt, prj_url, prj_pdf, email_id, self_api_score, veri_api_score, proj_tag) FROM stdin;
4	\N	\N	\N	\N	\N	\N		4	\N	\N	\N
1	ENGG	dfffddfdfd	qwqwq	4	45.09	\N		4	20.00	20.00	spon
\.


--
-- TOC entry 3644 (class 0 OID 16721)
-- Dependencies: 244
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- TOC entry 3612 (class 0 OID 16405)
-- Dependencies: 212
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	account	account
2	account	department
3	account	teachingexp
4	account	research
5	account	priorpost
6	account	presentpost
7	account	orientation
8	account	academic
9	account	apicatg_i
10	account	apicatg_ii
11	catg_3	jrnl_pub
12	catg_3	pub_other
13	catg_3	resch_proj
14	catg_3	prj_outcm
15	catg_3	resch_guide
16	catg_3	fellow_award
17	catg_3	lecture_paper
18	catg_3	e_learning
19	catg_3	resch_cons
20	admin	logentry
21	auth	permission
22	auth	group
23	contenttypes	contenttype
24	sessions	session
\.


--
-- TOC entry 3610 (class 0 OID 16396)
-- Dependencies: 210
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-07-21 09:52:11.559815+05:30
2	contenttypes	0002_remove_content_type_name	2022-07-21 09:52:11.626782+05:30
3	auth	0001_initial	2022-07-21 09:52:11.924599+05:30
4	auth	0002_alter_permission_name_max_length	2022-07-21 09:52:12.304366+05:30
5	auth	0003_alter_user_email_max_length	2022-07-21 09:52:12.344337+05:30
6	auth	0004_alter_user_username_opts	2022-07-21 09:52:12.388307+05:30
7	auth	0005_alter_user_last_login_null	2022-07-21 09:52:12.439277+05:30
8	auth	0006_require_contenttypes_0002	2022-07-21 09:52:12.451268+05:30
9	auth	0007_alter_validators_add_error_messages	2022-07-21 09:52:12.491245+05:30
10	auth	0008_alter_user_username_max_length	2022-07-21 09:52:12.53422+05:30
11	auth	0009_alter_user_last_name_max_length	2022-07-21 09:52:12.574203+05:30
12	auth	0010_alter_group_name_max_length	2022-07-21 09:52:12.61117+05:30
13	auth	0011_update_proxy_permissions	2022-07-21 09:52:12.648147+05:30
14	account	0001_initial	2022-07-21 09:52:12.856021+05:30
15	account	0002_auto_20220321_1303	2022-07-21 09:52:15.447035+05:30
16	account	0003_account_is_applicant	2022-07-21 09:52:16.102182+05:30
17	account	0004_apicatg_i	2022-07-21 09:52:16.208118+05:30
18	account	0005_auto_20220330_2105	2022-07-21 09:52:16.376014+05:30
19	account	0006_auto_20220331_1210	2022-07-21 09:52:16.474954+05:30
20	account	0007_auto_20220402_1634	2022-07-21 09:52:16.614868+05:30
21	account	0008_auto_20220406_1740	2022-07-21 09:52:16.797757+05:30
22	account	0009_account_frm_rejected	2022-07-21 09:52:16.842729+05:30
23	account	0010_auto_20220409_1716	2022-07-21 09:52:17.01662+05:30
24	account	0011_apicatg_ii	2022-07-21 09:52:17.103568+05:30
25	account	0012_research_url_link	2022-07-21 09:52:17.19451+05:30
26	account	0013_account_doc_link	2022-07-21 09:52:17.242483+05:30
27	account	0014_auto_20220608_1051	2022-07-21 09:52:17.333425+05:30
28	account	0015_auto_20220608_1939	2022-07-21 09:52:17.687209+05:30
29	account	0016_auto_20220609_1159	2022-07-21 09:52:17.940053+05:30
30	account	0017_auto_20220609_1555	2022-07-21 09:52:18.244865+05:30
31	account	0018_apicatg_ii_url_fba	2022-07-21 09:52:18.341809+05:30
32	account	0019_account_doc_ref	2022-07-21 09:52:18.471737+05:30
33	account	0020_remove_account_doc_ref	2022-07-21 09:52:18.597651+05:30
34	account	0021_auto_20220622_2200	2022-07-21 09:52:18.919451+05:30
35	account	0022_account_err_tag	2022-07-21 09:52:19.05837+05:30
36	account	0023_auto_20220702_2147	2022-07-21 09:52:19.237256+05:30
37	account	0024_auto_20220709_1021	2022-07-21 09:52:19.494098+05:30
38	account	0025_auto_20220709_1554	2022-07-21 09:52:20.516468+05:30
39	account	0026_auto_20220709_1738	2022-07-21 09:52:20.637392+05:30
40	account	0027_auto_20220709_2035	2022-07-21 09:52:21.375096+05:30
41	account	0028_auto_20220710_1521	2022-07-21 09:52:21.783824+05:30
42	account	0029_account_fwd_link	2022-07-21 09:52:21.832794+05:30
43	admin	0001_initial	2022-07-21 09:52:21.987699+05:30
44	admin	0002_logentry_remove_auto_add	2022-07-21 09:52:22.192913+05:30
45	admin	0003_logentry_add_action_flag_choices	2022-07-21 09:52:22.244878+05:30
46	catg_3	0001_initial	2022-07-21 09:52:22.530702+05:30
47	catg_3	0002_pub_other	2022-07-21 09:52:22.764558+05:30
48	catg_3	0003_auto_20220424_1349	2022-07-21 09:52:23.077369+05:30
49	catg_3	0004_cons_proj	2022-07-21 09:52:23.272245+05:30
50	catg_3	0005_prj_outcm	2022-07-21 09:52:23.505105+05:30
51	catg_3	0006_auto_20220425_2044	2022-07-21 09:52:23.794926+05:30
52	catg_3	0007_book	2022-07-21 09:52:23.909854+05:30
53	catg_3	0008_auto_20220430_1742	2022-07-21 09:52:24.157703+05:30
54	catg_3	0009_auto_20220506_1551	2022-07-21 09:52:24.666388+05:30
55	catg_3	0010_auto_20220509_2213	2022-07-21 09:52:24.957212+05:30
56	catg_3	0011_auto_20220524_2006	2022-07-21 09:52:25.206056+05:30
57	catg_3	0012_auto_20220526_1744	2022-07-21 09:52:25.361962+05:30
58	catg_3	0013_auto_20220528_1717	2022-07-21 09:52:25.629797+05:30
59	catg_3	0014_auto_20220530_2314	2022-07-21 09:52:26.259416+05:30
60	catg_3	0015_fellow_award	2022-07-21 09:52:26.744891+05:30
61	catg_3	0016_lecture_paper	2022-07-21 09:52:27.193612+05:30
62	catg_3	0017_e_learning	2022-07-21 09:52:27.484433+05:30
63	catg_3	0018_resch_cons	2022-07-21 09:52:27.786313+05:30
64	catg_3	0019_auto_20220603_1949	2022-07-21 09:52:28.116563+05:30
65	catg_3	0020_auto_20220605_1944	2022-07-21 09:52:28.178526+05:30
66	catg_3	0021_auto_20220606_1410	2022-07-21 09:52:28.241489+05:30
67	catg_3	0022_auto_20220606_1418	2022-07-21 09:52:28.304451+05:30
68	catg_3	0023_auto_20220606_1516	2022-07-21 09:52:28.382399+05:30
69	catg_3	0024_auto_20220606_1524	2022-07-21 09:52:28.450357+05:30
70	catg_3	0025_auto_20220713_1839	2022-07-21 09:52:28.520315+05:30
71	catg_3	0026_auto_20220713_1942	2022-07-21 09:52:28.587274+05:30
72	catg_3	0027_auto_20220713_2005	2022-07-21 09:52:28.65823+05:30
73	catg_3	0028_auto_20220714_0707	2022-07-21 09:52:28.784153+05:30
74	catg_3	0029_auto_20220714_1025	2022-07-21 09:52:28.860108+05:30
75	sessions	0001_initial	2022-07-21 09:52:29.016009+05:30
\.


--
-- TOC entry 3663 (class 0 OID 16934)
-- Dependencies: 263
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
7xsuc6df71f98v3bgz4tfwy1ij796b50	MDEzNmI0MDM4ZDdlMjA4NTExZDY2OGRhOWZiNmExYzFhYjA4ZTk2MTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5BbGxvd0FsbFVzZXJzTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOWEzZGYxNzY4OGZhMDc3NmE2NDYyZDE1MDgyMWJlYWNjNTM5MWUyYiJ9	2022-08-04 18:02:17.143168+05:30
\.


--
-- TOC entry 3696 (class 0 OID 0)
-- Dependencies: 237
-- Name: account_academic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_academic_id_seq', 2, true);


--
-- TOC entry 3697 (class 0 OID 0)
-- Dependencies: 223
-- Name: account_account_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_account_groups_id_seq', 1, false);


--
-- TOC entry 3698 (class 0 OID 0)
-- Dependencies: 219
-- Name: account_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_account_id_seq', 4, true);


--
-- TOC entry 3699 (class 0 OID 0)
-- Dependencies: 225
-- Name: account_account_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_account_user_permissions_id_seq', 1, false);


--
-- TOC entry 3700 (class 0 OID 0)
-- Dependencies: 239
-- Name: account_apicatg_i_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_apicatg_i_id_seq', 1, false);


--
-- TOC entry 3701 (class 0 OID 0)
-- Dependencies: 241
-- Name: account_apicatg_ii_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_apicatg_ii_id_seq', 1, false);


--
-- TOC entry 3702 (class 0 OID 0)
-- Dependencies: 221
-- Name: account_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_department_id_seq', 1, false);


--
-- TOC entry 3703 (class 0 OID 0)
-- Dependencies: 235
-- Name: account_orientation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_orientation_id_seq', 2, true);


--
-- TOC entry 3704 (class 0 OID 0)
-- Dependencies: 233
-- Name: account_presentpost_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_presentpost_id_seq', 3, true);


--
-- TOC entry 3705 (class 0 OID 0)
-- Dependencies: 231
-- Name: account_priorpost_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_priorpost_id_seq', 1, true);


--
-- TOC entry 3706 (class 0 OID 0)
-- Dependencies: 229
-- Name: account_research_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_research_id_seq', 1, true);


--
-- TOC entry 3707 (class 0 OID 0)
-- Dependencies: 227
-- Name: account_teachingexp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_teachingexp_id_seq', 1, false);


--
-- TOC entry 3708 (class 0 OID 0)
-- Dependencies: 215
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- TOC entry 3709 (class 0 OID 0)
-- Dependencies: 217
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 3710 (class 0 OID 0)
-- Dependencies: 213
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 96, true);


--
-- TOC entry 3711 (class 0 OID 0)
-- Dependencies: 259
-- Name: catg_3_e_learning_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catg_3_e_learning_id_seq', 2, true);


--
-- TOC entry 3712 (class 0 OID 0)
-- Dependencies: 255
-- Name: catg_3_fellow_award_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catg_3_fellow_award_id_seq', 2, true);


--
-- TOC entry 3713 (class 0 OID 0)
-- Dependencies: 245
-- Name: catg_3_jrnl_pub_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catg_3_jrnl_pub_id_seq', 3, true);


--
-- TOC entry 3714 (class 0 OID 0)
-- Dependencies: 257
-- Name: catg_3_lecture_paper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catg_3_lecture_paper_id_seq', 2, true);


--
-- TOC entry 3715 (class 0 OID 0)
-- Dependencies: 251
-- Name: catg_3_prj_outcm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catg_3_prj_outcm_id_seq', 2, true);


--
-- TOC entry 3716 (class 0 OID 0)
-- Dependencies: 247
-- Name: catg_3_pub_other_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catg_3_pub_other_id_seq', 2, true);


--
-- TOC entry 3717 (class 0 OID 0)
-- Dependencies: 261
-- Name: catg_3_resch_cons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catg_3_resch_cons_id_seq', 2, true);


--
-- TOC entry 3718 (class 0 OID 0)
-- Dependencies: 253
-- Name: catg_3_resch_guide_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catg_3_resch_guide_id_seq', 2, true);


--
-- TOC entry 3719 (class 0 OID 0)
-- Dependencies: 249
-- Name: catg_3_resch_proj_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catg_3_resch_proj_id_seq', 2, true);


--
-- TOC entry 3720 (class 0 OID 0)
-- Dependencies: 243
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- TOC entry 3721 (class 0 OID 0)
-- Dependencies: 211
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 24, true);


--
-- TOC entry 3722 (class 0 OID 0)
-- Dependencies: 209
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 75, true);


--
-- TOC entry 3400 (class 2606 OID 16567)
-- Name: account_academic account_academic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_academic
    ADD CONSTRAINT account_academic_pkey PRIMARY KEY (id);


--
-- TOC entry 3360 (class 2606 OID 16470)
-- Name: account_account account_account_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account
    ADD CONSTRAINT account_account_email_key UNIQUE (email);


--
-- TOC entry 3362 (class 2606 OID 16709)
-- Name: account_account account_account_emp_id_5fbd7a2e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account
    ADD CONSTRAINT account_account_emp_id_5fbd7a2e_uniq UNIQUE (emp_id);


--
-- TOC entry 3372 (class 2606 OID 16580)
-- Name: account_account_groups account_account_groups_account_id_group_id_33a11f43_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account_groups
    ADD CONSTRAINT account_account_groups_account_id_group_id_33a11f43_uniq UNIQUE (account_id, group_id);


--
-- TOC entry 3375 (class 2606 OID 16492)
-- Name: account_account_groups account_account_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account_groups
    ADD CONSTRAINT account_account_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3364 (class 2606 OID 16468)
-- Name: account_account account_account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account
    ADD CONSTRAINT account_account_pkey PRIMARY KEY (id);


--
-- TOC entry 3377 (class 2606 OID 16594)
-- Name: account_account_user_permissions account_account_user_per_account_id_permission_id_fa4fbca7_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account_user_permissions
    ADD CONSTRAINT account_account_user_per_account_id_permission_id_fa4fbca7_uniq UNIQUE (account_id, permission_id);


--
-- TOC entry 3381 (class 2606 OID 16504)
-- Name: account_account_user_permissions account_account_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account_user_permissions
    ADD CONSTRAINT account_account_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3403 (class 2606 OID 16652)
-- Name: account_apicatg_i account_apicatg_i_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_apicatg_i
    ADD CONSTRAINT account_apicatg_i_pkey PRIMARY KEY (id);


--
-- TOC entry 3406 (class 2606 OID 16677)
-- Name: account_apicatg_ii account_apicatg_ii_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_apicatg_ii
    ADD CONSTRAINT account_apicatg_ii_pkey PRIMARY KEY (id);


--
-- TOC entry 3367 (class 2606 OID 16483)
-- Name: account_department account_department_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_department
    ADD CONSTRAINT account_department_name_key UNIQUE (name);


--
-- TOC entry 3369 (class 2606 OID 16481)
-- Name: account_department account_department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_department
    ADD CONSTRAINT account_department_pkey PRIMARY KEY (id);


--
-- TOC entry 3397 (class 2606 OID 16558)
-- Name: account_orientation account_orientation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_orientation
    ADD CONSTRAINT account_orientation_pkey PRIMARY KEY (id);


--
-- TOC entry 3394 (class 2606 OID 16549)
-- Name: account_presentpost account_presentpost_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_presentpost
    ADD CONSTRAINT account_presentpost_pkey PRIMARY KEY (id);


--
-- TOC entry 3390 (class 2606 OID 16542)
-- Name: account_priorpost account_priorpost_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_priorpost
    ADD CONSTRAINT account_priorpost_pkey PRIMARY KEY (id);


--
-- TOC entry 3387 (class 2606 OID 16533)
-- Name: account_research account_research_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_research
    ADD CONSTRAINT account_research_pkey PRIMARY KEY (id);


--
-- TOC entry 3384 (class 2606 OID 16524)
-- Name: account_teachingexp account_teachingexp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_teachingexp
    ADD CONSTRAINT account_teachingexp_pkey PRIMARY KEY (id);


--
-- TOC entry 3348 (class 2606 OID 16460)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 3353 (class 2606 OID 16456)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 3356 (class 2606 OID 16435)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3350 (class 2606 OID 16426)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3343 (class 2606 OID 16442)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 3345 (class 2606 OID 16419)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3434 (class 2606 OID 16903)
-- Name: catg_3_e_learning catg_3_e_learning_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_e_learning
    ADD CONSTRAINT catg_3_e_learning_pkey PRIMARY KEY (id);


--
-- TOC entry 3428 (class 2606 OID 16873)
-- Name: catg_3_fellow_award catg_3_fellow_award_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_fellow_award
    ADD CONSTRAINT catg_3_fellow_award_pkey PRIMARY KEY (id);


--
-- TOC entry 3413 (class 2606 OID 16753)
-- Name: catg_3_jrnl_pub catg_3_jrnl_pub_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_jrnl_pub
    ADD CONSTRAINT catg_3_jrnl_pub_pkey PRIMARY KEY (id);


--
-- TOC entry 3431 (class 2606 OID 16888)
-- Name: catg_3_lecture_paper catg_3_lecture_paper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_lecture_paper
    ADD CONSTRAINT catg_3_lecture_paper_pkey PRIMARY KEY (id);


--
-- TOC entry 3422 (class 2606 OID 16821)
-- Name: catg_3_prj_outcm catg_3_prj_outcm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_prj_outcm
    ADD CONSTRAINT catg_3_prj_outcm_pkey PRIMARY KEY (id);


--
-- TOC entry 3416 (class 2606 OID 16771)
-- Name: catg_3_pub_other catg_3_pub_other_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_pub_other
    ADD CONSTRAINT catg_3_pub_other_pkey PRIMARY KEY (id);


--
-- TOC entry 3437 (class 2606 OID 16919)
-- Name: catg_3_resch_cons catg_3_resch_cons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_resch_cons
    ADD CONSTRAINT catg_3_resch_cons_pkey PRIMARY KEY (id);


--
-- TOC entry 3425 (class 2606 OID 16858)
-- Name: catg_3_resch_guide catg_3_resch_guide_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_resch_guide
    ADD CONSTRAINT catg_3_resch_guide_pkey PRIMARY KEY (id);


--
-- TOC entry 3419 (class 2606 OID 16788)
-- Name: catg_3_resch_proj catg_3_resch_proj_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_resch_proj
    ADD CONSTRAINT catg_3_resch_proj_pkey PRIMARY KEY (id);


--
-- TOC entry 3409 (class 2606 OID 16729)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3338 (class 2606 OID 16412)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 3340 (class 2606 OID 16410)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3336 (class 2606 OID 16403)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3440 (class 2606 OID 16940)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 3398 (class 1259 OID 16638)
-- Name: account_academic_email_id_24332243; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_academic_email_id_24332243 ON public.account_academic USING btree (email_id);


--
-- TOC entry 3357 (class 1259 OID 16639)
-- Name: account_account_Department_id_58e3c854; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "account_account_Department_id_58e3c854" ON public.account_account USING btree ("Department_id");


--
-- TOC entry 3358 (class 1259 OID 16473)
-- Name: account_account_email_3d3b3e7a_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_account_email_3d3b3e7a_like ON public.account_account USING btree (email varchar_pattern_ops);


--
-- TOC entry 3370 (class 1259 OID 16581)
-- Name: account_account_groups_account_id_7aa27e9f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_account_groups_account_id_7aa27e9f ON public.account_account_groups USING btree (account_id);


--
-- TOC entry 3373 (class 1259 OID 16582)
-- Name: account_account_groups_group_id_31ca8e7b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_account_groups_group_id_31ca8e7b ON public.account_account_groups USING btree (group_id);


--
-- TOC entry 3378 (class 1259 OID 16595)
-- Name: account_account_user_permissions_account_id_8c2c4a68; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_account_user_permissions_account_id_8c2c4a68 ON public.account_account_user_permissions USING btree (account_id);


--
-- TOC entry 3379 (class 1259 OID 16596)
-- Name: account_account_user_permissions_permission_id_e6a453ba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_account_user_permissions_permission_id_e6a453ba ON public.account_account_user_permissions USING btree (permission_id);


--
-- TOC entry 3401 (class 1259 OID 16658)
-- Name: account_apicatg_i_email_id_3130f019; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_apicatg_i_email_id_3130f019 ON public.account_apicatg_i USING btree (email_id);


--
-- TOC entry 3404 (class 1259 OID 16683)
-- Name: account_apicatg_ii_email_id_60d303e3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_apicatg_ii_email_id_60d303e3 ON public.account_apicatg_ii USING btree (email_id);


--
-- TOC entry 3365 (class 1259 OID 16568)
-- Name: account_department_name_466620ff_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_department_name_466620ff_like ON public.account_department USING btree (name varchar_pattern_ops);


--
-- TOC entry 3395 (class 1259 OID 16632)
-- Name: account_orientation_email_id_f92d2c5f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_orientation_email_id_f92d2c5f ON public.account_orientation USING btree (email_id);


--
-- TOC entry 3391 (class 1259 OID 16625)
-- Name: account_presentpost_department_id_5e1c0265; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_presentpost_department_id_5e1c0265 ON public.account_presentpost USING btree (department_id);


--
-- TOC entry 3392 (class 1259 OID 16626)
-- Name: account_presentpost_email_id_893d2fbc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_presentpost_email_id_893d2fbc ON public.account_presentpost USING btree (email_id);


--
-- TOC entry 3388 (class 1259 OID 16614)
-- Name: account_priorpost_email_id_a882f31a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_priorpost_email_id_a882f31a ON public.account_priorpost USING btree (email_id);


--
-- TOC entry 3385 (class 1259 OID 16608)
-- Name: account_research_email_id_ed595c44; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_research_email_id_ed595c44 ON public.account_research USING btree (email_id);


--
-- TOC entry 3382 (class 1259 OID 16602)
-- Name: account_teachingexp_email_id_00904e4c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_teachingexp_email_id_00904e4c ON public.account_teachingexp USING btree (email_id);


--
-- TOC entry 3346 (class 1259 OID 16461)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 3351 (class 1259 OID 16457)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 3354 (class 1259 OID 16458)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 3341 (class 1259 OID 16443)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 3432 (class 1259 OID 16909)
-- Name: catg_3_e_learning_email_id_b3821706; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX catg_3_e_learning_email_id_b3821706 ON public.catg_3_e_learning USING btree (email_id);


--
-- TOC entry 3426 (class 1259 OID 16879)
-- Name: catg_3_fellow_award_email_id_a636746e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX catg_3_fellow_award_email_id_a636746e ON public.catg_3_fellow_award USING btree (email_id);


--
-- TOC entry 3411 (class 1259 OID 16759)
-- Name: catg_3_jrnl_pub_email_id_ccaacd5a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX catg_3_jrnl_pub_email_id_ccaacd5a ON public.catg_3_jrnl_pub USING btree (email_id);


--
-- TOC entry 3429 (class 1259 OID 16894)
-- Name: catg_3_lecture_paper_email_id_afd6c990; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX catg_3_lecture_paper_email_id_afd6c990 ON public.catg_3_lecture_paper USING btree (email_id);


--
-- TOC entry 3420 (class 1259 OID 16827)
-- Name: catg_3_prj_outcm_email_id_08e083a1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX catg_3_prj_outcm_email_id_08e083a1 ON public.catg_3_prj_outcm USING btree (email_id);


--
-- TOC entry 3414 (class 1259 OID 16777)
-- Name: catg_3_pub_other_email_id_cd833935; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX catg_3_pub_other_email_id_cd833935 ON public.catg_3_pub_other USING btree (email_id);


--
-- TOC entry 3435 (class 1259 OID 16925)
-- Name: catg_3_resch_cons_email_id_315bef79; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX catg_3_resch_cons_email_id_315bef79 ON public.catg_3_resch_cons USING btree (email_id);


--
-- TOC entry 3423 (class 1259 OID 16864)
-- Name: catg_3_resch_guide_email_id_ea4b0f18; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX catg_3_resch_guide_email_id_ea4b0f18 ON public.catg_3_resch_guide USING btree (email_id);


--
-- TOC entry 3417 (class 1259 OID 16794)
-- Name: catg_3_resch_proj_email_id_b8849ad5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX catg_3_resch_proj_email_id_b8849ad5 ON public.catg_3_resch_proj USING btree (email_id);


--
-- TOC entry 3407 (class 1259 OID 16740)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 3410 (class 1259 OID 16741)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 3438 (class 1259 OID 16942)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 3441 (class 1259 OID 16941)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 3456 (class 2606 OID 16633)
-- Name: account_academic account_academic_email_id_24332243_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_academic
    ADD CONSTRAINT account_academic_email_id_24332243_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3445 (class 2606 OID 16640)
-- Name: account_account account_account_Department_id_58e3c854_fk_account_department_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account
    ADD CONSTRAINT "account_account_Department_id_58e3c854_fk_account_department_id" FOREIGN KEY ("Department_id") REFERENCES public.account_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3446 (class 2606 OID 16569)
-- Name: account_account_groups account_account_grou_account_id_7aa27e9f_fk_account_a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account_groups
    ADD CONSTRAINT account_account_grou_account_id_7aa27e9f_fk_account_a FOREIGN KEY (account_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3447 (class 2606 OID 16574)
-- Name: account_account_groups account_account_groups_group_id_31ca8e7b_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account_groups
    ADD CONSTRAINT account_account_groups_group_id_31ca8e7b_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3448 (class 2606 OID 16583)
-- Name: account_account_user_permissions account_account_user_account_id_8c2c4a68_fk_account_a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account_user_permissions
    ADD CONSTRAINT account_account_user_account_id_8c2c4a68_fk_account_a FOREIGN KEY (account_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3449 (class 2606 OID 16588)
-- Name: account_account_user_permissions account_account_user_permission_id_e6a453ba_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_account_user_permissions
    ADD CONSTRAINT account_account_user_permission_id_e6a453ba_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3457 (class 2606 OID 16653)
-- Name: account_apicatg_i account_apicatg_i_email_id_3130f019_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_apicatg_i
    ADD CONSTRAINT account_apicatg_i_email_id_3130f019_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3458 (class 2606 OID 16678)
-- Name: account_apicatg_ii account_apicatg_ii_email_id_60d303e3_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_apicatg_ii
    ADD CONSTRAINT account_apicatg_ii_email_id_60d303e3_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3455 (class 2606 OID 16627)
-- Name: account_orientation account_orientation_email_id_f92d2c5f_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_orientation
    ADD CONSTRAINT account_orientation_email_id_f92d2c5f_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3453 (class 2606 OID 16615)
-- Name: account_presentpost account_presentpost_department_id_5e1c0265_fk_account_d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_presentpost
    ADD CONSTRAINT account_presentpost_department_id_5e1c0265_fk_account_d FOREIGN KEY (department_id) REFERENCES public.account_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3454 (class 2606 OID 16620)
-- Name: account_presentpost account_presentpost_email_id_893d2fbc_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_presentpost
    ADD CONSTRAINT account_presentpost_email_id_893d2fbc_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3452 (class 2606 OID 16609)
-- Name: account_priorpost account_priorpost_email_id_a882f31a_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_priorpost
    ADD CONSTRAINT account_priorpost_email_id_a882f31a_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3451 (class 2606 OID 16603)
-- Name: account_research account_research_email_id_ed595c44_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_research
    ADD CONSTRAINT account_research_email_id_ed595c44_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3450 (class 2606 OID 16597)
-- Name: account_teachingexp account_teachingexp_email_id_00904e4c_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_teachingexp
    ADD CONSTRAINT account_teachingexp_email_id_00904e4c_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3444 (class 2606 OID 16450)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3443 (class 2606 OID 16445)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3442 (class 2606 OID 16436)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3468 (class 2606 OID 16904)
-- Name: catg_3_e_learning catg_3_e_learning_email_id_b3821706_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_e_learning
    ADD CONSTRAINT catg_3_e_learning_email_id_b3821706_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3466 (class 2606 OID 16874)
-- Name: catg_3_fellow_award catg_3_fellow_award_email_id_a636746e_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_fellow_award
    ADD CONSTRAINT catg_3_fellow_award_email_id_a636746e_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3461 (class 2606 OID 16754)
-- Name: catg_3_jrnl_pub catg_3_jrnl_pub_email_id_ccaacd5a_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_jrnl_pub
    ADD CONSTRAINT catg_3_jrnl_pub_email_id_ccaacd5a_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3467 (class 2606 OID 16889)
-- Name: catg_3_lecture_paper catg_3_lecture_paper_email_id_afd6c990_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_lecture_paper
    ADD CONSTRAINT catg_3_lecture_paper_email_id_afd6c990_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3464 (class 2606 OID 16822)
-- Name: catg_3_prj_outcm catg_3_prj_outcm_email_id_08e083a1_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_prj_outcm
    ADD CONSTRAINT catg_3_prj_outcm_email_id_08e083a1_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3462 (class 2606 OID 16772)
-- Name: catg_3_pub_other catg_3_pub_other_email_id_cd833935_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_pub_other
    ADD CONSTRAINT catg_3_pub_other_email_id_cd833935_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3469 (class 2606 OID 16920)
-- Name: catg_3_resch_cons catg_3_resch_cons_email_id_315bef79_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_resch_cons
    ADD CONSTRAINT catg_3_resch_cons_email_id_315bef79_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3465 (class 2606 OID 16859)
-- Name: catg_3_resch_guide catg_3_resch_guide_email_id_ea4b0f18_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_resch_guide
    ADD CONSTRAINT catg_3_resch_guide_email_id_ea4b0f18_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3463 (class 2606 OID 16789)
-- Name: catg_3_resch_proj catg_3_resch_proj_email_id_b8849ad5_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catg_3_resch_proj
    ADD CONSTRAINT catg_3_resch_proj_email_id_b8849ad5_fk_account_account_id FOREIGN KEY (email_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3459 (class 2606 OID 16730)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3460 (class 2606 OID 16735)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_account_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_account_account_id FOREIGN KEY (user_id) REFERENCES public.account_account(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2022-07-21 23:20:22

--
-- PostgreSQL database dump complete
--

