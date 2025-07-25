unit dao.ConnectionManager;

interface

uses
  System.SysUtils, System.Classes, System.generics.collections, System.SyncObjs,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, FireDAC.Stan.Option,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.DApt, FireDAC.VCLUI.Wait,
  System.IniFiles ;

type

  TConnectionString = class
  strict private
    const ID_SERVER = 'server';
    const ID_PORT = 'port';
    const ID_USER = 'user';
    const ID_PWD = 'password';
    const ID_DATABASE = 'database_name';
  private
    fProxy: TIniFile;
    fServer: string;
    fPort: Integer;
    fUser: string;
    fPassword: string;
    fDatabase: string;
  protected
    SectionName: string;
  public
    constructor Create(const aFileName: string); reintroduce;
    destructor Destroy; override;
    property server: string read fServer;
    property port: Integer read fPort;
    property user: string read fUser;
    property password: string read fPassword;
    property database: string read fDatabase;
  end;


  TConnectionManager = class sealed
  strict private
	  class var _instance: TConnectionManager;
  private
  	fSQLDialect, fLibraryPath, fServer: string;
  	fPort: Integer;
  	fUserName, fPassword, fDatabaseName: string;
    constructor create(); reintroduce;
    destructor destroy(); override;
  public
    class function createInstance(): TConnectionManager;
    class function getInstance(): TConnectionManager; static;
    class procedure destroyInstance();

  public
    procedure setServer(const aValue: string);
    procedure setPort(const aValue: Integer);
    procedure setUserName(const aValue: string);
    procedure setPassword(const aValue: string);
    procedure setDatabaseName(const aValue: string);
    function getThreadConnection(): TFDConnection;
    function newQuery(): TFDQuery ;
  end;


procedure CreateConnectionManager(const aFileName: string);


implementation

uses Winapi.Windows,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef;


procedure CreateConnectionManager(const aFileName: string);
var
  cs: TConnectionString;
  cm: TConnectionManager;
begin
  cs :=TConnectionString.Create(aFileName);
  try
    cm :=TConnectionManager.getInstance ;
    cm.setServer(cs.server);
    cm.setPort(cs.port);
    cm.setUserName(cs.user);
    cm.setPassword(cs.password);
    cm.setDatabaseName(cs.database);
  finally
    cs.Free;
  end;
end;

{ TConnectionString }

constructor TConnectionString.Create(const aFileName: string);
begin
  fProxy :=TIniFile.Create(aFileName);
  SectionName :=ExtractFileName(aFileName);
  fServer :=fProxy.ReadString(SectionName,ID_SERVER,'.\SQLEXPRESS2019');
  fPort :=fProxy.ReadInteger(SectionName,ID_PORT,0);
  fUser :=fProxy.ReadString(SectionName,ID_USER,'');
  fPassword :=fProxy.ReadString(SectionName,ID_PWD,'*');
  fDatabase :=fProxy.ReadString(SectionName,ID_DATABASE,'projects');
end;

destructor TConnectionString.Destroy;
begin
  fProxy.WriteString(SectionName,ID_SERVER,fServer);
  fProxy.WriteInteger(SectionName,ID_PORT,fPort);
  fProxy.WriteString(SectionName,ID_USER,fUser);
  fProxy.WriteString(SectionName,ID_PWD,fPassword);
  fProxy.WriteString(SectionName,ID_DATABASE,fDatabase);
  fProxy.Destroy ;
  inherited;
end;

{ TConnectionManager }

constructor TConnectionManager.create;
begin
  fPort :=-1;
  fSQLDialect :='MSSQL';
end;

class function TConnectionManager.createInstance: TConnectionManager;
begin
  Result :=getInstance();
end;

destructor TConnectionManager.destroy;
var
  localID: TThreadID;
  connName: String;
  conn: TFDConnection;
begin
  localID :=GetCurrentThreadId;

  connName :=Format('%dFireDAC%s',[localID,fSQLDialect]);

  conn :=TFDConnection(FDManager.FindConnection(connName)) ;
  if(conn <> nil)then
  begin
    conn.Free;
  end;
  inherited;
end;

class procedure TConnectionManager.destroyInstance;
begin
  FreeAndNil(_instance);
end;

class function TConnectionManager.getInstance: TConnectionManager;
begin
  if(_instance = nil)then
  begin
    _instance :=TConnectionManager.Create();
  end;
  Result :=_instance;
end;

function TConnectionManager.getThreadConnection: TFDConnection;
var
  localID: TThreadID;
  connName: String;
  connDef: TFDPhysMSSQLConnectionDefParams ;
begin
    localID :=GetCurrentThreadId;

    connName :=Format('%dFireDAC%s',[localID,fSQLDialect]);

    Result :=TFDConnection(FDManager.FindConnection(connName)) ;
    if(Result <> nil)then
    begin
      Exit;
    end;

    try
      Result :=TFDConnection.Create(nil);
      Result.ConnectionName :=connName;
      Result.DriverName :=fSQLDialect ;

      connDef :=(Result.Params as TFDPhysMSSQLConnectionDefParams);
      //connDef.ApplicationName :=app
      connDef.Server :=fServer;
      connDef.Database :=fDatabaseName;
      connDef.OSAuthent:=True;

      Result.LoginPrompt :=False;

    except
      raise ;
    end;
end;

function TConnectionManager.newQuery: TFDQuery;
begin
  Result :=TFDQuery.Create(nil);
  Result.Connection :=getThreadConnection;
end;

procedure TConnectionManager.setDatabaseName(const aValue: string);
begin
  if(fDatabaseName <> aValue)then
    fDatabaseName :=aValue;
end;

procedure TConnectionManager.setServer(const aValue: string);
begin
  if(fServer <> aValue)then
    fServer :=aValue;
end;

procedure TConnectionManager.setPassword(const aValue: string);
begin

end;

procedure TConnectionManager.setPort(const aValue: Integer);
begin

end;

procedure TConnectionManager.setUserName(const aValue: string);
begin

end;

end.
