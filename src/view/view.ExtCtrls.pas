unit view.ExtCtrls;

interface

uses Winapi.Windows, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls;

type
  TWBaseForm = class (Vcl.Forms.TForm)
  private
  protected
    procedure DoCreate; override;
    procedure DoInicialize(); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
  end;

  TCustomEditHelper = class helper for TCustomEdit
    function IsEmpty: Boolean;
  end;


implementation

uses System.SysUtils;

{ TWBaseForm }

procedure TWBaseForm.DoCreate;
begin
  inherited;
  KeyPreview :=true;
  Position :=poDesktopCenter;
end;

procedure TWBaseForm.DoInicialize;
begin

end;

procedure TWBaseForm.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: if not((ActiveControl is TCustomComboBox)and TCustomComboBox(ActiveControl).DroppedDown)then
               begin
                 ModalResult :=mrCancel;
               end;
    VK_RETURN: if Assigned(ActiveControl)then
               begin
                 SelectNext(ActiveControl, true, true);
               end;
  else
    inherited KeyDown(Key, Shift);
  end;
end;

{ TCustomEditHelper }

function TCustomEditHelper.IsEmpty: Boolean;
begin
  Result :=Trim(Text) ='';
end;

end.
