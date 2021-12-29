unit uRecibo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, RLReport, Vcl.Imaging.pngimage,
  Vcl.StdCtrls;

type
  TfrmRecibo = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLLabel6: TRLLabel;
    lbNomeEmpresa: TRLLabel;
    lbCnpj: TRLLabel;
    RLLabel13: TRLLabel;
    RLPanel1: TRLPanel;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLImage2: TRLImage;
    RLPanel2: TRLPanel;
    RLLabel8: TRLLabel;
    lbNome: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel4: TRLLabel;
    lbValor: TRLLabel;
    RLLabel5: TRLLabel;
    RLPanel3: TRLPanel;
    RLLabel10: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel9: TRLLabel;
    memoValorExtenso: TRLMemo;
    memoRef: TRLMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRecibo: TfrmRecibo;

implementation
uses uReciboMenu;
{$R *.dfm}




end.
