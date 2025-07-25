unit repository.employee;

interface

uses
  System.SysUtils, System.Classes,
  System.generics.collections, System.generics.defaults,
  repository.intf, model.employee ;


type
  TEmployeeRepository = class(TInterfacedObject, IRepository<TEmployee>)
  private
  protected
    procedure DoInsert(aEntity: TEmployee);
    procedure DoUpdate(aEntity: TEmployee);
  public
    constructor create(); reintroduce ;
    destructor destroy; override;

    function find(const aID: Integer): TEmployee;
    function findAll(): TObjectList<TEmployee>;
    procedure save(aEntity: TEmployee);
    procedure DoDelete(aEntity: TEmployee);
  end;



implementation

uses FireDAC.Comp.Client, Data.DB, System.Variants,
  dao.ConnectionManager;


{ TEmployeeRepository }

constructor TEmployeeRepository.create;
begin

end;

destructor TEmployeeRepository.destroy;
begin

  inherited;
end;

procedure TEmployeeRepository.DoDelete(aEntity: TEmployee);
begin

end;

procedure TEmployeeRepository.DoInsert(aEntity: TEmployee);
begin

end;

procedure TEmployeeRepository.DoUpdate(aEntity: TEmployee);
begin

end;

function TEmployeeRepository.find(const aID: Integer): TEmployee;
begin

end;

function TEmployeeRepository.findAll: TObjectList<TEmployee>;
var
  conn: TFDConnection;
  rset: TFDQuery ;
var
  cod_funcionario, nome, cargo, departamento: TField;
  employee: TEmployee;
begin
  Result :=nil;
  conn :=TConnectionManager.getInstance().getThreadConnection ;
  try
    if(conn.ExecSQL('select *from tab_employees', nil, TDataSet(rset)) > 0)then
    begin
      cod_funcionario :=rset.FieldByName('cod_funcionario') ;
      nome :=rset.FieldByName('nome')        ;
      cargo :=rset.FieldByName('cargo')   ;
      departamento :=rset.FieldByName('departamento') ;

      Result :=TObjectList<TEmployee>.Create(true);
      repeat
        employee :=TEmployee.Create(cod_funcionario.AsInteger);
        employee.Name :=nome.AsString;
        employee.position :=cargo.AsString;
        employee.department :=departamento.AsString;

        Result.Add(employee);
        rset.Next;
      until(rset.Eof) ;
    end;
  finally
    rset.Free;
  end;
end;

procedure TEmployeeRepository.save(aEntity: TEmployee);
begin

end;

end.
