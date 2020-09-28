SELECT 
    ID AS payment_id,
    ORDERID AS order_id,
    paymentmethod as payment_method,
    status,
    to_decimal((amount / 100),10,2) as amount,
    created,
    _BATCHED_AT
FROM raw.stripe.payment