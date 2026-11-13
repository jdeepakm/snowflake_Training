{% macro date_type_function(x) %}

CASE
 WHEN DAYNAME(TO_TIMESTAMP({{x}})) in ('Sat','Sun')
 THEN 'WEEKEND'
 ELSE 'BUSINESS DAY'
 END


{% endmacro%}