WITH purchase_counts AS (
    SELECT s.PUBID, MONTH(io.DATE_TIME) AS month, COUNT(*) AS num_purchases
    FROM ITEMS_IN_ORDERS io
    JOIN STOCKS_IN_BOOKSTORE s ON io.STOCKID = s.STOCKID
    GROUP BY s.PUBID, MONTH(io.DATE_TIME)
), 
increasing_pubs AS (
    SELECT pc1.PUBID
    FROM purchase_counts pc1
    JOIN purchase_counts pc2 ON pc1.PUBID = pc2.PUBID
    WHERE pc1.month = pc2.month - 1 AND pc1.num_purchases <= pc2.num_purchases
    GROUP BY pc1.PUBID
    HAVING COUNT(*) >= 2
)
SELECT p.PUBID, p.PUBLISHER, p.YEAR
FROM PUBLICATION p
JOIN increasing_pubs ip ON p.PUBID = ip.PUBID
