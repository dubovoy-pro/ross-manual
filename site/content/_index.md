+++
title = 'Архитектура ROSS'
layout = 'hextra-home'
draft = false
+++

<div class="mt-6 mb-6">
{{< hextra/hero-headline >}}
  Архитектура ROSS
{{< /hextra/hero-headline >}}
</div>

<div class="mb-12">
{{< hextra/hero-subtitle >}}
  Современная архитектура для сложных&nbsp;<br class="sm:block hidden" />клиентских приложений
{{< /hextra/hero-subtitle >}}
</div>

<div class="mb-6">
{{< hextra/hero-button text="Документация" link="docs" >}}
</div>

<div class="mt-6"></div>

{{< hextra/feature-grid >}}
  {{< hextra/feature-card
    title="Наглядность"
    link="docs/introduction/uml"
    subtitle="ROSS-приложение легко описывается 5-ю стандартными UML-диаграммами, причем уровень детализации можно наращивать постепенно."
    style="background: radial-gradient(ellipse at 50% 80%,rgba(158,219,162,0.15),hsla(0,0%,100%,0));"
    icon="presentation-chart-bar"
  >}}
  
  {{< hextra/feature-card
    title="Тестируемость"
    link="docs/introduction/tests"
    subtitle="Архитектура изначально сформирована так, чтобы помимо Unit-тестов было легко выполнять интеграционные/системные тесты, а также UI-тесты."
    style="background: radial-gradient(ellipse at 50% 80%,rgba(144,208,230,0.15),hsla(0,0%,100%,0));"
    icon="beaker"
  >}}
  
  {{< hextra/feature-card
    title="Пластичность"
    link="docs/introduction/flex"
    subtitle="Можно вносить произвольные изменения в бизнес-логику и UI-навигацию, не беспокоясь о связности модулей. ROSS заточена под непрерывную эволюцию."
    style="background: radial-gradient(ellipse at 50% 80%,rgba(221,210,159,0.15),hsla(0,0%,100%,0));"
    icon="view-grid-add"
  >}}
  
  {{< hextra/feature-card
    title="Легко внедрять"
    link="docs/integration"
    subtitle="Рефакторинг можно производить на любом этапе развития приложения. ROSS совместима с любой уже имеющейся архитектурой."
    style="background: radial-gradient(ellipse at 50% 80%,rgba(151,183,156,0.15),hsla(0,0%,100%,0));"
    icon="link"
  >}}
  
  {{< hextra/feature-card
    title="Описывает всё приложение"
    link="docs/compare"
    subtitle="В отличие от MV*-архитектур, ROSS описывает не отдельный модуль, а всё приложение целиком. Жесткая UDF-структура при этом не требуется."
    style="background: radial-gradient(ellipse at 50% 80%,rgba(142,153,174,0.15),hsla(0,0%,100%,0));"
    icon="cube-transparent"
  >}}
  
  {{< hextra/feature-card
    title="Не зависит от платформы"
    link="docs/ross-entities/router"
    subtitle="ROSS инкапсулирует платформенно-специфичные детали, что позволяет реализовать бизнес-логику однократно и на любом языке общего назначения."
    style="background: radial-gradient(ellipse at 50% 80%,rgba(204,197,254,0.15),hsla(0,0%,100%,0));"
    icon="puzzle"
  >}}

{{< /hextra/feature-grid >}}
