show databases;

create database dbagenda;

use dbagenda;

show tables;
-- criando uma tabela 
-- toda tabela precisa de uma chave primaria PK
-- int (tipo de dados -> numeros inteiros
-- primary key -> transforma este campo em chave primaria
-- auto_increment -> numeração automática
-- varchar (tipo de dados equivalente a String (50) número máximo de caracteres)
-- not null -> preenchimento obrigatório
-- unique -> não permite valores duplicados na tabela
-- virgula , -> pede continuação do código, quando não tem sinaliza o fim

create table contatos(
 id int primary key auto_increment,
 nome varchar(50) not null,
 fone varchar(15) not null,
 email varchar(50) unique 
 
 );

-- descrição da tabela 
describe contatos;

-- alterar o nome de um campo na tabela
alter table contatos change nome contatos varchar(50) not null;

-- adicionar um novo campo na tabela
alter table contatos add column obs varchar(250);

-- adicionar um novo campo (coluna) em local específico na tabela
alter table contatos add column fone2 varchar(15) after fone;

-- modificar o tipo de dados na coluna e/ou validações
alter table contatos modify column fone2 int;
alter table contatos modify column email varchar(100) not null;

-- excluir uma coluna da tabela
alter table contatos drop column obs;

-- excluir a tabela (perde tudo)
drop table contatos;

-- CRUD (Create Read Update Delete)
-- operações básicas de bando de dados

-- CRUD Create
insert into contatos(nome,fone,email)
values ('Eduardo Martins','1111-2222','eddmail@mail.com');

insert into contatos(nome,fone,email)
values ('Priscila Martins','1111-2223','primail@mail.com');

insert into contatos(nome,fone,email)
values ('Vicente Martins','1111-2224','vicmail@mail.com');

insert into contatos(nome,fone,email)
values ('Ailton Martins','1111-2225','altmail@mail.com');

insert into contatos(nome,fone)
values ('Antonia Martins','1111-2226');

insert into contatos(nome,fone)
values ('Allison Martins','1111-2227');

insert into contatos(nome,fone)
values ('Amanda Martins','1111-2228');

insert into contatos(nome,fone)
values ('Aston Martins','1111-2229');
-- CRUD Read
-- selecionar todos os registros(dados) da tabela
select * from contatos;

-- selecionar colunas específicas da tabela
select nome, fone from contatos;

-- selecionar colunas em ordem crescente e decrescente
select * from contatos order by nome;
select id, nome from contatos order by id desc;

-- uso de filtros
select * from contatos where id = 1;
select * from contatos where nome = 'Aston Martins';
select * from contatos where nome like 'A%';

-- CRUD Update
-- ATENÇÂO! Não esqueça do where e usar sempre o id para evitar problemas
update contatos set email='astonmart@mail.com' where id = 8;
update contatos set fone='9999-1234' where id = 1;
update contatos set nome='Allison Martins', fone = '98077-7777', email='allison@mail.com' where id=6;

-- CRUD Delete
-- ATENÇÂO! Não esqueça do where e usar sempre o id para evitar problemas
delete from contatos where id=6;





