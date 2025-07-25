unit ropository.intf;

interface

type

  // Plain Old Delphi Object (PODO)
  IRepository<Entity> = interface
    procedure DoInsert(aEntity: Entity);
    procedure DoUpdate(aEntity: Entity);
    procedure DoDelete(aEntity: Entity);
    function find(const aID: Integer): Entity;
    //function find(const aID: Integer): TEnumerable<TEntity>;
  end;

  IDataList<Model> = interface
    function add(aItem: Model): Model ;
  end;


implementation

end.
