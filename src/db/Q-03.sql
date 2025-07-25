/*
* Questao #3
*/

use projects
go

/*tab_projects 
* 3 projetos fict�cios
*/
-- Project #1
insert into tab_projects(nome, descricao)
values ('Desenvolvimento de Software',
        'Um projeto de desenvolvimento de software � um esfor�o planejado para criar, modificar ou aprimorar um sistema de software.');
-- Project #2
insert into tab_projects(nome, descricao)
values ('Implanta��o de Software',
        'Um projeto de implanta��o de software serve para colocar em funcionamento um software, desenvolvido ou adquirido, no ambiente dos usu�rios finais.');
-- Project #3
insert into tab_projects(nome, descricao)
values ('Consultoria empresarial',
        'Um projeto de consultoria empresarial � a a��o de consultores especializados para ajudar uma empresa a resolver problemas, melhorar processos, ou alcan�ar objetivos estrat�gicos. O foco do projeto pode variar!');

select *from tab_projects
go

/*tab_employees 
* 5 funcion�rios fict�cios.
*/
-- Employee #1
insert into tab_employees(nome, cargo, departamento)
values ('Carlos Sousa', 'Desenvolvedor', 'TI');
-- Employee #2
insert into tab_employees(nome, cargo, departamento)
values ('Jhonanthy Almeida', 'Desenvolvedor', 'TI');
-- Employee #3
insert into tab_employees(nome, cargo, departamento)
values ('Otavio Gonzaga', 'Analista de Sistemas', 'TI');
-- Employee #4
insert into tab_employees(nome, cargo, departamento)
values ('Jose Soares', 'QA', 'TI');
-- Employee #5
insert into tab_employees(nome, cargo, departamento)
values ('Maria Assis', 'Suporte', 'TI');

select *from tab_employees
go


/*tab_projects_tasks 
* 5 tarefas para o projeto: 1-Desenvolvimento de Software
*/
declare @cod_projeto  numeric(10,0) ; set @cod_projeto  =1;
declare @data_inicio  date          ;
declare @data_termino date          ;

-- task #1
set @data_inicio  =convert(date,getdate());
set @data_termino =dateadd(dd,30,@data_inicio); -- em media 4 semanas
insert into tab_projects_tasks(cod_projeto, nome, descricao, data_inicio, data_termino)
values (@cod_projeto, 
        'Planejamento e analise de requisitos',
        'POCs, coleta de requisitos, analise de viabilidades e aprova��o de requisitos',
        @data_inicio,
        @data_termino)

-- task #2
set @data_inicio  =@data_termino;
set @data_termino =dateadd(dd,44,@data_inicio); -- em media 4-6 semanas
insert into tab_projects_tasks(cod_projeto, nome, descricao, data_inicio, data_termino)
values (@cod_projeto, 
        'Design do sistema',
        'Arquitetura do sistema, design de UI e prototipagem',
        @data_inicio,
        @data_termino)

-- task #3
set @data_inicio  =@data_termino;
set @data_termino =dateadd(dd,112,@data_inicio); -- em media 12-16 semanas
insert into tab_projects_tasks(cod_projeto, nome, descricao, data_inicio, data_termino)
values (@cod_projeto, 
        'Desenvolvimento',
        'Desenvolvimento de back-end, desenvolvimento de front-end e integra��o de APIs',
        @data_inicio,
        @data_termino)
 
 -- task #4
set @data_inicio  =@data_termino;
set @data_termino =dateadd(dd,56,@data_inicio); -- em media 6-8 semanas
insert into tab_projects_tasks(cod_projeto, nome, descricao, data_inicio, data_termino)
values (@cod_projeto, 
        'Testes e garantia de qualidade',
        'Testes unitarios, teste de integra��o e testes de aceita��o',
        @data_inicio,
        @data_termino)

-- task #5
set @data_inicio  =@data_termino;
set @data_termino =dateadd(dd,30,@data_inicio); -- em media 2-4 semanas
insert into tab_projects_tasks(cod_projeto, nome, descricao, data_inicio, data_termino)
values (@cod_projeto, 
        'Implanta��o',
        'Prepara��o do ambiente de produ��o, migra��o de dados, lan�amento do software',
        @data_inicio,
        @data_termino)

select *from tab_projects_tasks
go  


/*tab_projects_allocation 
* 2 funcion�rios alocados a diferentes tarefas do projeto (1).
*/
set xact_abort on;
go

declare @cod_projeto      numeric(10,0) ; set @cod_projeto=1;
declare @status           tinyint       ; set @status     =1;
declare @cod_funcionario  numeric(10,0) ; 
declare @cod_tarefa       numeric(10,0) ; 
declare @data_inicio      date          ;
declare @data_termino     date          ;

begin try
  begin tran
    -- alocation #1
    set @cod_funcionario=3;
    set @cod_tarefa     =1;
    select  @data_inicio  =data_inicio,
            @data_termino =data_termino
    from tab_projects_tasks
    where cod_tarefa =@cod_tarefa;
    insert into tab_projects_allocation ( cod_funcionario,
                                          cod_tarefa,
                                          data_inicio,
                                          data_termino)
    values                              ( @cod_funcionario,
                                          @cod_tarefa,
                                          @data_inicio,
                                          @data_termino);
    -- atualiza projeto e tarefas conforme aloca��o
    update tab_projects set 
      [status]=@status,
      data_inicio =@data_inicio
    where cod_projeto =@cod_projeto;
    update tab_projects_tasks set
      [status]=@status
    where cod_tarefa =@cod_tarefa;

    -- alocation #2
    set @cod_funcionario=1;
    set @cod_tarefa     =2;
    select  @data_inicio  =data_inicio,
            @data_termino =data_termino
    from tab_projects_tasks
    where cod_tarefa =@cod_tarefa;
    insert into tab_projects_allocation ( cod_funcionario,
                                          cod_tarefa,
                                          data_inicio,
                                          data_termino)
    values                              ( @cod_funcionario,
                                          @cod_tarefa,
                                          @data_inicio,
                                          @data_termino);
    -- atualiza tarefa conforme aloca��o
    update tab_projects_tasks set
      [status]=@status
    where cod_tarefa =@cod_tarefa;

    print 'Aloca�oes executadas com sucesso.'
  commit tran;
end try
begin catch
  if (xact_state()) = -1
  begin
    print 'transaction n�o comitada, aloca�oes desfeitas!'
    rollback tran;
  end;

  if (xact_state()) = 1
  begin
    print 'Aloca�oes executadas com sucesso.'
    commit tran;   
  end;  
end catch;
go

select *from tab_projects_allocation ;
