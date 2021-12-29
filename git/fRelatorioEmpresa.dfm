object frmRelatorioEmpresa: TfrmRelatorioEmpresa
  Left = 0
  Top = 0
  Caption = 'RELATORIO DE EMPRESAS'
  ClientHeight = 476
  ClientWidth = 897
  Color = clAqua
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object rpNome: TRLReport
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    DataSource = dsFormulario
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    object RLDBText1: TRLDBText
      Left = 368
      Top = 552
      Width = 4
      Height = 18
      Text = ''
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 188
      Width = 718
      Height = 22
      object RLDBText3: TRLDBText
        Left = 263
        Top = 5
        Width = 28
        Height = 14
        DataField = 'CNPJ'
        DataSource = dsFormulario
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsUnderline]
        ParentFont = False
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 464
        Top = 6
        Width = 11
        Height = 14
        DataField = 'IE'
        DataSource = dsFormulario
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsUnderline]
        ParentFont = False
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 0
        Top = 6
        Width = 32
        Height = 14
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        DataField = 'NOME'
        DataSource = dsFormulario
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsUnderline]
        ParentFont = False
        Text = ''
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 147
      Width = 718
      Height = 41
      BandType = btColumnHeader
      object RLLabel1: TRLLabel
        Left = 0
        Top = 0
        Width = 51
        Height = 18
        Alignment = taJustify
        Caption = 'NOME'
      end
      object RLLabel2: TRLLabel
        Left = 443
        Top = 0
        Width = 180
        Height = 18
        Alignment = taCenter
        Caption = 'INSCRICAO ESTADUAL'
      end
      object RLLabel3: TRLLabel
        Left = 265
        Top = 0
        Width = 46
        Height = 18
        Alignment = taCenter
        Caption = 'CNPJ'
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 210
      Width = 718
      Height = 40
      BandType = btSummary
    end
    object rlb_Cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 109
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      object lbTitulo: TRLLabel
        Left = 0
        Top = 1
        Width = 238
        Height = 24
        Align = faLeftTop
        Alignment = taCenter
        Caption = 'RELACAO DE EMPRESAS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -20
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold, fsItalic]
        Layout = tlCenter
        ParentFont = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 570
        Top = 1
        Width = 148
        Height = 16
        Align = faRightTop
        Info = itPageNumber
        Text = 'P'#225'gina: '
      end
      object RLLabel4: TRLLabel
        Left = 0
        Top = 78
        Width = 122
        Height = 16
        Caption = 'Relat'#243'rio Sint'#233'tico'
      end
    end
    object RLSystemInfo3: TRLSystemInfo
      Left = 583
      Top = 8
      Width = 68
      Height = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Text = ''
    end
    object RLSystemInfo4: TRLSystemInfo
      Left = 666
      Top = 8
      Width = 54
      Height = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      Info = itHour
      ParentFont = False
      Text = ''
    end
  end
  object dsFormulario: TDataSource
    DataSet = dmPrincipal.qryFormulario
    Left = 824
    Top = 24
  end
end
