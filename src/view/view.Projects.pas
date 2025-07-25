unit view.Projects;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ComCtrls,
  Vcl.StdCtrls, System.Actions, Vcl.ActnList, view.ExtCtrls,
  System.generics.collections,
  repository.project, model.project;

type
  TfrmProjects = class(TWBaseForm)
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
    procedure actNewExecute(Sender: TObject);
    procedure actUpdExecute(Sender: TObject);
  private
    { Private declarations }
    repo: TProjectRepository;
    projects: TObjectList<TProject>;
    project: TProject ;
    procedure DoLoadGrid ;
    procedure DoLoadGridChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  protected
    procedure DoCreate(); override;
    procedure DoShow; override;
    procedure DoDestroy; override;
    procedure DoInicialize(); override;

  public
    { Public declarations }
  end;



implementation

{$R *.dfm}

uses repository.intf, view.cadastro.project;


{ TfrmCadProject }

procedure TfrmProjects.actNewExecute(Sender: TObject);
var
  project: TProject;
begin
  project :=TProject.Create(0);
  if TfrmCadProject.Execute(project)then
  begin
    try
      repo.save(project);
      TaskMessageDlg('Ifo','Projeto incluido com sucesso.',mtInformation,[mbOK],0);
      DoLoadGrid;
    except on E:EModelInsertError do
      TaskMessageDlg('Err',E.Message,mtError,[mbOK],0);
    end;
  end
  else begin
    project.Free;
    ActiveControl :=lvGrid;
  end;
end;

procedure TfrmProjects.actUpdExecute(Sender: TObject);
begin
  if TfrmCadProject.Execute(project)then
  begin
    try
      repo.save(project);
      TaskMessageDlg('Ifo','Projeto alterado com sucesso.',mtInformation,[mbOK],0);
      DoLoadGrid;
    except on E:EModelUpdateError do
      TaskMessageDlg('Err',E.Message,mtError,[mbOK],0);
    end;
  end
  else
    ActiveControl :=lvGrid;
end;

procedure TfrmProjects.DoCreate;
begin
  inherited;
  repo :=TProjectRepository.create ;
  projects :=nil;
  lvGrid.OnChange :=DoLoadGridChange;
end;

procedure TfrmProjects.DoDestroy;
begin
  if Assigned(projects) then
    projects.Destroy;
  repo.Destroy ;
  inherited;
end;

procedure TfrmProjects.DoInicialize;
begin
  if(project = nil)then
  begin
    actUpd.Enabled :=False;
    actDel.Enabled :=False;
  end
  else begin
    actUpd.Enabled :=True;
    actDel.Enabled :=true;
  end;
end;

procedure TfrmProjects.DoLoadGrid;
var
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

procedure TfrmProjects.DoLoadGridChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if(Item.Data = nil)then
    Exit;
  project :=TProject(Item.Data) ;
  DoInicialize ;
end;

procedure TfrmProjects.DoShow;
begin
  DoLoadGrid ;

end;

end.
