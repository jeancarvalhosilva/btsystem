--Criando tabela USUARIO
CREATE TABLE usuario (id                      NUMBER(10)   NOT NULL CONSTRAINT pk_usuario_id PRIMARY KEY
                    , descricao               VARCHAR2(30) NOT NULL
                    , cancelado               VARCHAR2(1)  DEFAULT 'N' NOT NULL
                    , usuario                 NUMBER(10)   NOT NULL
                    , data_criacao            DATE         NOT NULL
                    , data_ultima_atualizacao DATE         NOT NULL);

COMMENT ON TABLE usuario IS 'Usuários do sistema.';

COMMENT ON COLUMN usuario.id                      IS 'Código do registro.';
COMMENT ON COLUMN usuario.descricao               IS 'Descrição da usuário.';
COMMENT ON COLUMN usuario.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN usuario.usuario                 IS 'Usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN usuario.data_criacao            IS 'Data/hora da criação.';
COMMENT ON COLUMN usuario.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice USUARIO
CREATE UNIQUE INDEX ix_usuario ON usuario (id, descricao);

--Criando sequence USUARIO
CREATE SEQUENCE seq_usuario;

--Criando tabela FUNCAO
CREATE TABLE funcao (id                      NUMBER(10)   NOT NULL CONSTRAINT pk_funcao_id PRIMARY KEY
                   , descricao               VARCHAR2(30) NOT NULL
                   , cancelado               VARCHAR2(1)  DEFAULT 'N' NOT NULL
                   , usuario                 NUMBER(10)   NOT NULL
                   , data_ultima_atualizacao DATE         NOT NULL);

COMMENT ON TABLE funcao IS 'Função dos funcionários.';

COMMENT ON COLUMN funcao.id                      IS 'Código do registro.';
COMMENT ON COLUMN funcao.descricao               IS 'Descrição da função.';
COMMENT ON COLUMN funcao.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN funcao.usuario                 IS 'Usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN funcao.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice FUNCAO
CREATE UNIQUE INDEX ix_funcao ON funcao (id, descricao);

--Criando sequence FUNCAO
CREATE SEQUENCE seq_funcao;

--Criando tabela ESCOLARIDADE
CREATE TABLE escolaridade (id                       NUMBER(10)   NOT NULL CONSTRAINT pk_escolaridade_id PRIMARY KEY
                          , descricao               VARCHAR2(80) NOT NULL
                          , cancelado               VARCHAR2(1)  DEFAULT 'N' NOT NULL
                          , usuario                 NUMBER(10)   NOT NULL
                          , data_ultima_atualizacao DATE         NOT NULL);

COMMENT ON TABLE escolaridade IS 'Escolaridade.';

COMMENT ON COLUMN escolaridade.id                      IS 'Código do registro.';
COMMENT ON COLUMN escolaridade.descricao               IS 'Descrição da escolaridade.';
COMMENT ON COLUMN escolaridade.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN escolaridade.usuario                 IS 'Usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN escolaridade.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice ESCOLARIDADE
CREATE UNIQUE INDEX ix_escolaridade ON escolaridade (id, descricao);

--Criando sequence ESCOLARIDADE
CREATE SEQUENCE seq_escolaridade;

--Criando tabela ESTADO
CREATE TABLE estado (id                       NUMBER(10)  CONSTRAINT pk_estado_id PRIMARY KEY
                   , sigla                    VARCHAR2(2) NOT NULL
                   , cancelado                VARCHAR2(1) DEFAULT 'N' NOT NULL
                   , usuario_log_id           NUMBER(10)  NOT NULL
                   , data_ultima_atualizacao  DATE        NOT NULL);

COMMENT ON TABLE estado IS 'Estados brasileiros.';

COMMENT ON COLUMN estado.id                      IS 'Código do registro.';
COMMENT ON COLUMN estado.sigla                   IS 'Sigla do estado.';
COMMENT ON COLUMN estado.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN estado.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN estado.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice ESTADO
CREATE UNIQUE INDEX ix_estado ON estado (id, sigla);

--Criando sequence ESTADO
CREATE SEQUENCE seq_estado;

--Criando tabela CIDADE
CREATE TABLE cidade (id                       NUMBER(10)   CONSTRAINT pk_cidade_id PRIMARY KEY
                   , descricao                VARCHAR2(38) NOT NULL
                   , estado_id                NUMBER(10)   NOT NULL
                   , capital_id               NUMBER(1)
                   , cancelado                VARCHAR2(1)  DEFAULT 'N' NOT NULL
                   , usuario_log_id           NUMBER(10)   NOT NULL
                   , data_ultima_atualizacao  DATE         NOT NULL
                   , CONSTRAINTS fk_cidade_estado_id FOREIGN KEY (estado_id) REFERENCES estado(ID));

COMMENT ON TABLE cidade IS 'Cidades brasileiras.';

COMMENT ON COLUMN cidade.id                      IS 'Código do registro.';
COMMENT ON COLUMN cidade.descricao               IS 'Descrição da cidade.';
COMMENT ON COLUMN cidade.estado_id               IS 'Código do estado.';
COMMENT ON COLUMN cidade.capital_id              IS 'Código da capital.';
COMMENT ON COLUMN cidade.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN cidade.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN cidade.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice CIDADE
CREATE UNIQUE INDEX ix_cidade ON cidade (id, descricao, estado_id);

--Criando sequence CIDADE
CREATE SEQUENCE seq_cidade;

--Criando tabela FUNCIONARIO
CREATE TABLE funcionario (id                      NUMBER(10)   NOT NULL CONSTRAINT pk_funcionario_id PRIMARY KEY
                        , nome                    VARCHAR2(80) NOT NULL
                        , sexo                    VARCHAR2(1)  NOT NULL
                        , data_nascimento         DATE         NOT NULL
                        , documento               VARCHAR2(12)
                        , cpf                     NUMBER(11)   NOT NULL
                        , cep                     NUMBER(8)    NOT NULL
                        , logradouro              VARCHAR2(60) NOT NULL
                        , complemento             VARCHAR2(20)
                        , bairro                  VARCHAR2(50) NOT NULL
                        , cidade_id               NUMBER(10)   NOT NULL
                        , estado_id               NUMBER(10)   NOT NULL
                        , telefone_residencial    NUMBER(12)
                        , celular_prncipal        NUMBER(12)   NOT NULL
                        , celular_recado          NUMBER(12)
                        , escolaridade_id         NUMBER(10)   NOT NULL
                        , funcao_id               NUMBER(10)   NOT NULL
                        , data_cadastro           DATE         NOT NULL
                        , data_admissao           DATE         NOT NULL
                        , data_demissao           DATE             
                        , cancelado               VARCHAR2(1)  DEFAULT 'N' NOT NULL
                        , usuario_log_id          NUMBER(10)   NOT NULL
                        , data_ultima_atualizacao DATE         NOT NULL
                        , CONSTRAINTS fk_funcionario_cidade_id FOREIGN KEY (cidade_id) REFERENCES cidade(id)
                        , CONSTRAINTS fk_funcionario_escolaridade_id FOREIGN KEY (escolaridade_id) REFERENCES escolaridade(id)
                        , CONSTRAINTS fk_funcionario_funcao_id FOREIGN KEY (funcao_id) REFERENCES funcao(id));

COMMENT ON TABLE funcionario IS 'Dados cadastrais de funcionários.';

COMMENT ON COLUMN funcionario.id                      IS 'Código do registro.';
COMMENT ON COLUMN funcionario.nome                    IS 'Nome completo.';
COMMENT ON COLUMN funcionario.sexo                    IS 'Sexo.';
COMMENT ON COLUMN funcionario.data_nascimento         IS 'Data de nascimento.';
COMMENT ON COLUMN funcionario.documento               IS 'Número de documento pessoal RG ou Passaporte.';
COMMENT ON COLUMN funcionario.cpf                     IS 'Número do CPF.';
COMMENT ON COLUMN funcionario.cep                     IS 'CEP do endereço.';
COMMENT ON COLUMN funcionario.logradouro              IS 'Endereço.';
COMMENT ON COLUMN funcionario.complemento             IS 'Complemento do endereço.';
COMMENT ON COLUMN funcionario.bairro                  IS 'Bairro.';
COMMENT ON COLUMN funcionario.cidade_id               IS 'Código cidade.';
COMMENT ON COLUMN funcionario.estado_id               IS 'Código do estado.';
COMMENT ON COLUMN funcionario.telefone_residencial    IS 'Telefone residencial.';
COMMENT ON COLUMN funcionario.celular_prncipal        IS 'Celular principal.';
COMMENT ON COLUMN funcionario.celular_recado          IS 'Celular recado.';
COMMENT ON COLUMN funcionario.escolaridade_id         IS 'Escolaridade.';
COMMENT ON COLUMN funcionario.funcao_id               IS 'Função.';
COMMENT ON COLUMN funcionario.data_cadastro           IS 'Data de cadastro.';
COMMENT ON COLUMN funcionario.data_admissao           IS 'Data de admissão.';
COMMENT ON COLUMN funcionario.data_demissao           IS 'Data de demissão.';
COMMENT ON COLUMN funcionario.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN funcionario.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN funcionario.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice FUNCIONARIO
CREATE UNIQUE INDEX ix_funcionario ON funcionario (id, nome, cpf, funcao_id);

--Criando sequence FUNCIONARIO
CREATE SEQUENCE seq_funcionario;

--Criando tabela ESPECIE
CREATE TABLE especie (id                      NUMBER(10)   NOT NULL CONSTRAINT pk_especie_id PRIMARY KEY
                    , descricao               VARCHAR2(30) NOT NULL
                    , cancelado               VARCHAR2(1)  DEFAULT 'N' NOT NULL
                    , usuario_log_id          NUMBER(10)   NOT NULL
                    , data_ultima_atualizacao DATE         NOT NULL);

COMMENT ON TABLE especie IS 'Espécies de animais.';

COMMENT ON COLUMN especie.id                      IS 'Código do registro.';
COMMENT ON COLUMN especie.descricao               IS 'Descrição da espécie.';
COMMENT ON COLUMN especie.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN especie.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN especie.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice ESPECIE
CREATE UNIQUE INDEX ix_especie ON especie (id, descricao);

--Criando sequence ESPECIE
CREATE SEQUENCE seq_especie;

--Criando tabela RACA
CREATE TABLE raca (id                      NUMBER(10)   NOT NULL CONSTRAINT pk_raca_id PRIMARY KEY
                 , descricao               VARCHAR2(80) NOT NULL
                 , especie_id              NUMBER(10)   NOT NULL
                 , cancelado               VARCHAR2(1)  DEFAULT 'N' NOT NULL
                 , usuario_log_id          NUMBER(10)   NOT NULL
                 , data_ultima_atualizacao DATE         NOT NULL
                 , CONSTRAINTS fk_raca_especie_id FOREIGN KEY (especie_id) REFERENCES especie(id));

COMMENT ON TABLE raca IS 'Raças de animais.';

COMMENT ON COLUMN raca.id                      IS 'Código do registro.';
COMMENT ON COLUMN raca.descricao               IS 'Descrição da raça.';
COMMENT ON COLUMN raca.especie_id              IS 'Código da espécie.';
COMMENT ON COLUMN raca.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN raca.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN raca.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice RAÇA
CREATE UNIQUE INDEX ix_raca ON raca (id, descricao, especie_id);

--Criando sequence RAÇA
CREATE SEQUENCE seq_raca;

--Criando tabela PROPRIETARIO
CREATE TABLE proprietario (id                      NUMBER(10)   NOT NULL CONSTRAINT pk_proprietario_id PRIMARY KEY
                         , nome                    VARCHAR2(80) NOT NULL
                         , sexo                    VARCHAR2(1)  NOT NULL
                         , data_nascimento         DATE         NOT NULL
                         , documento               VARCHAR2(12)
                         , cpf                     NUMBER(11)   NOT NULL
                         , cep                     NUMBER(8)    NOT NULL
                         , logradouro              VARCHAR2(60) NOT NULL
                         , complemento             VARCHAR2(20)
                         , bairro                  VARCHAR2(50) NOT NULL
                         , cidade_id               NUMBER(10)   NOT NULL
                         , estado_id               NUMBER(2)    NOT NULL
                         , telefone_residencial    NUMBER(12)
                         , celular_prncipal        NUMBER(12)   NOT NULL
                         , celular_recado          NUMBER(12)
                         , telefone_comercial      NUMBER(12)
                         , data_cadastro           DATE         NOT NULL
                         , cancelado               VARCHAR2(1)  DEFAULT 'N' NOT NULL
                         , usuario_log_id          NUMBER(10)   NOT NULL
                         , data_ultima_atualizacao DATE         NOT NULL
                         , CONSTRAINTS fk_proprietario_cidade_id FOREIGN KEY (cidade_id) REFERENCES cidade(id));
             
COMMENT ON TABLE proprietario IS 'Dados cadastrais de proprietário de animais.';

COMMENT ON COLUMN proprietario.id                      IS 'Código do registro.';
COMMENT ON COLUMN proprietario.nome                    IS 'Nome completo.';
COMMENT ON COLUMN proprietario.sexo                    IS 'Sexo.';
COMMENT ON COLUMN proprietario.data_nascimento         IS 'Data de nascimento.';
COMMENT ON COLUMN proprietario.documento               IS 'Número de documento pessoal RG ou Passaporte.';
COMMENT ON COLUMN proprietario.cpf                     IS 'Número do CPF.';
COMMENT ON COLUMN proprietario.cep                     IS 'CEP do endereço.';
COMMENT ON COLUMN proprietario.logradouro              IS 'Endereço.';
COMMENT ON COLUMN proprietario.complemento             IS 'Complemento do endereço.';
COMMENT ON COLUMN proprietario.bairro                  IS 'Bairro.';
COMMENT ON COLUMN proprietario.cidade_id               IS 'Código cidade.';
COMMENT ON COLUMN proprietario.estado_id               IS 'Código do estado.';
COMMENT ON COLUMN proprietario.telefone_residencial    IS 'Telefone residencial.';
COMMENT ON COLUMN proprietario.celular_prncipal        IS 'Celular principal.';
COMMENT ON COLUMN proprietario.celular_recado          IS 'Celular recado.';
COMMENT ON COLUMN proprietario.telefone_comercial      IS 'Telefone comercial.';
COMMENT ON COLUMN proprietario.data_cadastro           IS 'Data de cadastro.';
COMMENT ON COLUMN proprietario.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN proprietario.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN proprietario.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice PROPRIETARIO
CREATE UNIQUE INDEX ix_proprietario ON proprietario (id, nome, cpf);

--Criando sequence PROPRIETARIO
CREATE SEQUENCE seq_proprietario;

--Criando tabela ANIMAL
CREATE TABLE animal (id                      NUMBER(10)   NOT NULL CONSTRAINT pk_animal_id PRIMARY KEY
                   , proprietario_id         NUMBER(10)   NOT NULL    
                   , nome                    VARCHAR2(80) NOT NULL
                   , apelido                 VARCHAR2(30)
                   , sexo                    VARCHAR2(1)  NOT NULL
                   , data_nascimento         DATE         NOT NULL
                   , vacinado                VARCHAR2(1)  NOT NULL
                   , peso                    NUMBER(6,3)  NOT NULL
                   , especie_id              NUMBER(10)   NOT NULL
                   , raca_id                 NUMBER(10)   NOT NULL
                   , porte                   VARCHAR2(1)  NOT NULL
                   , pelagem                 VARCHAR2(1)
                   , data_cadastro           DATE         NOT NULL
                   , cancelado               VARCHAR2(1)  DEFAULT 'N' NOT NULL
                   , usuario_log_id          NUMBER(10)   NOT NULL
                   , data_ultima_atualizacao DATE         NOT NULL
                   , CONSTRAINTS fk_animal_proprietario_id FOREIGN KEY (proprietario_id) REFERENCES proprietario (id)
                   , CONSTRAINTS fk_animal_especie_id FOREIGN KEY (especie_id) REFERENCES especie (id)
                   , CONSTRAINTS fk_animal_raca_id FOREIGN KEY (raca_id) REFERENCES raca (id));

COMMENT ON TABLE animal IS 'Dados cadastrais de animais.';

COMMENT ON COLUMN animal.id                      IS 'Código do registro.';
COMMENT ON COLUMN animal.proprietario_id         IS 'Código do registro do proprietário do animal.';
COMMENT ON COLUMN animal.nome                    IS 'Nome completo.';
COMMENT ON COLUMN animal.apelido                 IS 'Apelido.';
COMMENT ON COLUMN animal.sexo                    IS 'Sexo.';
COMMENT ON COLUMN animal.data_nascimento         IS 'Data de nascimento.';
COMMENT ON COLUMN animal.vacinado                IS 'Vacinado Sim/Não.';
COMMENT ON COLUMN animal.peso                    IS 'Peso.';
COMMENT ON COLUMN animal.especie_id              IS 'Código da espécie.';
COMMENT ON COLUMN animal.raca_id                 IS 'Código da raça.';
COMMENT ON COLUMN animal.porte                   IS 'Porte.';
COMMENT ON COLUMN animal.pelagem                 IS 'Tipo da pelagem.';
COMMENT ON COLUMN animal.data_cadastro           IS 'Data de cadastro.';
COMMENT ON COLUMN animal.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN animal.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN animal.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice ANIMAL
CREATE UNIQUE INDEX ix_animal ON animal (id, proprietario_id, nome, especie_id, raca_id);

--Criando sequence ANIMAL
CREATE SEQUENCE seq_animal;

--Criando tabela TIPO_ITEM
CREATE TABLE tipo_item (id                      NUMBER(10)   NOT NULL CONSTRAINT pk_tipo_item_id PRIMARY KEY
                      , descricao               VARCHAR2(80) NOT NULL
                      , cancelado               VARCHAR2(1)  DEFAULT 'N' NOT NULL
                      , usuario_log_id          NUMBER(5)    NOT NULL
                      , data_ultima_atualizacao DATE         NOT NULL);

COMMENT ON TABLE tipo_item IS 'Tabela de tipo de item: Produto / Serviços.';

COMMENT ON COLUMN tipo_item.id                      IS 'Código do registro.';
COMMENT ON COLUMN tipo_item.descricao               IS 'Descriçao do tipo de item.';
COMMENT ON COLUMN tipo_item.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN tipo_item.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN tipo_item.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice TIPO_ITEM
CREATE UNIQUE INDEX IX_tipo_item ON tipo_item (id, descricao);

--Criando sequence TIPO_ITEM
CREATE SEQUENCE seq_tipo_item;

--Criando tabela SERVIÇO
CREATE TABLE servico (id                      NUMBER(10)   NOT NULL CONSTRAINT pk_servico_id PRIMARY KEY
                    , descricao               VARCHAR2(80) NOT NULL
                    , tipo_item_id            NUMBER(10)   NOT NULL
                    , valor                   NUMBER(4,2)  NOT NULL
                    , cancelado               VARCHAR2(1)  DEFAULT 'N' NOT NULL
                    , usuario_log_id          NUMBER(5)    NOT NULL
                    , data_ultima_atualizacao DATE         NOT NULL
                    , CONSTRAINTS fk_servico_tipo_item_id FOREIGN KEY (tipo_item_id) REFERENCES tipo_item (id));

COMMENT ON TABLE servico IS 'Tabela de serviços.';

COMMENT ON COLUMN servico.id                      IS 'Código do registro.';
COMMENT ON COLUMN servico.descricao               IS 'Descrição do item.';
COMMENT ON COLUMN servico.tipo_item_id            IS 'Tipo de item ofertado.';
COMMENT ON COLUMN servico.valor                   IS 'Valor do item ofertado.';
COMMENT ON COLUMN servico.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN servico.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN servico.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice SERVIÇO
CREATE UNIQUE INDEX IX_servico ON servico (id, descricao, tipo_item_id);

--Criando sequence SERVIÇO
CREATE SEQUENCE seq_servico;

--Criando tabela PRODUTO
CREATE TABLE produto (id                      NUMBER(10)   NOT NULL CONSTRAINT pk_produto_id PRIMARY KEY
                    , descricao               VARCHAR2(80) NOT NULL
                    , tipo_item_id            NUMBER(10)   NOT NULL
                    , valor                   NUMBER(4,2)  NOT NULL
                    , cancelado               VARCHAR2(1)  DEFAULT 'N' NOT NULL
                    , usuario_log_id          NUMBER(5)    NOT NULL
                    , data_ultima_atualizacao DATE         NOT NULL
                    , CONSTRAINTS fk_produto_tipo_item_id FOREIGN KEY (tipo_item_id) REFERENCES tipo_item (id));

COMMENT ON TABLE produto IS 'Tabela de produtos.';

COMMENT ON COLUMN produto.id                      IS 'Código do registro.';
COMMENT ON COLUMN produto.descricao               IS 'Descrição do item.';
COMMENT ON COLUMN produto.tipo_item_id            IS 'Tipo de item ofertado.';
COMMENT ON COLUMN produto.valor                   IS 'Valor do item ofertado.';
COMMENT ON COLUMN produto.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN produto.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN produto.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice PRODUTO
CREATE UNIQUE INDEX IX_produto ON produto (id, descricao, tipo_item_id);

--Criando sequence PRODUTO
CREATE SEQUENCE seq_produto;

--Criando tabela ESTOQUE
CREATE TABLE estoque (id                      NUMBER(10)   NOT NULL CONSTRAINT pk_estoque_id PRIMARY KEY
                    , produto_id              NUMBER(10) NOT NULL
                    , quantidade              VARCHAR2(10) NOT NULL
                    , cancelado               VARCHAR2(1)  DEFAULT 'N' NOT NULL
                    , usuario_log_id          NUMBER(5)    NOT NULL
                    , data_ultima_atualizacao DATE         NOT NULL
                    , CONSTRAINTS fk_estoque_produto_id FOREIGN KEY (produto_id) REFERENCES produto (id));

COMMENT ON TABLE estoque IS 'Tabela de estoque de produtos.';

COMMENT ON COLUMN estoque.id                      IS 'Código do registro.';
COMMENT ON COLUMN estoque.produto_id              IS 'Código do produto.';
COMMENT ON COLUMN estoque.quantidade              IS 'Quantidade total.';
COMMENT ON COLUMN estoque.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN estoque.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN estoque.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice ESTOQUE
CREATE UNIQUE INDEX IX_estoque ON estoque (id, produto_id, quantidade);

--Criando sequence ESTOQUE
CREATE SEQUENCE seq_estoque;

--Criando tabela PEDIDO
CREATE TABLE pedido (id                      NUMBER(10)   NOT NULL CONSTRAINT pk_pedido_id PRIMARY KEY
                   , proprietario_id         NUMBER(10)   NOT NULL
                   , data_pedido             DATE         NOT NULL
                   , valor_total             NUMBER(6,2)  NOT NULL
                   , quantidade_total        NUMBER(10)   NOT NULL
                   , observacao              VARCHAR2(80)
                   , cancelado               VARCHAR2(1)  DEFAULT 'N' NOT NULL
                   , usuario_log_id          NUMBER(5)    NOT NULL
                   , data_ultima_atualizacao DATE         NOT NULL
                   , CONSTRAINTS fk_pedido_proprietario_id FOREIGN KEY (proprietario_id) REFERENCES proprietario (id));

COMMENT ON TABLE pedido IS 'Tabela de pedidos.';

COMMENT ON COLUMN pedido.id                      IS 'Código do registro.';
COMMENT ON COLUMN pedido.proprietario_id         IS 'Código do proprietário.';
COMMENT ON COLUMN pedido.data_pedido             IS 'Data do pedido.';
COMMENT ON COLUMN pedido.valor_total             IS 'Valor total do pedido.';
COMMENT ON COLUMN pedido.quantidade_total        IS 'Quantidade total do pedido.';
COMMENT ON COLUMN pedido.observacao              IS 'Observação do pedido.';
COMMENT ON COLUMN pedido.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN pedido.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN pedido.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice PEDIDO
CREATE UNIQUE INDEX IX_pedido ON pedido (id, proprietario_id, data_pedido);

--Criando sequence PEDIDO
CREATE SEQUENCE seq_pedido;

--Criando tabela PEDIDO ITENS
CREATE TABLE pedido_itens  (id                      NUMBER(10)   NOT NULL CONSTRAINT pk_pedido_itens_id PRIMARY KEY
                          , pedido_id               NUMBER(10)   NOT NULL
                          , servico_id              NUMBER(10)
                          , produto_id              NUMBER(10)
                          , valor                   NUMBER(6,2)  NOT NULL
                          , quantidade              NUMBER(10)   NOT NULL
                          , desconto                NUMBER(6,2)
                          , cancelado               VARCHAR2(1)  DEFAULT 'N' NOT NULL
                          , usuario_log_id          NUMBER(5)    NOT NULL
                          , data_ultima_atualizacao DATE         NOT NULL
                          , CONSTRAINTS fk_pedido_itens_pedido_id FOREIGN KEY (pedido_id) REFERENCES pedido (id)
                          , CONSTRAINTS fk_pedido_itens_servico_id FOREIGN KEY (servico_id) REFERENCES servico (id)
                          , CONSTRAINTS fk_pedido_itens_produto_id FOREIGN KEY (produto_id) REFERENCES produto (id));

COMMENT ON TABLE pedido_itens IS 'Tabela de itens dos pedidos.';

COMMENT ON COLUMN pedido_itens.id                      IS 'Código do registro.';
COMMENT ON COLUMN pedido_itens.pedido_id               IS 'Código do pedido.';
COMMENT ON COLUMN pedido_itens.servico_id              IS 'Código do serviço.';
COMMENT ON COLUMN pedido_itens.produto_id              IS 'Código do produto.';
COMMENT ON COLUMN pedido_itens.valor                   IS 'Valor unitário.';
COMMENT ON COLUMN pedido_itens.quantidade              IS 'Quantidade unitária.';
COMMENT ON COLUMN pedido_itens.desconto                IS 'Valor do desconto no item.';
COMMENT ON COLUMN pedido_itens.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN pedido_itens.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN pedido_itens.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice PEDIDO ITENS
CREATE UNIQUE INDEX IX_pedido_itens ON pedido_itens (id, pedido_id, servico_id, produto_id);

--Criando sequence PEDIDO ITENS
CREATE SEQUENCE seq_pedido_itens;

--Criando tabela AGENDAMENTO
CREATE TABLE agendamento (id                      NUMBER(10)  NOT NULL CONSTRAINT pk_agendamento_id PRIMARY KEY
                        , data_atendimento        DATE        NOT NULL
                        , proprietario_id         NUMBER(10)  NOT NULL
                        , data_cadastro           DATE        NOT NULL
                        , delivery                VARCHAR2(1) NOT NULL
                        , cancelado               VARCHAR2(1) DEFAULT 'N' NOT NULL
                        , usuario_log_id          NUMBER(5)   NOT NULL
                        , data_ultima_atualizacao DATE        NOT NULL
                        , CONSTRAINTS fk_agendamento_proprietario_id FOREIGN KEY (proprietario_id) REFERENCES proprietario (id));

COMMENT ON TABLE agendamento IS 'Tabela de agendamento.';

COMMENT ON COLUMN agendamento.id                      IS 'Código do registro.';
COMMENT ON COLUMN agendamento.data_atendimento        IS 'Data do atendimento a ser realizado.';
COMMENT ON COLUMN agendamento.proprietario_id         IS 'Código do proprietário que realizou o agendamento.';
COMMENT ON COLUMN agendamento.data_cadastro           IS 'Data de cadastro.';
COMMENT ON COLUMN agendamento.delivery                IS 'Serviço busca-leva (Sim/Não).';
COMMENT ON COLUMN agendamento.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN agendamento.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN agendamento.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice AGENDAMENTO
CREATE UNIQUE INDEX ix_agendamento ON agendamento (id, data_atendimento, proprietario_id);

--Criando sequence AGENDAMENTO
CREATE SEQUENCE seq_agendamento;

--Criando tabela AGENDAMENTO ITENS
CREATE TABLE agendamento_itens (id                      NUMBER(10)    NOT NULL CONSTRAINT pk_agendamento_itens_id PRIMARY KEY
                              , agendamento_id          NUMBER(10)    NOT NULL
                              , animal_id               NUMBER(10)    NOT NULL
                              , servico_id              NUMBER(10)    NOT NULL
                              , observacao              VARCHAR2(120)
                              , cancelado               VARCHAR2(1) DEFAULT 'N' NOT NULL
                              , usuario_log_id          NUMBER(5)   NOT NULL
                              , data_ultima_atualizacao DATE        NOT NULL
                              , CONSTRAINTS fk_agenda_itens_agendamento_id FOREIGN KEY (agendamento_id) REFERENCES agendamento (id)
                              , CONSTRAINTS fk_agenda_itens_animal_id FOREIGN KEY (animal_id) REFERENCES animal (id)
                              , CONSTRAINTS fk_agenda_itens_servico_id FOREIGN KEY (servico_id) REFERENCES servico (id));
            
COMMENT ON TABLE agendamento_itens IS 'Tabela de itens do agendamento.';

COMMENT ON COLUMN agendamento_itens.id                      IS 'Código do registro.';
COMMENT ON COLUMN agendamento_itens.agendamento_id          IS 'Código do agendamento principal.';
COMMENT ON COLUMN agendamento_itens.animal_id               IS 'Código do animal a ser atendido.';
COMMENT ON COLUMN agendamento_itens.servico_id              IS 'Código do serviço a ser realizado.';
COMMENT ON COLUMN agendamento_itens.observacao              IS 'Observações do serviço a ser realizado.';
COMMENT ON COLUMN agendamento_itens.cancelado               IS 'Cancelado (Sim/Não).';
COMMENT ON COLUMN agendamento_itens.usuario_log_id          IS 'Código do usuário que inseriu/atualizou o registro.';
COMMENT ON COLUMN agendamento_itens.data_ultima_atualizacao IS 'Data/hora que inseriu/atualizou o registro.';

--Criando indice AGENDAMENTO ITENS
CREATE UNIQUE INDEX ix_agendamento_itens ON agendamento_itens (id, agendamento_id, animal_id, servico_id);

--Criando sequence AGENDAMENTO ITENS
CREATE SEQUENCE seq_agendamento_itens;