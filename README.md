# Как запустить:

1. Нужен дистрибутив Linux или (на Windows) WSL, PostgreSQL 9.4+
2. Необходимо установить [Crystal](https://crystal-lang.org/install/) и пакетный менеджер Shards, а также [Lucky CLI](https://github.com/luckyframework/lucky_cli)
3. В папке с проектом выполнить `shards build`
4. Установить переменные среды: `DB_HOSTNAME`, `DB_PORT`, `DB_USERNAME`, `DB_PASSWORD`, `WALLET_PRIVKEY`, `WALLET_PUBKEY`
5. Создать и мигрировать базу данных `lucky db.setup`
6. Запустить командой `lucky dev` (в dev-режиме)
7. Первый созданный пользователь получает админ-права и может создавать NFT
