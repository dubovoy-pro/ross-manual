---
title: "С чего начать"
description: ""
lead: ""
draft: false
images: []
menu:
  docs:
    parent: "quick-start"
weight: 210
toc: true
---

## Проектирование{#client-apps}

С чего начать проектирование? С User Stories или User Flows. Преобразуем их к диаграмме операций, затем соединяем все полученные диаграммы воедино в диаграмме прецедентов. На этом этапе уже видны входы-выходы для сценариев, а также возможности по переиспользованию операций.
Затем начинаем формировать диаграммы сообщений для каждой полученной операции. Объекты на диаграмме сообщений — это сервисы-зависимости. После того, как сформированы все диаграммы сообщений, мы можем сформировать список ключевых сервисов, а также диаграмму сервисов. На этом этапе проектирование завершено,  можно переходить к кодингу.
Сначала формируем интерфейс для контейнера ключевых сервисов. Контейнер предоставляет доступ только к интерфейсам ключевых сервисов, следовательно, о реализации сервисов пока можно не беспокоиться и использовать тривиальные заглушки.
Формируем фабрику операций, ей на вход передаем контейнер ключевых сервисов. Фабрика также предоставляет доступ только к интерфейсам операций, следовательно, о реализации операций на данном этапе можно не беспокоиться и использовать тривиальные заглушки.
Примечание: фабрика — порождающий паттерн, при каждом обращении к одному и тому же методу создает новый объект. Контейнер при каждом обращении  к одному и тому же методу возвращает один и тот же объект.
Формируем MakeServicesOp и SetupServicesOp на основе диаграммы сервисов. Для сервисов по-прежнему используем тривиальные заглушки. Затем формируем AppService — он будет запускать сценарии, используя фабрику сценариев, т.е. заодно создаем и ее тоже. На этом этапе сформированы все основные сущности, далее увязываем их в AppDelegate в несколько шагов:
1. инстанцируем фабрику операций, а затем фабрику сценариев. Фабрика сценариев получает на вход фабрику операций.
2. инстанцируем и запускаем на выполнение MakeServicesOp и SetupServicesOp. Полученный в итоге контейнер сервисов пробрасываем через соответствующие свойства в фабрику операций.
3. инстанцируем AppService, ему на вход передаем фабрику сценариев и фабрику операций (AppService может запуска и единичные операции, для которых целый сценарий избыточен). Не забываем сохранить сильную ссылку на AppService.
Далее начинается непосредственно разработка. Смотрим на диаграмму прецедентов, выбираем первый понравившийся прецедент и переходим к его описанию — диаграмме операций либо диаграмме сообщений. Затем начинаем реализацию прецедентов по TDD. После того, как прецеденты реализованы и протестированы, переходим к реализации оставшихся операций, которые входят в сценарии, но не являются единичными прецедентами. Операции также легко реализуются через TDD. Наконец, приходим к формированию сервисов.
Контракт и зоны ответственности у каждого сервиса теперь выявлены, что также облегчает реализацию сервисов через TDD. Одним из этих сервисов является роутер.  Как правило, к этому моменту дизайн-команда уже сформировала макеты в фигме, что позволяет понять потребности каждого экрана и сформировать соответствующие вью-модели. На данном этапе UI-логика может повлиять на операции — настройка вью-модели внутри соответствующей операции формируется на данном этапе и также нуждается в тестировании. Как правило, это аддитивные тесты, которые реализуются с использованием RouterMock. Помимо роутера выявляются прочие сервисы, которые участвуют в прецеденте — их также нужно реализовать, чтобы увидеть работающий прецедент. Так последовательно каждый прецедент вводится в строй.

А что насчет диаграммы классов? С нее начинается любой учебник по UML!  У нас она тоже есть, и называется диаграммой сервисов. Диаграмма сервисов описывает жесткие связи между сервисами.

## Непонятно, нужен контекст{#try-again}

Возможно, стоит начать с самого начала! [Обзор →]({{< relref "overview" >}})