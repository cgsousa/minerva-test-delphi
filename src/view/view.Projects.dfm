object frmProjects: TfrmProjects
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  BorderWidth = 3
  Caption = '.:Lista de Projetos:.'
  ClientHeight = 445
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Trebuchet MS'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 18
  object StatusBar1: TStatusBar
    Left = 0
    Top = 426
    Width = 628
    Height = 19
    Panels = <>
  end
  object lvGrid: TListView
    Left = 0
    Top = 0
    Width = 628
    Height = 385
    Align = alTop
    BorderWidth = 1
    Columns = <
      item
        Caption = 'C'#243'digo'
      end
      item
        Caption = 'Nome'
        Width = 250
      end
      item
        Caption = 'Data inicio'
        Width = 75
      end
      item
        Caption = 'Data termino'
        Width = 85
      end>
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
  end
  object btnClose: TButton
    Left = 528
    Top = 390
    Width = 100
    Height = 30
    Caption = 'Fechar'
    TabOrder = 3
  end
  object btnNew: TButton
    Left = 122
    Top = 390
    Width = 100
    Height = 30
    Action = actNew
    TabOrder = 0
  end
  object btnUpd: TButton
    Left = 228
    Top = 390
    Width = 100
    Height = 30
    Action = actUpd
    TabOrder = 4
  end
  object btnDel: TButton
    Left = 334
    Top = 390
    Width = 100
    Height = 30
    Action = actDel
    TabOrder = 5
  end
  object Button1: TButton
    Left = 0
    Top = 390
    Width = 100
    Height = 30
    Action = actDet
    TabOrder = 6
  end
  object alStd: TActionList
    Left = 552
    Top = 16
    object actNew: TAction
      Category = 'CRUD'
      Caption = 'Novo'
      OnExecute = actNewExecute
    end
    object actUpd: TAction
      Category = 'CRUD'
      Caption = 'Alterar'
      OnExecute = actUpdExecute
    end
    object actDel: TAction
      Category = 'CRUD'
      Caption = 'Deletar'
      OnExecute = actDelExecute
    end
    object actDet: TAction
      Caption = 'Detalhar'
      OnExecute = actDetExecute
    end
  end
end
