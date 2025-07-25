unit repository.project;

interface

uses
  System.SysUtils, System.Classes,
  System.generics.collections, System.generics.defaults,
  repository.intf, model.project ;


type
  TProjectRepository = class(TInterfacedObject, IRepository<TProject>)
  private
  protected
    procedure DoInsert(aEntity: TProject);
    procedure DoUpdate(aEntity: TProject);
    procedure DoDelete(aEntity: TProject);
  public
    constructor create(); reintroduce ;
    destructor destroy; override;

    function find(const aID: Integer): TProject;
    function findAll(): TObjectList<TProject>;
    procedure save(aEntity: TProject);
  end;


implementation

uses FireDAC.Comp.Client, Data.DB, System.Variants,
  dao.ConnectionManager;

{ TProjectRepository }

constructor TProjectRepository.create;
begin

end;

destructor TProjectRepository.destroy;
begin

  inherited;
end;

procedure TProjectRepository.DoDelete(aEntity: TProject);
begin

end;

procedure TProjectRepository.DoInsert(aEntity: TProject);
var
  cmd: TFDQuery ;
begin
  cmd :=TConnectionManager.getInstance.newQuery ;
  try
    cmd.SQL.Add('insert into tab_projects ');
    cmd.SQL.Add('       (nome             ');
    cmd.SQL.Add('       ,descricao        ');
    cmd.SQL.Add('       ,data_inicio      ');
    cmd.SQL.Add('       ,data_termino)    ');
    cmd.SQL.Add(' values                  ');
    cmd.SQL.Add('       (:nome            ');
    cmd.SQL.Add('       ,:descricao       ');
    cmd.SQL.Add('       ,:data_inicio     ');
    cmd.SQL.Add('       ,:data_termino)   ');

    cmd.Params.ParamByName('nome').AsString :=aEntity.Name;
    cmd.Params.ParamByName('descricao').AsString :=aEntity.description;

    if(aEntity.date_begin > 0)then
      cmd.Params.ParamByName('data_inicio').AsDate :=aEntity.date_begin
    else
      cmd.Params.ParamByName('data_inicio').AsDate :=0;

    if(aEntity.date_end > 0)then
      cmd.Params.ParamByName('data_termino').AsDate :=aEntity.date_end
    else
      cmd.Params.ParamByName('data_termino').AsDate :=0;

    try
      cmd.ExecSQL ;
    except
      on E:EDatabaseError do
      begin
        raise EModelInsertError.Create('Projeto');
      end;
    end;
  finally
    cmd.Free;
  end;
end;

procedure TProjectRepository.DoUpdate(aEntity: TProject);
var
  cmd: TFDQuery ;
begin
  cmd :=TConnectionManager.getInstance.newQuery ;
  try

    cmd.SQL.Add('update tab_projects               ');
    cmd.SQL.Add('   set nome = :nome               ');
    cmd.SQL.Add('      ,descricao :descricao       ');
    cmd.SQL.Add('      ,data_inicio =:data_inicio  ');
    cmd.SQL.Add('      ,data_termino =:data_termino');
    cmd.SQL.Add('where cod_projeto = :cod_projeto  ');

    cmd.Params.ParamByName('nome').AsString :=aEntity.Name;
    cmd.Params.ParamByName('descricao').AsString :=aEntity.description;

    if(aEntity.date_begin > 0)then
      cmd.Params.ParamByName('data_inicio').AsDate :=aEntity.date_begin
    else
      cmd.Params.ParamByName('data_inicio').AsDate :=0;

    if(aEntity.date_end > 0)then
      cmd.Params.ParamByName('data_termino').AsDate :=aEntity.date_end
    else
      cmd.Params.ParamByName('data_termino').AsDate :=0;

    try
      cmd.ExecSQL ;
    except
      on E:EDatabaseError do
      begin
        raise EModelUpdateError.Create('Projeto');
      end;
    end;
  finally
    cmd.Free;
  end;
end;

function TProjectRepository.find(const aID: Integer): TProject;
begin

end;

function TProjectRepository.findAll: TObjectList<TProject>;
var
  conn: TFDConnection;
  rset: TFDQuery ;
var
  cod_projeto, nome, descricao, data_inicio, data_termino, status: TField;
  project: TProject;
begin
  Result :=nil;
  conn :=TConnectionManager.getInstance().getThreadConnection ;
  try
    if(conn.ExecSQL('select *from tab_projects', nil, TDataSet(rset)) > 0)then
    begin
      cod_projeto :=rset.FieldByName('cod_projeto') ;
      nome        :=rset.FieldByName('nome')        ;
      descricao   :=rset.FieldByName('descricao')   ;
      data_inicio :=rset.FieldByName('data_inicio') ;
      data_termino:=rset.FieldByName('data_termino');
      status      :=rset.FieldByName('status')      ;


      Result :=TObjectList<TProject>.Create(true);
      repeat
        project :=TProject.Create(cod_projeto.AsInteger);
        project.Name :=nome.AsString;
        project.description :=descricao.AsString;
        project.date_begin :=data_inicio.AsDateTime;
        project.date_end :=data_termino.AsDateTime;
        project.status :=TProjectStatus(status.AsInteger);
        Result.Add(project);
        rset.Next;
      until(rset.Eof) ;
    end;
  finally
    rset.Free;
  end;

end;

procedure TProjectRepository.save(aEntity: TProject);
begin
  if(aEntity = nil)then
    Exit;
  if(aEntity.iD > 0)then
    DoUpdate(aEntity)
  else
    DoInsert(aEntity);
end;

end.
