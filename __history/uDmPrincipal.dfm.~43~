object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  Height = 439
  Width = 646
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=admin'
      'User_Name=root'
      'Password=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 80
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 80
    Top = 88
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\PROJETO\Win32\Debug\libmysql.dll'
    Left = 72
    Top = 152
  end
  object qryEmpresa: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM ADMIN.EMPRESA;')
    Left = 88
    Top = 264
  end
  object dsEmpresaConsuta: TDataSource
    DataSet = qryEmpresaConsulta
    Left = 392
    Top = 384
  end
  object qryEmpresaConsulta: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM ADMIN.empresa ;')
    Left = 296
    Top = 384
  end
  object dsDbGrid: TDataSource
    DataSet = qryDbGrid
    Left = 584
    Top = 296
  end
  object qryDbGrid: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM ADMIN.EMPRESA;')
    Left = 520
    Top = 296
  end
  object dsCliente: TDataSource
    DataSet = qryCliente
    Left = 312
    Top = 32
  end
  object qryCliente: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'select * from admin.cliente;')
    Left = 248
    Top = 32
  end
  object dsDbGrid_Cliente: TDataSource
    DataSet = qrydbGrid_Cliente
    Left = 504
    Top = 40
  end
  object qrydbGrid_Cliente: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM ADMIN.cliente;')
    Left = 400
    Top = 48
  end
  object qryFormulario: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM ADMIN.EMPRESA;')
    Left = 432
    Top = 120
  end
  object dsEmpresa: TDataSource
    DataSet = qryEmpresa
    Left = 144
    Top = 264
  end
end
