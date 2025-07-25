object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  BorderWidth = 3
  Caption = 'frmMain'
  ClientHeight = 205
  ClientWidth = 451
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
    Top = 186
    Width = 451
    Height = 19
    Panels = <>
  end
  object Button1: TButton
    Left = 0
    Top = 0
    Width = 451
    Height = 81
    Align = alTop
    Caption = 'Cadastro de Projeto'
    TabOrder = 1
    OnClick = Button1Click
  end
end
