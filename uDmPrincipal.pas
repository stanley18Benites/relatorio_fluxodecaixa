unit uDmPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.UI,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FCarregarMySQL;

type
  TdmPrincipal = class(TDataModule)
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    qryEmpresa: TFDQuery;
    dsEmpresaConsuta: TDataSource;
    qryEmpresaConsulta: TFDQuery;
    dsDbGrid: TDataSource;
    qryDbGrid: TFDQuery;
    dsCliente: TDataSource;
    qryCliente: TFDQuery;
    dsDbGrid_Cliente: TDataSource;
    qrydbGrid_Cliente: TFDQuery;
    qryFormulario: TFDQuery;
    dsEmpresa: TDataSource;
    procedure FDConnection1BeforeConnect(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmPrincipal.FDConnection1BeforeConnect(Sender: TObject);
var s,sDirBD: string;
  begin
    if DirectoryExists(s) then begin
      s := s + '\bin\mysqld-nt.exe --defaults-file=opmysql.cnf';
      TCarregarMySQL.Execute( s,ConeccaoPrincipal,'UniConta' );
      try
        FCarregarMySQL := false;
      except
        FCarregarMySQL := true;
      end;
    end;
  end
end.

end.
