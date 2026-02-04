unit uClienteRepository;

interface

uses
  uCliente;

type
  TClienteRepository = class
  public
    class function BuscarPorCodigo(pCodigo: Integer): TCliente;
  end;

implementation

uses
  FireDAC.Comp.Client,
  System.SysUtils,
  uDM;

class function TClienteRepository.BuscarPorCodigo(pCodigo: Integer): TCliente;
var
  qry: TFDQuery;
begin
  Result := nil;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := DM.DB;
    qry.SQL.Text :=
      'SELECT CODIGO, NOME, CIDADE, UF FROM CLIENTE WHERE CODIGO = :CODIGO';
    qry.ParamByName('CODIGO').AsInteger := pCodigo;
    qry.Open;

    if not qry.IsEmpty then
    begin
      Result := TCliente.Create;
      Result.Codigo := qry.FieldByName('CODIGO').AsInteger;
      Result.Nome   := qry.FieldByName('NOME').AsString;
      Result.Cidade := qry.FieldByName('CIDADE').AsString;
      Result.UF     := qry.FieldByName('UF').AsString;
    end;
  finally
    qry.Free;
  end;
end;

end.
