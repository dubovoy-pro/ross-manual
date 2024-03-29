+++
title = 'Клиентские приложения'
weight = 1
draft = false
+++

Определим термин «клиентские приложения». С точки зрения конечного бизнеса платформа — это канал дистрибуции сервиса, который этот бизнес осуществляет. Современные web-приложения стали полностью интерактивными и иногда даже поддерживают офлайн-работу, а приложения для мобильных платформ получают обновления раз в неделю (и это не считая «фичетоглов» и A/B-тестов). Клиенты на различных платформах могут использовать единый backend-API, да и различия на уровне API ОС между двумя основными мобильными платформами стремительно сглаживаются. Одна из причин — общие требования, налагаемые бизнес-процессами. Бизнес-процессы не зависят от платформы, поэтому и бизнес-требования также не зависят от платформы.

{{< callout type="info" emoji="👉">}}
Клиентское приложение — это часть информационной системы, отвечающая за взаимодействие с пользователем без привязки к среде исполнения.
{{< /callout >}}

{{< callout type="info" emoji="💡" >}}
Примеры в данном руководстве будут сформированы в контексте iOS на языке Swift, но суть изложенных идей и принципов от платформы не зависит. Они одинаково применимы к Android, Web Frontend, Win/Linux/macOS Desktop и т.п.
{{< /callout >}}