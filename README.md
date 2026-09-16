# 🏪 Análisis de Datos — Northwind Traders

## 📋 Descripción del proyecto
Análisis exploratorio de datos sobre Northwind Traders, una empresa 
ficticia de importación y exportación de alimentos creada por Microsoft. 
El objetivo es responder 15 preguntas de negocio usando SQL y MySQL,
abarcando desde consultas básicas hasta técnicas avanzadas como
subconsultas correlacionadas y window functions.

## 🗄️ Dataset
- **Fuente:** [Kaggle — Northwind Traders](https://www.kaggle.com/datasets/jeetahirwar/northwind-traders)
- **Período:** 2013 — 2015
- **Tablas analizadas:** 7
- **Total de registros:** ~2.000 filas

## 🛠️ Herramientas
- MySQL 8.0
- MySQL Workbench

## ❓ Preguntas de negocio respondidas

| # | Pregunta | Técnicas SQL utilizadas |
|---|---|---|
| 1 | ¿Cuáles son los 5 productos más vendidos? | JOIN, GROUP BY, ORDER BY, LIMIT |
| 2 | ¿Cuál es el ingreso total por categoría? | JOIN múltiple, GROUP BY, SUM |
| 3 | ¿Qué empleado generó más ventas? | JOIN múltiple, GROUP BY, SUM |
| 4 | ¿Cuáles son los 3 clientes que más gastaron? | JOIN múltiple, GROUP BY, LIMIT |
| 5 | ¿Qué país genera más ingresos? | JOIN, GROUP BY, LIMIT |
| 6 | ¿Cuál es el promedio de días de envío por empresa? | JOIN, AVG, DATEDIFF |
| 7 | ¿Qué categoría tiene el producto más caro? | Subconsulta correlacionada |
| 8 | ¿Qué productos nunca fueron ordenados? | LEFT JOIN, IS NULL |
| 9 | ¿Qué clientes tienen más de 5 órdenes? | GROUP BY, HAVING |
| 10 | ¿Qué empleado atendió al cliente que más gastó? | JOIN múltiple, subconsulta |
| 11 | ¿Cuál es el mes con más órdenes históricamente? | YEAR(), MONTH(), COUNT |
| 12 | ¿Qué productos superan el precio promedio de su categoría? | Subconsulta correlacionada |
| 13 | ¿Top 3 empleados por trimestre en 2014? | Window Function ROW_NUMBER() |
| 14 | ¿Qué clientes no compraron en el último año? | LEFT JOIN condicional, IS NULL |
| 15 | ¿Cuál es el % de contribución de cada categoría? | Subconsulta, cálculo porcentual |

## 💡 Principales insights

- **Camembert Pierrot** es el producto más vendido con 1.577 unidades,
  pero no el más rentable — Raclette Courdavault genera más ingresos.
- **Beverages** es la categoría más rentable con $286.526 (21.15% del total),
  seguida por Dairy Products con $251.330.
- **Margaret Peacock** es la empleada con mejor desempeño histórico
  con $250.187 generados — más del triple que el último lugar.
- **USA** es el país que más ingresos genera con $263.566,
  seguido por Germany con $244.640.
- **Federal Shipping** es la empresa de envío más rápida
  con 7.47 días promedio vs 9.23 de United Package.
- El **100% del catálogo** ha sido ordenado al menos una vez,
  lo que indica una gestión eficiente del inventario.
- **10 clientes** no realizaron ninguna compra en 2015,
  representando una oportunidad de reactivación comercial.

## 📁 Estructura del repositorio
