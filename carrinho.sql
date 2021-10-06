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
insert into estoque(produto,barcode,fabricante,dataval,quantidade,estoquemin,
medida,valor,loc)
values
('Caneta BIC azul','BIC',20221005,9,10,'CX',28.75,'setor A p2');

insert into estoque(produto,barcode,fabricante,dataval,quantidade,estoquemin,
medida,valor,loc)
values
('Borracha Faber verde','Faber',20251005,100,5,'CX',9.99,'setor B p3');

insert into estoque(produto,barcode,fabricante,dataval,quantidade,estoquemin,
medida,valor,loc)
values
('Réguas Jogo 10','Faber',20191005,30,3,'CX',29.99,'setor B p3');

insert into estoque(produto,barcode,fabricante,dataval,quantidade,estoquemin,
medida,valor,loc)
values
('Fita durex','durex',20201005,50,10,'CX',19.99,'setor B p2');

insert into estoque(produto,barcode,fabricante,dataval,quantidade,estoquemin,
medida,valor,loc)
values
('Cola Bastão','Polar',20261005,4,5,'CX',9.99,'setor B p3');

delete from estoque where codigo=2;

select * from estoque;

-- Inventário do estoque (total)
select sum(quantidade * valor) as total from estoque;

-- Relatório de reposição do estoque 1
select * from estoque where quantidade < estoquemin;

-- Relatório de reposição do estoque 2
-- date_format() -> formatar a exibição da data
-- %d (dia) %m (mês) %y (ano 2 dígitos) %Y (ano 4 dígitos)

select codigo as código,produto,
date_format (dataval,'%d/%m/%Y') as data_validade,quantidade,estoquemin as estoque_mínimo
from estoque where quantidade < estoquemin;

-- Relatório de produtos vencidos 1
select codigo as código,produto,
date_format(dataval,'%d/%m/%Y') as data_validade
from estoque;

-- Relatório de produtos vencidos 2
-- datediff() retorna a diferença em dias de duas datas
-- curdate() data atual
select codigo as código,produto,
date_format(dataval,'%d/"m/%Y') as data_validade,
datediff(dataval,curdate()) as dias_restantes
from estoque;

update estoque set quantidade = '99' where codigo=1;
update estoque set produto = 'Borracha Faber Azul', fabricante = 'Faber Castell', datacad='20191006', dataval='20221006', quantidade='95', estoquemin='3', medida='UN', valor='8.99', loc='setor A p2' where codigo='3';


-- 

select * from carrinho order by produto;
select codigo, produto from carrinho order by codigo desc;

-- CRUD Update
update carrinho set quantidade = '20' where codigo=1;
update carrinho set valor = '50.00' where codigo=3;


-- CRUD delete
delete from carrinho where codigo=5;


