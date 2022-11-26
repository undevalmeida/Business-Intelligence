# Dimensão Tempo
* Granularidade e periodicidade
  * Granularidade: É o menor grão da dimensão tempo associado a uma ocorrência.
  * Periodicidade: É o menor grão da dimensão onde eu faço os "fotografias".

## Fotografia do carro
* Carro A: | 2012/01/01 às 00:00 |
* Carro B: | 2012/01/01 às 01:00 |
* Carro C: | 2012/01/01 às 02:00 |

Granularidade foi de 1 em 1 hora.

---

### Se a Granularidade for diária.

* Carro A: | 2012/01/01 |
* Carro B: | 2012/01/01 |
* Carro C: | 2012/01/01 |

* Exemplos de indicadores com Granularidades e Periodicidades diferentes
  * Medição de Energia Elétrica;
  * Inflação acumulada;
  * Saldo diário da conta corrente.

---

## Agragando a dimensão tempo
* Podemos representar a dimensão tempo da mesma maneira que as outras dimensões
  * Modelo Estrela
  * Modelo Floco de Neve
  * Tabela Pai / Filho
* Os níveis de agragação são já os mesmos associados ao tempo
  * Milisegundo
  * Segundo
  * Quarto de Hora
  * Hora
  * Período(Manhã, Tarde ou Noite)
  * Dia
  * Dia da Semana
  * Semana do Mês
  * Mês
  * Bimestral
  * Trimestral
  * Semestral
  * Anual
  * Década
* A Periodicidade e Granularidade estão associadas a medida
* Num mesmo modelo gerencial podemos ter indicadores com Granularidades e Periodicidades diferentes
  * Venda de um produto(Granularidade diária)
  * Custo de mão de obra(Granularidade mensal)
* As medidas de granularidade diferentes devem ficar em tabelas de fato diferentes