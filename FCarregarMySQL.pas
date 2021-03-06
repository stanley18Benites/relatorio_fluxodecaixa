unit FCarregarMySQL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;//ZConnection;

type
  TConfiguraMySQL = class( TStringList )
    private
      FNomeArquivo: string;
      FProcesso: TProcessInformation;
      Function MySQLCarregado( var sIp: string; var sPorta: string ): boolean;
      Function PegaIPCorrente( var HostName, IPaddr, WSAErr: string ): Boolean;
      function pPararMySQL( NomeProcesso: string ): boolean;
      function PortTCP_IsOpen(dwPort : Word; ipAddressStr:AnsiString) : boolean;
    public
      constructor Create( NomeArq: string = 'opmysql.cnf' );
      destructor Destroy;
      function PegaValorSeccao( chave: string; valor: string ): string;
      function PegaBaseDir: string;
      function PegaDataDir: string;
      function PegaLogError: string;
      function PegaIP: string;
      function PegaPorta: string;
      function EstaConectado( iPorta: word; sIP: string ): boolean;
      function ColocaSeccao( chave: string; valor: string = '' ): integer;
      function ColocaGrupo( grupo: string; linha: integer ): integer;
      procedure ColocaBaseDir( valor: string = '' );
      procedure ColocaDatadir( valor: string = '' );
      procedure ColocaLogerror( valor: string = '' );
      procedure ColocaBindAddress( valor: string = '' );
      procedure ColocaPort( valor: string = '' );
      procedure ColocaFlush( valor: string = '' );
      procedure ColocaStandalone( valor: string = '' );
      procedure ColocaLogWarnings( valor: string = '' );
      procedure ColocaSkipThreadPriority( valor: string = '' );
      procedure ColocaLanguage( valor: string = 'portuguese' );

      function AbrirMySQL( var processo: TProcessInformation; LinhaComando: string = ''  ): boolean;
      function PararMySQL( var processo: TProcessInformation ): boolean;
      procedure SalvaArquivo;
  end;


  TCarregarMySQL = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    aplic: string;
  public
    { Public declarations }
   // class procedure Execute(  apl: string = ''; Coneccao: TZConnection = nil; NomePrograma: string = ''; PathDados: string = ''; sPorta: string = '3307' );

  end;

function EstouNaEstacao: boolean;
procedure ProvidenciaLibMySQL;
//Function MySQLCarregado( var sIp: string ): boolean;
//Function GetIPFromHost( var HostName, IPaddr, WSAErr: string ): Boolean;

implementation

uses IniFiles,StrUtils,Winsock,{EDCUtil,}Tlhelp32;//PPropaganda;

{$R *.dfm}

const
  LIBMYSQL = 'libmysql41.dll';

var
  CarregarMySQL: TCarregarMySQL;
  lProcesso: TProcessInformation;
  NomeDoPrograma,DirDados,Porta: string;
  ConfiguraMySQL: TConfiguraMySQL;
  bClose: boolean;

{ pegar o IP }
{
Function GetIPFromHost( var HostName, IPaddr, WSAErr: string ): Boolean;
type
  Name = array[0..100] of Char;
  PName = ^Name;
var
  HEnt: pHostEnt;
  HName: PName;
  WSAData: TWSAData;
  i: Integer;
begin
  Result := False;
  if WSAStartup($0101, WSAData) <> 0 then begin
    WSAErr := 'Winsock is not responding."';
    Exit;
  end;
  IPaddr := '';
  New(HName);
  if GetHostName(HName^, SizeOf(Name)) = 0 then
  begin
    HostName := StrPas(HName^);
    HEnt := GetHostByName(HName^);
    for i := 0 to HEnt^.h_length - 1 do
     IPaddr :=
      Concat(IPaddr,
      IntToStr(Ord(HEnt^.h_addr_list^[i])) + '.');
    SetLength(IPaddr, Length(IPaddr) - 1);
    Result := True;
  end
  else
    begin
     case WSAGetLastError of
      WSANOTINITIALISED:WSAErr:='WSANotInitialised';
      WSAENETDOWN      :WSAErr:='WSAENetDown';
      WSAEINPROGRESS   :WSAErr:='WSAEInProgress';
      end;
  end;
  Dispose(HName);
  WSACleanup;
end;
}

function KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;


function EstouNaEstacao: boolean;
var  Tipo: byte;
     S: string;
begin
  Tipo := GetDriveType(PChar(ExtractFileDrive(Application.ExeName)));
  Result := Not(Tipo=DRIVE_FIXED);
end;


Procedure mCopyFile( Const sourcefilename, targetfilename: String );
Var S, T: TFileStream;
Begin

  S := TFileStream.Create( sourcefilename, fmOpenRead );
  try
    T := TFileStream.Create( targetfilename, fmOpenWrite or fmCreate );
    try
      T.CopyFrom(S, S.Size ) ;
    finally
      T.Free;
    end;
  finally
    S.Free;
  end;
end;


function SysSystemDir: string;
begin
  SetLength(Result, MAX_PATH);
  if GetSystemDirectory(PChar(Result), MAX_PATH) > 0 then
  Result := string(PChar(Result))
  else
  Result := '';
end;

procedure ProvidenciaLibMySQL;
var dirSystem,dirSystem64: string;
begin
  dirSystem := SysSystemDir;
  dirSystem64 := Copy(dirSystem,1,pos('SYSTEM32',uppercase(dirSystem))-1 )+'SysWOW64';
  if DirectoryExists( dirSystem64 ) then begin
    if not FileExists( dirSystem64+'\'+LIBMYSQL ) then begin
      mCopyFile( LIBMYSQL,dirSystem64+'\'+LIBMYSQL );
    end;
  end else  begin
    if not FileExists( dirSystem+'\'+LIBMYSQL ) then begin
      if FileExists( LIBMYSQL ) then begin
        mCopyFile( LIBMYSQL,dirSystem+'\'+LIBMYSQL );
      end;
    end;
  end;
end;
 {
class procedure TCarregarMySQL.Execute(  apl: string = ''; Coneccao: TZConnection = nil; NomePrograma: string = ''; PathDados: string = ''; sPorta: string = '3307' );
var sIp: string;
    bCarregado: boolean;
begin
  bClose := false;
  NomeDoPrograma := NomePrograma;
  if NomeDoPrograma='' then NomeDoPrograma := 'LogErro';
  if not FileExists( NomeDoPrograma+'.err' ) then begin
    with TFileStream.Create( NomeDoPrograma+'.err', fmCreate ) do begin
      Free;
    end;
  end;

  DirDados := PathDados;
  if DirDados='' then DirDados := GetCurrentDir;

  ConfiguraMySQL := TConfiguraMySQL.create( 'opmysql.cnf' );
  bCarregado := ConfiguraMySQL.MySQLCarregado( sIp,sPorta );
  Porta := sPorta;

  if Coneccao<>nil then begin
    Coneccao.HostName := sIp;
    Coneccao.Port     := strToIntDef(sPorta,0);
    Coneccao.User     := 'root';
  end;
  if not bCarregado then begin
    if not EstouNaEstacao then begin
      CarregarMySQL := TCarregarMySQL.Create(Application);
      try
        CarregarMySQL.aplic := apl;
        CarregarMySQL.ShowModal;
      finally
        CarregarMySQL.Free;
      end;
    end else begin
      ShowMessage( 'O MySQL n?o foi carregado, e precisa ser carregado pelo Servidor'+#13+#10+
                   'para que o programa funcione normalmente.' );
    end;
  end;
  ConfiguraMySQL.Free;

end;

 }

procedure TCarregarMySQL.FormShow(Sender: TObject);
begin
  ConfiguraMySQL.AbrirMySQL( lProcesso, aplic  );
  bClose := true;
end;


procedure TCarregarMySQL.Timer1Timer(Sender: TObject);
var
  lExitCode: dword;
begin
  // Testa se Processo ainda est? ativo...
  // Continua rodando o timer enquanto o status
  // for diferente de STILL_ACTIVE, que indica que
  // o processo est? ativo.
  if bClose then
    Close;


  if GetExitCodeProcess(lProcesso.hProcess, lExitCode) then begin
    if (lExitCode=STILL_ACTIVE) or (lExitCode=1) then
      close;
    CloseHandle(lProcesso.hProcess);
    CloseHandle(lProcesso.hThread);
  end;

end;



{ *** TConfiguraMySQL *** }

constructor TConfiguraMySQL.Create( NomeArq: string = 'opmysql.cnf' );
begin
  inherited Create;
  FNomeArquivo := NomeArq;
  if FileExists( FNomeArquivo ) then self.LoadFromFile( FNomeArquivo );
end;

destructor TConfiguraMySQL.Destroy;
begin
  inherited Destroy;
end;

procedure TConfiguraMySQL.SalvaArquivo;
begin
  self.SaveToFile( FNomeArquivo );
end;

function TConfiguraMySQL.PegaValorSeccao( chave: string; valor: string ): string;
var p,i: integer;
begin
  Result := '';
  for i := 0 to self.Count-1 do begin
    if Pos( Uppercase(chave),Uppercase(self.Strings[i]) )>0 then begin
      p := Pos( '=',self.Strings[i] );
      if p>-1 then begin
        if uppercase(trim( Copy( self.Strings[i],1,p-1 ) ))=Uppercase(chave) then begin
          Result := trim(Copy( self.Strings[i],p+1,Length(self.Strings[i]) ));
          Break;
        end;
      end else begin
        if uppercase(trim(self.Strings[i]))=Uppercase(chave) then begin
          Break;
        end;
      end;
    end;
  end;
  if Result='' then Result := valor;
end;

function TConfiguraMySQL.PegaBaseDir: string;
begin
  Result := self.PegaValorSeccao( 'basedir','' );
end;

function TConfiguraMySQL.PegaDataDir: string;
begin
  Result := self.PegaValorSeccao( 'datadir','' );
end;

function TConfiguraMySQL.PegaLogError: string;
begin
  Result := self.PegaValorSeccao( 'log-error','' );
end;

function TConfiguraMySQL.PegaIP: string;
begin
  Result := self.PegaValorSeccao( 'bind-address','' );
end;

function TConfiguraMySQL.PegaPorta: string;
begin
  Result := self.PegaValorSeccao( 'port','' );
end;

function TConfiguraMySQL.EstaConectado( iPorta: word; sIP: string ): boolean;
//var DirDados,logerror: string;
//    Arq: TFileStream;
begin
  result := PortTCP_IsOpen( iPorta,sIP );

{  DirDados := self.PegaDataDir;
  logerror := self.PegaLogError;
  DirDados := StringReplace( DirDados,'/','\',[rfReplaceAll] );

  //Verifica se o MySQL esta carregado ou n?o...
  result := true;
  try
    Arq := TFileStream.Create( DirDados+'\'+logerror, fmOpenRead OR fmShareExclusive );
    result := false;
  except
    if Arq<>nil then Arq.Free;
  end; }
end;

procedure TConfiguraMySQL.ColocaBaseDir( valor: string = '' );
begin
  ColocaSeccao( 'basedir', valor );
end;

procedure TConfiguraMySQL.ColocaDatadir( valor: string = '' );
begin
  ColocaSeccao( 'datadir', valor );
end;

procedure TConfiguraMySQL.ColocaLogerror( valor: string = '' );
begin
  ColocaSeccao( 'log-error', valor );
end;

procedure TConfiguraMySQL.ColocaBindAddress( valor: string = '' );
begin
  ColocaSeccao( 'bind-address', valor );
end;

procedure TConfiguraMySQL.ColocaPort( valor: string = '' );
begin
  ColocaSeccao( 'port', valor );
end;

procedure TConfiguraMySQL.ColocaFlush( valor: string = '' );
begin
  ColocaSeccao( 'flush', valor );
end;

procedure TConfiguraMySQL.ColocaStandalone( valor: string = '' );
begin
  ColocaSeccao( 'standalone', valor );
end;

procedure TConfiguraMySQL.ColocaLogWarnings( valor: string = '' );
begin
  ColocaSeccao( 'log-warnings', valor );
end;

procedure TConfiguraMySQL.ColocaSkipThreadPriority( valor: string = '' );
begin
  ColocaSeccao( 'skip-thread-priority', valor );
end;

procedure TConfiguraMySQL.ColocaLanguage( valor: string = 'portuguese' );
begin
  ColocaSeccao( 'language', valor );
end;


function TConfiguraMySQL.ColocaSeccao( chave: string; valor: string = '' ): integer;
var i,p: integer;
begin
  Result := -1;
  for i := 0 to self.Count-1 do begin
    if Pos( Uppercase(chave),Uppercase(self.Strings[i]) )>0 then begin
      p := Pos( '=',self.Strings[i] );
      if p>0 then begin
        if uppercase(trim( Copy( self.Strings[i],1,p-1 ) ))=Uppercase(chave) then begin
          Result := i;
          Break;
        end;
      end else begin
        if uppercase(trim(self.Strings[i]))=Uppercase(chave) then begin
          Result := i;
          Break;
        end;
      end;
    end;
  end;
  if Result=-1 then Result := self.Add( chave+IfThen( valor='','',' = '+valor ) )
  else self.Strings[Result] := chave+IfThen( valor='','',' = '+valor );
end;

function TConfiguraMySQL.ColocaGrupo( grupo: string; linha: integer ): integer;
var sTexto: string;
    i: integer;
begin
  Result := -1;
  if Pos('[',grupo)=0 then grupo := '['+grupo;
  if Pos(']',grupo)=0 then grupo := grupo+']';
  for i := 0 to self.Count-1 do begin
    if Pos( Uppercase(grupo),Uppercase(trim(self.Strings[i])) )>0 then begin
      Result := i;
      break;
    end;
  end;
  if Result=-1 then begin
    Result := self.Add(grupo)
  end;
  if Result<>linha then begin
    self.Move( Result,linha );
  end;
end;


function TConfiguraMySQL.PortTCP_IsOpen(dwPort : Word; ipAddressStr:AnsiString) : boolean;
var
  client : sockaddr_in;
  sock   : Integer;

  ret    : Integer;
  wsdata : WSAData;
begin
 Result:=False;
 ret := WSAStartup($0002, wsdata); //initiates use of the Winsock DLL
  if ret<>0 then exit;
  try
    client.sin_family      := AF_INET;  //Set the protocol to use , in this case (IPv4)
    client.sin_port        := htons(dwPort); //convert to TCP/IP network byte order (big-endian)
    client.sin_addr.s_addr := inet_addr(PAnsiChar(ipAddressStr));  //convert to IN_ADDR  structure
    sock  :=socket(AF_INET, SOCK_STREAM, 0);    //creates a socket
    Result:=connect(sock,client,SizeOf(client))=0;  //establishes a connection to a specified socket
  finally
  WSACleanup;
  end;
end;


Function TConfiguraMySQL.MySQLCarregado( var sIp: string; var sPorta: string ): boolean;
var Arq: TFileStream;
    logerror,Path,BaseDir,dirAtual: string;
    sHost,IpDoServidor,sErro: string;
    bGravaArqOp: boolean;
    ixs: integer;
    bEstacao: boolean;
begin
  Result := false;

  dirAtual  := GetCurrentDir;
  BaseDir  := Copy(dirAtual, 1, LastDelimiter('\', dirAtual));
  if not DirectoryExists(BaseDir) then
    BaseDir := dirAtual+'\';
  BaseDir  := BaseDir+'mysql50';
  BaseDir := StringReplace( BaseDir,'\','/',[rfReplaceAll] );

  Path     := StringReplace( DirDados,'\','/',[rfReplaceAll] );
  logerror := NomeDoPrograma+'.err';
  sIp := '127.0.0.1';
  if not(Porta='') then
    sPorta   := Porta;

  IpDoServidor := sIp;

  bGravaArqOp := false;

  bEstacao := EstouNaEstacao;

  if not bEstacao then begin
    bGravaArqOp := true;
    if not GetIPFromHost( sHost,IpDoServidor,sErro ) then
      IpDoServidor := sIp;
  end;

  BaseDir  := self.PegaValorSeccao( 'basedir',BaseDir );
  Path     := self.PegaValorSeccao( 'datadir',Path );
  logerror := self.PegaValorSeccao( 'log-error',logerror );
  sIp      := self.PegaValorSeccao( 'bind-address',sIp );
  sPorta   := self.PegaValorSeccao( 'port',sPorta );
  if sPorta='' then sPorta := '3307';


  if not bEstacao then begin
    if (sIp<>IpDoServidor) then sIp := IpDoServidor;
  end;

  if bGravaArqOp then begin
    self.ColocaGrupo( 'mysqld',0 );
    self.ColocaSeccao( 'basedir',BaseDir );
    self.ColocaSeccao( 'datadir',Path );
    self.ColocaSeccao( 'flush','' );
    self.ColocaSeccao( 'standalone','' );
    self.ColocaSeccao( 'log-error',logerror );
    self.ColocaSeccao( 'log-warnings','' );
    self.ColocaSeccao( 'skip-thread-priority','' );
    self.ColocaSeccao( 'language','portuguese' );
    self.ColocaSeccao( 'bind-address',sIp );
    self.ColocaSeccao( 'port',sPorta );
    self.SalvaArquivo;
  end;

  //Verifica se o MySQL esta carregado ou n?o...
  result := PortTCP_IsOpen( strToIntDef(sPorta,0), sIp );
  {
  Path := AnsiReplaceStr( Path,'/','\' );
  try
    Arq := TFileStream.Create( Path+'\'+logerror, fmOpenRead OR fmShareExclusive );
    try
      result := false;
    finally
      Arq.Free;
    end;
  except
    result := true;
  end;
  }

end;

Function TConfiguraMySQL.PegaIPCorrente( var HostName, IPaddr, WSAErr: string ): Boolean;
begin
  Result := GetIPFromHost( HostName,IPaddr,WSAErr );
end;

function ExecProg( cmd: String ): integer;
var
  SUInfo : TStartupInfo;
  ProcInfo : TProcessInformation;
  estado : cardinal;
begin
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  SUInfo.cb      := SizeOf(SUInfo);
  SUInfo.dwFlags := STARTF_USESHOWWINDOW;
  SUInfo.wShowWindow := SW_HIDE;
  if CreateProcess(nil,
                   PChar(cmd),
                   nil,
                   nil,
                   false,
                   CREATE_NEW_CONSOLE or
                   NORMAL_PRIORITY_CLASS,
                   nil,
                   nil,
                   SUInfo,
                   ProcInfo) then begin
      GetExitCodeProcess( ProcInfo.hProcess,estado );
      while estado<>STILL_ACTIVE do begin
      GetExitCodeProcess( ProcInfo.hProcess,estado );
      end;
      //WaitForSingleObject(ProcInfo.hProcess, INFINITE); isso as vezes n?o da certo...
      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);
  end else begin
    ShowMessage('Erro ao tentar carregar o MySQL');
  end;
end;


function TConfiguraMySQL.AbrirMySQL( var processo: TProcessInformation; LinhaComando: string = ''  ): boolean;
var
  lStartUpInfo:TStartUpInfo;
  s: string;
  estado : dword;

  function pegaDirBD: string;
  begin
    result := '\GESuporte\MySQL50';
    if not DirectoryExists(result) then
      result := '\UniSystem\MySQL50';
    if not DirectoryExists(result) then
      result := GetCurrentDir+'\MySQL50';
  end;

begin
  result := false;
  s := pegaDirBD; //'\UniSystem\MySQL50';
  if not DirectoryExists(s) then
    s := GetCurrentDir+'\MySQL50';
  if not DirectoryExists(s) then
    Exit;

  s := s + '\bin\mysqld-nt.exe --defaults-file=opmysql.cnf';

  if LinhaComando<>'' then s := LinhaComando;
  try
    ExecProg( s );
    result := true;
  except
    result := false;
  end;

  Exit;

  // Inicializa a estrutura TStartUpInfo
  // indicando formato de abertura da janela
  // e setando os atributos obrigat?rios
  // de serem inicializados.
  FillChar(lStartUpInfo, SizeOf(lStartUpInfo), #0);
  With lStartUpInfo do begin
    cb         :=SizeOf(lStartUpInfo);
    lpReserved :=NIL;
    lpDesktop  :=NIL;
    lpTitle    :=NIL;
    dwFlags    :=STARTF_USESHOWWINDOW;
    wShowWindow:=SW_Hide; //SW_SHOWNORMAL; //para n?o aparecer na tela!
    cbReserved2:=0;
    lpReserved2:=NIL;
  end;


  // Cria o processo notepad.exe e passa por
  // par?metro o arquivo a ser aberto.
  // Passa tamb?m as estruturas de controle,
  // lStartUpInfo e lProcesso.
  if not CreateProcess( NIL,
                        PChar(s),
                        NIL,
                        NIL,
                        False,
                        CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, {0}
                        NIL,
                        nil, //PChar(ExtractFilePath(edArquivo.Text))
                        lStartUpInfo,
                        FProcesso) then
    ShowMessage('Erro ao tentar carregar o MySQL')
  else begin
    // Abre tela de apoio para aguardar o
    // t?rmino do processo rec?m criado.
    // A tela de apoio fica testando
    // o status do processo, atrav?s da
    // fun??o da API do Windows, chamada
    // GetExitCodeProcess

    GetExitCodeProcess( FProcesso.hProcess,estado );
    while estado<>STILL_ACTIVE do begin
      GetExitCodeProcess( FProcesso.hProcess,estado );
    end;

    //WaitForSingleObject(ProcInfo.hProcess, INFINITE); isso as vezes n?o da certo...
//    CloseHandle(FProcesso.hProcess);
//    CloseHandle(FProcesso.hThread);
  end;
  processo := FProcesso;
end;

function TConfiguraMySQL.pPararMySQL( NomeProcesso: string ): boolean;
begin
  Result := (KillTask( NomeProcesso )>0);
end;

function TConfiguraMySQL.PararMySQL( var processo: TProcessInformation ): boolean;
var
  lStartUpInfo:TStartUpInfo;
  s,LinhaComando,porta,Ip: string;
  ExitCode: longword;
begin
  Result := pPararMySQL( 'mysqld-nt.exe' );
  Exit;

{  esta rotina abaixo funcionou mas ele deixa o arquivo de erros *.err aberto

  s := '\MySQL50\bin\mysqladmin.exe --user=root --port=3307 --host=127.0.0.1 shutdown';
  LinhaComando := self.PegaBaseDir;
  if LinhaComando<>'' then begin
    porta := self.PegaPorta;
    ip := self.PegaIP;
    s := StringReplace( LinhaComando,'/','\',[rfReplaceAll] )+'\bin\mysqladmin.exe --user=root --port='+porta+' --host='+ip+' shutdown';
  end;

  // Inicializa a estrutura TStartUpInfo
  // indicando formato de abertura da janela
  // e setando os atributos obrigat?rios
  // de serem inicializados.
  With lStartUpInfo do begin
    cb         :=2048;
    lpReserved :=NIL;
    lpDesktop  :=NIL;
    lpTitle    :=NIL;
    dwFlags    :=STARTF_USESHOWWINDOW;
    wShowWindow:=SW_Hide; //SW_SHOWNORMAL; //para n?o aparecer na tela!
    cbReserved2:=0;
    lpReserved2:=NIL;
  end;

  if not CreateProcess(NIL,PChar(s),
                       NIL,NIL,False,0,NIL,nil, //PChar(ExtractFilePath(edArquivo.Text))
                       lStartUpInfo, FProcesso) then
    ShowMessage('Erro ao tentar parar o MySQL')
  else begin
    // Abre tela de apoio para aguardar o
    // t?rmino do processo rec?m criado.
    // A tela de apoio fica testando
    // o status do processo, atrav?s da
    // fun??o da API do Windows, chamada
    WaitForSingleObject( FProcesso.hProcess, INFINITE);
    GetExitCodeProcess( FProcesso.hProcess, ExitCode );
  end;
  processo := FProcesso;

}

end;


end.
