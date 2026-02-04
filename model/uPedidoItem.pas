unit uPedidoItem;

interface

type
  TPedidoItem = class
  public
    Id            : Integer;
    CodigoProduto : Integer;
    Quantidade    : Double;
    ValorUnitario : Currency;
    ValorTotal    : Currency;
    Descricao     : string;
  end;

implementation

end.
