create database cine_db
go
use cine_db
go

create table Generos
(
	ID_genero int identity(1,1),
	Genero varchar(50)
	constraint pk_Generos primary key(ID_genero)
)

create table Barrios
(ID_barrio int IDENTITY (1,1),
Barrio varchar(50),
ID_localidad int
constraint pk_barrios primary key (ID_barrio)
)

create table Clasificaciones
(
	ID_clasificacion int identity(1,1),
	Clasificacion varchar(50)
	constraint pk_Clasificaciones primary key(ID_clasificacion)
)

create table Idiomas
(
	ID_idioma int identity(1,1),
	Idioma varchar(30)
	constraint pk_Idiomas primary key(ID_idioma)
)

create table Proveedores 
(
	ID_proveedor int identity(1,1),
	Cuit int,
	Telefono bigint,
	Direccion varchar(50)
	constraint pk_Proveedores primary key(ID_proveedor)
)

create table Paises
(
	ID_pais int identity(1,1),
	Pais varchar(50)
	constraint pk_Paises primary key (ID_pais)
)

create table Provincias
(
	 ID_provincia int identity(1,1),
	 Provincia varchar(50),
	 ID_pais int
	 constraint pk_Provincias primary key (ID_provincia),
	 constraint fk_Paises_Prov foreign key(ID_pais)
		references Paises(ID_pais)
)

create table Localidades
(
	ID_localidad int identity(1,1),
	Localidad varchar(50),
	ID_provincia int
	constraint pk_Localidades primary key(ID_localidad),
	constraint fk_Provincias_Loc foreign key(ID_provincia)
		references Provincias(ID_provincia)
)

create table Productos
(
	ID_producto int identity(1,1),
	Producto varchar(50),
	ID_proveedor int
	constraint pk_Productos primary key(ID_producto),
	constraint fk_Proveedores_Prod foreign key(ID_proveedor)
		references Proveedores(ID_proveedor)
)

create table Cines
(
	ID_cine int identity(1,1),
	Nombre varchar(50),
	Direccion varchar(50),
	ID_localidad int
	constraint pk_Cines primary key(ID_cine),
	constraint fk_Localidades_Cines foreign key(ID_localidad)
		references Localidades(ID_localidad)
)

create table Salas
(
	ID_sala int IDENTITY(1,1),
	ID_Cine int,
	Nombre_sala varchar(50),
	capacidad int,
	ID_tipo_sala int,
	constraint pk_salas primary key (ID_sala),
	constraint fk_Cines_Salas foreign key (ID_cine)
		references Cines (ID_cine)
)

create table Tipo_trabajadores (
	ID_tipo int identity(1,1),
	Tipo varchar(100),
	CONSTRAINT PK_Tipo_trabajadores PRIMARY KEY (ID_tipo),
)

create table Trabajadores (
	ID_trabajador int identity(1,1),
	Nombre varchar(100),
	Apellido varchar(100),
	[E-mail] varchar(100),
	Telefono bigint,
	ID_barrio int,
	ID_tipo int,
	CONSTRAINT PK_Trabajadores PRIMARY KEY (ID_trabajador),
	CONSTRAINT FK_Barrios_Trab FOREIGN KEY (ID_barrio) REFERENCES Barrios(ID_barrio),
	CONSTRAINT FK_Tipo_trabajadores_Trab FOREIGN KEY (ID_tipo) REFERENCES Tipo_trabajadores(ID_tipo)
)

create table Confiterias
(
	ID_confiteria int identity(1,1),
	ID_Cine int,	
	ID_trabajador int
	constraint pk_Confiterias primary key(ID_confiteria),
	constraint fk_Cines_Conf foreign key(ID_Cine)
		references Cines(ID_Cine),
	constraint fk_Trabajadores_Conf foreign key(ID_trabajador)
		references Trabajadores(ID_trabajador)
)

create table Tipo_Clientes (
	ID_tipo_cliente int identity(1,1),
	Tipo_cliente varchar(100),
	CONSTRAINT PK_Tipo_Clientes PRIMARY KEY (ID_tipo_cliente)
)

create table Clientes
(
	ID_cliente int IDENTITY(1,1),
	Nombre varchar(50),
	Apellido varchar(50),
	ID_barrio int,
	Direccion varchar (50),
	Telefono bigint,
	[E-mail] varchar (50),
	Fecha_nacimiento datetime,
	ID_tipo_cliente int,
	constraint pk_clientes primary key (ID_cliente),
	constraint fk_barrios_Cli foreign key (ID_barrio)
		references Barrios (ID_barrio),
	constraint fk_tipo_cliente_Cli foreign key (ID_tipo_cliente)
		references Tipo_Clientes (ID_tipo_cliente)
)

create table Metodo_pagos (
	ID_metodo_pago int identity(1,1),
	Metodo_pago varchar(100),
	CONSTRAINT PK_Metodo_pagos PRIMARY KEY (ID_metodo_pago)
)

create table Orden_retiro_confiterias
(
	ID_orden_retiro_confiteria int identity(1,1),
	Numero int,
	ID_confiteria int,
	ID_cliente int,
	ID_trabajador int,
	ID_metodo_pago int,
	Fecha datetime
	constraint pk_Orden_retiro_confiterias primary key(ID_orden_retiro_confiteria),
	constraint fk_Confiterias_Ord_Ret_Conf foreign key(ID_confiteria)
		references Confiterias(ID_confiteria),
	constraint fk_Clientes foreign key(ID_cliente)
		references Clientes(ID_cliente),
	constraint fk_Trabajadores_Ord_Ret_Conf foreign key(ID_trabajador)
		references Trabajadores(ID_trabajador),
	constraint fk_Metodo_pagos_Ord_Ret_Conf foreign key(ID_metodo_pago)
		references Metodo_pagos(ID_metodo_pago)
)

create table Detalle_retiro_confiterias
(
	ID_detalle_retiro_conf int identity(1,1),
	ID_producto int,
	ID_orden_retiro_confiteria int,
	Cantidad int,
	Precio_unitario decimal(10,2),
	ID_promocion int
	constraint pk_Detalles_retiro_confiteria primary key (ID_detalle_retiro_conf),		
	constraint fk_Productos_Det_Ret_Conf foreign key(ID_producto)
		references Productos(ID_producto),
	constraint fk_Orden_retiro_confiterias_Det_Ret_Conf foreign key(ID_orden_retiro_confiteria)
		references Orden_retiro_confiterias(ID_orden_retiro_confiteria)
)

create table Inventarios 
(
	ID_inventario int identity(1,1),
	ID_producto int,
	Stock_actual int,
	Stock_minimo int,
	Fecha_actualizacion datetime,
	ID_cine int
	constraint pk_Inventarios primary key (ID_inventario),
	constraint fk_Productos_inv foreign key(ID_producto)
		references Productos(ID_producto),
	constraint fk_Cines_inv foreign key(ID_cine)
		references Cines(ID_cine)
)

create table Peliculas
( 
	ID_pelicula int IDENTITY (1,1),
	Titulo varchar (50),
	Descripcion varchar (50),
	ID_clasificacion int,
	ID_genero int,
	Duracion int,
	constraint pk_peliculas primary key (ID_pelicula),
	constraint fk_clasificaciones_peli foreign key (ID_clasificacion)
		references Clasificaciones (ID_clasificacion)
)

create table Trailers
( 
	ID_trailer int IDENTITY(1,1),
	ID_pelicula int,
	Duracion int,
	Url_video varchar(50),
	constraint pk_trailers primary key (ID_trailer),
	constraint fk_peliculas_Trailers foreign key (ID_pelicula)
		references Peliculas (ID_pelicula)
);

create table Reseñas 
( 
	ID_reseña int IDENTITY(1,1),
	ID_cliente int,
	ID_pelicula int,
	Puntuacion int,
	Comentario varchar(50),
	Fecha datetime
	constraint pk_reseñas primary key (ID_reseña),
	constraint fk_clientes_Reseñas foreign key (ID_cliente)
		references Clientes (ID_cliente),
	constraint fk_peliculas_Reseñas foreign key (ID_pelicula)
		references Peliculas (ID_pelicula)
)

create table Promociones(
	ID_promocion int identity(1,1),
	Descripcion varchar(100),
	Fecha_Inicio datetime,
	Fecha_final datetime,
	Procentaje_desc decimal(10,2),
	CONSTRAINT PK_Promociones PRIMARY KEY (ID_promocion)
)

create table Funciones
(
	ID_funcion int IDENTITY(1,1),
	ID_sala int,
	ID_pelicula int,
	ID_idioma int,
	Horario time,
	Fecha datetime,
	constraint pk_funciones primary key (ID_funcion),
	constraint fk_salas_Func foreign key (ID_sala)
		references Salas (ID_sala),
	constraint fk_peliculas_Func foreign key (ID_pelicula)
		references Peliculas (ID_pelicula),
	constraint fk_Idiomas_Func foreign key (ID_idioma)
		references Idiomas (ID_idioma)
)

create table Detalle_promociones(
	ID_detalle_promocion int identity(1,1),
	ID_funcion int,
	ID_promocion int,
	Condiciones varchar(100),
	CONSTRAINT PK_Detalle_promociones PRIMARY KEY (ID_detalle_promocion),
	CONSTRAINT FK_Funciones_Det_Prom FOREIGN KEY(ID_funcion) references Funciones(ID_funcion),
	CONSTRAINT FK_Promociones_Det_Prom FOREIGN KEY (ID_promocion) REFERENCES Promociones (ID_promocion)
)

create table Promocion_productos (
	ID_promocion_producto int identity(1,1),
	ID_promocion int,
	ID_producto int,
	CONSTRAINT PK_Promocion_productos PRIMARY KEY (ID_promocion_producto),
	CONSTRAINT FK_Promociones_Promo_Prod FOREIGN KEY (ID_promocion) REFERENCES Promociones (ID_promocion)
);


create table Roles (
	ID_rol int identity(1,1),
	Rol varchar(100),
	Descripcion varchar(100),
	CONSTRAINT PK_Roles PRIMARY KEY (ID_rol)
)


create table Usuario_Sistemas (
	ID_sistema int identity(1,1),
	Nombre_usuario varchar(100),
	Contraseña varchar(100),
	ID_rol int,
	ID_trabajador int,
	ID_cliente int,
	CONSTRAINT PK_Usuario_Sistemas PRIMARY KEY (ID_sistema),
	CONSTRAINT FK_Roles_Us_Sis FOREIGN KEY (ID_rol) REFERENCES Roles(ID_rol),
	CONSTRAINT FK_Trabajadores_Us_Sis FOREIGN KEY (ID_trabajador) REFERENCES Trabajadores(ID_trabajador),
	CONSTRAINT FK_Clientes_Us_Sis FOREIGN KEY (ID_cliente) REFERENCES Clientes(ID_cliente)
)


create table Tipo_Canales (
	ID_canal int identity(1,1),
	Descripcion varchar(100),
	CONSTRAINT PK_Tipo_Canales PRIMARY KEY (ID_canal)
)

create table Facturas (
	ID_factura int identity(1,1),
	ID_metodo_pago int,
	ID_canal int,
	ID_cliente int,
	ID_trabajador int,
	Fecha datetime,
	CONSTRAINT PK_Facturas PRIMARY KEY (ID_factura),
	CONSTRAINT FK_Metodo_pagos_Fact FOREIGN KEY (ID_metodo_pago) REFERENCES Metodo_pagos(ID_metodo_pago),
	CONSTRAINT FK_Tipo_Canales_Fact FOREIGN KEY (ID_canal) REFERENCES Tipo_Canales(ID_canal),
	CONSTRAINT FK_Clientes_Fact FOREIGN KEY (ID_cliente) REFERENCES Clientes(ID_cliente),
	CONSTRAINT FK_Trabajadores_Fact FOREIGN KEY (ID_trabajador) REFERENCES Trabajadores(ID_trabajador)
)



create table Estado_butacas
(ID_estado int IDENTITY(1,1),
Estado varchar(50),
constraint pk_estados primary key (ID_estado)
)


create table Tipo_Salas
(ID_tipo_sala int IDENTITY(1,1),
Tipo varchar (50)
)

create table Tipo_butacas (
	ID_tipo_butaca int identity(1,1),
	Tipo varchar(100),
	CONSTRAINT PK_Tipo_butacas PRIMARY KEY (ID_tipo_butaca)
)


create table Butacas
(
	ID_butaca int IDENTITY(1,1),
	ID_sala int,
	Fila int,
	Numero int,
	ID_tipo_butaca int,
	ID_estado int,
	constraint pk_butacas primary key (ID_butaca),
	constraint fk_salas_but foreign key (ID_sala)
		references Salas (ID_sala),
	constraint fk_tipo_butaca_but foreign key (ID_tipo_butaca)
		references Tipo_butacas (ID_tipo_butaca),
	constraint fk_estado_butacas_but foreign key (ID_estado)
		references Estado_butacas (ID_estado)
)

create table Entradas (
	ID_entrada int identity(1,1),
	ID_factura int,
	Precio_unitario decimal(10,2),
	ID_butaca int,
	ID_funcion int,
	CONSTRAINT PK_Entradas PRIMARY KEY (ID_entrada),
	CONSTRAINT FK_Butacas_Entr FOREIGN KEY (ID_butaca) REFERENCES Butacas(ID_butaca),
	CONSTRAINT FK_Funciones_Entr FOREIGN KEY (ID_funcion) REFERENCES Funciones(ID_funcion)
)

create table Detalles_facturas (
	ID_detalle_factura int identity(1,1),
	ID_entrada int,
	ID_factura int,
	Cantidad int,
	Precio_unitario decimal(10,2),
	CONSTRAINT PK_Detalles_facturas PRIMARY KEY (ID_detalle_factura),
	CONSTRAINT FK_Entradas_Det_Fact FOREIGN KEY (ID_entrada) REFERENCES Entradas(ID_entrada),
	CONSTRAINT FK_Facturas_Det_Fact FOREIGN KEY (ID_Factura) REFERENCES Facturas(ID_factura)
)

ALTER TABLE Trabajadores
ADD ContraseñaHash NVARCHAR(MAX) NULL

CREATE PROCEDURE SP_CONSULTAR_FUNCIONES_CINE
    @titulo     VARCHAR(50) = NULL,
    @genero     VARCHAR(50) = NULL,
    @fechaDesde DATE = NULL,
    @fechaHasta DATE = NULL,
    @idCine     INT = NULL          
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.Titulo,
        g.Genero,
        c.Nombre       AS Cine,
        s.Nombre_sala  AS Sala,
        f.Fecha,
        f.Horario,
        i.Idioma,
        p.Duracion,
        cla.Clasificacion
    FROM Funciones f
    JOIN Peliculas p      ON f.ID_pelicula = p.ID_pelicula
    JOIN Generos g        ON p.ID_genero = g.ID_genero
    JOIN Clasificaciones cla ON p.ID_clasificacion = cla.ID_clasificacion
    JOIN Salas s          ON f.ID_sala = s.ID_sala
    JOIN Cines c          ON s.ID_cine = c.ID_cine
    JOIN Idiomas i        ON f.ID_idioma = i.ID_idioma
    WHERE 
        (@titulo     IS NULL OR p.Titulo LIKE '%' + @titulo + '%') AND
        (@genero     IS NULL OR g.Genero = @genero) AND
        (@fechaDesde IS NULL OR f.Fecha >= @fechaDesde) AND
        (@fechaHasta IS NULL OR f.Fecha <= @fechaHasta) AND
        (@idCine     IS NULL OR c.ID_cine = @idCine)
    ORDER BY f.Fecha, f.Horario;
END;
GO


EXEC SP_CONSULTAR_FUNCIONES_CINE 
    @titulo = 'Matrix', 
    @genero = 'Ciencia Ficción', 
    @fechaDesde = '2025-10-01', 
    @fechaHasta = '2025-11-01';



CREATE PROCEDURE SP_REPORTE_VENTAS_CINE
    @fechaDesde DATE,
    @fechaHasta DATE,
    @idCine     INT = NULL     
AS
BEGIN
    SET NOCOUNT ON;

    IF @fechaDesde IS NULL OR @fechaHasta IS NULL
    BEGIN
        RAISERROR('Debe ingresar ambas fechas para el reporte.', 16, 1);
        RETURN;
    END;

    SELECT 
        p.Titulo AS Pelicula,
        COUNT(e.ID_entrada)                  AS EntradasVendidas,
        SUM(e.Precio_unitario)               AS TotalRecaudado,
        AVG(e.Precio_unitario)               AS PrecioPromedio,
        MIN(f.Fecha)                         AS PrimeraFuncion,
        MAX(f.Fecha)                         AS UltimaFuncion
    FROM Entradas e
    JOIN Funciones f ON e.ID_funcion = f.ID_funcion
    JOIN Salas s     ON f.ID_sala     = s.ID_sala
    JOIN Cines c     ON s.ID_cine     = c.ID_cine
    JOIN Peliculas p ON f.ID_pelicula = p.ID_pelicula
    WHERE f.Fecha BETWEEN @fechaDesde AND @fechaHasta
      AND (@idCine IS NULL OR c.ID_cine = @idCine)       
    GROUP BY p.Titulo
    ORDER BY TotalRecaudado DESC;
END;
GO


EXEC SP_REPORTE_VENTAS_CINE 
    @fechaDesde = '2025-10-01', 
    @fechaHasta = '2025-10-31';



CREATE PROCEDURE SP_CONSULTAR_STOCK_BAJO
 @producto  VARCHAR(50) = NULL,
    @proveedor VARCHAR(50) = NULL, 
    @idCine    INT = NULL          
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.Producto,
        pr.Cuit AS CUIT_Proveedor,
        i.Stock_actual,
        i.Stock_minimo,
        DATEDIFF(DAY, i.Fecha_actualizacion, GETDATE()) AS DiasDesdeUltAct,
        CASE 
            WHEN i.Stock_actual = 0 THEN 'SIN STOCK'
            WHEN i.Stock_actual <= i.Stock_minimo THEN 'BAJO'
            ELSE 'OK'
        END AS EstadoStock
    FROM Inventarios i
    JOIN Productos   p  ON i.ID_producto = p.ID_producto
    JOIN Proveedores pr ON p.ID_proveedor = pr.ID_proveedor
    WHERE i.Stock_actual <= i.Stock_minimo
      AND (@producto  IS NULL OR p.Producto LIKE '%' + @producto + '%')
      AND (@proveedor IS NULL OR CAST(pr.Cuit AS VARCHAR(20)) LIKE '%' + @proveedor + '%')
      AND (@idCine    IS NULL OR i.ID_cine = @idCine) 
    ORDER BY i.Stock_actual ASC;
END;
GO


EXEC SP_CONSULTAR_STOCK_BAJO;





CREATE PROCEDURE SP_PRODUCTOS_MAS_VENDIDOS
    @fechaDesde DATE = NULL,
    @fechaHasta DATE = NULL,
    @producto   VARCHAR(50) = NULL,
    @proveedor  VARCHAR(50) = NULL,
    @idCine     INT = NULL             
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.Producto,
        pr.Cuit AS CUIT_Proveedor,
        SUM(drc.Cantidad)                            AS TotalVendido,
        SUM(drc.Cantidad * drc.Precio_unitario)      AS TotalRecaudado,
        COUNT(DISTINCT orc.ID_orden_retiro_confiteria) AS TotalVentas,
        MIN(orc.Fecha)                                AS PrimeraVenta,
        MAX(orc.Fecha)                                AS UltimaVenta
    FROM Detalle_retiro_confiterias drc
    JOIN Productos   p   ON drc.ID_producto = p.ID_producto
    JOIN Proveedores pr  ON p.ID_proveedor = pr.ID_proveedor
    JOIN Orden_retiro_confiterias orc ON drc.ID_orden_retiro_confiteria = orc.ID_orden_retiro_confiteria
    JOIN Confiterias conf ON orc.ID_confiteria = conf.ID_confiteria
    JOIN Cines c          ON conf.ID_cine     = c.ID_cine
    WHERE 
        (@fechaDesde IS NULL OR orc.Fecha >= @fechaDesde)
        AND (@fechaHasta IS NULL OR orc.Fecha <= @fechaHasta)
        AND (@producto   IS NULL OR p.Producto LIKE '%' + @producto + '%')
        AND (@proveedor  IS NULL OR CAST(pr.Cuit AS VARCHAR(20)) LIKE '%' + @proveedor + '%')
        AND (@idCine     IS NULL OR c.ID_cine = @idCine)
    GROUP BY p.Producto, pr.Cuit
    ORDER BY TotalVendido DESC;
END;
GO




EXEC SP_PRODUCTOS_MAS_VENDIDOS 
    @fechaDesde = '2025-10-01', 
    @fechaHasta = '2025-10-31';

CREATE OR ALTER PROCEDURE SP_OCUPACION_FUNCIONES
    @idCine INT = NULL,
    @idFuncion INT = NULL,
    @fechaDesde DATE = NULL,
    @fechaHasta DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        f.ID_funcion,
        p.Titulo AS Pelicula,
        c.Nombre AS Cine,
        s.Nombre_sala AS Sala,
        f.Fecha,
        f.Horario,
        COUNT(DISTINCT b.ID_butaca) AS CapacidadTotal,
        COUNT(DISTINCT e.ID_butaca) AS ButacasOcupadas,
        CAST(COUNT(DISTINCT e.ID_butaca) * 100.0 / NULLIF(COUNT(DISTINCT b.ID_butaca),0) AS DECIMAL(5,2)) AS PorcentajeOcupacion
    FROM Funciones f
    INNER JOIN Peliculas p ON p.ID_pelicula = f.ID_pelicula
    INNER JOIN Salas s ON s.ID_sala = f.ID_sala
    INNER JOIN Cines c ON c.ID_cine = s.ID_Cine
    INNER JOIN Butacas b ON b.ID_sala = s.ID_sala
    LEFT JOIN Entradas e ON e.ID_funcion = f.ID_funcion AND e.ID_butaca = b.ID_butaca
    WHERE 
        (@idCine IS NULL OR c.ID_cine = @idCine)
        AND (@idFuncion IS NULL OR f.ID_funcion = @idFuncion)
        AND (@fechaDesde IS NULL OR f.Fecha >= @fechaDesde)
        AND (@fechaHasta IS NULL OR f.Fecha <= @fechaHasta)
    GROUP BY 
        f.ID_funcion, p.Titulo, c.Nombre, s.Nombre_sala, f.Fecha, f.Horario
    ORDER BY 
        f.Fecha, f.Horario;
END
GO

