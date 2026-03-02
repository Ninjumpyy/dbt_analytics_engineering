{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

{% set payment_methods = get_payment_methods() %}

WITH orders AS (
    SELECT * 
    FROM {{ ref('stg_orders') }}

    {% if is_incremental() %}
    WHERE order_date > (SELECT MAX(order_date) FROM {{ this }})
    {% endif %}
),

order_metrics AS (
    SELECT * FROM {{ ref('int_order_metrics') }}
),

final AS (
    SELECT
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.order_status,
       
       {% for payment_method in payment_methods -%}

       order_metrics.{{ payment_method }}_amount,

       {% endfor -%}

        order_metrics.total_order_amount,
        order_metrics.number_of_payments
    
    FROM orders
    LEFT JOIN order_metrics ON orders.order_id = order_metrics.order_id
)

SELECT * FROM final