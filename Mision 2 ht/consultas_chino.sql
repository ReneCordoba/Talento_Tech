use Chinook;
show tables in Chinook;

/*2. ¿Qué país tiene más facturas?*/
SELECT BillingCountry,
COUNT(INVOICEID)
FROM Invoice
GROUP BY 1 
ORDER BY 2 DESC;
/*3. se quiere promocionar un nuevo festival musical, para ello es necesario saber en qué ciudad hay mas facturas (invoices) . determinar en qué
ciudad la suma de facturas es la mayor.*/
SELECT BillingCity,
sum(Total) AS TOTAL
FROM Invoice
GROUP BY BillingCity
HAVING SUM(Total) = (SELECT MAX(Total)
							 FROM (SELECT SUM(Total) AS TOTAL
								FROM Invoice
								GROUP BY BillingCity)AS Subquery);
                                
/*se obtiene el mismo resultado que la consulta anterior*/
SELECT 
BillingCity,
SUM(Total) AS TotalInvoices
FROM Invoice
GROUP BY BillingCity
ORDER BY TotalInvoices DESC
LIMIT 1;
                          
/*4. Determinar quien es el mejor cliente (el que mas ha gastado en el sistema)  */
select
C.CustomerId,
C.FirstName,
C.LastName,	
sum(I.Total) AS TOTAL
from Invoice I
join Customer C ON I.CustomerId =  C.CustomerId 
group by I.CustomerId
order by TOTAL desc
Limit 1;

/*5. Obtener una tabla con el correo, nombre y apellido de todos las personas
que escuchan Rock. Retornar la lista por orden alfabético*/
SELECT 
C.Email,
C.FirstName,
C.LastName,
G.Name
FROM Customer C
JOIN Invoice I ON C.CustomerId = I.CustomerId
JOIN InvoiceLine IL ON I.InvoiceId = IL.InvoiceId
JOIN Track T ON IL.TrackId = T.TrackId
JOIN Genre G ON T.GenreId = G.GenreId
WHERE G.Name = 'Rock'
GROUP BY C.Email, C.FirstName, C.LastName
ORDER BY C.LastName, C.FirstName;

/*6. Sacar una lista con todos los artistas que generan música rock*/
SELECT 
DISTINCT A.Name,
G.Name
FROM Artist A
JOIN Album AL ON A.ArtistId = AL.ArtistId
JOIN Track T ON AL.AlbumId = T.AlbumId
JOIN Genre G ON T.GenreId = G.GenreId
WHERE G.Name = 'Rock'
order by G.name ASC;

/*7. Encontrar cual es el artista que más ha ganado de acuerdo al campo
invoiceLines.*/

SELECT 
A.ArtistId,
A.Name,
SUM(IL.UnitPrice * IL.Quantity) AS Total
FROM Artist A
JOIN Album AL ON A.ArtistId = AL.ArtistId
JOIN Track T ON AL.AlbumId = T.AlbumId
JOIN InvoiceLine IL ON T.TrackId = IL.TrackId
GROUP BY A.ArtistId
ORDER BY Total DESC
LIMIT 1;

/*8. Encontrar cuanto gastaron en total en estados unidos en compras*/
SELECT 
SUM(I.Total) AS Total_USA
FROM Invoice I
JOIN Customer C ON I.CustomerId = C.CustomerId
WHERE C.Country = 'USA';

/*9. Encontrar cuánto gastaron los usuarios por género musical*/
SELECT
G.Name AS Genero_Musical,
SUM(IL.UnitPrice * IL.Quantity) AS Total
FROM Genre G
JOIN Track T ON G.GenreId = T.GenreId
JOIN InvoiceLine IL ON T.TrackId = IL.TrackId
JOIN Invoice I ON IL.InvoiceId = I.InvoiceId
GROUP BY G.Name;

/*10.Generar una tabla con el conteo de usuarios por cada país.*/
SELECT 
Country,
COUNT(CustomerId) AS UserCount
FROM Customer
GROUP BY Country;

/*11. Encontrar cuantas canciones hay por cada género musical.*/
SELECT 
G.Name AS Genre,
COUNT(T.TrackId) AS SongCount
FROM Genre G
JOIN Track  T ON G.GenreId = T.GenreId
GROUP BY G.Name;

select * from Invoice;
select * from Genre;
select * from MediaType;

SELECT 
BillingCity,
SUM(Total) AS TotalInvoices
FROM Invoice
GROUP BY BillingCity
ORDER BY TotalInvoices DESC
LIMIT 1;
