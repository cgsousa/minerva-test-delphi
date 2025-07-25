object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 150
  Width = 215
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=projects'
      'OSAuthent=Yes'
      'Server=.\SQLEXPRESS2019'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 88
    Top = 56
  end
  object DataSource1: TDataSource
    Left = 112
    Top = 16
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 152
    Top = 80
  end
end
