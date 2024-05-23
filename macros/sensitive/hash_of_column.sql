{% macro hash_of_column(column) %}
    MD5({{column}}) AS {{column}}
{% endmacro %}
