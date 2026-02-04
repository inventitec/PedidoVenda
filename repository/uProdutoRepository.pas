unit uProdutoRepository;

interface

uses
  uProduto;

type
  TProdutoRepository = class
  public
    class function BuscarPorCodigo(pCodigo: Integer): TProduto;
  end;

implementation

uses
  FireDAC.Comp.Client,
  System.SysUtils,
  uDM;

class function TProdutoRepository.BuscarPorCodigo(pCodigo: Integer): TProduto;
var
  qry: TFDQuery;
begin
  Result := nil;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := DM.DB;
    qry.SQL.Text   :=  'SELECT CODIGO, DESCRICAO, PRECO_VENDA '+
      'FROM PRODUTO '+
      'WHERE CODIGO = :CODIGO';
    qry.ParamByName('CODIGO').AsInteger := pCodigo;
    qry.Open;

    if not qry.IsEmpty then
    begin
      Result := TProduto.Create;
      Result.Codigo     := qry.FieldByName('CODIGO').AsInteger;
      Result.Descricao  := qry.FieldByName('DESCRICAO').AsString;
      Result.PrecoVenda := qry.FieldByName('PRECO_VENDA').AsCurrency;
    end;
  finally
    qry.Free;
  end;
end;

end.
