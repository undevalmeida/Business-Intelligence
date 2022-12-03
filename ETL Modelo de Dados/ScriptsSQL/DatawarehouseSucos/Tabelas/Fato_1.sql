CREATE TABLE [dbo].[Fato_1]
(
	[Cod_Cliente] NVARCHAR(50) NOT NULL , 
    [Cod_Produto] NVARCHAR(50) NOT NULL, 
    [Cod_Organizacional] NVARCHAR(50) NOT NULL, 
    [Cod_Fabrica] NVARCHAR(50) NOT NULL, 
    [Cod_Dia] NVARCHAR(50) NOT NULL, 
    [Faturamento] FLOAT NULL, 
    [Imposto] FLOAT NULL, 
    [Custo_Variavel] FLOAT NULL, 
    [Quantidade_vendida] FLOAT NULL, 
    [Unidade_Vendida] FLOAT NULL, 
    PRIMARY KEY ([Cod_Cliente], [Cod_Dia], [Cod_Produto], [Cod_Organizacional], [Cod_Fabrica]),
    CONSTRAINT [FK_Fato_1_Dim_Cliente] FOREIGN KEY ([Cod_Cliente]) REFERENCES [Dim_Clientes]([Cod_Cliente]),
    CONSTRAINT [FK_Fato_1_Dim_Produto] FOREIGN KEY ([Cod_Produto]) REFERENCES [Dim_Produto]([Cod_Produto]),
    CONSTRAINT [FK_Fato_1_Dim_Organizacional] FOREIGN KEY ([Cod_Organizacional]) REFERENCES [Dim_Organizacional]([Cod_Filho]),
    CONSTRAINT [FK_Fato_1_Dim_Fabrica] FOREIGN KEY ([Cod_Fabrica]) REFERENCES [Dim_Fabrica]([Cod_Fabrica]),
    CONSTRAINT [FK_Fato_1_Dim_Tempo] FOREIGN KEY ([Cod_Dia]) REFERENCES [Dim_Tempo]([Cod_Dia])	
)
