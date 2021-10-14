/**
	Sistema para gestão de assistência técnica de uma Oficina de Brinquedos
    @author Eduardo Martins
*/

create database dbtoys;
use dbtoys;

create table usuarios(
	id int primary key auto_increment,
    usuario varchar(50) not null,
    login varchar(50) not null unique,
    senha varchar(250) not null,
    perfil varchar(50) not null
);

describe usuarios;

insert into usuarios(usuario,login,senha,perfil)
values('Eduardo Martins','admin',md5('123456'),'admnistrador');
insert into usuarios(usuario,login,senha,perfil)
values('Jane Smith','jane',md5('123'),'operador');
insert into usuarios(usuario,login,senha,perfil)
values('John Doe','john',md5('456'),'operador jr');

select * from usuarios;

create table clientes(
	idcli int primary key auto_increment,
    nome varchar(50) not null,
    cep char(8),
    endereco varchar(50) not null,
    numero varchar(12) not null,
    complemento varchar(30),
    bairro varchar(50) not null,
    cidade varchar(50) not null,
    uf char(2) not null,
    fone varchar(15) not null
);

insert into clientes (nome,cep,endereco,numero,bairro,cidade,uf,fone)
values('Flávia Silveira','55554444','Rua das Bonecas','45','Liberdade','São Paulo','SP','111112222');

insert into clientes (nome,cep,endereco,numero,bairro,cidade,uf,fone)
values('Renata Soares','44444555','Rua dos Carrinhos','99','Santana','São Paulo','SP','222223333');

insert into clientes (nome,cep,endereco,numero,bairro,cidade,uf,fone)
values('Carla Oliveira','99999444','Rua das Bolas','84','Perdizes','São Paulo','SP','555551111');

insert into clientes (nome,cep,endereco,numero,bairro,cidade,uf,fone)
values('Indiara Flores','12345678','Rua dos Peões','17','Vila Peteca','Mogi das Cruzes','SP','954879333');

insert into clientes (nome,cep,endereco,numero,bairro,cidade,uf,fone)
values('Meg Pereira','45678912','Travessa Quebra Cabeças','45','Jardim Redenção','Jundiaí','SP','789123444');

insert into clientes (nome,cep,endereco,numero,bairro,cidade,uf,fone)
values('Janina Santos','45789124','Estrada Hot Wheels','27','Guaianazes','São Paulo','SP','895671247');

insert into clientes (nome,cep,endereco,numero,bairro,cidade,uf,fone,cpf)
values('Regina Carvalho','45789124','Estrada Hot Wheels','37','Guaianazes','São Paulo','SP','495671241','70903787766');

insert into clientes (nome,cep,endereco,numero,bairro,cidade,uf,fone,cpf)
values('Roberta Silva','45789124','Estrada das Bikes','77','Guaianazes','São Paulo','SP','495671242','50904787744');

insert into clientes (nome,cep,endereco,numero,bairro,cidade,uf,fone,cpf)
values('Rose Magalhães','45789124','Estrada Hot Wheels','87','Guaianazes','São Paulo','SP','495671243','40905787733');

insert into clientes (nome,cep,endereco,numero,bairro,cidade,uf,fone,cpf)
values('Ruby Peixoto','45789124','Estrada Hot Wheels','67','Guaianazes','São Paulo','SP','495671244','30908787722');



alter table clientes add column email varchar(50);

alter table clientes add column cpf char(20) not null;


select * from clientes;

create table orderserv(
	os int primary key auto_increment,
    dataos timestamp default current_timestamp,
    tipo varchar(20) not null,
    statusos varchar(30) not null,
    brinquedo varchar(200) not null,
    defeito varchar(200) not null,
    medico varchar(50),
    valor decimal (10,2),
    idcli int not null,
    foreign key(idcli) references clientes(idcli)
);

alter table orderserv add column origem varchar(50);

alter table orderserv add column medidas varchar(250);

alter table orderserv add column retirada date not null;

describe orderserv;

insert into orderserv
(tipo,statusos,brinquedo,defeito,idcli)
values 
('orçamento','UTI','Boneco Homem Aranha','braço quebrado',1);

insert into orderserv
(tipo,statusos,brinquedo,defeito,idcli)
values 
('orçamento','UTI','Carro Tamiya RC','direção torta',2);

insert into orderserv
(tipo,statusos,brinquedo,defeito,idcli)
values 
('Serviço','Enfermaria','Boneca Barbie','retoque no rosto',3);

insert into orderserv
(tipo,statusos,brinquedo,defeito,idcli)
values 
('Serviço','Liberado','Pula Pirata','mola não funciona',4);

insert into orderserv
(tipo,statusos,brinquedo,defeito,medico,valor,idcli)
values 
('Serviço','Liberado','Dinossauro T-Rex','mandíbula quebrada','Ana','38',5);

insert into orderserv
(tipo,statusos,brinquedo,defeito,medico,valor,idcli)
values 
('Serviço','Liberado','Urso de Pelúcia','faltando olho','Paulo','25',6);

update orderserv set origem='Presencial' where os = 1;
update orderserv set origem='Presencial' where os = 2;
update orderserv set origem='Correios' where os = 3;
update orderserv set origem='Presencial' where os = 4;
update orderserv set origem='Correios' where os = 5;
update orderserv set origem='Correios' where os = 6;
update orderserv set origem='Presencial' where os = 7;

update orderserv set medidas='Colagem das peças quebradas' where os = 1;
update orderserv set medidas='Colagem da direção e realinhamento das rodas' where os = 2;

select * from orderserv;

select * from orderserv inner join clientes
on orderserv.idcli = clientes.idcli;

select * from clientes where nome like 'R%';

select
orderserv.brinquedo,orderserv.defeito,orderserv.statusos as status_os,orderserv.valor,
clientes.nome,clientes.fone
from orderserv inner join clientes
on orderserv.idcli = clientes.idcli
where statusos = 'UTI';

select
orderserv.os,date_format(orderserv.dataos,'%d/%m/%Y - %H:%i') as data_os,orderserv.brinquedo,orderserv.defeito,orderserv.valor,
clientes.nome as cliente
from orderserv inner join clientes
on orderserv.idcli = clientes.idcli
where statusos = 'Liberado';



