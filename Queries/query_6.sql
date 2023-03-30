SELECT bs.BOOKSTOREID, SUM(io.ITEM_PRICE * io.ITEM_QTY) AS REVENUE
FROM BOOKSTORE bs
JOIN STOCKS_IN_BOOKSTORE sib ON bs.BOOKSTOREID = sib.BOOKSTOREID
JOIN ITEMS_IN_ORDERS io ON sib.STOCKID = io.STOCKID
WHERE io.DATE_TIME >= '2022-08-01' AND io.DATE_TIME < '2022-09-01'
GROUP BY bs.BOOKSTOREID
HAVING SUM(io.ITEM_PRICE * io.ITEM_QTY) IN (
  SELECT MAX(total_revenue)
  FROM (
    SELECT SUM(io.ITEM_PRICE * io.ITEM_QTY) AS total_revenue
    FROM BOOKSTORE bs
    JOIN STOCKS_IN_BOOKSTORE sib ON bs.BOOKSTOREID = sib.BOOKSTOREID
    JOIN ITEMS_IN_ORDERS io ON sib.STOCKID = io.STOCKID
    WHERE io.DATE_TIME >= '2022-08-01' AND io.DATE_TIME < '2022-09-01'
    GROUP BY bs.BOOKSTOREID
  ) AS max_revenue
)
