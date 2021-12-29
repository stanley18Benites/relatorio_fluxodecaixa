object frmReciboMenu: TfrmReciboMenu
  Left = 0
  Top = 0
  Caption = 'RECIBO'
  ClientHeight = 293
  ClientWidth = 599
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 81
    Height = 13
    Caption = 'NOME CLIENTE:'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 46
    Width = 84
    Height = 13
    Caption = 'VALOR RECIBO:'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label3: TLabel
    Left = 26
    Top = 80
    Width = 74
    Height = 13
    Caption = 'REFERENTE A:'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 144
    Width = 89
    Height = 13
    Caption = 'NOME EMPRESA:'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label5: TLabel
    Left = 67
    Top = 177
    Width = 30
    Height = 13
    Caption = 'CNPJ:'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object edtNome: TEdit
    Left = 106
    Top = 13
    Width = 463
    Height = 21
    TabOrder = 0
  end
  object edtValRecebido: TEdit
    Left = 106
    Top = 43
    Width = 463
    Height = 21
    TabOrder = 1
  end
  object edtRef: TEdit
    Left = 106
    Top = 77
    Width = 463
    Height = 21
    TabOrder = 2
  end
  object edtNomEmpresa: TEdit
    Left = 106
    Top = 141
    Width = 463
    Height = 21
    TabOrder = 3
  end
  object edtCnpj: TEdit
    Left = 106
    Top = 174
    Width = 463
    Height = 21
    TabOrder = 4
  end
  object btnImprimir: TButton
    Left = 26
    Top = 232
    Width = 75
    Height = 25
    Caption = 'IMPRIMIR'
    TabOrder = 5
    OnClick = btnImprimirClick
  end
end
