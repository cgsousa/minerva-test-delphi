unit Test_usp_projects_tasks;

interface
uses
  DUnitX.TestFramework, dao.ConnectionManager, FireDAC.Comp.Client;

type

  [TestFixture]
  Test_projects_tasks = class(TObject)
  private
    Cmd: TFDQuery;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    [TestCase('TestA','1')]
    [TestCase('TestB','100')]
    //[TestCase('TestB','3,4')]
    procedure TestExec(const aValue: Integer);
  end;

implementation

procedure Test_projects_tasks.Setup;
begin
  CreateConnectionManager('man_project.cfg');
  Cmd :=TConnectionManager.getInstance.newQuery;
end;

procedure Test_projects_tasks.TearDown;
begin
  Cmd :=nil;
end;

procedure Test_projects_tasks.TestExec(const aValue: Integer);
var
  R: Integer;
begin
  Cmd.SQL.Add('declare @cod_projeto numeric(10,0); set @cod_projeto =:cod_projeto');
  Cmd.SQL.Add('exec usp_projects_tasks @cod_projeto =@cod_projeto');
  Cmd.Params[0].AsFloat :=aValue;
//  try
    Cmd.ExecSQL;
    if(Cmd.RecordCount >0)then
      Assert.Pass(' A SP executou conforme parametro.')
    else
      Assert.Pass(' A SP executou mas não retornou dados!')
//  except
//    Assert.Fail('Falha na execução da SP!');
//  end;
end;

initialization
  TDUnitX.RegisterTestFixture(Test_projects_tasks);
end.
