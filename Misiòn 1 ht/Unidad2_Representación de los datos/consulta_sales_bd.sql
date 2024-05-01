use seis_bd;
/**1. ¿Cuántos productos tiene tu catálogo?*/
select 
count(product_id) AS PRODUCTOS,
count(distinct product_id) DPROD
from PRODUCTS;
/*95*/

/**2. ¿Cuántos artículos tiene tu catálogo por tipo de productos ordenándolos de
la mayor cifra a la menor?*/
select
type as tipo,
count(product_id) AS TIPO_PRODUCTO
FROM PRODUCTS
group by tipo
order by TIPO_PRODUCTO desc;

/*3. ¿Cuál es el product id, product name y el price del artículo más caro y del
más barato?*/
select 
product_id,
name as PRODUCT_NAME,
price_uds AS PRICE_DEL_ARTICULO
from PRODUCTS
where price_uds = (select max(price_uds) FROM PRODUCTS)or
price_uds = (select min(price_uds) FROM PRODUCTS);

/*4. ¿Qué tienes más registrado dentro de la plataforma, mujeres u hombres?*/
select 
garder AS SEXO,
count(user_id) AS USUARIOS
FROM USERS
group by garder;

/*5. El top 5 de estados es donde tienes menos usuarios registrados*/

select 
state as ESTADO,
count(user_id) NUM_USUARIOS
FROM USERS
group by state
order by NUM_USUARIOS asc
limit 5;

/*¿Cuál es la fecha mínima de la tabla SALES?*/
select 
min(date) as FECHA_MIN
from SALES;

/*7. ¿Qué día ha sido el día que más ingresos han generado?*/
	select 
	date as fecha,
	sum(amount) as total
	from SALES
	group by fecha
	order by total desc
	limit 1;

/**8. Listar todos los nombres de los productos empezando por el que más
unidades ha vendido.**/
select 
P.name Nombre_Producto,
sum(S.units) Numero_unidades
from SALES S
left join PRODUCTS P on S.product_id_fk=P.product_id
group by P.name
order by Numero_unidades desc;

SELECT 
p.name Nombre_Producto,
SUM(s.units) Numero_unidades
FROM PRODUCTS p
JOIN SALES s ON p.product_id = s.product_id_fk
GROUP BY p.name
ORDER BY Numero_unidades DESC;

/*9.Coloca los datos del usuario con mayor amount generado.*/
select 
U.user_id,
U.first_name NOMBRES,
U.last_name APELLIDOS,
sum(S.units) UNIDADES,
sum(S.amount) TOTAL_VENDIDO
from SALES S
left join USERS U ON S.user_id_fk = U.user_id
group by U.user_id
order by TOTAL_VENDIDO desc
limit 1;

select
U.user_id
select * from SALES;