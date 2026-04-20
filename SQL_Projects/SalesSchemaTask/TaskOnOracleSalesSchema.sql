SELECT tb_task_1.*,
tb_task_4.Sales_Target_Comparison,
tb_task_4.num_class_country_region,
tb_task_2.Q1_sales,tb_task_2.Q2_sales,
tb_task_2.Q3_sales,tb_task_2.Q4_sales,
tb_task_6.sales_difference,
tb_task_5.baseball_sales,tb_task_5.baseball_avg_price,
tb_task_5.cricket_sales,tb_task_5.cricket_avg_price,
tb_task_5.golf_sales,tb_task_5.golf_avg_price,
tb_task_5.football_sales,tb_task_5.football_avg_price,
tb_task_5.tennis_sales,tb_task_5.tennis_avg_price,
tb_task_3.top_perf_prod_1,tb_task_3.top_perf_prod_2,tb_task_3.top_perf_prod_3,
tb_task_3.top_perf_prod_4,tb_task_3.top_perf_prod_5,
tb_task_3.bottom_perf_prod_1,tb_task_3.bottom_perf_prod_2,tb_task_3.bottom_perf_prod_3,
tb_task_3.bottom_perf_prod_4,tb_task_3.bottom_perf_prod_5
from (SELECT 
    RANK() OVER (ORDER BY total_sales DESC) AS rank_of_region,
    country_region,
    total_sales
FROM (
    SELECT 
        tb1.COUNTRY_REGION,
        SUM(tb3.amount_sold) AS total_sales 
    FROM sh.COUNTRIES tb1
    LEFT JOIN sh.CUSTOMERS tb2 ON tb1.COUNTRY_ID = tb2.COUNTRY_ID
    LEFT JOIN sh.sales tb3 ON tb2.CUST_ID = tb3.Cust_id
    WHERE EXTRACT(YEAR FROM tb3.TIME_ID) = (
        SELECT MAX(EXTRACT(YEAR FROM TIME_ID)) FROM sh.sales
    )
    GROUP BY tb1.COUNTRY_REGION
) main_table) tb_task_1
LEft JOIN
(SELECT 
    tb1.COUNTRY_REGION,
    SUM(CASE WHEN TO_CHAR(tb3.TIME_ID, 'Q') = '1' THEN tb3.amount_sold ELSE 0 END) AS Q1_sales,
    SUM(CASE WHEN TO_CHAR(tb3.TIME_ID, 'Q') = '2' THEN tb3.amount_sold ELSE 0 END) AS Q2_sales,
    SUM(CASE WHEN TO_CHAR(tb3.TIME_ID, 'Q') = '3' THEN tb3.amount_sold ELSE 0 END) AS Q3_sales,
    SUM(CASE WHEN TO_CHAR(tb3.TIME_ID, 'Q') = '4' THEN tb3.amount_sold ELSE 0 END) AS Q4_sales
FROM sh.COUNTRIES tb1
    LEFT JOIN sh.CUSTOMERS tb2 ON tb1.COUNTRY_ID = tb2.COUNTRY_ID
    LEFT JOIN sh.sales tb3 ON tb2.CUST_ID = tb3.Cust_id
    WHERE EXTRACT(YEAR FROM tb3.TIME_ID) = (
        SELECT MAX(EXTRACT(YEAR FROM TIME_ID)) FROM sh.sales
    )
    GROUP BY tb1.COUNTRY_REGION
ORDER BY tb1.COUNTRY_REGION) tb_task_2
on tb_task_1.country_region=tb_task_2.country_region
LEFT JOIN
(SELECT 
    country_region,
    -- Display the top 5 products
    MAX(CASE WHEN sales_rank = 1 THEN prod_name END) AS TOP_PERF_prod_1,
    MAX(CASE WHEN sales_rank = 2 THEN prod_name END) AS TOP_PERF_prod_2,
    MAX(CASE WHEN sales_rank = 3 THEN prod_name END) AS TOP_PERF_prod_3,
    MAX(CASE WHEN sales_rank = 4 THEN prod_name END) AS TOP_PERF_prod_4,
    MAX(CASE WHEN sales_rank = 5 THEN prod_name END) AS TOP_PERF_prod_5,
    -- Display the bottom 5 products
    MAX(CASE WHEN sales_rank = total_products - 4 THEN prod_name END) AS BOTTOM_PERF_prod_1,
    MAX(CASE WHEN sales_rank = total_products - 3 THEN prod_name END) AS BOTTOM_PERF_prod_2,
    MAX(CASE WHEN sales_rank = total_products - 2 THEN prod_name END) AS BOTTOM_PERF_prod_3,
    MAX(CASE WHEN sales_rank = total_products - 1 THEN prod_name END) AS BOTTOM_PERF_prod_4,
    MAX(CASE WHEN sales_rank = total_products THEN prod_name END) AS BOTTOM_PERF_prod_5
FROM (
    SELECT 
        ctry.country_region,
        p.prod_id,
        p.prod_name,
        SUM(s.amount_sold) AS total_sales_prod,
        RANK() OVER (PARTITION BY ctry.country_region ORDER BY SUM(s.amount_sold) DESC) AS sales_rank,
        COUNT(DISTINCT p.prod_id) OVER (PARTITION BY ctry.country_region) AS total_products
    FROM sh.sales s
    JOIN sh.customers cust ON s.cust_id = cust.cust_id
    JOIN sh.countries ctry ON cust.country_id = ctry.country_id
    JOIN sh.products p ON s.prod_id = p.prod_id
    WHERE EXTRACT(YEAR FROM s.time_id) = (
        SELECT MAX(EXTRACT(YEAR FROM time_id)) FROM sh.sales
    )
    GROUP BY ctry.country_region, p.prod_id, p.prod_name
) ranked_products
WHERE sales_rank <= 5 OR sales_rank >= total_products - 4
GROUP BY country_region
ORDER BY country_region
) tb_task_3
on tb_task_1.country_region=tb_task_3.country_region
LEft JOIN (select country_region,Sales_Target_Comparison,
count(Sales_Target_Comparison) over (partition by Sales_Target_Comparison) as num_class_country_region from 
(SELECT 
    country_region,
    total_sales,
    CASE when total_sales=250000 then 'Met Target'
    when total_sales>250000 then 'Exceed Target'
    else 'Below Target' end as Sales_Target_Comparison 
FROM (
    SELECT 
        tb1.COUNTRY_REGION,
        SUM(tb3.amount_sold) AS total_sales 
    FROM sh.COUNTRIES tb1
    LEFT JOIN sh.CUSTOMERS tb2 ON tb1.COUNTRY_ID = tb2.COUNTRY_ID
    LEFT JOIN sh.sales tb3 ON tb2.cust_id = tb3.CUST_ID
    WHERE EXTRACT(YEAR FROM tb3.time_id) = (
        SELECT MAX(EXTRACT(YEAR FROM time_id)) FROM sh.sales
    )
    GROUP BY tb1.COUNTRY_REGION
) main_table) tb_task_4) tb_task_4
    on tb_task_4.country_region=tb_task_1.country_region
LEFT JOIN
(SELECT 
    tb1.country_region,
    
    -- Total Sales per category
    SUM(CASE WHEN tb4.PROD_CATEGORY = 'Baseball' THEN tb3.amount_sold ELSE 0 END) AS baseball_sales,
    SUM(CASE WHEN tb4.PROD_CATEGORY = 'Cricket' THEN tb3.amount_sold ELSE 0 END) AS cricket_sales,
    SUM(CASE WHEN tb4.PROD_CATEGORY = 'Golf' THEN tb3.amount_sold ELSE 0 END) AS golf_sales,
    SUM(CASE WHEN tb4.PROD_CATEGORY = 'Soccer / Football' THEN tb3.amount_sold ELSE 0 END) AS football_sales,
    SUM(CASE WHEN tb4.PROD_CATEGORY = 'Tennis' THEN tb3.amount_sold ELSE 0 END) AS tennis_sales,
    
    -- Average Price per category
    ROUND(AVG(CASE WHEN tb4.PROD_CATEGORY = 'Baseball' THEN tb4.PROD_LIST_PRICE END)) AS baseball_avg_price,
    ROUND(AVG(CASE WHEN tb4.PROD_CATEGORY = 'Cricket' THEN tb4.PROD_LIST_PRICE END)) AS cricket_avg_price,
    ROUND(AVG(CASE WHEN tb4.PROD_CATEGORY = 'Golf' THEN tb4.PROD_LIST_PRICE END)) AS golf_avg_price,
    ROUND(AVG(CASE WHEN tb4.PROD_CATEGORY = 'Soccer / Football' THEN tb4.PROD_LIST_PRICE END)) AS football_avg_price,
    ROUND(AVG(CASE WHEN tb4.PROD_CATEGORY = 'Tennis' THEN tb4.PROD_LIST_PRICE END)) AS tennis_avg_price

FROM 
    sh.COUNTRIES tb1
LEFT JOIN 
    sh.CUSTOMERS tb2 ON tb2.COUNTRY_ID = tb1.COUNTRY_ID
LEFT JOIN 
    sh.SALES tb3 ON tb2.CUST_ID = tb3.CUST_ID
LEFT JOIN 
    sh.products tb4 ON tb3.PROD_ID = tb4.PROD_ID

WHERE 
    EXTRACT(YEAR FROM tb3.time_id) = (
        SELECT MAX(EXTRACT(YEAR FROM time_id)) FROM sh.sales
    )

GROUP BY 
    tb1.country_region

ORDER BY 
    tb1.country_region
) tb_task_5
on tb_task_1.country_region=tb_task_5.country_region
LEft JOIN
(SELECT 
    country_region,
    q1_sales,
    q4_sales,
    round((q4_sales - q1_sales)/q1_sales*100) AS sales_difference
FROM (
    SELECT 
        tb1.country_region,
        SUM(CASE WHEN TO_CHAR(tb3.time_id, 'Q') = '1' THEN tb3.amount_sold ELSE 0 END) AS q1_sales,
        SUM(CASE WHEN TO_CHAR(tb3.time_id, 'Q') = '4' THEN tb3.amount_sold ELSE 0 END) AS q4_sales
    FROM sh.countries tb1
    LEFT JOIN sh.customers tb2 ON tb1.COUNTRY_ID = tb2.COUNTRY_ID
    LEFT JOIN sh.sales tb3 ON tb2.CUST_ID = tb3.cust_id
    WHERE EXTRACT(YEAR FROM tb3.time_id) = (
        SELECT MAX(EXTRACT(YEAR FROM time_id)) FROM sh.sales
    )
    GROUP BY tb1.country_region
) sales_by_quarter) tb_task_6
on tb_task_6.country_region=tb_task_1.country_region
order by tb_task_1.rank_of_region