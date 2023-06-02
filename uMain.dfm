object Form36: TForm36
  Left = 0
  Top = 0
  Caption = 'Gerber Fixer'
  ClientHeight = 525
  ClientWidth = 585
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Button1: TButton
    Left = 488
    Top = 39
    Width = 75
    Height = 25
    Caption = '...'
    TabOrder = 0
    OnClick = Button1Click
  end
  object LabeledEdit1: TLabeledEdit
    Left = 48
    Top = 40
    Width = 417
    Height = 23
    EditLabel.Width = 69
    EditLabel.Height = 15
    EditLabel.Caption = 'GerberX2 File'
    TabOrder = 1
    Text = ''
  end
  object btnProcess: TButton
    Left = 488
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Process'
    TabOrder = 2
    OnClick = btnProcessClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 506
    Width = 585
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = 'select file'
    ExplicitLeft = 304
    ExplicitTop = 104
    ExplicitWidth = 0
  end
  object Memo1: TMemo
    Left = 48
    Top = 136
    Width = 515
    Height = 353
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 4
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'zip'
    Filter = 'Gerber Files|*.zip'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist]
    Title = 'Select GerberX2 file'
    Left = 56
    Top = 88
  end
end
