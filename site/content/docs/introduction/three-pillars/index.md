+++
title = 'Три кита архитектуры'
weight = 2
draft = false
+++

## Пластичность{#plasticity}

Бизнес-требования — это один из важнейших факторов, влияющих на выбор архитектуры проекта. Универсальных и одновременно удобных решений не существует. Использование архитектуры с большим количеством слоев абстракции для простого CRUD-клиента будет избыточно. В ходе проектирования, разработки и тестирования простой системы мы просто не столкнемся с теми проблемами, которые сложная архитектура призвана решать. Вместе с тем простые проекты со временем могут превратиться в сложные, и у этой сложности есть несколько источников.

Во-первых, приложение может обзавестись собственным состоянием, которое надо синхронизировать с бекендом. Как известно, инвалидация кеша — это одна из ключевых проблем программирования, вторая после нейминга =)

Во-вторых, в современных приложениях могут протекать несколько процессов одновременно: мы можем выбирать пироги в каталоге с акциями дня, а на соседней вкладке параллельно отслеживать местоположение курьера с уже заказанной пиццей. А еще в этот момент скоринговый центр проверяет, можно ли нам продать пиццу в рассрочку, и тоже общается на этот счет с приложением, проверяя нашу геопозицию.

В-третьих, не отстают и проектировщики UX: пользовательский путь должен быть максимально коротким и удобным, причем независимо от контекста. Умный интерактив неминуемо приводит к усложнению «подкапотной» части приложения. И этот процесс вряд ли когда-либо остановится. Когда мы, наконец, изобретем внятный нейроинтерфейс, а UX-дизайнеры с Проксима Центавра будут ломать копья насчет единственно правильной формы гравитационных возмущений в квантовых терминалах, разработчики будут по-прежнему переделывать дизайн-систему =) 

В-четвертых, вместе с дизайнерами придут они — маркетологи. Эти ребята никогда не откажутся от использования технологий ненадлежащим или непредусмотренным для этого образом. Диплинки в произвольную часть приложения, реферальные ссылки, A/B-тесты, бесчисленные интеграции с аналитическими и рекламным сервисами — это то, с чем приходится сталкиваться каждый день.

Таким образом, сложность требований постоянно растет. Недостаточно, чтобы сложность выбранной архитектуры просто соответствовала текущей сложности бизнес-требований. Правильно подобранная архитектура должна уметь эволюционировать вместе с бизнес-требованиями. 

Эволюция бизнес-требований подразумевает также эволюционные изменения в кодовой базе. Простые проекты дешевле переписать заново, а сложные на то и сложные, что копили свою сложность годами: все время появляется новый код, а старый код — модифицируется. Попытка «все переписать» кавалерийским наскоком, как правило, обречена на провал. Таким образом, мы можем сформулировать первое требование к архитектуре сложных приложений — **пластичность**.

{{< callout type="info" emoji="👉" >}}
Пластичность — это возможность менять внешнюю форму без разрушения внутренней структуры.
{{< /callout >}}

Структура необходима, поскольку помогает бороться со сложностью. Вместе с тем поддержание структуры может обходиться слишком дорого. Рассмотрим практический пример.

Допустим, вы разрабатываете приложение приложение, которое предоставляет доступ к электронным книгам. В нем есть 5 экранов: онбординг, вход, каталог, непосредственно читалка выбранной книги, конечно же, оплата. Соответственно, у вас есть 5 модулей, которые вы реализовали на любимой архитектуре (MVC, MVVM, VIP и т.д). Все сущности в этих модулях вы честно покрыли Unit-тестами. Модули хорошо изолированы друг от друга и практически не нуждаются в организации межмодульного взаимодействия: они пользуются общими сервисами вроде сетевого слоя и локального хранилища, а общаются друг с другом с помощью какого-нибудь тривиального координатора, не содержащего бизнес-логики.

Пользовательский сценарий подразумевает, что пользователь изучает онбординг, авторизуется, выбирает книгу в каталоге, начинает читать книгу бесплатно, а затем вносит плату для продолжения чтения понравившейся книги. Именно такая последовательность закодирована в вашем координаторе. Внезапно к вам приходит маркетолог с уже утвержденной у начальства гипотезой, которая гласит: «Если мы уже на онбординге (т.е. до регистрации) будем предоставлять возможность купить подписку со скидкой в 50%, то увеличим общую выручку на 100%». Отвертеться не получится, и это означает, что у нас неприятности. Во-первых, нам теперь нужно скрестить ~~ежа с ужом~~ платежный модуль и модуль онбординга. Во-вторых, придумать, как информацию о проведенном платеже передать в аккаунт пользователя. При этом придется помнить, что пользователь может:

 1. заплатить, но не создавать аккаунт вообще (явным образом);
 2. переустановить приложение и требовать восстановление покупок.

 Иными словами, в сплав онбординга и платежей еще добавляется авторизация. Пластичная архитектура должна быть устойчивой к подобного рода потрясениям, т.е. в ходе изменения бизнес-требований приложение должно менять форму, но не структуру. В данном примере мы без изменения структуры получим гигантский стартовый модуль, т.е. неоправданное увеличение сложности. Поддерживать такой модуль будет непросто, потому что в виду размеров его тестируемость ограничена.

## Тестируемость{#testability}

На определенном этапе развития каждая выжившая IT-компания приходит к выводу, что ПО мало написать, его еще надо протестировать, и этим должен заниматься *не* программист. В компании появляются тестировщики. Затем наступает этап, когда программисты начинают порождать столько каскадных изменений в проекте, что отдел тестирования перестает справляться с потоком задач. Как правило, это возникает с уменьшением релизного цикла, а его уменьшение — это требование бизнеса... или маркетинга. В итоге двухнедельный release train с аджайлом и спринтами может прийти даже в те области, где раньше безраздельно царствовал водопадный подход. Решение «наши тестировщики — отличные ребята, найдут любую багу» уже не работает, т.к. QA не успевает протестировать сборки в срок. Бизнес приходит к выводу, что нужно инвестировать в технические средства тестирования, в частности, в Unit-тесты. До этого момента попытки внедрения Unit-тестов обычно проваливаются, поскольку БЕЗ тестов разработка движется быстрее (что логично, так как за поиск и пропуск багов отвечают тестировщики).

Итак, задача поставлена: покрыть кодовую базу Unit-тестами, а затем еще интеграционными заодно. Но если в этой кодовой базе использовались синглтоны, сервис-локаторы, бродкаст-сообщения, и прочие объемные и/или сильносвязанные сущности, то мы сразу же осознаем второе требование к архитектуре сложных приложений — **тестируемость**.

{{< callout type="info" emoji="👉" >}}
Тестируемость — это возможность покрыть тестами произвольный участок кодовой базы.
{{< /callout >}}

При этом важно, чтобы тесты были:

- легковесными (быстро собираются и выполняются);
- наглядными (легко сопоставляются с документацией);
- не хрупкими (хрупкие тесты приводят к необходимости переписывать тесты в ходе рефакторинга тестируемого кода).

Как правило, отдельные сущности покрыть тестами несложно, гораздо сложнее простестировать взаимодействие между этими сущностями. Тестируемая архитектура позволяет выполнять интеграционное тестирование:

- без избыточного усложнения сущностей, т.е. сущность ничего не знает о сценариях ее использования;
- без необходимости задействовать высокоуровневые UI-тесты, поскольку они не позволяют проверить все граничные случаи (либо позволяют, но становятся очень хрупкими).

Предположим, мы нашли способ перераспределить ответственности между сущностями так, что каждая из них в итоге стала тестируемой. Например, цепочка преобразований объемного стартового модуля может выглядеть так:

1. Из чересчур объемной вью-модели стартового модуля переносим код в «менеджеры»: OnboardingManager, AuthManager и PaymentManager. *Вью-модель похудела, но есть проблема*: менеджеры знают друг о друге. Во-первых, им нужно передавать друг другу управление: OnboardingManager вызывает PaymentManager, а он, в свою очередь, вызывает AuthManager. Во-вторых, им нужно обмениваться данными. Например, к AuthManager должен быть подключен PaymentManager, чтобы по завершению входа сообщить координатору, была ли проведена оплата. Координатор будет учитывать эту информацию и показывать каталог в соответствующем состоянии.
2. Избавляем менеджеры от лишних зависимостей — переносим общение между ними в координатор. Интерфейсы у менеджеров теперь чистенькие, Unit-тесты менеджеров перестали быть хрупкими. Но какова цена? В координаторе теперь живет специальная логика, хотя изначально должна была быть только общая. Примером общей логики является обработка ошибок: некоторые ошибки можно поправить обычным ретраем, а некоторые должны привести на форму обратной связи, чтобы пользователь рассказал саппорту, что случилось. Где будем хранить эту общую для всех модулей логику? В координаторе! А еще есть процедура логаута. Нужно почистить все, что насохраняли на диске, а затем отобразить стартовый экран, причем уже без онбординга. Где будем хранить эту логику? Тоже в координаторе! А что насчет диплинков, пуш-уведомлений, шеринг-экстеншенов? Нетрудно заметить, что со временем координатор превращается в огромный нетестируемый god-объект.
3. Разбиваем один большой координатор на плеяду суб-координаторов поменьше. Теперь все хорошо - каждая сущность системы тестируется! Не совсем... *у нас все еще есть проблема* =)

## Наглядность{#visualization}

Теперь каждый суб-координатор — это порождение совокупных требований различной природы:

- бизнес-логика (пользовательский сценарий);
- UI/UX (навигация);
- маркетинг (скидку дня не забудьте показать!);
- технические ограничения (Apple требует обеспечить доступ к встроенным покупкам независимо от авторизации).

Смешение требований из разных миров порождает несколько проблем.

Во-первых, читать, понимать и модифицировать код отдельного суб-координатора в отрыве от остальных частей теперь непросто. При работе с каждым пользовательским сценарием придется изучить множества смежных суб-координаторов.

Во-вторых, программисту теперь сложно гарантировать, что кодовая база в целом соответствует всем требованиям, изложенным в документации. Первичная документация обычно представлена в виде текста, но людям со времен наскальной живописи легче анализировать диаграммы. На диаграммах мы отображаем сущности (элементы системы), потоки данных между сущностями и сценарии использования. Диаграммы должны быть понятны как программистам, так и аналитикам, несмотря на различия в контекстах. Аналитик хочет в первую очередь представить бизнес-логику и маркетинг, в то время как программисту важно учесть все технические ограничения, не забывая про UX. Соответственно, диграммы для этих ролей/задач могут быть  разными. Код суб-координатора придется сопоставлять со всеми видами диаграмм, представленных в документации.

Таким образом, потребность легко сопоставлять код и документацию, представленную в виде диаграмм, формирует третье требование к архитектуре сложных приложений — **наглядность**.

{{< callout type="info" emoji="👉" >}}
Наглядность — это возможность представить код графически, в виде диаграмм.
{{< /callout >}}

В классическом [UML](https://ru.wikipedia.org/wiki/UML#Диаграммы) можно насчитать до 3 десятков различных диаграмм (во всяком случае, различных названий). Для разработки клиентских приложений необходимый и достаточный набор включает только 5 из них:

- [диаграмма классов](https://ru.wikipedia.org/wiki/Диаграмма_классов);
- [диаграмма состояний](https://ru.wikipedia.org/wiki/Диаграмма_состояний_(UML));
- [диаграмма последовательности](https://ru.wikipedia.org/wiki/Диаграмма_последовательности);
- [диаграмма деятельности](https://ru.wikipedia.org/wiki/Диаграмма_деятельности);
- [диаграмма прецедентов](https://ru.wikipedia.org/wiki/Диаграмма_прецедентов).