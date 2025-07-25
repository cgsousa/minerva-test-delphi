/*
* Questao #3
*/

use projects
go

/*tab_projects 
* 3 projetos fictícios
*/
-- Project #1
insert into tab_projects(nome, descricao)
values ('Desenvolvimento de Software',
        'Um projeto de desenvolvimento de software é um esforço planejado para criar, modificar ou aprimorar um sistema de software.');
-- Project #2
insert into tab_projects(nome, descricao)
values ('Implantação de Software',
        'Um projeto de implantação de software serve para colocar em funcionamento um software, desenvolvido ou adquirido, no ambiente dos usuários finais.');
-- Project #3
insert into tab_projects(nome, descricao)
values ('Consultoria empresarial',
        'Um projeto de consultoria empresarial é a ação de consultores especializados para ajudar uma empresa a resolver problemas, melhorar processos, ou alcançar objetivos estratégicos. O foco do projeto pode variar!');

select *from tab_projects
go

/*tab_employees 
* 5 funcionários fictícios.
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
        'POCs, coleta de requisitos, analise de viabilidades e aprovação de requisitos',
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
        'Desenvolvimento de back-end, desenvolvimento de front-end e integração de APIs',
        @data_inicio,
        @data_termino)
 
 -- task #4
set @data_inicio  =@data_termino;
set @data_termino =dateadd(dd,56,@data_inicio); -- em media 6-8 semanas
insert into tab_projects_tasks(cod_projeto, nome, descricao, data_inicio, data_termino)
values (@cod_projeto, 
        'Testes e garantia de qualidade',
        'Testes unitarios, teste de integração e testes de aceitação',
        @data_inicio,
        @data_termino)

-- task #5
set @data_inicio  =@data_termino;
set @data_termino =dateadd(dd,30,@data_inicio); -- em media 2-4 semanas
insert into tab_projects_tasks(cod_projeto, nome, descricao, data_inicio, data_termino)
values (@cod_projeto, 
        'Implantação',
        'Preparação do ambiente de produção, migração de dados, lançamento do software',
        @data_inicio,
        @data_termino)

select *from tab_projects_tasks
go  


/*tab_projects_allocation 
* 2 funcionários alocados a diferentes tarefas do projeto (1).
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
    -- atualiza projeto e tarefas conforme alocação
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
    -- atualiza tarefa conforme alocação
    update tab_projects_tasks set
      [status]=@status
    where cod_tarefa =@cod_tarefa;

    print 'Alocaçoes executadas com sucesso.'
  commit tran;
end try
begin catch
  if (xact_state()) = -1
  begin
    print 'transaction não comitada, alocaçoes desfeitas!'
    rollback tran;
  end;

  if (xact_state()) = 1
  begin
    print 'Alocaçoes executadas com sucesso.'
    commit tran;   
  end;  
end catch;
go

select *from tab_projects_allocation ;
