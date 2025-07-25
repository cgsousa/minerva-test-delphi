program man_project;

uses
  Vcl.Forms,
  form.main00 in 'view\form.main00.pas' {frmMain},
  model.project in 'model\model.project.pas',
  repository.intf in 'ropository\repository.intf.pas',
  repository.project in 'ropository\repository.project.pas',
  dao.ConnectionManager in 'dao\dao.ConnectionManager.pas',
  view.Projects in 'view\view.Projects.pas' {frmProjects},
  view.cadastro.project in 'view\cadastro\view.cadastro.project.pas' {frmCadProject},
  view.ExtCtrls in 'view\view.ExtCtrls.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown :=True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Gerenciador de Progetos';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
