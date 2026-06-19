-- SHIPPING PERFORMANCE
SELECT 
    shipping_mode,
    COUNT(*)                                    AS total_orders,
    ROUND(AVG(late_delivery_risk) * 100, 1)    AS late_rate_pct,
    ROUND(AVG(shipping_delay), 2)              AS avg_delay_days,
    ROUND(SUM(sales), 2)                       AS total_revenue
FROM orders
GROUP BY shipping_mode
ORDER BY late_rate_pct DESC

-- ABC CLASSIFICATION
WITH revenue_by_product AS (
    SELECT 
        product_name,
        category_name,
        SUM(sales) AS total_revenue,
        SUM(benefit_per_order)  AS total_profit
    FROM orders
    GROUP BY product_name, category_name
),
ranked AS (
    SELECT *,
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC) AS cumulative_revenue,
        SUM(total_revenue) OVER () AS grand_total
    FROM revenue_by_product
)
SELECT 
    product_name,
    category_name,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(cumulative_revenue / grand_total * 100, 1) AS cumulative_pct,
    CASE 
        WHEN cumulative_revenue / grand_total <= 0.80 THEN 'A'
        WHEN cumulative_revenue / grand_total <= 0.95 THEN 'B'
        ELSE 'C'
    END AS abc_class
FROM ranked
ORDER BY total_revenue DESC
LIMIT 25

-- REVENUE AT RISK
SELECT 
    category_name,
    COUNT(*)                                                            AS total_orders,
    SUM(late_delivery_risk)                                            AS late_orders,
    ROUND(AVG(late_delivery_risk) * 100, 1)                           AS late_rate_pct,
    ROUND(SUM(CASE WHEN late_delivery_risk = 1 THEN sales ELSE 0 END), 2) AS revenue_at_risk
FROM orders
GROUP BY category_name
ORDER BY revenue_at_risk DESC
LIMIT 10

-- SEGMENT PROFITABILITY
WITH segment_stats AS (
    SELECT 
        customer_segment,
        COUNT(*)                        AS order_count,
        ROUND(SUM(sales), 2)           AS total_revenue,
        ROUND(SUM(benefit_per_order), 2) AS total_profit,
        ROUND(AVG(profit_margin) * 100, 2) AS avg_margin_pct
    FROM orders
    GROUP BY customer_segment
)
SELECT *,
    RANK() OVER (ORDER BY total_profit DESC) AS profit_rank
FROM segment_stats
ORDER BY profit_rank

-- MONTHLY REVENUE TREND
SELECT 
    order_year,
    order_month,
    COUNT(*)                         AS order_count,
    ROUND(SUM(sales), 2)            AS total_revenue,
    ROUND(SUM(benefit_per_order), 2) AS total_profit,
    ROUND(AVG(profit_margin) * 100, 2) AS avg_margin_pct
FROM orders
WHERE order_year < 2018
  AND NOT (order_year = 2017 AND order_month >= 9)
GROUP BY order_year, order_month
ORDER BY order_year, order_month

