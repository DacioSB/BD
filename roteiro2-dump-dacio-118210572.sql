--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.19
-- Dumped by pg_dump version 9.5.19
--**COMENTARIOS**
--INSERT INTO AUTOMOVEL (no_placa, chassi, cor, modelo, ano) VALUES ('RIO634', 'FHOA89A67DLA86641910', 'vermelho', 'cruze', 2017);
--SELECT modelo FROM AUTOMOVEL WHERE ano >= 2017;
--INSERT INTO AUTOMOVEL (no_placa, chassi, cor, modelo, ano) VALUES ('MAV785', 'AKDJHA78854ALA893891', 'prata', 'up', 2019), ('PAR', 'A489242KSDDA42394218', 'preto', 'gol', 2011);

--INSERT INTO SEGURO(no_seguro, dataadesao, validade) VALUES (12, '12/07/2018', 2);
--INSERT INTO SEGURO(no_seguro, dataadesao, validade) VALUES (78, '12/07/2018', 10), (43, '09/09/2017', 5);
--SELECT no_seguro FROM SEGURO WHERE validade = 5;
--UPDATE SEGURO SET validade = 3 no_seguro = 43;
--SELECT no_seguro FROM SEGURO WHERE validade = 5; (0 rows)
--SELECT no_seguro FROM SEGURO WHERE validade = 3; (1 row)

--QUESTAO 1:

--CREATE TABLE tarefas(id_funcionario BIGINT, tarefa TEXT, cpf_func CHAR(11), prioridade SMALLINT, status_tarefa CHAR(1));
--INSERT INTO tarefas VALUES(2147483646, 'limpar chao corredor central', '98765432111', 0, 'F');
--INSERT INTO tarefas VALUES(2147483647, 'limpar janelas sala 203', '98765432122', 1, 'F');
--INSERT INTO tarefas VALUES(null, null, null, null, null);

--INSERT INTO tarefas VALUES(2147483644, 'limpar chao corredor superior', '987654321121', 0, 'F'); --(value too long for type character(11))--
--INSERT INTO tarefas VALUES(2147483643, 'limpar janelas sala 203', '98765432122', 1, 'FF'); --value too long for type character(1)--

--QUESTAO 2:

--INSERT INTO tarefas VALUES(2147483648, 'limpar portas do terreo', '32323232955', 4, 'A');
--QUESTAO 3:

--INSERT INTO tarefas VALUES(2147483649, 'limpar portas', '32322525199', 32768, 'A'); --ERROR:  smallint out of range
--SELECT * FROM tarefas;
--INSERT INTO tarefas VALUES(2147483651, 'limpar portas 1o andar', '32323232911', 32767, 'A');
--INSERT INTO tarefas VALUES(2147483652, 'limpar portas 1o andar', '32323232911', 32766, 'A');

--QUESTAO 4:
--ALTER TABLE tarefas ALTER COLUMN id_funcionario SET NOT NULL; --ERROR:  column "id_funcionario" contains null values

--ALTER TABLE tarefas RENAME COLUMN tarefa TO descricao;
--ALTER TABLE tarefas RENAME COLUMN id_funcionario TO id_descricao;

--DELETE FROM tarefas WHERE id_funcionario IS NULL;
--ALTER TABLE tarefas ALTER COLUMN id_funcionario SET NOT NULL;
--ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
--ALTER TABLE tarefas ALTER COLUMN cpf_func SET NOT NULL;
--ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
--ALTER TABLE tarefas ALTER COLUMN status_tarefa SET NOT NULL;

--QUESTAO 5:
--INSERT INTO tarefas VALUES(2147483611, 'limpar portas 1o andar', 32323232911, 2, 'A');
--ALTER TABLE tarefas ADD PRIMARY KEY (id_descricao);
--INSERT INTO tarefas VALUES(2147483653, 'limpar portas 1o andar', 32323232911, 3, 'A'); --ERROR:  duplicate key value violates unique constraint "tarefas_pkey"

--QUESTAO 6A:

--Creio que a constraint do CHAR(11) dada na criação da tabela seja suficiente para 
--promover a integridade da mesma.

--QUESTAO 6B:

--UPDATE tarefas SET status_tarefa = 'P' WHERE status_tarefa = 'A';
--UPDATE tarefas SET status_tarefa = 'C' WHERE status_tarefa = 'F';

--ALTER TABLE tarefas ADD CONSTRAINT status_valido CHECK(status_tarefa = 'P' OR status_tarefa = 'E' OR status_tarefa = 'C');

--QUESTAO 7:
--UPDATE tarefas SET prioridade = 1 WHERE prioridade > 5;
--ALTER TABLE tarefas ADD CONSTRAINT prioridade_valida CHECK(prioridade <= 5);

--QUESTAO 8:
--CREATE TABLE funcionario(cpf CHAR(11) PRIMARY KEY, data_nasc DATE, nome TEXT, nivel CHAR(1), CHECK (nivel = 'J' OR nivel = 'P' OR nivel = 'S'), funcao TEXT, CHECK((funcao = 'LIMPEZA' AND superior_cpf IS NOT NULL) OR funcao = 'SUP_LIMPEZA'), superior_cpf CHAR(11) REFERENCES funcionario(cpf));
--ALTER TABLE funcionario ALTER COLUMN data_nasc SET NOT NULL;
--ALTER TABLE funcionario ALTER COLUMN nome SET NOT NULL;
--ALTER TABLE funcionario ALTER COLUMN nivel SET NOT NULL;
--ALTER TABLE funcionario ALTER COLUMN funcao SET NOT NULL;
--INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678911', '1980-05-07', 'Pedro Silva', 'SUP_LIMPEZA', 'S', null), ('12345678912', '1980-03-08', 'Joao Silva', 'LIMPEZA', 'J', '12345678911'); 
--INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678913', '1980-03-08', 'Joao Silva', 'LIMPEZA', 'J', null); --ERROR:  new row for relation "funcionario" violates check constraint "funcionario_check"

--QUESTAO 9:
--INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678914', '1980-05-07', 'Bruno Silva', 'SUP_LIMPEZA', 'S', null), ('12345678915', '1980-03-08', 'Otavio Silva', 'LIMPEZA', 'J', '12345678914'), ('12345678916', '1980-03-08', 'Leandro Silva', 'SUP_LIMPEZA', 'P', '12345678911'), ('12345678917', '1980-03-08', 'Rodrigo Silva', 'LIMPEZA', 'J', '12345678916'), ('12345678918', '1980-03-08', 'Rodrigo Silva', 'SUP_LIMPEZA', 'S', null); 
--INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678919', '1980-03-08', 'Fabio Silva', 'SUP_LIMPEZA', 'J', null), ('12345678920', '1980-03-08', 'Carlos Silva', 'LIMPEZA', 'J', '12345678919'), ('12345678921', '1980-03-08', 'Mauricio Silva', 'SUP_LIMPEZA', 'P', null); 

--INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('123456789142', '1980-05-07', 'Bruno Silva', 'SUP_LIMPEZA', 'S', null); --ERROR:  value too long for type character(11)
--INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678924', null, 'Bruno Silva', 'SUP_LIMPEZA', 'S', null); --ERROR:  null value in column "data_nasc" violates not-null constraint
--INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678924', '1980-05-07', null, 'SUP_LIMPEZA', 'S', null); --ERROR:  null value in column "nome" violates not-null constraint
--INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678911', '1980-05-07', 'Rafael Silva', 'SUP_LIMPEZA', 'S', null); --ERROR:  duplicate key value violates unique constraint "funcionario_pkey"
--INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678924', '1980-05-07', 'Rafael Silva', 'SUPLIMPEZA', 'S', null); --ERROR:  new row for relation "funcionario" violates check constraint "funcionario_check"
--INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678924', '1980-05-07', 'Rafael Silva', 'SUP_LIMPEZA', 'Z', null); --ERROR:  new row for relation "funcionario" violates check constraint "funcionario_nivel_check"
--INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678924', '1980-05-07', 'Rafael Silva', 'LIMPEZA', 'S', null); --ERROR:  new row for relation "funcionario" violates check constraint "funcionario_check"
--INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678924', '1980-05-07', 'Rafael Silva', 'SUP_LIMPEZA', null, null); --ERROR:  null value in column "nivel" violates not-null constraint
--INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('12345678924', '1980-05-07', 'Rafael Silva', 'LIMPEZA', 'S', '1234567'); --ERROR:  insert or update on table "funcionario" violates foreign key constraint"funcionario_superior_cpf_fkey" DETAIL:  Key (superior_cpf)=(1234567    ) is not present in table "funcionario".

--QUESTAO 10:
--ALTER TABLE funcionario DROP CONSTRAINT funcionario_superior_cpf_fkey;
--ALTER TABLE funcionario ADD CONSTRAINT funcionario_superior_cpf_fkeyFOREIGN KEY (superior_cpf) REFERENCES funcionario(cpf) ON DELETE CASCADE;

--DELETE FROM funcionario WHERE cpf = '12345678911'; --Antes tinha 10 rows (tuplas) agora so temos 6 tuplas por conta da deleção em cascata

--QUESTAO 11:
--**Fim dos comentarios**

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_superior_cpf_fkey;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT tarefas_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: dacio
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc date NOT NULL,
    nome text NOT NULL,
    nivel character(1) NOT NULL,
    funcao text NOT NULL,
    superior_cpf character(11),
    CONSTRAINT funcionario_check CHECK ((((funcao = 'LIMPEZA'::text) AND (superior_cpf IS NOT NULL)) OR (funcao = 'SUP_LIMPEZA'::text))),
    CONSTRAINT funcionario_nivel_check CHECK (((nivel = 'J'::bpchar) OR (nivel = 'P'::bpchar) OR (nivel = 'S'::bpchar)))
);


ALTER TABLE public.funcionario OWNER TO dacio;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: dacio
--

CREATE TABLE public.tarefas (
    id_descricao bigint NOT NULL,
    descricao text NOT NULL,
    cpf_func character(11) NOT NULL,
    prioridade smallint NOT NULL,
    status_tarefa character(1) NOT NULL,
    CONSTRAINT prioridade_valida CHECK ((prioridade <= 5)),
    CONSTRAINT status_valido CHECK (((status_tarefa = 'P'::bpchar) OR (status_tarefa = 'E'::bpchar) OR (status_tarefa = 'C'::bpchar)))
);


ALTER TABLE public.tarefas OWNER TO dacio;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: dacio
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, nivel, funcao, superior_cpf) VALUES ('12345678914', '1980-05-07', 'Bruno Silva', 'S', 'SUP_LIMPEZA', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, nivel, funcao, superior_cpf) VALUES ('12345678915', '1980-03-08', 'Otavio Silva', 'J', 'LIMPEZA', '12345678914');
INSERT INTO public.funcionario (cpf, data_nasc, nome, nivel, funcao, superior_cpf) VALUES ('12345678918', '1980-03-08', 'Rodrigo Silva', 'J', 'SUP_LIMPEZA', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, nivel, funcao, superior_cpf) VALUES ('12345678919', '1980-03-08', 'Fabio Silva', 'J', 'SUP_LIMPEZA', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, nivel, funcao, superior_cpf) VALUES ('12345678920', '1980-03-08', 'Carlos Silva', 'J', 'LIMPEZA', '12345678919');
INSERT INTO public.funcionario (cpf, data_nasc, nome, nivel, funcao, superior_cpf) VALUES ('12345678921', '1980-03-08', 'Mauricio Silva', 'P', 'SUP_LIMPEZA', NULL);


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: dacio
--

INSERT INTO public.tarefas (id_descricao, descricao, cpf_func, prioridade, status_tarefa) VALUES (2147483648, 'limpar portas do terreo', '32323232955', 4, 'P');
INSERT INTO public.tarefas (id_descricao, descricao, cpf_func, prioridade, status_tarefa) VALUES (2147483653, 'limpar portas 1o andar', '32323232911', 2, 'P');
INSERT INTO public.tarefas (id_descricao, descricao, cpf_func, prioridade, status_tarefa) VALUES (2147483646, 'limpar chao corredor central', '98765432111', 0, 'C');
INSERT INTO public.tarefas (id_descricao, descricao, cpf_func, prioridade, status_tarefa) VALUES (2147483647, 'limpar janelas sala 203', '98765432122', 1, 'C');
INSERT INTO public.tarefas (id_descricao, descricao, cpf_func, prioridade, status_tarefa) VALUES (2147483651, 'limpar portas 1o andar', '32323232911', 1, 'P');
INSERT INTO public.tarefas (id_descricao, descricao, cpf_func, prioridade, status_tarefa) VALUES (2147483652, 'limpar portas 1o andar', '32323232911', 1, 'P');


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: tarefas_pkey; Type: CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_pkey PRIMARY KEY (id_descricao);


--
-- Name: funcionario_superior_cpf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dacio
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_superior_cpf_fkey FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

