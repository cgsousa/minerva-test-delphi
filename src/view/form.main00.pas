unit form.main00;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    StatusBar1: TStatusBar;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DoCreate(); override;
    procedure DoShow; override;
    procedure DoDestroy; override;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;


implementation

{$R *.dfm}

uses dao.ConnectionManager,
  view.Projects;


{ TfrmMain }

procedure TfrmMain.Button1Click(Sender: TObject);
var
  V: TfrmProjects;
begin
  V :=TfrmProjects.Create(Application);
  try
    V.ShowModal;
  finally
    FreeAndNil(V);
  end;
end;

procedure TfrmMain.DoCreate;
var
  fileCon: string;
begin
  inherited;
  fileCon :=ChangeFileExt(Application.ExeName,'.cfg');
  CreateConnectionManager(fileCon);
end;

procedure TfrmMain.DoDestroy;
begin
  TConnectionManager.destroyInstance ;

end;

procedure TfrmMain.DoShow;
var
  fileCon: string;
begin
  inherited;
  fileCon :=ChangeFileExt(Application.ExeName,'.cfg');
end;

end.
