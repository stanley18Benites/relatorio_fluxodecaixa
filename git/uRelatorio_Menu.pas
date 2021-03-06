unit uRelatorio_Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.DBCtrls;

type
  TfrmRelatorio_Menu = class(TForm)
    btnImprimir: TButton;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    rgOrdenar: TRadioGroup;
    txtFiltro: TEdit;
    rgFiltrar: TRadioGroup;
    procedure btnImprimirClick(Sender: TObject);
    //ocedure rbNomeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorio_Menu: TfrmRelatorio_Menu;

implementation
uses fRelatorioEmpresa, uDmPrincipal;
{$R *.dfm}




procedure TfrmRelatorio_Menu.btnImprimirClick(Sender: TObject);
begin
    frmRelatorioEmpresa := TfrmRelatorioEmpresa.create(application);
      try
        if rgOrdenar.ItemIndex = 0 then
          begin
            dmPrincipal.qryFormulario.Close;
            dmPrincipal.qryFormulario.SQL.Clear;
            dmPrincipal.qryFormulario.SQL.Add('SELECT * FROM ADMIN.EMPRESA order by nome');
            dmPrincipal.qryFormulario.Open();
            frmRelatorioEmpresa.rpNome.Preview();
          end;
          //*******************************************************************************
         if rgOrdenar.ItemIndex = 1 then
            begin
               dmPrincipal.qryFormulario.Close;
               dmPrincipal.qryFormulario.SQL.Clear;
               dmPrincipal.qryFormulario.SQL.Add('SELECT * FROM ADMIN.EMPRESA order by cnpj');
               dmPrincipal.qryFormulario.Open();
               frmRelatorioEmpresa.rpNome.Preview();
            end;
          //*******************************************************************************
          if rgOrdenar.ItemIndex = 2 then
            begin
              dmPrincipal.qryFormulario.Close;
              dmPrincipal.qryFormulario.SQL.Clear;
              dmPrincipal.qryFormulario.SQL.Add('SELECT * FROM ADMIN.EMPRESA order by ie');
              dmPrincipal.qryFormulario.Open();
              frmRelatorioEmpresa.rpNome.Preview();
            end
          //*******************************************************************************
            else
              dmPrincipal.qryFormulario.Close;
              dmPrincipal.qryFormulario.SQL.Clear;
              dmPrincipal.qryFormulario.SQL.Add('SELECT * FROM ADMIN.EMPRESA');
              dmPrincipal.qryFormulario.Open();
              frmRelatorioEmpresa.rpNome.Preview();

          //*******************************************************************************
   finally
     frmRelatorioEmpresa.Free;
   end;
end;
end.
