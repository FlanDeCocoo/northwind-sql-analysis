-- ================================================
-- ANÁLISIS DE DATOS - NORTHWIND TRADERS
-- Dataset: Northwind Traders
-- Fuente: Kaggle
-- Herramienta: MySQL 8.0
-- Autor: [Tu nombre]
-- ================================================

USE northwind;

-- ================================================
-- PREGUNTA 1
-- ¿Cuáles son los 5 productos más vendidos por cantidad total vendida?
-- Resultado: Camembert Pierrot lidera con 1.577 unidades vendidas
-- ================================================

select
    products.productName as Producto,
    sum(order_details.quantity) as Cantidad_Total,
    round(sum(order_details.quantity * order_details.unitPrice), 2) as Ganancia_Total
from products
join order_details
    on products.productID = order_details.productID
group by productName
order by Cantidad_Total desc
limit 5;

-- ================================================
-- PREGUNTA 2
-- ¿Cuál es el ingreso total generado por cada categoría de producto?
-- Resultado: Beverages lidera con $286.526, Grains & Cereals es la menor con $100.726
-- ================================================

select
    categoryName as Categoria,
    sum(order_details.quantity) as Cantidad_Total,
    round(sum(order_details.quantity * order_details.unitPrice), 2) as Ganancia_Total
from categories
join products
    on categories.categoryID = products.categoryID
join order_details
    on products.productID = order_details.productID
group by categoryName
order by Ganancia_Total desc;

-- ================================================
-- PREGUNTA 3
-- ¿Qué empleado generó más ventas en términos de dinero recaudado?
-- Resultado: Margaret Peacock lidera con $250.187, Steven Buchanan es el último con $75.567
-- ================================================

select
    concat(employees.firstName, ' ', employees.lastName) as Empleado,
    sum(order_details.quantity) as Cantidad_Total,
    round(sum(order_details.quantity * order_details.unitPrice), 2) as Ganancia_Total
from employees
join orders
    on employees.employeeID = orders.employeeID
join order_details
    on orders.orderID = order_details.orderID
group by employees.employeeID, employees.firstName, employees.lastName
order by Ganancia_Total desc;

-- ================================================
-- PREGUNTA 4
-- ¿Cuáles son los 3 clientes que más dinero han gastado históricamente?
-- Resultado: QUICK-Stop $117.483, Save-a-lot Markets $115.673, Ernst Handel $113.236
-- ================================================

select
    companyName as Cliente,
    sum(order_details.quantity) as Cantidad_Total,
    round(sum(order_details.quantity * order_details.unitPrice), 2) as Ganancia_Total
from customers
join orders
    on customers.customerID = orders.customerID
join order_details
    on orders.orderID = order_details.orderID
group by companyName
order by Ganancia_Total desc
limit 3;

-- ================================================
-- PREGUNTA 5
-- ¿Qué país genera más ingresos para Northwind?
-- Resultado: USA con $263.566
-- ================================================

select
    country as Pais,
    round(sum(order_details.quantity * order_details.unitPrice), 2) as Ganancia_Total
from customers
join orders
    on customers.customerID = orders.customerID
join order_details
    on orders.orderID = order_details.orderID
group by country
order by Ganancia_Total desc
limit 1;

-- ================================================
-- PREGUNTA 6
-- ¿Cuál es el promedio de días entre la fecha de orden y fecha de envío por empresa de shipping?
-- Resultado: Federal Shipping es la más rápida con 7.47 días promedio
-- ================================================

select
    shippers.companyName as Empresa,
    round(avg(datediff(shippedDate, orderDate)), 2) as Promedio_Dias
from shippers
join orders
    on shippers.shipperID = orders.shipperID
group by shippers.companyName
order by Promedio_Dias;

-- ================================================
-- PREGUNTA 7
-- ¿Qué categoría tiene el producto más caro y cuál es ese producto?
-- Resultado: Beverages tiene el producto más caro — Côte de Blaye a $263.5
-- ================================================

select
    categories.categoryName as Categoria,
    (select products2.productName
     from products as products2
     where products2.categoryID = categories.categoryID
     order by products2.unitPrice desc
     limit 1) as Producto_Mas_Caro,
    (select max(products2.unitPrice)
     from products as products2
     where products2.categoryID = categories.categoryID) as Precio_Mas_Caro
from categories
order by Precio_Mas_Caro desc;

-- ================================================
-- PREGUNTA 8
-- ¿Qué productos nunca han sido ordenados?
-- Resultado: todos los productos han sido ordenados al menos una vez
-- Insight: gestión eficiente del catálogo sin productos obsoletos
-- ================================================

select
    products.productName as Producto
from products
left join order_details
    on products.productID = order_details.productID
where order_details.productID is null;

-- ================================================
-- PREGUNTA 9
-- ¿Cuáles son los clientes que han realizado más de 5 órdenes?
-- Resultado: 64 clientes con más de 5 órdenes, Save-a-lot Markets lidera con 31
-- ================================================

select
    companyName as Cliente,
    count(orderID) as Cantidad_Ordenes
from customers
join orders
    on customers.customerID = orders.customerID
group by companyName
having count(orderID) > 5
order by Cantidad_Ordenes desc;

-- ================================================
-- PREGUNTA 10
-- ¿Qué empleado atendió al cliente que más gastó y cuánto fue ese gasto?
-- Resultado: Nancy Davolio atendió a Hanari Carnes en la orden más valiosa ($15.810)
-- ================================================

select * from (
    select
        order_details.orderID as ID,
        employeeName as Empleado,
        companyName as Cliente,
        round((order_details.quantity * order_details.unitPrice) * (1 - order_details.discount), 2) as Ganancia_Total
    from customers
    join orders
        on customers.customerID = orders.customerID
    join order_details
        on order_details.orderID = orders.orderID
    join employees
        on orders.employeeID = employees.employeeID
) as resultado
order by Ganancia_Total desc
limit 1;

-- ================================================
-- PREGUNTA 11
-- ¿Cuál es el mes con mayor cantidad de órdenes históricamente?
-- Resultado: Abril 2015 con 74 órdenes
-- ================================================

select * from (
    select
        year(orderDate) as Año,
        month(orderDate) as Mes,
        count(orderID) as Numero_de_Pedidos
    from orders
    group by year(orderDate), month(orderDate)
) as resultado
order by Numero_de_Pedidos desc
limit 1;

-- ================================================
-- PREGUNTA 12
-- ¿Qué productos tienen un precio mayor al promedio de su categoría?
-- Resultado: 8 productos superan el promedio de su categoría
-- ================================================

select
    categories.categoryName as Categoria,
    round(avg(products.unitPrice), 2) as Promedio,
    max(products.unitPrice) as Precio_Mas_Caro,
    (select products2.productName
     from products as products2
     where products2.categoryID = categories.categoryID
     order by products2.unitPrice desc
     limit 1) as Producto_Mas_Caro
from categories
join products
    on categories.categoryID = products.categoryID
group by categories.categoryID, categories.categoryName
order by Promedio desc;

-- ================================================
-- PREGUNTA 13
-- ¿Cuáles son los 3 empleados con mejor desempeño por trimestre en 2014?
-- Resultado: Margaret Peacock domina Q1 y Q4, Janet Leverling lidera Q2
-- ================================================

select * from (
    select
        quarter(orderDate) as Trimestre,
        employeeName as Empleado,
        sum(order_details.quantity) as Cantidad_Total,
        round(sum(order_details.quantity * order_details.unitPrice), 2) as Ganancia_Total,
        row_number() over (
            partition by quarter(orderDate)
            order by sum(order_details.quantity * order_details.unitPrice) desc
        ) as Ranking
    from employees
    join orders
        on employees.employeeID = orders.employeeID
    join order_details
        on orders.orderID = order_details.orderID
    where year(orderDate) = 2014
    group by employeeName, quarter(orderDate)
) as resultado
where Ranking <= 3
order by Trimestre, Ranking;

-- ================================================
-- PREGUNTA 14
-- ¿Qué clientes no han realizado ninguna orden en el último año del dataset?
-- Resultado: 10 clientes sin órdenes en 2015
-- ================================================

select
    customers.companyName as Cliente
from customers
left join orders
    on customers.customerID = orders.customerID
    and year(orders.orderDate) = 2015
where orders.orderID is null
order by Cliente;

-- ================================================
-- PREGUNTA 15
-- ¿Cuál es el porcentaje de contribución de cada categoría al ingreso total?
-- Resultado: Beverages lidera con 21.15%, Grains & Cereals es la menor con 7.44%
-- ================================================

select * from (
    select
        categories.categoryName as Categoria,
        round(sum(order_details.quantity * order_details.unitPrice), 2) as Ingreso_Categoria,
        round(sum(order_details.quantity * order_details.unitPrice) * 100 /
            (select sum(order_details2.quantity * order_details2.unitPrice)
             from order_details as order_details2), 2) as Porcentaje
    from categories
    join products
        on categories.categoryID = products.categoryID
    join order_details
        on products.productID = order_details.productID
    group by categories.categoryName
) as resultado
order by Porcentaje desc;
