/**
 E-Commerce
 @Author Eduardo Martins
*/ 


create database dbloja;

use dbloja;

create table clientes (
	idcli int primary key auto_increment,
	nome varchar(50) not null,
	email varchar(50) unique not null,
	senha varchar(250) not null
);

insert into clientes (nome,email,senha)
values('José de Assis','jose@email.com',md5('123456'));

select * from clientes;
describe clientes;

-- timestamp default current_timestamp (Data e hora automática)
-- date (tipo de dados relacionados a data) YYYYMMDD
create table produtos(
	codigo int primary key auto_increment,
    barcode varchar(50) unique,
    produto varchar(100) not null,
    fabricante varchar(100) not null,
    datacad timestamp default current_timestamp,
    dataval date not null,
    estoque int not null,
    estoquemin int not null,
    medida varchar(50) not null,
    valor decimal(10,2),
    loc varchar(100)
);

describe produtos;

-- inserir apenas os itens não automáticos
insert into produtos(produto,fabricante,dataval,estoque,estoquemin,
medida,valor,loc)
values
('Caneta BIC azul','BIC',20221005,9,10,'CX',28.75,'setor A p2');

insert into produtos(produto,fabricante,dataval,estoque,estoquemin,
medida,valor,loc)
values
('Borracha Faber verde','Faber',20251005,100,5,'CX',9.99,'setor B p3');

insert into produtos(produto,fabricante,dataval,estoque,estoquemin,
medida,valor,loc)
values
('Réguas Jogo 10','Faber',20191005,30,3,'CX',29.99,'setor B p3');

insert into produtos(produto,fabricante,dataval,estoque,estoquemin,
medida,valor,loc)
values
('Fita durex','durex',20201005,50,10,'CX',19.99,'setor B p2');

insert into produtos(produto,fabricante,dataval,estoque,estoquemin,
medida,valor,loc)
values
('Cola Bastão','Polar',20261005,4,5,'CX',9.99,'setor B p3');

delete from produtos where codigo=2;

select * from produtos;

-- Inventário do estoque (total)
select sum(estoque * valor) as total from produtos;

-- Relatório de reposição do estoque 1
select * from produtos where estoque < estoquemin;

-- Relatório de reposição do estoque 2
-- date_format() -> formatar a exibição da data
-- %d (dia) %m (mês) %y (ano 2 dígitos) %Y (ano 4 dígitos)

select codigo as código,produto,
date_format (dataval,'%d/%m/%Y') as data_validade,estoque,estoquemin as estoque_mínimo
from estoque where quantidade < estoquemin;

-- Relatório de produtos vencidos 1
select codigo as código,produto,
date_format(dataval,'%d/%m/%Y') as data_validade
from produto;

-- Relatório de produtos vencidos 2
-- datediff() retorna a diferença em dias de duas datas
-- curdate() data atual
select codigo as código,produto,
date_format(dataval,'%d/"m/%Y') as data_validade,
datediff(dataval,curdate()) as dias_restantes
from produto;

update produtos set estoque = '99' where codigo=1;
update produtos set produto = 'Borracha Faber Azul', fabricante = 'Faber Castell', datacad='20191006', dataval='20221006', quantidade='95', estoquemin='3', medida='UN', valor='8.99', loc='setor A p2' where codigo='3';



show tables;

-- decimal (tipo de dado numérico não inteiro 10,2 dez dígitos com 2 casas decimais de precisão)
create table pedidos(
	pedido int primary key auto_increment,
    dataped timestamp default current_timestamp,
    total decimal(10,2),
    idcli int not null,
    foreign key(idcli) references clientes(idcli)
);

insert into pedidos(idcli) values(1);
select * from pedidos;

-- abertura do pedido
select 
pedidos.pedido,
date_format(pedidos.dataped,'%d/%m/%Y - %H:%i') as data_pedido,
clientes.nome as cliente, clientes.email as e_mail
from pedidos inner join clientes
on pedidos.idcli = clientes.idcli;

-- tabela de apoio, não tem int
create table carrinho (
	pedido int not null,    -- chave estrangeira
    codigo int not null,    -- chave estrangeira
    quantidade int not null,
    foreign key(pedido) references pedidos(pedido),
    foreign key(codigo) references produtos(codigo)
);

select * from carrinho;

insert into carrinho (pedido,codigo,quantidade)
values (1,1,5);
insert into carrinho (pedido,codigo,quantidade)
values (1,2,4);

-- exibir o carrinho (traz campos selecionados de tabelas selecionadas)
select 
pedidos.pedido,
carrinho.codigo as código,
produtos.produto,
carrinho.quantidade, 
produtos.valor,
produtos.valor * carrinho.quantidade as sub_total
from (carrinho inner join pedidos on carrinho.pedido = pedidos.pedido)
inner join produtos on carrinho.codigo = produtos.codigo;

-- total do carrinho (não tem campo valor, vem da tabela produtos)
select sum(produtos.valor * carrinho.quantidade) as total
from carrinho inner join produtos on carrinho.codigo = produtos.codigo;

-- atualizar o banco de dados após o fechamento do pedido
update carrinho
inner join produtos
on carrinho.codigo = produtos.codigo 
set produtos.estoque = produtos.estoque - carrinho.quantidade
where carrinho.quantidade > 0;






