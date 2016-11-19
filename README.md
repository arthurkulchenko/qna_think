[![Build Status](https://travis-ci.org/arthurkulchenko/qna_think.svg?branch=lesson_16_advanced_rspec)](https://travis-ci.org/arthurkulchenko/qna_think)
[![Code Climate](https://codeclimate.com/repos/58298db64a858c244c0057b8/badges/772ee1cdcc8590a12c9a/gpa.svg)](https://codeclimate.com/repos/58298db64a858c244c0057b8/feed)
[![Test Coverage](https://codeclimate.com/repos/58298db64a858c244c0057b8/badges/772ee1cdcc8590a12c9a/coverage.svg)](https://codeclimate.com/repos/58298db64a858c244c0057b8/coverage)
[![Issue Count](https://codeclimate.com/repos/58298db64a858c244c0057b8/badges/772ee1cdcc8590a12c9a/issue_count.svg)](https://codeclimate.com/repos/58298db64a858c244c0057b8/feed)
# README
## Current tasks
### Реализовать следующие истории, используя ActiveJob:
* ~~В качестве движка фоновых задач рекомендуется  Sidekiq~~
* ~~Отправка ежедневного письма-дайджеста всем пользователям. Дайджест содержит список всех вопросов, созданных за последние сутки.~~
* ~~Автор вопроса получает уведомление на email при появлении нового ответа на свой вопрос.~~
* ~~Любой залогиненный пользователь может подписаться на обновления вопроса. При этом он будет получать уведомления по email при появлении новых ответов на этот вопрос. Кол-во вопросов, на которые может быть подписан пользователь не ограничено.~~
* ~~Пользователь может отписаться от получения уведомлений об обновлении вопроса, если он на них подписан. Отписаться можно только от вопроса, на обновления которого пользователь подписан.~~
* ~~Автор вопроса также может отписаться от получения уведомлений о новых ответах на его вопрос.~~

#### Примечание по интеграции sidekiq и ActiveJob:

_ ActiveJob отправку писем помещает в отделюную очередь под названием mailers, а все остальные задачи - в очередь default. Поэтому, чтобы работала отправка писем в фоне, нужно указать sidekiq следить за обоими очередями. Для этого sidekiq надо запускать такой командой:  
sidekiq -q default -q mailers _