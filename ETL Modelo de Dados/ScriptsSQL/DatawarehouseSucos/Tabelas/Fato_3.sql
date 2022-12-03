﻿CREATE TABLE [dbo].[Fato_3]
(
    [Cod_Fabrica] NVARCHAR(50) NOT NULL, 
    [Cod_Dia] NVARCHAR(50) NOT NULL, 
    [Custo_Fixo] FLOAT NULL,
    PRIMARY KEY ([Cod_Dia], [Cod_Fabrica]),
    CONSTRAINT [FK_Fato_3_Dim_Fabrica] FOREIGN KEY ([Cod_Fabrica]) REFERENCES [Dim_Fabrica]([Cod_Fabrica]),
    CONSTRAINT [FK_Fato_3_Dim_Tempo] FOREIGN KEY ([Cod_Dia]) REFERENCES [Dim_Tempo]([Cod_Dia])	
)