unit repository.intf;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  System.generics.collections, System.generics.defaults;

type

  TMadelStatus = (psNone, psStarted, psFinish, psCancel);

  // Plain Old Delphi Object (PODO)
  IRepository<Entity> = interface
    procedure DoInsert(aEntity: Entity);
    procedure DoUpdate(aEntity: Entity);
    procedure DoDelete(aEntity: Entity);
    function find(const aID: Integer): Entity;
    //function findAll(): TEnumerable<Entity>;
    procedure save(aEntity: Entity);
  end;

  IDataList<Model> = interface
    function add(aItem: Model): Model ;
  end;

  EModelInsertError = class(EDatabaseError)
  public
    constructor Create(const aModel: string); reintroduce;
  end;

  EModelUpdateError = class(EDatabaseError)
  public
    constructor Create(const aModel: string); reintroduce;
  end;

  EModelDeleteError = class(EDatabaseError)
  public
    constructor Create(const aModel: string); reintroduce;
  end;


implementation

{ EModelInsertError }

constructor EModelInsertError.Create(const aModel: string);
begin
  inherited CreateFmt('Não foi possivel inserir o "%s" no banco de dados!'#13#10'%s',[aModel,Self.Message]
  );
end;

{ EModelUpdateError }

constructor EModelUpdateError.Create(const aModel: string);
begin
  inherited CreateFmt('Não foi possivel atualizarr o "%s" no banco de dados!'#13#10'%s',[aModel,Self.Message]
  );
end;

{ EModelDeleteError }

constructor EModelDeleteError.Create(const aModel: string);
begin
  inherited CreateFmt('Não foi possivel deletar o "%s" no banco de dados!'#13#10'%s',[aModel,Self.Message]
  );
end;

end.
