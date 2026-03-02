WITH source AS (
    SELECT * FROM {{ source('jaffle_raw', 'raw_customers') }}
),

renamed AS (
    SELECT
        id AS customer_id,
        first_name,
        last_name
    FROM source
)

SELECT * FROM renamed