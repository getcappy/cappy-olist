select
    zip_code_prefix,
    city,
    state,
    lat,
    lng
from {{ ref('stg_geolocation') }}
