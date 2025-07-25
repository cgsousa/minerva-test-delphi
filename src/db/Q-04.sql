/*
* Questao #4
* 
* SP que liste todas as tarefas de um projeto que ainda não foram concluídas e que possuem 
* funcionários alocados a elas. A procedure deve receber o código do projeto como parâmetro 
* de entrada e retornar as informações das tarefas e dos funcionários alocados.
*/

use projects
go

if exists(select o.[object_id] from sys.objects o
              where o.[object_id] =object_id('usp_projects_tasks')
              and   objectproperty(o.[object_id], N'IsProcedure') = 1)
  drop procedure usp_projects_tasks
go

create procedure usp_projects_tasks(
  @cod_projeto  numeric(10,0)  
)as
  declare @ret_codigo int; set @ret_codigo =0;
  declare @ret_noproj int; set @ret_noproj =10100;
  declare @ret_notask int; set @ret_notask =10101;
  /*declare @ret_noemit int ; set @ret_noemit =10103;
  declare @ret_nodest int ; set @ret_nodest =10105;
  declare @ret_nomfre int ; set @ret_nomfre =10107;
  declare @ret_nondoc int ; set @ret_nondoc =10109;  
  declare @ret_exists int ; set @ret_exists =10111;*/
  
  --// valida projeto
  if not exists(select cod_projeto from tab_projects where cod_projeto =@cod_projeto)
  begin
    raiserror(N'Projeto (%d) enexistente!', 16, 1, @cod_projeto)
    return @ret_noproj
  end;

  --// valida tarefas
  if not exists(select cod_tarefa from tab_projects_tasks where cod_projeto =@cod_projeto)
  begin
    raiserror(N'Nenhuma tarefa vinculada ao projeto (%d)!', 16, 1, @cod_projeto)
    return @ret_notask
  end;

  select 
    t.cod_tarefa, t.nome, t.descricao, t.data_inicio, t.data_termino, t.status,
    c.cod_funcionario, c.nome, c.cargo, c.departamento
  from tab_projects_allocation a
  inner join tab_employees c      on c.cod_funcionario  =a.cod_funcionario
  inner join tab_projects_tasks t on t.cod_tarefa       =a.cod_tarefa
  where t.cod_projeto =@cod_projeto
go

