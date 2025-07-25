unit model.project;

interface

uses
  System.SysUtils, System.Classes;

type
  TProjectStatus = (psNone, psStarted, psFinish, psCancel);
  TProject = class
  private
    Fid: Integer;
    Fname: string;
    Fdescription: string;
    Fdate_begin: TDate;
    Fdate_end: TDate;
    Fstatus: TProjectStatus;
  public
    constructor Create(const aId: Integer);
    property iD: Integer read Fid ;
    property Name: string read Fname write Fname;
    property description: string read Fdescription write Fdescription;
    property date_begin: TDate read Fdate_begin write Fdate_begin;
    property date_end: TDate read Fdate_end write Fdate_end;
    property status: TProjectStatus read Fstatus write Fstatus;
  end;

  TProjectTask = class
  private
    FParent: TProject;
    Fid: Integer;
    Fname: string;
    Fdescription: string;
    Fdate_begin: TDate;
    Fdate_end: TDate;
    Fstatus: TProjectStatus;
  public
    constructor Create(aParent: TProject);
    property iD: Integer read Fid ;
    property Name: string read Fname write Fname;
    property description: string read Fdescription write Fdescription;
    property date_begin: TDate read Fdate_begin write Fdate_begin;
    property date_end: TDate read Fdate_end write Fdate_end;
    property status: TProjectStatus read Fstatus write Fstatus;
  end;


implementation

{ TProject }

constructor TProject.Create(const aId: Integer);
begin
  inherited Create;
  Fid :=aId ;
  Fstatus :=psNone;
end;

{ TProjectTask }

constructor TProjectTask.Create(aParent: TProject);
begin
  FParent :=aParent
  ;
end;

end.
