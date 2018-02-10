ALTER FUNCTION [dbo].[ProductCompare] 
(
	@ProductID	INT,
	@Color		VARCHAR(50), 
	@Price		DECIMAL(18,4),
	@Size		VARCHAR(5)
)
RETURNS VARCHAR(1000) 
AS
BEGIN
	--valiables internas
	DECLARE @Int_Color	VARCHAR(50) = ''
	DECLARE @Int_Price	DECIMAL(18,4) = 0.0
	DECLARE @Int_Size	VARCHAR(5) = '' 
	DECLARE @Int_Name	VARCHAR(500) = ''
	DECLARE @MENSAJE	VARCHAR(1000)  = ''
	DECLARE @Int_Size_IN	INT  = 0
	DECLARE @Int_Size_OUT	INT  = 0


	-- setea datos internos
	SELECT @Int_Name =	[Name]
		  ,@Int_Color = [Color]
		  ,@Int_Price = [ListPrice]
		  ,@Int_Size =	[Size]
	  FROM [Production].[Product]
	 WHERE [ProductID] = @ProductID

	 -- validamos que el producto exista
	 IF ISNULL(@Int_Name,'') = ''
		 -- si no existe indicamos por mensaje
		 SET @MENSAJE = 'El producto: ' + CONVERT(varchar,@ProductID) + ', no existe en la base de datos.'
	 ELSE
		BEGIN
			-- si existe, realizamos la comparacion
		
			-- Se setea la variable de producto.
			SET @MENSAJE = 'El producto: ' + @Int_Name + ', cuenta con las siguiente caracteristicas: '

			-- Comparacion de color
		
			SET @MENSAJE = 
			CASE 
				WHEN ISNULL(@Color,'') = @Int_Color THEN	@MENSAJE + 'El color es igual. '
				ELSE										@MENSAJE + 'El color es diferente. '
			END

			-- Comparacion de Precio
		
			SET @MENSAJE = 
			CASE 
				WHEN ISNULL(@Price,-1) = @Int_Price THEN @MENSAJE + 'El precio es igual. '
				WHEN ISNULL(@Price,-1) > @Int_Price THEN @MENSAJE + 'El precio es mayor. '
				ELSE									 @MENSAJE + 'El precio es menor. '
			END

			-- Comparacion de tamaño numerico

			IF ISNUMERIC ( @Size ) = 1 AND ISNUMERIC ( @Int_Size ) = 1
			
				SET @MENSAJE = 
				CASE
					WHEN ISNULL(@Size,'') = @Int_Size THEN	@MENSAJE + 'El tamaño es igual. '
					WHEN ISNULL(@Size,'') > @Int_Size THEN  @MENSAJE + 'El tamaño es mayor. '
					ELSE									@MENSAJE + 'El tamaño es menor. '
				END

			-- Comparacion de tamaño por letra

			IF ISNUMERIC ( @Size ) = 0 AND ISNUMERIC ( @Int_Size ) = 0
			BEGIN
				SET @Int_Size_IN = 
				CASE @Size 
					WHEN 'S'	THEN 1
					WHEN 'M'	THEN 2
					WHEN 'L'	THEN 3
					WHEN 'XL'	THEN 4
					ELSE			 0
				END

				SET @Int_Size_OUT = 
				CASE @Int_Size 
					WHEN 'S'	THEN 1
					WHEN 'M'	THEN 2
					WHEN 'L'	THEN 3
					WHEN 'XL'	THEN 4
					ELSE			 0
				END
			
				SET @MENSAJE = 
				CASE 
					WHEN @Int_Size_IN = @Int_Size_OUT THEN	@MENSAJE + 'El tamaño es igual. '
					WHEN @Int_Size_IN > @Int_Size_OUT THEN	@MENSAJE + 'El tamaño es mayor. '
					ELSE									@MENSAJE + 'El tamaño es menor. '
				END
			END

		END
	Return @MENSAJE

END
GO
