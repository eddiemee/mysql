/**
 Carrinho de compras
 @Author Eduardo Martins
*/ 
show databases;

create database carrinhocompras;

use carrinhocompras;

show tables;

-- decimal (tipo de dado numérico não inteiro 10,2 dez dígitos com 2 casas decimais de precisão)
create table carrinho(
codigo int primary key auto_increment,
produto varchar(250) not null,
quantidade int not null,
valor decimal(10,2) not null
);

describe carrinho;
-- CRUD Create   --valores numericos não usam '' separador de casas decimais é ponto
insert into carrinho(produto,quantidade,valor)
values ('Caneta Bic CX 30',10, 17.50);

insert into carrinho(produto,quantidade,valor)
values ('Borracha Faber CX 30',10, 9.50);

insert into carrinho(produto,quantidade,valor)
values ('Caneta piloto Faber',50, 49.50);

insert into carrinho(produto,quantidade,valor)
values ('Papel Sufite A4',100, 29.50);

insert into carrinho(produto,quantidade,valor)
values ('Kit Réguas',1, 9.50);

-- CRUD Read

select * from carrinho;

-- Operações matemáticas no Banco de dados
select sum(valor * quantidade) as total from carrinho;

-- timestamp default current_timestamp (Data e hora automática)
-- date (tipo de dados relacionados a data) YYYYMMDD
create table estoque(
	codigo int primary key auto_increment,
    barcode varchar(50) unique,
    produto varchar(100) not null,
    fabricante varchar(100) not null,
    datacad timestamp default current_timestamp,
    dataval date not null,
    quantidade int not null,
    estoquemin int not null,
    medida varchar(50) not null,
    valor decimal(10,2),
    loc varchar(100)
);

describe estoque;

-- inserir apenas os itens não automáticos
insert into estoque(produto,fabricante,dataval,quantidade,estoquemin,
medida,valor,loc)
values
('Caneta BIC azul','BIC',20221005,100,10,'CX',28.75,'setor A p2');

insert into estoque(produto,fabricante,dataval,quantidade,estoquemin,
medida,valor,loc)
values
('Borracha Faber verde','Faber',20251005,100,5,'CX',9.99,'setor B p3');

delete from estoque where codigo=2;

select * from estoque;

select * from carrinho order by produto;
select codigo, produto from carrinho order by codigo desc;

-- CRUD Update
update carrinho set quantidade = '20' where codigo=1;
update carrinho set valor = '50.00' where codigo=3;

-- CRUD delete
delete from carrinho where codigo=5;


