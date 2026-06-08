{% test my_test() %}

    {{ config(severity = 'warn', error_if = '>50', warn_if = '<50') }}


{% endtest %}


