WITH customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
),

customer_metrics AS (
    SELECT * FROM {{ ref('int_customer_metrics') }}
),

final AS (
    SELECT
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_metrics.first_order,
        customer_metrics.most_recent_order,
        customer_metrics.number_of_orders,
        customer_metrics.is_repeat_customer,
        customer_metrics.total_amount AS customer_lifetime_value,
        customer_metrics.average_amount AS average_customer_order_value
    FROM customers
    LEFT JOIN customer_metrics ON customers.customer_id = customer_metrics.customer_id
)

SELECT * FROM final