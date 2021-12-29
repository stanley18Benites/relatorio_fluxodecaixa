unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uMenu;

type
  TfrmPrincipal = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  frmMenu: TfrmMenu;

implementation

{$R *.dfm}

uses uRelatorio_Menu, uDmPrincipal;

procedure TfrmPrincipal.Button1Click(Sender: TObject);  //Cria o form menu e apos, limpa da memoria
  begin
    frmMenu := TfrmMenu.Create(Application);
    try
      frmMenu.ShowModal;
    finally
      frmMenu.Free;
    end;
  end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
   Application.Terminate;
end;

end.
