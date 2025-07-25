unit view.cadastro.project;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, view.ExtCtrls,
  model.project;

type
  TfrmCadProject = class(TWBaseForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    edtName: TLabeledEdit;
    edtCod: TLabeledEdit;
    edtDescr: TMemo;
    edtDateIni: TDateTimePicker;
    edtDateFin: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnSave: TButton;
    btnCancel: TButton;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    FProject: TProject;
  protected
    procedure DoCreate(); override;
    procedure DoShow; override;
    procedure DoInicialize(); override;
  public
    { Public declarations }
    class function Execute(aProject: TProject): Boolean ; static ;
  end;


implementation

{$R *.dfm}

{ TfrmCadProject }

class function TfrmCadProject.Execute(aProject: TProject): Boolean;
var
  V: TfrmCadProject;
begin
  V :=TfrmCadProject.Create(Application) ;
  try
    V.FProject :=aProject ;
    Result :=V.ShowModal = mrOk;
  finally
    FreeAndNil(V);
  end;
end;

procedure TfrmCadProject.btnCancelClick(Sender: TObject);
begin
  ModalResult :=mrCancel;
end;

procedure TfrmCadProject.btnSaveClick(Sender: TObject);
begin
  if edtName.IsEmpty then
  begin
    TaskMessageDlg('Adv','O campo nome deve ser informado!',mtWarning,[mbOK],0);
    edtName.SetFocus ;
    Exit;
  end;
  FProject.Name :=edtName.Text;
  FProject.description :=edtDescr.Text;
  FProject.date_begin :=edtDateIni.Date;
  FProject.date_end :=edtDateFin.Date;
  ModalResult :=mrOk;
end;

procedure TfrmCadProject.DoCreate;
begin
  inherited;

end;

procedure TfrmCadProject.DoInicialize;
begin
  if(FProject = nil)then
    exit;

  if(FProject.iD > 0)then
  begin
    edtCod.Text :=Format('%d',[FProject.iD]);
    edtName.Text :=FProject.Name ;
    edtDescr.Text :=FProject.description ;
    if(FProject.date_begin > 0)then
      edtDateIni.Date :=FProject.date_begin
    else
      edtDateIni.Date :=0;
    if(FProject.date_end > 0)then
      edtDateFin.Date :=FProject.date_end
    else
      edtDateFin.Date :=0;
  end
  else begin
    edtCod.Clear;
    edtName.Clear;
    edtDescr.Clear;
    edtDateIni.Date :=Date;
    edtDateFin.Date :=Date;
  end;
end;

procedure TfrmCadProject.DoShow;
begin
  DoInicialize ;
end;

end.
