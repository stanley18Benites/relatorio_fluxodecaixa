unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uEmpresa, uCliente;

type
  TfrmMenu = class(TForm)
    btnCliente: TButton;
    btnCancelar: TButton;
    btnEmpresa: TButton;
    btnImprimir: TButton;
    btnRecibo: TButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure btnClienteClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnReciboClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;
  frmEmpresa : TfrmEmpresa;


implementation

uses uDMPrincipal, uRelatorio_Menu, uReciboMenu;

{$R *.dfm}

procedure TfrmMenu.btnClienteClick(Sender: TObject);
begin
  frmCliente := TfrmCliente.Create(application);
  try
    frmCliente.ShowModal;
  finally
    frmCliente.Free;
  end;
end;

procedure TfrmMenu.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMenu.btnEmpresaClick(Sender: TObject);
begin
  frmEmpresa:= TfrmEmpresa.Create(Application);
  try
    frmEmpresa.ShowModal;
  finally
    frmEmpresa.Free;
end;
  end;

procedure TfrmMenu.btnImprimirClick(Sender: TObject);
begin
  frmRelatorio_Menu := TfrmRelatorio_Menu.create(application);
  try
    frmRelatorio_Menu.ShowModal;
  finally
    frmRelatorio_Menu.Free;
  end;
end;

procedure TfrmMenu.btnReciboClick(Sender: TObject);
begin
  frmReciboMenu:= TfrmReciboMenu.Create(application);
  try
    frmReciboMenu.ShowModal;
  finally
    frmReciboMenu.Free;
  end;
end;

end .
