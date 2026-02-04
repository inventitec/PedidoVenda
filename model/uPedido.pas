unit uPedido;

interface

uses
  System.Generics.Collections,
  uPedidoItem;

type
  TPedido = class
  private
    function GetValorTotal: Currency;
  public
    Numero: Integer;
    CodigoCliente: Integer;
    DataEmissao: TDate;
    Itens: TObjectList<TPedidoItem>;

    constructor Create;
    destructor Destroy; override;

    property ValorTotal: Currency read GetValorTotal;
  end;

implementation

constructor TPedido.Create;
begin
  Itens := TObjectList<TPedidoItem>.Create(True);
end;

destructor TPedido.Destroy;
begin
  Itens.Free;
  inherited;
end;

function TPedido.GetValorTotal: Currency;
var
  Item: TPedidoItem;
begin
  Result := 0;
  for Item in Itens do
    Result := Result + Item.ValorTotal;
end;

end.
