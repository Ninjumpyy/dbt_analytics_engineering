{% macro get_payment_methods() %}
    {%- set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] -%}
    {%- do return(payment_methods) -%}
{% endmacro %}