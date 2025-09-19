# GitLab CI/CD Variables для Flutter приложения TaxLien.online
# Добавьте эти переменные в Settings → CI/CD → Variables

## SSH ключи для деплоя
STAGING_SSH_PRIVATE_KEY=-----BEGIN OPENSSH PRIVATE KEY-----
# Ваш приватный SSH ключ для staging сервера
-----END OPENSSH PRIVATE KEY-----

PRODUCTION_SSH_PRIVATE_KEY=-----BEGIN OPENSSH PRIVATE KEY-----
# Ваш приватный SSH ключ для production сервера
-----END OPENSSH PRIVATE KEY-----

## Staging окружение
STAGING_HOST=staging.taxlien.online
STAGING_USER=deploy
STAGING_PATH=/var/www/taxlien-staging

## Production окружение
PRODUCTION_HOST=taxlien.online
PRODUCTION_USER=deploy
PRODUCTION_PATH=/var/www/taxlien-production

## Уведомления
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/YOUR/SLACK/WEBHOOK

## Flutter специфичные переменные
FLUTTER_VERSION=3.24.5
FLUTTER_CHANNEL=stable

## Android специфичные переменные (опционально)
ANDROID_KEYSTORE_PASSWORD=your_keystore_password
ANDROID_KEY_PASSWORD=your_key_password
ANDROID_KEY_ALIAS=your_key_alias

## iOS специфичные переменные (опционально)
IOS_DISTRIBUTION_CERTIFICATE=-----BEGIN CERTIFICATE-----
# Ваш iOS distribution certificate
-----END CERTIFICATE-----

IOS_DISTRIBUTION_KEY=-----BEGIN PRIVATE KEY-----
# Ваш iOS distribution private key
-----END PRIVATE KEY-----

## Firebase (опционально)
FIREBASE_PROJECT_ID=your-firebase-project-id
FIREBASE_SERVICE_ACCOUNT_KEY={"type": "service_account", ...}

## Настройки безопасности
# Установите эти переменные как Protected и Masked
# Protected: только для защищенных веток (main, develop)
# Masked: скрывает значение в логах

