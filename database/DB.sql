/******************************************************************************/
/****                              Generators                              ****/
/******************************************************************************/

CREATE GENERATOR GEN_PEDIDO;

CREATE GENERATOR GEN_PEDIDO_ITEM;


/******************************************************************************/
/****                                Tables                                ****/
/******************************************************************************/

CREATE TABLE CLIENTE (
    CODIGO  INTEGER NOT NULL,
    NOME    VARCHAR(100),
    CIDADE  VARCHAR(60),
    UF      CHAR(2)
);

CREATE TABLE PEDIDO (
    NUMERO_PEDIDO   INTEGER NOT NULL,
    DATA_EMISSAO    DATE,
    CODIGO_CLIENTE  INTEGER,
    VALOR_TOTAL     NUMERIC(15,2),
    OBSERVACAO      VARCHAR(255)
);

CREATE TABLE PEDIDO_ITEM (
    ID              INTEGER NOT NULL,
    NUMERO_PEDIDO   INTEGER NOT NULL,
    CODIGO_PRODUTO  INTEGER NOT NULL,
    QUANTIDADE      NUMERIC(15,2),
    VLR_UNITARIO    NUMERIC(15,2),
    VLR_TOTAL       NUMERIC(15,2)
);

CREATE TABLE PRODUTO (
    CODIGO       INTEGER NOT NULL,
    DESCRICAO    VARCHAR(120),
    PRECO_VENDA  NUMERIC(15,2)
);



/******************************************************************************/
/****                             Primary Keys                             ****/
/******************************************************************************/

ALTER TABLE CLIENTE ADD CONSTRAINT PK_CLIENTE PRIMARY KEY (CODIGO);
ALTER TABLE PEDIDO ADD CONSTRAINT PK_PEDIDO PRIMARY KEY (NUMERO_PEDIDO);
ALTER TABLE PEDIDO_ITEM ADD CONSTRAINT PK_PEDIDO_ITEM PRIMARY KEY (ID);
ALTER TABLE PRODUTO ADD CONSTRAINT PK_PRODUTO PRIMARY KEY (CODIGO);


/******************************************************************************/
/****                             Foreign Keys                             ****/
/******************************************************************************/

ALTER TABLE PEDIDO ADD CONSTRAINT FK_PEDIDO_CLIENTE FOREIGN KEY (CODIGO_CLIENTE) REFERENCES CLIENTE (CODIGO);
ALTER TABLE PEDIDO_ITEM ADD CONSTRAINT FK_ITEM_PEDIDO FOREIGN KEY (NUMERO_PEDIDO) REFERENCES PEDIDO (NUMERO_PEDIDO) ON DELETE CASCADE;
ALTER TABLE PEDIDO_ITEM ADD CONSTRAINT FK_ITEM_PRODUTO FOREIGN KEY (CODIGO_PRODUTO) REFERENCES PRODUTO (CODIGO);


/******************************************************************************/
/****                               Indices                                ****/
/******************************************************************************/

CREATE INDEX IDX_PEDIDO_CLIENTE ON PEDIDO (CODIGO_CLIENTE);
CREATE INDEX IDX_ITEM_PEDIDO ON PEDIDO_ITEM (NUMERO_PEDIDO);
CREATE INDEX IDX_ITEM_PRODUTO ON PEDIDO_ITEM (CODIGO_PRODUTO);


/******************************************************************************/
/****                               Triggers                               ****/
/******************************************************************************/


SET TERM ^ ;



/******************************************************************************/
/****                         Triggers for tables                          ****/
/******************************************************************************/



/* Trigger: BI_PEDIDO */
CREATE TRIGGER BI_PEDIDO FOR PEDIDO
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.NUMERO_PEDIDO IS NULL) THEN
        NEW.NUMERO_PEDIDO = GEN_ID(GEN_PEDIDO, 1);
END
^

/* Trigger: BI_PEDIDO_ITEM */
CREATE TRIGGER BI_PEDIDO_ITEM FOR PEDIDO_ITEM
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.ID IS NULL) THEN
        NEW.ID = GEN_ID(GEN_PEDIDO_ITEM, 1);
END
^

SET TERM ; ^

