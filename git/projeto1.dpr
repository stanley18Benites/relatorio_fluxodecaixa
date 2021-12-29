program projeto1;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uEmpresa in 'uEmpresa.pas' {frmEmpresa},
  uMenu in 'uMenu.pas' {frmMenu},
  uDmPrincipal in 'uDmPrincipal.pas' {dmPrincipal: TDataModule},
  uCliente in 'uCliente.pas' {frmCliente},
  fRelatorioEmpresa in 'fRelatorioEmpresa.pas' {frmRelatorioEmpresa},
  uRelatorio_Menu in 'uRelatorio_Menu.pas' {frmRelatorio_Menu},
  uRecibo in 'uRecibo.pas' {frmRecibo},
  uReciboMenu in 'C:\Users\User\AppData\Roaming\Microsoft\Windows\Network Shortcuts\uReciboMenu.pas' {frmReciboMenu},
  UnExtenso in 'UnExtenso.pas';

//extenso in 'extenso.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  //Application.CreateForm(TfrmCliente, frmCliente);
  //Application.CreateForm(TfrmRelatorioEmpresa, frmRelatorioEmpresa);
  //Application.CreateForm(TfrmRelatorio_Menu, frmRelatorio_Menu);
  //Application.CreateForm(TfrmRecibo, frmRecibo);
  //Application.CreateForm(TfrmReciboMenu, frmReciboMenu);
  //Application.CreateForm(TfrmReciboMenu, frmReciboMenu);
  //Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
