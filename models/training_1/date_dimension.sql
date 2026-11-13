with cte as(
select
 TO_TIMESTAMP(STARTED_AT) AS STARTED_AT, 
 DATE( TO_TIMESTAMP(STARTED_AT)) AS DATE_STARTED_AT,
 HOUR( TO_TIMESTAMP(STARTED_AT)) AS HOUR_STARTED_AT,
 DAYNAME( TO_TIMESTAMP(STARTED_AT)) DAY_NAME,

 CASE
 WHEN DAYNAME( TO_TIMESTAMP(STARTED_AT)) in ('Sat','Sun')
 THEN 'WEEKEND'
 ELSE 'BUSINESS DAY'
 END AS DAY_TYPE,

{{date_type_function('STARTED_AT')}} AS DATE_TYPE_2


 from
{{ ref('stg_bike') }}
where STARTED_AT != 'started_at'

)
select * from cte

