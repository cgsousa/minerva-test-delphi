unit form.CadProject;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ComCtrls,
  repository.project, model.project, Vcl.StdCtrls, System.Actions, Vcl.ActnList;

type
  TfrmCadProject = class(TForm)
    StatusBar1: TStatusBar;
    lvGrid: TListView;
    alStd: TActionList;
    actNew: TAction;
    actUpd: TAction;
    actDel: TAction;
    btnClose: TButton;
    btnNew: TButton;
    btnUpd: TButton;
    btnDel: TButton;
  private
    { Private declarations }
    repo: TProjectRepository;
    procedure DoLoadGrid ;
    procedure DoLoadGridChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  protected
    procedure DoCreate(); override;
    procedure DoShow; override;
    procedure DoDestroy; override;

  public
    { Public declarations }
  end;



implementation

{$R *.dfm}

uses System.generics.collections;


{ TfrmCadProject }

procedure TfrmCadProject.DoCreate;
begin
  inherited;
  repo :=TProjectRepository.create ;
end;

procedure TfrmCadProject.DoDestroy;
begin
  repo.Destroy ;
  inherited;
end;

procedure TfrmCadProject.DoLoadGrid;
var
  projects: TObjectList<TProject>;
  project: TProject;
  item: TListItem;
begin
  projects :=repo.findAll();
  if(projects = nil)then
    exit;
  lvGrid.Clear ;
  for project in projects do
  begin
    item :=lvGrid.Items.Add;
    item.Data :=project;
    item.Caption :=project.iD.ToString;
    item.SubItems.Add(project.Name);
    if(project.date_begin > 0)then
      item.SubItems.Add(DateToStr(project.date_begin))
    else
      item.SubItems.Add('-');
    if(project.date_end > 0)then
      item.SubItems.Add(DateToStr(project.date_end))
    else
      item.SubItems.Add('-');
  end;
end;

procedure TfrmCadProject.DoLoadGridChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  project: TProject ;
begin
  if(Item.Data = nil)then
    Exit;
  project :=TProject(Item.Data) ;
end;

procedure TfrmCadProject.DoShow;
begin
  DoLoadGrid ;

end;

end.
