object frmCadProject: TfrmCadProject
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  BorderWidth = 3
  Caption = '.:Cadastro de Projeto:.'
  ClientHeight = 295
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Trebuchet MS'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 18
  object StatusBar1: TStatusBar
    Left = 0
    Top = 276
    Width = 451
    Height = 19
    Panels = <>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 451
    Height = 233
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 76
      Top = 69
      Width = 58
      Height = 18
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label2: TLabel
      Left = 72
      Top = 159
      Width = 62
      Height = 18
      Alignment = taRightJustify
      Caption = 'Data inicio:'
    end
    object Label3: TLabel
      Left = 59
      Top = 186
      Width = 75
      Height = 18
      Alignment = taRightJustify
      Caption = 'Data termino:'
    end
    object edtName: TLabeledEdit
      Left = 140
      Top = 42
      Width = 300
      Height = 26
      EditLabel.Width = 35
      EditLabel.Height = 18
      EditLabel.Caption = 'Nome:'
      LabelPosition = lpLeft
      TabOrder = 1
    end
    object edtCod: TLabeledEdit
      Left = 140
      Top = 15
      Width = 125
      Height = 26
      TabStop = False
      Alignment = taCenter
      Color = clInactiveBorder
      EditLabel.Width = 41
      EditLabel.Height = 18
      EditLabel.Caption = 'C'#243'digo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Trebuchet MS'
      Font.Style = [fsBold]
      LabelPosition = lpLeft
      ParentFont = False
      TabOrder = 0
    end
    object edtDescr: TMemo
      Left = 140
      Top = 69
      Width = 300
      Height = 89
      Lines.Strings = (
        'edtDescr')
      MaxLength = 250
      TabOrder = 2
    end
    object edtDateIni: TDateTimePicker
      Left = 140
      Top = 159
      Width = 125
      Height = 26
      Date = 45863.000000000000000000
      Time = 0.388446111108351000
      TabOrder = 3
    end
    object edtDateFin: TDateTimePicker
      Left = 140
      Top = 186
      Width = 125
      Height = 26
      Date = 45863.000000000000000000
      Time = 0.388776597224932600
      TabOrder = 4
    end
  end
  object btnSave: TButton
    Left = 245
    Top = 239
    Width = 100
    Height = 30
    Caption = 'Salvar'
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 351
    Top = 239
    Width = 100
    Height = 30
    Caption = 'Calcelar'
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
