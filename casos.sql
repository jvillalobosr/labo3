
SELECT *
  FROM [AdventureWorks2014].[Production].[Product]
 WHERE productId in ( 742, 714)

--producto no existe
SELECT [dbo].[ProductCompare] (0,'Multi',49.99,'0')

--todo igual
SELECT [dbo].[ProductCompare] (714,'Multi',49.99,'M')

-- Precio mayor
SELECT [dbo].[ProductCompare] (714,'Multi',50.00,'M')

-- Precio menor
SELECT [dbo].[ProductCompare] (714,'Multi',49.98,'M')

-- Color diferente
SELECT [dbo].[ProductCompare] (714,'ROJO',49.99,'M')

--todo diferente
SELECT [dbo].[ProductCompare] (714,'ROJO',49.989,'S')

--Tamaño menor
SELECT [dbo].[ProductCompare] (714,'Multi',50.00,'S')

--Tamaño mayor
SELECT [dbo].[ProductCompare] (714,'Multi',50.00,'L')
SELECT [dbo].[ProductCompare] (714,'Multi',50.00,'XL')



--Tamaño menor
SELECT [dbo].[ProductCompare] (742,'Silver',1364.50,45)

--Tamaño mayor
SELECT [dbo].[ProductCompare] (742,'Silver',1364.50,47)

--Tamaño igual
SELECT [dbo].[ProductCompare] (742,'Silver',1364.50,46)

