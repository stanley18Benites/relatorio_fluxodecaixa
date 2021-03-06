unit uCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmCliente = class(TForm)
    dbeNome: TDBEdit;
    dbeCNPJ: TDBEdit;
    dbeIE: TDBEdit;
    dbeTelefone: TDBEdit;
    dbeEmail: TDBEdit;
    dbeBairro: TDBEdit;
    dbeCidade: TDBEdit;
    dbeLogradouro: TDBEdit;
    dbeComplemento: TDBEdit;
    dbeNumero: TDBEdit;
    dbeCEP: TDBEdit;
    dbeUF: TDBEdit;
    lbNome: TLabel;
    lbCnpjCpf: TLabel;
    lbIERG: TLabel;
    lbTelefone: TLabel;
    lnEmail: TLabel;
    lbBairro: TLabel;
    lbCidade: TLabel;
    lbLogradouro: TLabel;
    lbNumero: TLabel;
    lbComplemento: TLabel;
    lbCep: TLabel;
    lbUF: TLabel;
    dbGrid_Cliente: TDBGrid;
    btnNovo: TButton;
    btnSair: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    DBEdit5: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    Label7: TLabel;
    DBEdit8: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    Label10: TLabel;
    DBEdit11: TDBEdit;
    Label11: TLabel;
    DBEdit12: TDBEdit;
    Label12: TLabel;
    DBEdit13: TDBEdit;
    Label13: TLabel;
    DBEdit14: TDBEdit;
    Label14: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure dbGrid_ClienteDblClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCliente: TfrmCliente;

implementation
 uses uDmPrincipal;
{$R *.dfm}

procedure TfrmCliente.btnSalvarClick(Sender: TObject);
begin
  //dmPrincipal.qryEmpresa.Edit;
  dmPrincipal.qryCliente.Post;
  //dmPrincipal.qrydbGrid_Cliente.Close;
  //dmPrincipal.qrydbGrid_Cliente.SQL.Clear;
  //dmPrincipal.qrydbGrid_Cliente.SQL.Add('SELECT * FROM ADMIN.CLIENTE');
  //dmPrincipal.qrydbGrid_Cliente.Open();
  //dmPrincipal.qryCliente.Close;
end;

procedure TfrmCliente.btnExcluirClick(Sender: TObject);
var
  id : Integer;
begin
  id := dbGrid_Cliente.DataSource.DataSet.FieldByName('id').AsInteger;
  dmPrincipal.qryCliente.Close;
  dmPrincipal.qryCliente.SQL.Clear;
  dmPrincipal.qryCliente.SQL.Add('DELETe FROM admin.CLIENTE WHERE ID = ' + IntToStr(id));
  dmPrincipal.qryCliente.ExecSQL;

end;

procedure TfrmCliente.btnNovoClick(Sender: TObject);
begin
  dmPrincipal.qryCliente.Close;
  dmPrincipal.qryCliente.SQL.Clear;
  dmPrincipal.qryCliente.SQL.Add('SELECT * FROM ADMIN.CLIENTE WHERE ID = 0');
  dmPrincipal.qryCliente.Open;
  dbeNome.SetFocus;
end;

procedure TfrmCliente.btnSairClick(Sender: TObject);
begin
  dmPrincipal.qryCliente.Close;
  close;
end;

procedure TfrmCliente.dbGrid_ClienteDblClick(Sender: TObject);
var
  id : Integer;
begin
  id := dbGrid_Cliente.DataSource.DataSet.FieldByName('ID').AsInteger;
  dmPrincipal.qryCliente.Close;
  dmPrincipal.qryCliente.SQL.Clear;
  dmPrincipal.qryCliente.SQL.Add('SELECT * FROM admin.CLIENTE WHERE ID = ' + IntToStr(id));
  dmPrincipal.qryCliente.Open();
end;

procedure TfrmCliente.FormShow(Sender: TObject);
begin
  dmPrincipal.qryCliente.Close;
  dmPrincipal.qrydbGrid_Cliente.Close;
  dmPrincipal.qrydbGrid_Cliente.SQL.Clear;
  dmPrincipal.qrydbGrid_Cliente.SQL.Add('SELECT * FROM ADMIN.CLIENTE');
  dmPrincipal.qrydbGrid_Cliente.Open();
  btnNovo.SetFocus;
end;

end.
