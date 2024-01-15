+++
title = 'Интеграция'
weight = 4
draft = false
prev = '/docs/ross-entities'
+++

## Внедрение в существующие проекты{#for-existing-projects}

Независимо от используемой архитектуры любое приложение можно рассматривать как один большой объект, который обладает состоянием и содержит методы UX-взаимодействия. В терминах ROSS состоянием обладает только одна сущность – сервис. Этот сервис по определению является ключевым. Если предоставить ему доступ к фабрике сценариев, то сервис превратится в AppService. Останется только определить, какая часть приложения (какой класс) будет реализовывать протокол  IAppService, после чего можно считать, что ROSS интегрирована в текущее приложение. Все новые пользовательские сценарии можно будет уже свободно формировать в ROSS-компонентах.

Разумеется, чтобы полностью задействовать преимущества  ROSS (высокий уровень наглядности, пластичности и тестируемости), необходимо перевести на ROSS-рельсы оставшуюся часть приложения. Процесс выполняется в несколько шагов:

1. Заменяем неявные зависимости на явные. Устраняем синглтоны, сервис-локаторы, DI-контейнеры, бродкаст-сообщения, статические порождающие функции и т.п.
1. Инкапсулируем UI-слой, формируем роутер. Инстанцирование всех  UI-компонентов должно выполняться в роутере, по запросу через методы в интерфейсе роутера. В качестве контекста в эти методы передаем вью-модели. Роутер пробрасывается в качестве зависимости во все точки, где требуется UI.
1. Переносим ответственности из объемных общих сущностей (координатор, контроллер приложения и т.п.) в специализированные ключевые сервисы, формируем контейнер ключевых сервисов.
1. Формируем операцию по инициализации ключевых сервисов, добавляем метод по созданию операции в фабрику операций.
1. Формируем сценарий входа в приложение, формируем составляющие сценарий операции (один из самых наглядных и линейных  UserFlow).
1. Реализуем тесты на сценарий входа, а также на задействованные в нем операции и сервисы.
1. Реализуем UI-тест на сценарий входа.
1. Обеспечиваем наглядность: формируем диаграмму операций для сценария, диаграммы сообщений для операций и диаграммы состояний для сервисов (если требуется, то и диаграмму сервисов для отображения зависимостей между сервисами).
1. Повторяем пункты 5-8 для всех UserFlow в приложении.

В результате такого преобразования получаем полностью простестированную кодовую базу, снабженную актуальной и наглядной документацией. В дальнейшем разработка новых UserFlow начинается с проектирования, а именно с построения диаграмм. Это позволяет формировать более точную оценку трудозатрат, поскольку:

1. Граничные случаи выявляются на раннем этапе (например, «хвосты» на диаграмме операций);
2. Заранее выявляется общее количество операций и сервисов, задействованных в UserFlow. Без диаграмм разработчик может полагаться только на количество экранов и переходов между ними в дизайн-макетах, да на количество эндпоинтов в swagger-описаниях.
3. Наглядное описание UserFlow облегчает декомпозицию и распределение задач в команде разработки.

## Разработка нового проекта {#new-project}

### Проектирование{#design}

Разработку лучше всего начинать с проектирования =) Проектирование начинается с User Stories или User Flows, после чего они преобразуются в диаграммы операций, затем все полученные диаграммы соединяются воедино в диаграмме прецедентов. На этом этапе уже видны входы-выходы для сценариев, а также возможности по переиспользованию операций.

Затем начинаем формировать диаграммы сообщений для каждой полученной операции. Объекты на диаграмме сообщений — это сервисы-зависимости. После того, как сформированы все диаграммы сообщений, мы можем сформировать список ключевых сервисов, а также диаграмму сервисов.

{{< callout type="info" emoji="👉" >}}
Диаграмма сервисов — это диаграмма классов, на которой отражены сервисы и их отношения. Диаграмма сервисов описывает жесткие связи между сервисами.
{{< /callout >}}

На этом этапе проектирование завершено,  можно переходить к кодингу.

### Формируем каркас{#skeleton}

Сначала формируем интерфейс для контейнера ключевых сервисов. Контейнер предоставляет доступ только к интерфейсам ключевых сервисов, следовательно, о реализации сервисов пока можно не беспокоиться и использовать тривиальные заглушки.

Формируем фабрику операций, ей на вход передаем контейнер ключевых сервисов. Фабрика также предоставляет доступ только к интерфейсам операций, следовательно, о реализации операций на данном этапе можно не беспокоиться и использовать тривиальные заглушки.

{{< callout type="info" emoji="💡" >}}
Фабрика — порождающий паттерн, при каждом обращении к одному и тому же методу создает новый объект. Контейнер при каждом обращении  к одному и тому ]же методу возвращает один и тот же объект.
{{< /callout >}}

Формируем `MakeServicesOp` и `SetupServicesOp` на основе диаграммы сервисов. Для сервисов по-прежнему используем тривиальные заглушки. Затем формируем `AppService` — он будет запускать сценарии, используя фабрику сценариев, т.е. заодно создаем и ее тоже. На этом этапе сформированы все основные сущности, далее увязываем их в `AppDelegate` в несколько шагов:

1. инстанцируем фабрику операций, а затем фабрику сценариев. Фабрика сценариев получает на вход фабрику операций.
2. инстанцируем и запускаем на выполнение `MakeServicesOp` и `SetupServicesOp`. Полученный в итоге контейнер сервисов пробрасываем через соответствующие свойства в фабрику операций.
3. инстанцируем `AppService`, ему на вход передаем фабрику сценариев и фабрику операций (`AppService` может запускать единичные операции, для которых целый сценарий избыточен). Не забываем сохранить сильную ссылку на `AppService` (например, в `AppDelegate`).

### Разработка{#development}

Далее начинается непосредственно разработка. Смотрим на диаграмму прецедентов, выбираем первый понравившийся прецедент и переходим к его описанию — к диаграмме операций либо диаграмме сообщений. Затем начинаем реализацию прецедентов по TDD. После того, как прецеденты реализованы и протестированы, переходим к реализации оставшихся операций, которые входят в сценарии, но не являются единичными прецедентами. Операции также легко реализуются через TDD. Наконец, приходим к формированию сервисов.

Контракт и зоны ответственности у каждого сервиса теперь выявлены, что также облегчает реализацию сервисов через TDD. Одним из этих сервисов является роутер.  Как правило, к этому моменту дизайн-команда уже сформировала макеты в фигме, что позволяет понять потребности каждого экрана и сформировать соответствующие вью-модели. На данном этапе UI-логика еще может повлиять на операции — настройка вью-модели внутри соответствующей операции также формируется на данном этапе и также нуждается в тестировании. Обычно это аддитивные тесты, которые реализуются с использованием RouterMock. Помимо роутера выявляются прочие сервисы, которые участвуют в прецеденте — их также нужно реализовать, чтобы увидеть работающий прецедент. Таким образом каждый прецедент последовательно вводится в строй.