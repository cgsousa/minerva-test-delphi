object frmProjectDetails: TfrmProjectDetails
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  BorderWidth = 3
  Caption = '.:Detalhes do Projeto:.'
  ClientHeight = 445
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Trebuchet MS'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 18
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 628
    Height = 49
    Align = alTop
    Caption = ' Projeto '
    TabOrder = 0
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 426
    Width = 628
    Height = 19
    Panels = <>
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 49
    Width = 628
    Height = 344
    Align = alTop
    Caption = ' Tarefas alocadas /Colaboradores '
    TabOrder = 2
    DesignSize = (
      628
      344)
    object lvGrid: TListView
      Left = 4
      Top = 20
      Width = 613
      Height = 314
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderWidth = 1
      Columns = <
        item
          Caption = 'Tarefa'
          Width = 200
        end
        item
          Caption = 'Data inicio'
          Width = 75
        end
        item
          Caption = 'Data termino'
          Width = 85
        end
        item
          Caption = 'Colaborador'
          Width = 200
        end>
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
end
