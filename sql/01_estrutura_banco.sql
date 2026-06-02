Criação -table 

create schema corretora;


create type corretora.tipo_risco as enum('conservador', 'moderado', 'arrojado');


create table corretora.cliente(
	cpf char(11) primary key,
	nome varchar(60) not null,
	data_nasc date not null,
	perfil_risco corretora.tipo_risco not null,
	email varchar(150) unique
);

create table corretora.telefone_cliente (
  cpf_fk char(11),
  telefone varchar(20),
  PRIMARY KEY (cpf_fk, telefone),
  FOREIGN KEY (cpf_fk) references corretora.cliente(cpf)
);


create table corretora.endereco(
	id serial primary key,
	cep char(8) not null,
	rua varchar(150),
	bairro varchar(100),
	cidade varchar(100) not null,
	estado varchar(15) not null,
	cpf_fk char(11) not null references corretora.cliente(cpf)
);


create type corretora.tipo_conta as enum('PF', 'PJ');

create table corretora.conta(
	numero varchar(20) primary key,
	saldo_disponivel decimal(15,2) default 0.00,
	data_abertura date not null,
	tipo corretora.tipo_conta not null,
	cpf_fk char(11) not null references corretora.cliente(cpf)	
);

create table corretora.categoria_ativo(
	id serial primary key,
	nome varchar(60) not null unique
);

create type corretora.tipo_ativo as enum('acao', 'fii', 'cdb', 'lci', 'lca', 'cripto');

create table corretora.ativo(
	codigo varchar(20) not null primary key,
	nome varchar(100) not null,
	tipo corretora.tipo_ativo not null,
	valor_atual decimal(15,6) not null,
	id_categoria_fk int not null references corretora.categoria_ativo(id) 
);


create table corretora.historico_preco(
	id serial primary key,
	data date not null,
	preco_abertura decimal (15,6),
	preco_fechamento decimal(15,6) not null,
	codigo_ativo_fk varchar(20) not null references corretora.ativo(codigo) 
);

create type corretora.tipo_ordem as enum('compra', 'venda');
create type corretora.status_ordem as enum('pendente', 'executada', 'cancelada');

create table corretora.ordem(
	id serial primary key,
	data timestamp not null,
	tipo corretora.tipo_ordem not null,
	quantidade decimal(15,6) not null,
	status corretora.status_ordem not null,
	numero_conta_fk varchar(20) not null references corretora.conta(numero),
	codigo_ativo_fk varchar(20) not null references corretora.ativo(codigo)
);

create table corretora.operacao(
	id serial primary key,
	data timestamp not null,
	tipo corretora.tipo_ordem not null,
	preco_unitario decimal(15,6) not null,
	quantidade decimal(15,6) not null,
	numero_conta_fk varchar(20) not null references corretora.conta(numero),
	codigo_ativo_fk varchar(20) not null references corretora.ativo(codigo),
	id_ordem_fk int not null references corretora.ordem(id)
);

create table corretora.posicao(
	id serial primary key,
	preco_medio decimal(15,5) not null,
	quantidade_atual decimal(15,5) not  null,
	numero_conta_fk varchar(20) not null references corretora.conta(numero),
	codigo_ativo_fk varchar(20) not null references corretora.ativo(codigo)
);



create type corretora.tipo_rendimento as enum('dividendo', 'jcp', 'rendimento_fixo');



create table corretora.rendimento(
	id serial primary key,
	data date not null,
	valor decimal(15,6) not null,
	tipo corretora.tipo_rendimento not null,
	codigo_ativo_fk varchar(20) not null references corretora.ativo(codigo)
);

create table corretora.rendimento_conta (
    id_rendimento_fk int references corretora.rendimento(id),
    numero_conta_fk varchar(20) references corretora.conta(numero),
    valor_creditado decimal(15,6) not null,
    primary key (id_rendimento_fk, numero_conta_fk)
);


create table corretora.funcionario(
	id serial primary key,
	cpf char(11) not null unique,
	nome varchar(100) not null,
	cargo varchar(60) not null,
	salario decimal(10,2) not null,
	data_admissao date not null	
);

create table corretora.assessor(
	id_funcionario_fk int primary key references corretora.funcionario(id),
	credenciamento varchar(20),
	comissao_percentual decimal (5,2) not null
);

create table corretora.assessor_cliente(
	id_assessor_fk int references corretora.assessor(id_funcionario_fk),
	cpf_cliente_fk char(11) references corretora.cliente(cpf),
	data_inicio date not null,
	primary key (id_assessor_fk, cpf_cliente_fk)
);


create type corretora.tipo_taxa as enum('corretagem', 'administracao', 'custodia');


create table corretora.taxa(
	id serial primary key,
	descricao text not null,
	percentual decimal(5,2) not null,
	tipo corretora.tipo_taxa not null,
	id_categoria_fk int not null references corretora.categoria_ativo(id)
);
