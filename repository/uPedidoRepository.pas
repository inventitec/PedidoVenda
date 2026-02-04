unit uPedidoRepository;

interface

uses
  uPedido;

type
  TPedidoRepository = class
  public
    class function Gravar(pPedido: TPedido): Integer;
  end;

implementation

uses
  FireDAC.Comp.Client,
  System.SysUtils,
  uDM,
  uPedidoItem;

class function TPedidoRepository.Gravar(pPedido: TPedido): Integer;
var
  qry    : TFDQuery;
  qryNum : TFDQuery;
  Item   : TPedidoItem;
begin
  qry    := TFDQuery.Create(nil);
  qryNum := TFDQuery.Create(nil);
  try
    DM.DB.StartTransaction;
    try
      qry.Connection := DM.DB;
      qry.SQL.Text   := 'INSERT INTO PEDIDO (DATA_EMISSAO, CODIGO_CLIENTE, VALOR_TOTAL, OBSERVACAO) ' +
        'VALUES (:DATA, :CLIENTE, :TOTAL, :OBS)';
      qry.ParamByName('DATA').AsDate       := pPedido.DataEmissao;
      qry.ParamByName('CLIENTE').AsInteger := pPedido.CodigoCliente;
      qry.ParamByName('TOTAL').AsCurrency  := pPedido.ValorTotal;
      qry.ParamByName('OBS').AsString      := pPedido.Observacao;
      qry.ExecSQL;

      qryNum.Connection := DM.DB;
      qryNum.SQL.Text := 'SELECT MAX(NUMERO_PEDIDO) AS NUM FROM PEDIDO';
      qryNum.Open;

      Result := qryNum.FieldByName('NUM').AsInteger;
      qryNum.Close;

      qry.SQL.Text :=
        'INSERT INTO PEDIDO_ITEM ' +
        '(NUMERO_PEDIDO, CODIGO_PRODUTO, QUANTIDADE, VLR_UNITARIO, VLR_TOTAL) ' +
        'VALUES (:PEDIDO, :PRODUTO, :QTD, :UNIT, :TOTAL)';

      for Item in pPedido.Itens do
      begin
        qry.ParamByName('PEDIDO').AsInteger  := Result;
        qry.ParamByName('PRODUTO').AsInteger := Item.CodigoProduto;
        qry.ParamByName('QTD').AsFloat       := Item.Quantidade;
        qry.ParamByName('UNIT').AsCurrency   := Item.ValorUnitario;
        qry.ParamByName('TOTAL').AsCurrency  := Item.ValorTotal;
        qry.ExecSQL;
      end;

      DM.DB.Commit;
    except
      DM.DB.Rollback;
      raise;
    end;
  finally
    qryNum.Free;
    qry.Free;
  end;
end;

end.
