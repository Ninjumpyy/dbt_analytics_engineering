WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

payments AS (
    SELECT * FROM {{ ref('stg_payments') }}
),

customer_orders AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order,
        MAX(order_date) AS most_recent_order,
        COUNT(order_id) AS number_of_orders,
        CASE WHEN COUNT(order_id) > 1 THEN TRUE ELSE FALSE END AS is_repeat_customer
    FROM orders
    GROUP BY customer_id
),

customer_payments AS (
    SELECT
        orders.customer_id,
        SUM(amount) AS total_amount
    FROM payments
    LEFT JOIN orders ON payments.order_id = orders.order_id
    GROUP BY orders.customer_id
),

customer_metrics AS (
    SELECT
        customer_orders.customer_id,
        first_order,
        most_recent_order,
        number_of_orders,
        is_repeat_customer,
        total_amount,
        ROUND(COALESCE(total_amount, 0) / number_of_orders) AS average_amount
    FROM customer_orders
    LEFT JOIN customer_payments ON customer_orders.customer_id = customer_payments.customer_id
)

SELECT * FROM customer_metrics