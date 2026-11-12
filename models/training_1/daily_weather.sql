with daily_weather as (
select
date(time) as date_weather,
weather,
pressure,
humidity,
temp,
clouds
from
{{ source('demo', 'weather') }}

),
daily_weather_agg as (
    select 
    date_weather,
    weather,
    round(avg(temp),2) as avg_temp,
    round(avg(pressure),2) as avg_pressure,
    round(avg(humidity),2) as avg_humidity,
    avg(clouds) as avg_clouds,
    count(weather),
    row_number()over(partition by date_weather order by count(weather)desc) as rowNum

    from
    daily_weather
    group by date_weather, weather
    qualify row_number()over(partition by date_weather order by count(weather)desc) =1
)

select * from daily_weather_agg