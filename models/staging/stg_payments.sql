WITH source AS (
    SELECT * FROM {{ source('jaffle_raw', 'raw_payments') }}
),

renamed AS (
    SELECT
        id AS payment_id,
        order_id,
        payment_method,

        {{ cents_to_dollars('amount') }} as amount
    
    FROM source
)

SELECT * FROM renamed