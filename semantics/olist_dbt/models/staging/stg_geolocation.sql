select
    geolocation_zip_code_prefix as zip_code_prefix,
    avg(geolocation_lat) as lat,
    avg(geolocation_lng) as lng,
    any_value(geolocation_city) as city,
    any_value(geolocation_state) as state
from {{ source('olist_raw', 'raw_geolocation') }}
group by 1
