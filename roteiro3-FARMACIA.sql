CREATE TABLE farmacia(id INTEGER PRIMARY KEY, nome TEXT NOT NULL, bairro TEXT NOT NULL, cidade TEXT NOT NULL, estado TEXT NOT NULL, tipo VARCHAR(6) NOT NULL, CHECK(tipo = 'sede' OR tipo = 'filial'), gerente CHAR(11) NOT NULL);
CREATE TABLE funcionario(cpf CHAR(11) PRIMARY KEY, nome TEXT, funcao TEXT NOT NULL, CHECK(funcao = 'farmaceutico' OR funcao = 'vendedor' OR funcao = 'entregador' OR funcao = 'caixa' OR funcao = 'administrador'), id_farmacia INTEGER REFERENCES farmacia(id));
ALTER TABLE farmacia ADD CONSTRAINT gerente_fkey FOREIGN KEY(gerente) REFERENCES funcionario(cpf);

CREATE TABLE cliente(cpf CHAR(11) PRIMARY KEY, nome TEXT, endereco TEXT, CHECK(endereco = 'residencia' OR endereco = 'trabalho' OR endereco = 'outro');
CREATE TABLE medicamento(id INTEGER PRIMARY KEY, nome TEXT, caracteristica TEXT, CHECK(caracteristica = 'venda exclusiva com receita'));

CREATE TABLE entregas(id_entrega INTEGER PRIMARY KEY, cliente_cpf CHAR(11) REFERENCES cliente(cpf) ON DELETE CASCADE ON UPDATE CASCADE, cliente_endereco TEXT NOT NULL, CHECK(cliente_endereco = 'residencia' OR cliente_endereco = 'trabalho' OR cliente_endereco = 'outro'));

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
