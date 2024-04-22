WITH source AS(
    select
        id as customer_id,
        company,
        last_name,
        first_name,
        email_address,
        job_title,
        business_phone,
        home_phone,
        mobile_phone,
        fax_number,
        address,
        city,
        state_province,
        zip_postal_code,
        country_region,
        web_page,
        notes,
        attachments,
        current_timestamp() as insertion_timestamp,
    from {{ ref('stg_customer') }}),
unique_source AS (
    select *,
            row_number() OVER(partition by customer_id) AS row_number
    from source
)

select *
except (row_number)
from unique_source
where row_number = 1