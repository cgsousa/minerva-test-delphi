use projects
go

-- Tabela Responsavel por Armazenar os projetos existentes
if not exists(select o.[object_id] from sys.objects o
              where o.[object_id] =object_id('tab_projects')
              and   o.type ='U')
  create table tab_projects(cod_projeto numeric(10,0) not null identity ,
    nome varchar(50) not null ,
    descricao varchar(250) ,
    data_inicio date null ,
    data_termino date null , 
    [status] tinyint not null default (0), -- 0=não iniciado, 1=em andamento, 2=conculido, 9=cancelado
    constraint pk__tab_projects primary key (cod_projeto) ,
    constraint ck__tab_projects_data_termino check (data_termino >= data_inicio)
  )
go

-- Tabela com as atividades dos projetos.
if not exists(select o.[object_id] from sys.objects o
              where o.[object_id] =object_id('tab_projects_tasks')
              and   o.type ='U')
  create table tab_projects_tasks(cod_tarefa numeric(10,0) not null identity ,
    cod_projeto numeric(10,0) not null ,
    nome varchar(50) not null ,
    descricao varchar(125) ,
    data_inicio date null  ,
    data_termino date null , 
    [status] tinyint not null default (0), -- 0=pendente, 1=em andamento, 2=concluida, 9=cancelada
    constraint pk__tab_projects_tasks 
      primary key (cod_tarefa) ,
    constraint fk__cod_projeto 
      foreign key (cod_projeto ) 
      references tab_projects(cod_projeto),
    constraint ck__tab_projects_tasks_data_termino 
      check (data_termino >= data_inicio)
  )
go

-- Tabela com os Colaboradores
if not exists(select o.[object_id] from sys.objects o
              where o.[object_id] =object_id('tab_employees')
              and   o.type ='U')
  create table tab_employees(cod_funcionario numeric(10,0) not null identity ,
    nome varchar(60) not null ,
    cargo varchar(50) ,
    departamento varchar(50) ,
    constraint pk__tab_employees primary key (cod_funcionario)
  )
go

-- Tabela com as as alocaçoes dos Colaboradores por projetos
if not exists(select o.[object_id] from sys.objects o
              where o.[object_id] =object_id('tab_projects_allocation')
              and   o.type ='U')
  create table tab_projects_allocation(cod_alocacao numeric(10,0) not null identity ,
    cod_funcionario numeric(10,0) not null ,
    cod_tarefa numeric(10,0) not null ,
    data_inicio date null ,
    data_termino date null,
    constraint pk__tab_projects_allocation primary key (cod_alocacao) ,
    constraint fk__cod_funcionario
      foreign key (cod_funcionario) 
      references tab_employees(cod_funcionario) ,
    constraint fk__cod_tarefa
      foreign key (cod_tarefa) 
      references tab_projects_tasks(cod_tarefa),
    constraint ck__tab_projects_allocation_data_termino 
      check (data_termino >= data_inicio)    
  )
go
