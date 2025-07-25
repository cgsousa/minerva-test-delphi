unit model.employee;

interface

uses
  System.SysUtils, System.Classes;

type
  TEmployee = class
  private
    Fid: Integer;
    Fname: string;
    Fposition, Fdepartment: string;
  public
    constructor Create(const aId: Integer);
    property iD: Integer read Fid ;
    property Name: string read Fname write Fname;
    property position: string read Fposition write Fposition;
    property department: string read Fdepartment write Fdepartment;
  end;


implementation

{ TEmployee }

constructor TEmployee.Create(const aId: Integer);
begin
  Fid :=aId;
end;

end.
