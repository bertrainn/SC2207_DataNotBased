SELECT P.PUBID, COUNT(DISTINCT S.BOOKSTOREID) AS NumOfBookstores
FROM PUBLICATION P
INNER JOIN STOCKS_IN_BOOKSTORE S ON P.PUBID = S.PUBID
WHERE P.PUBLISHER = 'Nanyang Publisher Company'
GROUP BY P.PUBID;
