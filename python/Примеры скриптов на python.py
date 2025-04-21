# 1
# Фильтруем только отменённые бронирования для City Hotel
city_canceled = bookings[(bookings['hotel'] == 'City Hotel') & (bookings['is_canceled'] == 1)]

# Группируем по году и месяцу, считаем количество
cancel_counts = city_canceled.groupby(['arrival_date_year', 'arrival_date_month'])['is_canceled'].count()

# Для каждого года выводим месяц с максимальными отменами
for year in [2015, 2016, 2017]:
    most_canceled_month = cancel_counts[year].idxmax()
    print(f"В {year} больше всего отмен в месяце: {most_canceled_month}")

    
# 2
# Создаём колонку has_kids
bookings['has_kids'] = bookings['total_kids'] > 0

# Группируем по has_kids и считаем Churn Rate
churn_rate = bookings.groupby('has_kids')['is_canceled'].mean() * 100

# Округляем до 2 знаков
churn_rate = churn_rate.round(2)

# Показываем результат
print(churn_rate)

# Выводим наибольшее значение
print("Максимальный churn rate:", churn_rate.max())


# 3
import requests
# URL API
url = "https://ads.vk.com/api/v2/oauth2/token.json"

# Данные для запроса
data = {
    "grant_type": "refresh_token",  # Используем refresh_token для обновления токена
    "client_id": "####",  # Укажите ваш client_id
    "client_secret": "####",  # Укажите ваш client_secret
    "refresh_token": "####",  # Укажите ваш refresh_token
    "permanent": "true",  # Устанавливаем токен бессрочным
    # Укажите ID клиента агентства:
    "agency_client_id": "12345567"
    # Или имя клиента, если ID отсутствует:
    # "agency_client_name": "КОНКРЕТНОЕ_ИМЯ_КЛИЕНТА"
}

# Выполнение POST-запроса
response = requests.post(url, data=data)

# Обработка ответа
if response.status_code == 200:
    token_data = response.json()
    print("Бессрочный токен:", token_data["access_token"])
else:
    print("Ошибка:")
    print("Статус-код:", response.status_code)
    print("Ответ:", response.text)