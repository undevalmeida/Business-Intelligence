﻿CREATE TABLE [dbo].[Fato_2]
(
	[Cod_Cliente] NVARCHAR(50) NOT NULL , 
    [Cod_Produto] NVARCHAR(50) NOT NULL, 
    [Cod_Fabrica] NVARCHAR(50) NOT NULL, 
    [Cod_Dia] NVARCHAR(50) NOT NULL, 
    [Frete] FLOAT NULL, 
    PRIMARY KEY ([Cod_Cliente], [Cod_Dia], [Cod_Produto], [Cod_Fabrica]),
    CONSTRAINT [FK_Fato_2_Dim_Cliente] FOREIGN KEY ([Cod_Cliente]) REFERENCES [Dim_Clientes]([Cod_Cliente]),
    CONSTRAINT [FK_Fato_2_Dim_Produto] FOREIGN KEY ([Cod_Produto]) REFERENCES [Dim_Produto]([Cod_Produto]),
    CONSTRAINT [FK_Fato_2_Dim_Fabrica] FOREIGN KEY ([Cod_Fabrica]) REFERENCES [Dim_Fabrica]([Cod_Fabrica]),
    CONSTRAINT [FK_Fato_2_Dim_Tempo] FOREIGN KEY ([Cod_Dia]) REFERENCES [Dim_Tempo]([Cod_Dia])	
)