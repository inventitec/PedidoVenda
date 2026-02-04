unit uFrmPedidoVenda;

interface

uses
  uCliente,
  uProduto,
  uPedido,
  uPedidoItem,
  uClienteRepository,
  uProdutoRepository,
  uPedidoRepository,
  uPedidoService,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Grids;

type
  TFrmPedidoVenda = class(TForm)
    lblCodCliente: TLabel;
    lblNomeCliente: TLabel;
    lblCidade: TLabel;
    lblUF: TLabel;
    lblCodProduto: TLabel;
    lblQtd: TLabel;
    lblVlrUnit: TLabel;
    lblTotal: TLabel;
    lblObs: TLabel;
    edtCodCliente: TEdit;
    edtNomeCliente: TEdit;
    edtCidade: TEdit;
    edtUF: TEdit;
    edtCodProduto: TEdit;
    edtQtd: TEdit;
    edtVlrUnit: TEdit;
    btnAddItem: TButton;
    grdItens: TStringGrid;
    memObs: TMemo;
    btnGravar: TButton;
    edtVlrTotal: TEdit;
    Label1: TLabel;
    edtDescricao: TEdit;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddItemClick(Sender: TObject);
    procedure grdItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtQtdExit(Sender: TObject);
    procedure edtVlrUnitExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    FPedido: TPedido;
    FEditRow: Integer;
    procedure SetarFoco(pComponente: TWinControl);
    procedure AtualizarTotal;
    procedure AtualizarCampoTotal;
    procedure LimparCamposProduto;
    procedure LimparCamposCliente;
    procedure AtualizarGrid;

    function FormartarCasasDecimais(pValor: string): string;
  public
    { Public declarations }
  end;

var
  FrmPedidoVenda: TFrmPedidoVenda;

implementation

{$R *.dfm}

procedure TFrmPedidoVenda.AtualizarCampoTotal;
begin
  edtVlrTotal.Text := FormatFloat('0.00', StrToFloatDef(edtQtd.Text,0) * StrToFloatDef(edtVlrUnit.Text,0));
end;

procedure TFrmPedidoVenda.AtualizarGrid;
var
  i: Integer;
  item: TPedidoItem;
  produto: TProduto;
begin
  grdItens.RowCount := FPedido.Itens.Count + 1;

  for i := 0 to FPedido.Itens.Count - 1 do
  begin
    item := FPedido.Itens[i];
    produto := TProdutoRepository.BuscarPorCodigo(item.CodigoProduto);
    try
      grdItens.Cells[0,i+1] := IntToStr(item.CodigoProduto);
      grdItens.Cells[1,i+1] := produto.Descricao;
      grdItens.Cells[2,i+1] := FormartarCasasDecimais(FloatToStr(item.Quantidade));
      grdItens.Cells[3,i+1] := FormartarCasasDecimais(CurrToStr(item.ValorUnitario));
      grdItens.Cells[4,i+1] := FormartarCasasDecimais(CurrToStr(item.ValorTotal));
    finally
      produto.Free;
    end;
  end;
end;

procedure TFrmPedidoVenda.AtualizarTotal;
var
  i: Integer;
  total: Double;
begin
  total := 0;
  for i := 1 to grdItens.RowCount - 1 do
    total := total + StrToFloatDef(grdItens.Cells[4,i], 0);

  lblTotal.Caption := 'Total: R$ ' + FormatFloat('0.00', total);
end;

procedure TFrmPedidoVenda.btnAddItemClick(Sender: TObject);
var
  pItem: TPedidoItem;
begin
  if FPedido.CodigoCliente = 0 then
  begin
    ShowMessage('Informe um cliente válido.');
    SetarFoco(edtCodCliente);
    Exit;
  end;

  if Trim(edtCodProduto.Text) = '' then
  begin
    ShowMessage('Código produto inválido.');
    SetarFoco(edtCodProduto);
    Exit;
  end;

  if FEditRow >= 0 then
  begin
    pItem               := FPedido.Itens[FEditRow];
    pItem.CodigoProduto := StrToIntDef(edtCodProduto.Text, 0);
    pItem.Quantidade    := StrToFloatDef(edtQtd.Text, 0);
    pItem.ValorUnitario := StrToCurrDef(edtVlrUnit.Text, 0);
    pItem.ValorTotal    := pItem.Quantidade * pItem.ValorUnitario;
    FEditRow := -1;
  end
  else
  begin
    pItem               := TPedidoItem.Create;
    pItem.CodigoProduto := StrToIntDef(edtCodProduto.Text, 0);
    pItem.Quantidade    := StrToFloatDef(edtQtd.Text, 0);
    pItem.ValorUnitario := StrToCurrDef(edtVlrUnit.Text, 0);
    pItem.Descricao     := edtDescricao.Text;
    TPedidoService.AdicionarItem(FPedido, pItem);
  end;

  AtualizarGrid;
  AtualizarTotal;
  LimparCamposProduto;

  SetarFoco(edtCodProduto);
end;

procedure TFrmPedidoVenda.btnGravarClick(Sender: TObject);
begin
  if FPedido.CodigoCliente = 0 then
  begin
    ShowMessage('Informe um cliente válido.');
    SetarFoco(edtCodCliente);
    Exit;
  end;

  if FPedido.Itens.Count = 0 then
  begin
    ShowMessage('Adicione pelo menos um item ao pedido.');
    SetarFoco(edtCodProduto);
    Exit;
  end;

  FPedido.Observacao := memObs.Text;
  FPedido.DataEmissao := Date;

  try
    FPedido.Numero := TPedidoRepository.Gravar(FPedido);

    MessageDlg('Pedido gravado com sucesso!' + sLineBreak +
               'Número do pedido: ' + IntToStr(FPedido.Numero),
               mtInformation, [mbOK], 0);

    // Limpar para novo pedido
    FPedido.Itens.Clear;
    edtCodCliente.Clear;
    LimparCamposCliente;
    LimparCamposProduto;
    memObs.Clear;
    AtualizarGrid;
    AtualizarTotal;

    SetarFoco(edtCodCliente);
  except
    on E: Exception do
      MessageDlg('Erro ao gravar pedido:' + sLineBreak + E.Message,
                 mtError, [mbOK], 0);
  end;
end;

procedure TFrmPedidoVenda.edtCodClienteExit(Sender: TObject);
var
  cliente: TCliente;
  pCodigo: Integer;
begin
  LimparCamposCliente;
  FPedido.CodigoCliente := 0;

  if Trim(edtCodCliente.Text) = '' then
  begin
    LimparCamposCliente;
    Exit;
  end;

  pCodigo := StrToIntDef(edtCodCliente.Text, 0);
  if pCodigo = 0 then
  begin
    ShowMessage('Código de cliente inválido.');
    SetarFoco(edtCodCliente);
    Exit;
  end;

  cliente := TClienteRepository.BuscarPorCodigo(pCodigo);
  try
    if cliente = nil then
    begin
      ShowMessage('Cliente não encontrado.');
      edtCodCliente.Clear;
      SetarFoco(edtCodCliente);
      Exit;
    end;

    edtNomeCliente.Text   := cliente.Nome;
    edtCidade.Text        := cliente.Cidade;
    edtUF.Text            := cliente.UF;

    FPedido.CodigoCliente := cliente.Codigo;
  finally
    cliente.Free;
  end;
end;

procedure TFrmPedidoVenda.edtCodProdutoExit(Sender: TObject);
var
  produto: TProduto;
  pCodigo: Integer;
begin
  if Trim(edtCodProduto.Text) = '' then
  begin
    LimparCamposProduto;
    Exit;
  end;

  pCodigo := StrToIntDef(edtCodProduto.Text, 0);
  if pCodigo = 0 then
  begin
    ShowMessage('Código de produto inválido.');
    SetarFoco(edtCodProduto);
    Exit;
  end;

  produto := TProdutoRepository.BuscarPorCodigo(pCodigo);
  try
    if produto = nil then
    begin
      ShowMessage('Produto não encontrado.');
      LimparCamposProduto;
      Exit;
    end;

    edtVlrUnit.Text   := FormartarCasasDecimais(CurrToStr(produto.PrecoVenda));
    edtDescricao.Text := produto.Descricao;

    //️ SOMENTE PARA NOVO ITEM
    if FEditRow = -1 then
      edtQtd.Text := FormartarCasasDecimais('1');

    AtualizarCampoTotal;
    SetarFoco(edtQtd);
  finally
    produto.Free;
  end;
end;

procedure TFrmPedidoVenda.edtQtdExit(Sender: TObject);
begin
  edtQtd.Text := FormartarCasasDecimais(edtQtd.Text);
  AtualizarCampoTotal;
end;

procedure TFrmPedidoVenda.edtVlrUnitExit(Sender: TObject);
begin
  edtVlrUnit.Text := FormartarCasasDecimais(edtVlrUnit.Text);
  AtualizarCampoTotal;
end;

function TFrmPedidoVenda.FormartarCasasDecimais(pValor: string): string;
begin
  Result := FormatFloat('0.00', StrToFloatDef(pValor,0));
end;

procedure TFrmPedidoVenda.FormCreate(Sender: TObject);
begin
  KeyPreview := True;

  FPedido := TPedido.Create;
  FEditRow := -1;

  grdItens.ColCount := 5;
  grdItens.FixedRows := 1;
  grdItens.RowCount := 1;

  grdItens.Cells[0,0] := 'Cód. produto';
  grdItens.Cells[1,0] := 'Descrição';
  grdItens.Cells[2,0] := 'Quantidade';
  grdItens.Cells[3,0] := 'Vlr. Unitário';
  grdItens.Cells[4,0] := 'Vlr. Total(Item)';

  grdItens.ColWidths[0] := 100;
  grdItens.ColWidths[1] := 300;
  grdItens.ColWidths[2] := 100;
  grdItens.ColWidths[3] := 100;
  grdItens.ColWidths[4] := 100;
end;

procedure TFrmPedidoVenda.FormDestroy(Sender: TObject);
begin
  FPedido.Free;
end;

procedure TFrmPedidoVenda.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFrmPedidoVenda.grdItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  idx: Integer;
begin
  if (Key = VK_RETURN) and (grdItens.Row > 0) then
  begin
    idx := grdItens.Row - 1;

    if idx < FPedido.Itens.Count then
    begin
      FEditRow           := idx;
      edtCodProduto.Text := IntToStr(FPedido.Itens[idx].CodigoProduto);
      edtQtd.Text        := FormartarCasasDecimais(FloatToStr(FPedido.Itens[idx].Quantidade));
      edtVlrUnit.Text    := FormartarCasasDecimais(CurrToStr(FPedido.Itens[idx].ValorUnitario));
      edtDescricao.Text  := FPedido.Itens[idx].Descricao;
      SetarFoco(edtCodProduto);
    end;

    Key := 0;
    Exit;
  end;

  if (Key = VK_DELETE) and (grdItens.Row > 0) then
  begin
    if MessageDlg('Deseja excluir este registro?', mtConfirmation,
      [mbYes, mbNo], 0, mbNo) = mrYes then
    begin
      idx := grdItens.Row - 1;
      if idx < FPedido.Itens.Count then
      begin
        FPedido.Itens.Delete(idx);
        AtualizarGrid;
        AtualizarTotal;
      end;
      Key := 0;
    end;
  end;
end;

procedure TFrmPedidoVenda.LimparCamposCliente;
begin
  edtNomeCliente.Clear;
  edtCidade.Clear;
  edtUF.Clear;
end;

procedure TFrmPedidoVenda.LimparCamposProduto;
begin
  edtCodProduto.Clear;
  edtQtd.Clear;
  edtVlrUnit.Clear;
  edtVlrTotal.Clear;
  edtDescricao.Clear;
end;

procedure TFrmPedidoVenda.SetarFoco(pComponente: TWinControl);
begin
  if pComponente.CanFocus then
    pComponente.SetFocus;
end;

end.
