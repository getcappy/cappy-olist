with days as (
    select unnest(
        generate_series(date '2016-01-01', date '2019-01-01', interval 1 day)
    ) as date_day
)

select date_day from days
