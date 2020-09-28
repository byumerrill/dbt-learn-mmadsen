with 

orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

final as (
    select 
        o.order_id,
        o.customer_id,
        o.order_date,
        sum(case when p.payment_method = 'coupon' then 0 else p.amount end) as actual_revenue,
        sum(case when p.payment_method = 'coupon' then p.amount else 0 end) as coupon_amount,        
        sum(p.amount) as total_order_amount
    from orders o
    left outer join payments p 
        on o.order_id = p.order_id
    where p.status = 'success'
    group by 1,2,3
)

select * from final