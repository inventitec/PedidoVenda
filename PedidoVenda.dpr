program PedidoVenda;

uses
  Vcl.Forms,
  UDM in 'UDM.pas' {DM: TDataModule},
  uCliente in 'model\uCliente.pas',
  uPedido in 'model\uPedido.pas',
  uPedidoItem in 'model\uPedidoItem.pas',
  uProduto in 'model\uProduto.pas',
  uClienteRepository in 'repository\uClienteRepository.pas',
  uPedidoRepository in 'repository\uPedidoRepository.pas',
  uProdutoRepository in 'repository\uProdutoRepository.pas',
  uPedidoService in 'service\uPedidoService.pas',
  uFrmPedidoVenda in 'view\uFrmPedidoVenda.pas' {FrmPedidoVenda};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmPedidoVenda, FrmPedidoVenda);
  Application.Run;
end.
