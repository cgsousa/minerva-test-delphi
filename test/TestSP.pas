unit TestSP;

interface
uses
  DUnitX.TestFramework;

type

  [TestFixture]
  Test_usp_projects_tasks = class(TObject)
  public
    // Sample Methods
    // Simple single Test
    [Test]
    procedure Test1;
    // Test with TestCase Attribute to supply parameters.
    [Test]
    [TestCase('TestA','1,2')]
    [TestCase('TestB','3,4')]
    procedure Test2(const AValue1 : Integer;const AValue2 : Integer);
  end;

implementation

procedure Test_usp_projects_tasks.Test1;
begin
end;

procedure Test_usp_projects_tasks.Test2(const AValue1 : Integer;const AValue2 : Integer);
begin
end;

initialization
  TDUnitX.RegisterTestFixture(Test_usp_projects_tasks);
end.
