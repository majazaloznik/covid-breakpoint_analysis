### exploring struccplot::breakpoints() to look for breaks in covid data

by [Luka Medic](https://github.com/luka-medic) ([implementacija mz](code/))

Jiang, Zhao & Shao (2020) [Time series analysis of COVID-19 infection curve: A change-point perspective](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7392157/pdf/main.pdf)

1. V  članku so vzeli `data=log(cumulativeCases)`, gledali pa so prelome na linearnih odsekih `y~kx+n`.
2. `cumulativeCases` je "zvezna funkcija", ker je integral `dailyCases`.
3. Ker je zvezna, ni mogoč prelom `n`. Prelomi se lahko samo `k`. Kar ni nič drugega kot sprememba/prelom odvoda `y`.
4. To pomeni, da je ekvivalentno reševati problem: `data=diff(log(cumulativeCases))` na konstantnih odsekih `y~k`.
5. V zvezni limiti velja: `diff(log(cumulativeCases)) ->  d/dx [log( integral(dailyCases) )] = dailyCases/cumulativeCases`.
6. To pomeni, da v tistem članku niso delali nič drugega, kot z navadnim BP analizirali  `data=dailyCases/cumulativeCases`.
7. Ta analiza je ekvivalentna analizi faznega prostora `(dailyCases, cumulativeCases)`.
8. Mi pa že vemo, da `cumulativeCases` hrani vso zgodovino primerov, kar je nepotrebno, saj tisti iz marca niso relevantni za trenutno dogajanje. Zato je smiselno nekje v zgodovini odrezati podatke, recimo nekaj period `p`, kjer je dolžina periode dolga `d=7` dni. Imamo `movingSum(p)` z oknom `d=7p` dni. (NB: `movingAvg(p) = movingSum(p) / (7p))`
9. Dobimo fazni prostor `(dailyCases, movingSum(p))`, ekvivalentno pa lahko analizo ponovimo z BP na `data=dailyCases/movingSum(p) `.
![plot1](figures/plot1.png)
10. Lahko pa primerjamo različne periode: `(movingSum(p1), movingSum(p2))`, npr. `p1=1`, `p2=3`.
![plot2](figures/plot2.png)