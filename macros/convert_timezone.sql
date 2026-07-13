{% macro to_ist(column_name) %}
    convert_timezone('UTC', 'Asia/Kolkata', {{ column_name }})
{% endmacro %}

{% macro to_gmt(column_name) %}
    convert_timezone('UTC', 'GMT', {{ column_name }})
{% endmacro %}

{% macro to_timezone(column_name, tz) %}
    convert_timezone('UTC', '{{ tz }}', {{ column_name }})
{% endmacro %}
