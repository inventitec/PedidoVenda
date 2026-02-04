unit uDM;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.Comp.UI, Data.DB, FireDAC.Phys.IBBase;

type
  TDM = class(TDataModule)
    DB: TFDConnection;
    WaitCursor: TFDGUIxWaitCursor;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure CarregarConfiguracao;
  public
    procedure Conectar;
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.CarregarConfiguracao;
var
  Ini: TIniFile;
  IniPath: string;
begin
  if DB.Connected then
    DB.Connected := False;

  IniPath := ExtractFilePath(ParamStr(0)) + 'Config.ini';

  if not FileExists(IniPath) then
    raise Exception.Create('Arquivo config.ini não encontrado.');

  Ini := TIniFile.Create(IniPath);
  try
    DB.Params.Clear;
    DB.Params.DriverID := 'FB';
    DB.Params.Database := Ini.ReadString('DATABASE', 'Database', '');
    DB.Params.UserName := Ini.ReadString('DATABASE', 'Username', '');
    DB.Params.Password := Ini.ReadString('DATABASE', 'Password', '');
    DB.Params.Add('Server=' + Ini.ReadString('DATABASE', 'Server', 'localhost'));
    DB.Params.Add('Port='   + Ini.ReadString('DATABASE', 'Port', '3050'));

    FDPhysFBDriverLink.VendorLib := Ini.ReadString('DATABASE', 'ClientLibrary', 'fbclient.dll');
  finally
    Ini.Free;
  end;
end;

procedure TDM.Conectar;
begin
  CarregarConfiguracao;
  DB.Connected := True;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  Conectar;
end;

end.

