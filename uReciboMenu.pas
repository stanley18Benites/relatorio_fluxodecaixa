unit uReciboMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.Menus, MaskUtils,
  Vcl.ComCtrls, FireDAC.VCLUI.Controls, Vcl.ExtCtrls   ;

type
  TfrmReciboMenu = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtNome: TEdit;
    edtNomEmpresa: TEdit;
    btnImprimir: TButton;
    edValorTotal: TEdit;
    listboxItens: TComboBox;
    Label5: TLabel;
    lbIdentificacao: TLabel;
    Label7: TLabel;
    TMmascara: TMaskEdit;
    edtRef: TRichEdit;
    Panel1: TPanel;
    procedure btnImprimirClick(Sender: TObject);
    procedure edValorTotalKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure RetiraPontos(s : String);
    procedure CheckBox();
    function formacpf(numtexto: String): String;
    function formacnpj(numtexto: String): String;
    procedure listboxItensClick(Sender: TObject);
  private
    function formatelefone(numtexto: String): String;
    { Private declarations }
  public
    { Public declarations }
  end;
var
  frmReciboMenu: TfrmReciboMenu;
implementation

uses uRecibo, UnExtenso;
{$R *.dfm}

procedure TfrmReciboMenu.btnImprimirClick(Sender: TObject);
begin
    if (listboxItens.ItemIndex<1) then
    begin
      ShowMessage('SELECIONE UMA OPCAO.(CPF OU CNPJ)');
      listboxItens.SetFocus;
      exit;
    end;
    if TMmascara.Text='' then
    begin
      ShowMessage('INFORME CPF OU CNPJ.');
      listboxItens.SetFocus;
      exit;
    end;
  frmRecibo:= TfrmRecibo.Create(application);
  try
    frmRecibo.lbNome.Caption := edtNome.Text;
    frmRecibo.lbValor.Caption := edValorTotal.Text;
    frmRecibo.memoValorExtenso.Lines.Text :=  edValorTotal.Text;
    frmRecibo.lbNomeEmpresa.Caption := edtNomEmpresa.Text;
    RetiraPontos(edValorTotal.Text);  //funcao para formatar o valor digitado
    edValorTotal.Text := Extenso(StrToFloat(edValorTotal.Text)) ; //funcao valor por extenso
    frmRecibo.memoValorExtenso.lines.Text := edValorTotal.Text;
    frmRecibo.memoRef.Lines.Text := edtRef.Text;
    CheckBox();
    if TMmascara.Text='' then
      begin
        ShowMessage('INFORME O CPF OU CNPJ.');
        exit;
      end;
    if (Trim(edValorTotal.Text) = '' )then
      begin
        ShowMessage('DIGITE O VALOR.');
        exit;
      end;
  frmRecibo.RLReport1.Preview();
  finally
    edValorTotal.Text := '0,00';
    frmRecibo.Free;
  end;
end;

procedure TfrmReciboMenu.edValorTotalKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
var
  s: String;
begin
  if (Key in [96..107]) or (Key in [48..57]) then
     begin
      S := edValorTotal.Text;
      S := StringReplace(S,',','',[rfReplaceAll]);
      S := StringReplace(S,'.','',[rfReplaceAll]);
      if Length(s) = 3 then
        begin
          s := Copy(s,1,1)+','+Copy(S,2,15);
          edValorTotal.Text := S;
          edValorTotal.SelStart := Length(S);
        end
      else
        if (Length(s) > 3) and (Length(s) < 6) then
          begin
            s := Copy(s,1,length(s)-2)+','+Copy(S,length(s)-1,15);
            edValorTotal.Text := s;
            edValorTotal.SelStart := Length(S);
          end
        else
          if (Length(s) >= 6) and (Length(s) < 9) then
            begin
              s := Copy(s,1,length(s)-5)+'.'+Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
              edValorTotal.Text := s;
              edValorTotal.SelStart := Length(S);
            end
          else
            if (Length(s) >= 9) and (Length(s) < 12) then
              begin
                s := Copy(s,1,length(s)-8)+'.'+Copy(s,length(s)-7,3)+'.'+
                       Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
                edValorTotal.Text := s;
                edValorTotal.SelStart := Length(S);
              end
            else
              if (Length(s) >= 12) and (Length(s) < 15)  then
                begin
                  s := Copy(s,1,length(s)-11)+'.'+Copy(s,length(s)-10,3)+'.'+
                          Copy(s,length(s)-7,3)+'.'+Copy(s,length(s)-4,3)+','+Copy(S,length(s)-1,15);
                  edValorTotal.Text := s;
                  edValorTotal.SelStart := Length(S);
                end;
      end;
end;

procedure TfrmReciboMenu.RetiraPontos( s : String);
var
 i:Integer;
 texto:String;
 tamanho:Integer;
begin
 Texto:= s;
 tamanho:=Length(texto);
 i:=1;
 while i <= tamanho do
 begin
   if (pos(Texto[i],'.') > 0)or
      (pos(Texto[i],'/') > 0) Then
     begin
      delete(texto,i,1);
      i:=i-1;
      tamanho:=tamanho-1;
     end;
   i:=i+1;
 end;
 edValorTotal.Text:=Texto;
end;

procedure TfrmReciboMenu.CheckBox(); //checa a opcao selecionada no comboBox
begin
   if listboxItens.ItemIndex = 1 then
      begin
        lbIdentificacao.Caption := 'CPF';
        TMmascara.Text := formacpf(TMmascara.Text);
        frmRecibo.lbCnpj.Caption := 'CPF: ' + TMmascara.Text;
      end
   ELSE
    if listboxItens.ItemIndex = 2 then
      begin
        lbIdentificacao.Caption := 'CNPJ';
        TMmascara.Text := formacnpj(TMmascara.Text);
        frmRecibo.lbcnpj.Caption := 'CNPJ: ' + TMmascara.Text;
      end;
end;

Function TfrmReciboMenu.formacpf(numtexto:String):String;
var str : String ;
begin
  str := numtexto;
    Delete(numtexto,ansipos('.',numtexto),1);  //Remove ponto .
    Delete(numtexto,ansipos('.',numtexto),1);
    Delete(numtexto,ansipos('-',numtexto),1); //Remove tra?o -
    Delete(numtexto,ansipos('/',numtexto),1); //Remove barra /
    Result:= formatmasktext ('000\.000\.000\-00;0;',numtexto); // FORMATA OS NUMEROS
end;

procedure TfrmReciboMenu.listboxItensClick(Sender: TObject);
begin
  if listboxItens.ItemIndex = 1 then
  begin
    lbIdentificacao.Caption := 'CPF';
    TMmascara.EditMask := '###.###.###-##;0;_' ;
  end;
  if listboxItens.ItemIndex = 2 then
  begin
    lbIdentificacao.Caption := 'CNPJ';
    TMmascara.EditMask := '##.###.###/####-##;0;_' ;
  end;
end;

Function TfrmReciboMenu.formacnpj(numtexto:String):String;
begin
    Delete(numtexto,ansipos('.',numtexto),1);  //Remove ponto .
    Delete(numtexto,ansipos('.',numtexto),1);
    Delete(numtexto,ansipos('-',numtexto),1); //Remove tra?o -
    Delete(numtexto,ansipos('/',numtexto),1); //Remove barra /
    Result:=FormatmaskText('00\.000\.000\/0000\-00;0;',numtexto);  //FORMATA OS NUMEROS
end;
end.


