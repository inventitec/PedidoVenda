unit uPedidoService;

interface

uses
  uPedido,
  uPedidoItem;

type
  TPedidoService = class
  public
    class procedure AdicionarItem(pPedido: TPedido; pItem: TPedidoItem);
    class procedure RemoverItem(pPedido: TPedido; pItem: TPedidoItem);
  end;

implementation

class procedure TPedidoService.AdicionarItem(pPedido: TPedido; pItem: TPedidoItem);
begin
  pItem.ValorTotal := pItem.Quantidade * pItem.ValorUnitario;
  pPedido.Itens.Add(pItem);
end;

class procedure TPedidoService.RemoverItem(pPedido: TPedido; pItem: TPedidoItem);
begin
  pPedido.Itens.Remove(pItem);
end;

end.
