# Simple SIEM for Apache Log Monitoring

Pet-проект для мониторинга логов Apache2 на предмет подозрительной активности.
Развертывание происходило в виртуальной машине (VB oracle), server Ubuntu 24.04.3 LTS.

## Функционал
- Детектирование Path Traversal атак (`../`)
- Детектирование базовых SQL-инъекций (`union select`, etc.)
- Логирование алертов в отдельный файл
- Парсинг IP-адреса атакующего

## Технологии
- Bash
- Linux
- Apache2
- Регулярные выражения

## Установка и запуск
Прежде стоит убедиться в установке apache и наличии прав на чтение /var/log/apache2/access.log

1. Скопируйте скрипт на сервер:
```bash
wget https://github.com/ipojn/SIEM/blob/main/siem.sh
chmod +x siem.sh
./siem.sh
```
## Пример выввода
ALERT: Path Traversal detected - /index.php?page=../../../../etc/passwd
IP: 192.168.1.105
