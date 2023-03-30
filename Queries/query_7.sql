SELECT DISTINCT c.CID, p.PUBID,m.max_price
FROM (
    SELECT io.CID, MAX(s.STOCK_PRICE) AS max_price
    FROM ITEMS_IN_ORDERS io
    JOIN STOCKS_IN_BOOKSTORE s ON io.STOCKID = s.STOCKID
    GROUP BY io.CID
) as m
JOIN CUSTOMERS c ON m.CID = c.CID
JOIN ITEMS_IN_ORDERS io ON c.CID = io.CID
JOIN STOCKS_IN_BOOKSTORE s ON io.STOCKID = s.STOCKID AND s.STOCK_PRICE = m.max_price
JOIN PUBLICATION p ON s.PUBID = p.PUBID
JOIN (
    SELECT CID
    FROM COMPLAINTS
    GROUP BY CID
    HAVING COUNT(*) IN (
        SELECT MAX(complaint_count)
        FROM (
            SELECT COUNT(*) AS complaint_count
            FROM COMPLAINTS
            GROUP BY CID
        ) AS complaint_counts
    )
) comp ON c.CID = comp.CID
