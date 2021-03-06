unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uEmpresa, uCliente,
  Vcl.Menus, RLReport;

type
  TfrmMenu = class(TForm)
    btnCliente: TButton;
    btnCancelar: TButton;
    btnEmpresa: TButton;
    btnImprimir: TButton;
    btnRecibo: TButton;
    MainMenu1: TMainMenu;
    Cadastrar1: TMenuItem;
    Relatorio1: TMenuItem;
    Recibo1: TMenuItem;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure btnClienteClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnReciboClick(Sender: TObject);
    procedure S(Sender: TObject);
    procedure Cadastrar1AdvancedDrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;
  //frmEmpresa : TfrmEmpresa;


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

procedure TfrmMenu.Cadastrar1AdvancedDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; State: TOwnerDrawState);
begin
  frmEmpresa := TfrmEmpresa.Create(application);
  try
    frmEmpresa.ShowModal;
  finally
    frmEmpresa.Free;
  end;
end;

procedure TfrmMenu.S(Sender: TObject);
begin
  frmEmpresa := TfrmEmpresa.Create(application);
  try
    frmEmpresa.ShowModal;
  finally
    frmEmpresa.Free;
  end;
end;

end .
