--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.19
-- Dumped by pg_dump version 9.5.19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_funcionario_cpf_fkey;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_cliente_cpf_fkey;
ALTER TABLE ONLY public.medicamento DROP CONSTRAINT medicamento_cliente_cadastro_fkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT gerente_fkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_id_farmacia_fkey;
ALTER TABLE ONLY public.medicamento DROP CONSTRAINT fgk_id_venda;
ALTER TABLE ONLY public.entregas DROP CONSTRAINT entregas_cliente_cpf_fkey;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT unique_bairro;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT tipo_exc;
ALTER TABLE ONLY public.medicamento DROP CONSTRAINT medicamento_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_pkey;
ALTER TABLE ONLY public.entregas DROP CONSTRAINT entregas_pkey;
ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
DROP TABLE public.vendas;
DROP TABLE public.medicamento;
DROP TABLE public.funcionario;
DROP TABLE public.farmacia;
DROP TABLE public.entregas;
DROP TABLE public.cliente;
DROP TYPE public.estado;
DROP EXTENSION btree_gist;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: estado; Type: TYPE; Schema: public; Owner: dacio
--

CREATE TYPE public.estado AS ENUM (
    'paraiba',
    'rio grande do norte',
    'sergipe',
    'alagoas',
    'bahia',
    'piaui',
    'pernambuco',
    'ceara',
    'maranhao'
);


ALTER TYPE public.estado OWNER TO dacio;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: dacio
--

CREATE TABLE public.cliente (
    cpf character(11) NOT NULL,
    nome text,
    endereco text,
    birthdate date,
    CONSTRAINT cliente_birthdate_check CHECK ((birthdate < (('now'::text)::date - '18 years'::interval year))),
    CONSTRAINT cliente_endereco_check CHECK (((endereco = 'residencia'::text) OR (endereco = 'trabalho'::text) OR (endereco = 'outro'::text)))
);


ALTER TABLE public.cliente OWNER TO dacio;

--
-- Name: entregas; Type: TABLE; Schema: public; Owner: dacio
--

CREATE TABLE public.entregas (
    id_entrega integer NOT NULL,
    cliente_cpf character(11),
    cliente_endereco text NOT NULL,
    CONSTRAINT entregas_cliente_endereco_check CHECK (((cliente_endereco = 'residencia'::text) OR (cliente_endereco = 'trabalho'::text) OR (cliente_endereco = 'outro'::text)))
);


ALTER TABLE public.entregas OWNER TO dacio;

--
-- Name: farmacia; Type: TABLE; Schema: public; Owner: dacio
--

CREATE TABLE public.farmacia (
    id integer NOT NULL,
    nome text NOT NULL,
    bairro text NOT NULL,
    cidade text NOT NULL,
    tipo character varying(6) NOT NULL,
    gerente character(11) NOT NULL,
    gerente_funcao text,
    estado public.estado NOT NULL,
    CONSTRAINT farmacia_tipo_check CHECK ((((tipo)::text = 'sede'::text) OR ((tipo)::text = 'filial'::text)))
);


ALTER TABLE public.farmacia OWNER TO dacio;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: dacio
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    nome text,
    funcao text NOT NULL,
    id_farmacia integer,
    CONSTRAINT funcionario_funcao_check CHECK (((funcao = 'farmaceutico'::text) OR (funcao = 'vendedor'::text) OR (funcao = 'entregador'::text) OR (funcao = 'caixa'::text) OR (funcao = 'administrador'::text)))
);


ALTER TABLE public.funcionario OWNER TO dacio;

--
-- Name: medicamento; Type: TABLE; Schema: public; Owner: dacio
--

CREATE TABLE public.medicamento (
    id integer NOT NULL,
    nome text,
    caracteristica text,
    id_venda integer,
    cliente_cadastro character(11),
    CONSTRAINT cliente_cadastro_chk CHECK ((((cliente_cadastro IS NULL) AND (caracteristica IS NULL)) OR (cliente_cadastro IS NOT NULL))),
    CONSTRAINT medicamento_caracteristica_check CHECK ((caracteristica = 'venda exclusiva com receita'::text))
);


ALTER TABLE public.medicamento OWNER TO dacio;

--
-- Name: vendas; Type: TABLE; Schema: public; Owner: dacio
--

CREATE TABLE public.vendas (
    id_venda integer NOT NULL,
    cliente_cpf character(11),
    funcionario_cpf character(11),
    vendedor_funcao text,
    CONSTRAINT vendedor_func_chk CHECK ((vendedor_funcao = 'vendedor'::text))
);


ALTER TABLE public.vendas OWNER TO dacio;

--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: dacio
--



--
-- Data for Name: entregas; Type: TABLE DATA; Schema: public; Owner: dacio
--



--
-- Data for Name: farmacia; Type: TABLE DATA; Schema: public; Owner: dacio
--



--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: dacio
--



--
-- Data for Name: medicamento; Type: TABLE DATA; Schema: public; Owner: dacio
--



--
-- Data for Name: vendas; Type: TABLE DATA; Schema: public; Owner: dacio
--



--
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cpf);


--
-- Name: entregas_pkey; Type: CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.entregas
    ADD CONSTRAINT entregas_pkey PRIMARY KEY (id_entrega);


--
-- Name: farmacia_pkey; Type: CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_pkey PRIMARY KEY (id);


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: medicamento_pkey; Type: CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.medicamento
    ADD CONSTRAINT medicamento_pkey PRIMARY KEY (id);


--
-- Name: tipo_exc; Type: CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT tipo_exc EXCLUDE USING gist (tipo WITH =) WHERE (((tipo)::text = 'sede'::text));


--
-- Name: unique_bairro; Type: CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT unique_bairro UNIQUE (bairro);


--
-- Name: vendas_pkey; Type: CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_pkey PRIMARY KEY (id_venda);


--
-- Name: entregas_cliente_cpf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.entregas
    ADD CONSTRAINT entregas_cliente_cpf_fkey FOREIGN KEY (cliente_cpf) REFERENCES public.cliente(cpf) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fgk_id_venda; Type: FK CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.medicamento
    ADD CONSTRAINT fgk_id_venda FOREIGN KEY (id_venda) REFERENCES public.vendas(id_venda);


--
-- Name: funcionario_id_farmacia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_id_farmacia_fkey FOREIGN KEY (id_farmacia) REFERENCES public.farmacia(id);


--
-- Name: gerente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT gerente_fkey FOREIGN KEY (gerente) REFERENCES public.funcionario(cpf);


--
-- Name: medicamento_cliente_cadastro_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.medicamento
    ADD CONSTRAINT medicamento_cliente_cadastro_fkey FOREIGN KEY (cliente_cadastro) REFERENCES public.cliente(cpf);


--
-- Name: vendas_cliente_cpf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_cliente_cpf_fkey FOREIGN KEY (cliente_cpf) REFERENCES public.cliente(cpf);


--
-- Name: vendas_funcionario_cpf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_funcionario_cpf_fkey FOREIGN KEY (funcionario_cpf) REFERENCES public.funcionario(cpf);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--Se chegar esse comentario, eh porque nao deu tempo e tive que enviar essa versao, se nao der tempo, terminar os inserts e updates
CREATE TABLE vendas(id_venda INTEGER PRIMARY KEY, cliente_cpf CHAR(11) REFERENCES cliente(cpf), funcionario_cpf CHAR(11) REFERENCES funcionario(cpf)); 


ALTER TABLE farmacia ADD CONSTRAINT unique_bairro UNIQUE(bairro);
ALTER TABLE MEDICAMENTO ADD COLUMN id_venda INTEGER;
ALTER TABLE cliente ADD COLUMN birthdate DATE;
ALTER TABLE cliente ADD CONSTRAINT cliente_birthdate_check CHECK(birthdate < (current_date - interval '18' year));
ALTER TABLE farmacia ADD CONSTRAINT tipo_exc EXCLUDE USING gist(tipo WITH=) WHERE(tipo = 'sede');

--Nessa parte eu nao sei se entendi bem
--Por exemplo, fiz uma coluna artificial com o cadastro do cliente passando esse cadastro como chave estrangeira para cliente como foi pedido nas dicas
--Pois a questao pede que medicamentos por receita so sejam vendidos para clientes cadastrados
--Contudo, fazendo uma ligacao de chave estrangeira, nunca poderiamos ter clientes nao cadastrados
--A nao ser que passse um cliente null. Dai nao faz muito sentido. Acho que nao entendi bem
ALTER TABLE farmacia ADD COLUMN gerente_funcao TEXT;
ALTER TABLE farmacia ADD CONSTRAINT gerente_func_chk CHECK(gerente_funcao = 'farmaceutico' OR gerente_funcao = 'admnistrador');
ALTER TABLE vendas  ADD COLUMN vendedor_funcao TEXT;
ALTER TABLE vendas ADD CONSTRAINT vendedor_func_chk CHECK(vendedor_funcao = 'vendedor');
ALTER TABLE medicamento ADD COLUMN cliente_cadastro CHAR(11) REFERENCES cliente(cpf);
ALTER TABLE medicamento ADD CONSTRAINT cliente_cadastro_chk CHECK((cliente_cadastro IS NULL AND caracteristica is NULL) OR cliente_cadastro IS NOT NULL);

ALTER TABLE farmacia DROP COLUMN estado;
CREATE TYPE estado AS ENUM('paraiba','rio grande do norte','sergipe','alagoas','bahia','piaui','pernambuco','ceara','maranhao');
ALTER TABLE farmacia ADD COLUMN estado estado NOT NULL;

-- funcionario success insert
INSERT INTO funcionario (
--farmacia success insert
INSERT INTO farmacia (id, nome, bairro, cidade, estado, tipo) VALUES(1, 'drogaria1', 'bairro_generico1', 'cidade_generica1', 'bahia', 
INSERT INTO cliente (cpf, nome, endereco, birthdate) VALUES ('12345678910', 'djubs', 'residencia', '1998-10-12');
INSERT INTO cliente (cpf, nome, endereco, birthdate) VALUES ('12345678911', 'djubirs', 'residencia', '1997-10-12');
INSERT INTO medicamento(id, nome, caracteristica, id_venda, cliente_cadastro) VALUES(123, 'para', null, null, null);
--Abaixo nao aceita
INSERT INTO medicamento(id, nome, caracteristica, id_venda, cliente_cadastro) VALUES(1234, 'para', 'venda exclusiva com receita', null, null);

