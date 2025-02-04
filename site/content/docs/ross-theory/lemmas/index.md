+++
title = 'Леммы ROSS'
draft = false
+++

## Лемма 1{#lemma1}

{{< callout type="info" emoji="👉" >}}
Логические развилки находятся в сервисах либо сценариях.
{{< /callout >}}

### Лемма 1. Доказательство

Предположим, что логическая развилка находится в операции. Тогда операция будет разделена на логические 3 части: одна часть до развилки и 2 части после. Это противоречит [аксиоме атомарности](../axioms/#atom "Аксиома атомарности — rossmanual.com").

### Лемма 1. Следствие A

Если возникает потребность в логической развилке, то ее можно перенести на уровень выше или ниже. Логические развилки следует переносить:

1) на уровень сценариев. В этом случае сценарий параметризирует вызов операции и обрабатывает результат выполнения операции;
2) на уровень сервисов. В этом случае операция запрашивает у сервиса результат логических расчетов, выполненных внутри сервиса.

## Лемма 2{#lemma2}

{{< callout type="info" emoji="👉" >}}
Вызов сценария осуществляется в только в сервисах.
{{< /callout >}}

### Лемма 2. Доказательство

Предположим, что сценарий вызывается из другого сценария. Тогда сценарий имеет доступ к другому сценарию, а  это противоречит [аксиоме однородности](../axioms/#uniform "Аксиома однородности — rossmanual.com").
Предположим, что сценарий вызывается из операции. Тогда операция должна будет обработать результат выполнения сценария, т.е. содержать логическую развилку. Согласно [лемме 1](#lemma1 "Лемма 1 — rossmanual.com") логические развилки находятся в сервисах либо сценариях.

## Лемма 3{#lemma3}

{{< callout type="info" emoji="👉" >}}
Сервис не имеет доступа к операциям.
{{< /callout >}}

### Лемма 3. Доказательство

Предположим, что сервис имеет доступ к операции. Это противоречит [аксиоме вложенности](../axioms/#shell "Аксиома вложенности — rossmanual.com"), следовательно сервис не имеет доступа к операциям.

### Лемма 3. Следствие A

Если сервису нужно обратиться к `операции A`, то это признак неявной зависимости. Как правило, сервис обслуживает запрос другой операции, например, `операции B`. `Операция B` всегда выполняется в контексте некоторого сценария ([аксиома вложенности](./../axioms/#shell "Аксиома вложенности — rossmanual.com")),  значит, вызов `операции A` следует добавить во все сценарии, где используется `операция B`. Если `операции A` и `B` связаны безусловно, то их следует объединить в одну операцию.

### Лемма 3. Следствие B

Если сервису нужно обратиться к операции, не следует «обходить» [лемму 3](#lemma3 "Лемма 3 — rossmanual.com") переносом  операции  в отдельный сценарий. Сценарий, состоящий из единственной операции, избыточен, поскольку эквивалентен операции.
