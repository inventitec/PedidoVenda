object FrmPedidoVenda: TFrmPedidoVenda
  Left = 0
  Top = 0
  Caption = 'Pedido de venda'
  ClientHeight = 431
  ClientWidth = 773
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object lblCodCliente: TLabel
    Left = 16
    Top = 15
    Width = 75
    Height = 13
    Caption = 'C'#243'digo cliente'
    FocusControl = edtCodCliente
  end
  object lblNomeCliente: TLabel
    Left = 107
    Top = 15
    Width = 30
    Height = 13
    Caption = 'Nome'
    FocusControl = edtNomeCliente
  end
  object lblCidade: TLabel
    Left = 363
    Top = 15
    Width = 36
    Height = 13
    Caption = 'Cidade'
    FocusControl = edtCidade
  end
  object lblUF: TLabel
    Left = 569
    Top = 15
    Width = 14
    Height = 13
    Caption = 'UF'
    FocusControl = edtUF
  end
  object lblCodProduto: TLabel
    Left = 16
    Top = 65
    Width = 70
    Height = 13
    Caption = 'C'#243'd. produto'
    FocusControl = edtCodProduto
  end
  object lblQtd: TLabel
    Left = 363
    Top = 65
    Width = 61
    Height = 13
    Caption = 'Quantidade'
    FocusControl = edtQtd
  end
  object lblVlrUnit: TLabel
    Left = 449
    Top = 65
    Width = 70
    Height = 13
    Caption = 'Valor unit'#225'rio'
    FocusControl = edtVlrUnit
  end
  object lblTotal: TLabel
    Left = 16
    Top = 385
    Width = 67
    Height = 13
    Caption = 'Total: R$ 0,00'
  end
  object Label1: TLabel
    Left = 535
    Top = 65
    Width = 53
    Height = 13
    Caption = 'Valor total'
    FocusControl = edtVlrTotal
  end
  object Label2: TLabel
    Left = 107
    Top = 65
    Width = 49
    Height = 13
    Caption = 'Descri'#231#227'o'
    FocusControl = edtDescricao
  end
  object edtCodCliente: TEdit
    Left = 16
    Top = 30
    Width = 85
    Height = 21
    TabOrder = 0
    OnExit = edtCodClienteExit
  end
  object edtNomeCliente: TEdit
    Left = 107
    Top = 30
    Width = 250
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 1
  end
  object edtCidade: TEdit
    Left = 363
    Top = 30
    Width = 200
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 2
  end
  object edtUF: TEdit
    Left = 569
    Top = 30
    Width = 46
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 3
  end
  object edtCodProduto: TEdit
    Left = 16
    Top = 80
    Width = 85
    Height = 21
    TabOrder = 4
    OnExit = edtCodProdutoExit
  end
  object edtQtd: TEdit
    Left = 363
    Top = 80
    Width = 80
    Height = 21
    TabOrder = 6
    OnExit = edtQtdExit
  end
  object edtVlrUnit: TEdit
    Left = 449
    Top = 80
    Width = 80
    Height = 21
    TabOrder = 7
    OnExit = edtVlrUnitExit
  end
  object btnAddItem: TButton
    Left = 633
    Top = 80
    Width = 129
    Height = 25
    Caption = 'Inserir / Atualizar Item'
    TabOrder = 9
    OnClick = btnAddItemClick
  end
  object grdItens: TStringGrid
    Left = 16
    Top = 119
    Width = 746
    Height = 250
    TabOrder = 10
    OnKeyDown = grdItensKeyDown
  end
  object btnGravar: TButton
    Left = 666
    Top = 385
    Width = 80
    Height = 25
    Caption = 'Gravar Pedido'
    TabOrder = 11
    OnClick = btnGravarClick
  end
  object edtVlrTotal: TEdit
    Left = 535
    Top = 80
    Width = 80
    Height = 21
    ReadOnly = True
    TabOrder = 8
  end
  object edtDescricao: TEdit
    Left = 107
    Top = 80
    Width = 250
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 5
    OnExit = edtCodProdutoExit
  end
end
