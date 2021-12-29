unit fRelatorioEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB;

type
  TfrmRelatorioEmpresa = class(TForm)
    rpNome: TRLReport;
    RLDBText1: TRLDBText;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLBand3: TRLBand;
    RLDBText2: TRLDBText;
    rlb_Cabecalho: TRLBand;
    lbTitulo: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    dsFormulario: TDataSource;
    RLSystemInfo4: TRLSystemInfo;
    RLLabel4: TRLLabel;
    private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioEmpresa: TfrmRelatorioEmpresa;

implementation
uses uDmPrincipal, uRelatorio_Menu;

{$R *.dfm}

end.
