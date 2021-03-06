unit uEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmEmpresa = class(TForm)
    btnCancelar: TButton;
    tlbNome: TLabel;
    tlbCNPJ: TLabel;
    tlbIE: TLabel;
    btnSalvar: TButton;
    DBGrid1: TDBGrid;
    btnNovo: TButton;
    dbeNome: TDBEdit;
    dbeCNPJ: TDBEdit;
    dbeIE: TDBEdit;
    btnAtualizar: TButton;
    btnExcluir: TButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmpresa: TfrmEmpresa;


implementation

uses uDmPrincipal;

{$R *.dfm}


procedure TfrmEmpresa.btnAtualizarClick(Sender: TObject);
var
  id : Integer;
begin
  //id := DBGrid1.DataSource.DataSet.FieldByName('id').AsInteger;
  //dmPrincipal.qryEmpresa.Close;
  //dmPrincipal.qryEmpresa.SQL.Clear;
  //dmPrincipal.qryEmpresa.SQL.Add('UPDATE admin.empresa SET nome = :nome where id ='+ IntToStr(id));
  //dmPrincipal.qryEmpresa.ParamByName('nome').AsString := dbeNome.Text;
  //dmPrincipal.qryEmpresa.ExecSQL;
  //dmPrincipal.qryEmpresa.Post;
  //id := 0;


  //dmPrincipal.qryDbGrid.Close;
  //dmPrincipal.qryDbGrid.SQL.Clear;
  //dmPrincipal.qryDbGrid.SQL.Add('select * from admin.empresa');
  //dmPrincipal.qryDbGrid.Open;


  dmPrincipal.qryEmpresa.Post;
end;

procedure TfrmEmpresa.btnCancelarClick(Sender: TObject);
begin
  dmPrincipal.qryEmpresaConsulta.Close;
  Close;
end;


procedure TfrmEmpresa.btnExcluirClick(Sender: TObject);
var
id : Integer;
begin
  id := DBGrid1.DataSource.DataSet.FieldByName('id').AsInteger;
  dmPrincipal.qryEmpresa.Close;
  dmPrincipal.qryEmpresa.SQL.Clear;
  dmPrincipal.qryEmpresa.SQL.Add('DELETe FROM ADMIN.EMPRESA where id = '+ IntToStr(id));
  dmPrincipal.qryEmpresa.ExecSQL;
  //dmPrincipal.qryEmpresa.Post;
  dmPrincipal.qryDbGrid.Close;
  dmPrincipal.qryDbGrid.SQL.Clear;
  dmPrincipal.qryDbGrid.SQL.Add('select * from admin.empresa');
  dmPrincipal.qryDbGrid.Open;
end;

procedure TfrmEmpresa.btnNovoClick(Sender: TObject);
begin
    dmPrincipal.qryEmpresaConsulta.Close;
    dmPrincipal.qryEmpresaConsulta.SQL.Clear;
    dmPrincipal.qryEmpresaConsulta.SQL.Add('select * from empresa where id=0');
    dmPrincipal.qryEmpresaConsulta.Open;
    dbeNome.SetFocus;
end;

procedure TfrmEmpresa.FormShow(Sender: TObject);
begin
  btnNovo.SetFocus;
  dmPrincipal.qryDbGrid.Close;
  dmPrincipal.qryDbGrid.SQL.Clear;
  dmPrincipal.qryDbGrid.SQL.Add('select * from admin.empresa');
  dmPrincipal.qryDbGrid.Open;
  dmPrincipal.qryEmpresaConsulta.Close;
end;

procedure TfrmEmpresa.btnSalvarClick(Sender: TObject);
begin
  try
    //dmPrincipal.qryCliente.Post;
    dmPrincipal.qryEmpresa.Close;
    dmPrincipal.qryEmpresa.SQL.Clear;
    dmPrincipal.qryEmpresa.SQL.Add('INSERT INTO EMPRESA (NOME, CNPJ, IE) VALUES (:NOME, :CNPJ, :IE)');
    dmPrincipal.qryEmpresa.ParamByName('NOME').AsString := dbeNome.Text;
    dmPrincipal.qryEmpresa.ParamByName('CNPJ').AsString := dbeCNPJ.Text;
    dmPrincipal.qryEmpresa.ParamByName('IE').AsString := dbeIE.Text;
    dmPrincipal.qryEmpresa.ExecSQL;
    dmPrincipal.qryDbGrid.Close;
    dmPrincipal.qryDbGrid.SQL.Clear;
    dmPrincipal.qryDbGrid.SQL.Add('SELECT * FROM ADMIN.EMPRESA');
    dmPrincipal.qryDbGrid.Open;
  finally
    btnNovo.SetFocus;
  end;
end;

 procedure TfrmEmpresa.DBGrid1DblClick(Sender: TObject);
var
id :integer;
begin
  //id := DBGrid1.DataSource.DataSet.FieldByName('ID').AsInteger;
  dmPrincipal.qryEmpresaConsulta.Close;
  dmPrincipal.qryEmpresaConsulta.SQL.Clear;
  dmPrincipal.qryEmpresaConsulta.SQL.Add('select * from admin.empresa');
  dmPrincipal.qryEmpresaConsulta.Open();
end;

end.
