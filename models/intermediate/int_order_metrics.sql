{% set payment_methods = get_payment_methods() %}

WITH payments AS (
    SELECT * FROM {{ ref('stg_payments') }}
),

order_metrics AS (
    SELECT
        order_id,
        {% for payment_method in payment_methods -%}
        SUM(CASE WHEN payment_method = '{{ payment_method }}' THEN amount ELSE 0 END) AS {{ payment_method }}_amount,
        {% endfor -%}

        SUM(amount) AS total_order_amount,
        COUNT(payment_id) AS number_of_payments
    
    FROM payments
    GROUP BY order_id
)

SELECT * FROM order_metrics