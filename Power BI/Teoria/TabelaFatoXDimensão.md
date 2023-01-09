# Tabela Fato X Dimensão
### Tabela Fato
Tabela fato representará acontecimentos, como por exemplo, vendas. Dentro dessa tabela fato, deve-se sempre haver colunas com "chaves estrangeiras", 
são essas "chaves estrangeiras" que irão criar uma relação entre a tabela fato e a tabela dimensão.

### Tabela Dimensão  
Com intuito de minimizar a quantidade de dados existentes em uma tabela fato, a tabela dimensão contém pequenos resumos complementares para concretizar uma informação. 

Por exemplo:   
## Tabela Fato
---  
|Cód. Produto|Produto|R$ Venda| Cód. Vendedor|
|:----------:|:-------:|:--------:|:--------------:|
|01|Iogurte|R$ 10,00|101|

## Tabela Dimensão  
---
|Cód. Vendedor|Nome|Idade|Data Nascimento|
|:-----------:|:--:|:---:|:-------------:|
|101|Vanderlan|28|10/01/1994|

## Relacionamento  
Notem as tabelas tem uma coluna em comum, a coluna "Cód. Vendedor", através dessa coluna será possível ser feito o relacionamento no Power BI, 
sendo assim, não seria necessário repetir várias vezes o nome, idade, 
data de nascimento e cód do vendedor para identificar de quem foi aquela venda. Com uma pequena quantidade de dados, talvez não seja tão evidente assim, mas de acordo com o aumento da tabela fato será notório essa estratégia de relacionamentos entre as tabelas.
