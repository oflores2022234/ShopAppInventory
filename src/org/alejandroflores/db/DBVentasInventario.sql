
DROP DATABASE IF EXISTS DBVentasInventario;

-- Crear la base de datos
CREATE DATABASE DBVentasInventario;

-- Usar la base de datos
USE DBVentasInventario;
-- Crear tabla de Roles

CREATE TABLE Rol (
    rolId INT NOT NULL AUTO_INCREMENT,
    nombreRol VARCHAR(50) NOT NULL,
    descripcionRol VARCHAR(150) NOT NULL,
    PRIMARY KEY (rolId)
);



-- Crear tabla de Usuario con la columna de rolId y tipoUsuario
CREATE TABLE Usuario (
    idUsuario INT NOT NULL AUTO_INCREMENT,
    nombreUsuario VARCHAR(100) NOT NULL,
    apellidoUsuario VARCHAR(100) NOT NULL,
    usuario VARCHAR(50) NOT NULL,
    clave VARCHAR(50) NOT NULL,
    rolId INT NOT NULL,
    PRIMARY KEY (idUsuario),
    CONSTRAINT FK_Usuario_Rol FOREIGN KEY (rolId) REFERENCES Rol (rolId)
);

-- Crear tabla de Login
CREATE TABLE Login (
    idLogin INT NOT NULL AUTO_INCREMENT,
    usuarioLogin VARCHAR(50) NOT NULL,
    claveLogin VARCHAR(50) NOT NULL,
    PRIMARY KEY (idLogin)
);

-- Crear tabla de TipoProducto
CREATE TABLE TipoProducto (
    tipoProductoId INT NOT NULL AUTO_INCREMENT,
    nombreTipoProducto VARCHAR(150) NOT NULL,
    descripcionTipoProducto VARCHAR(200) NOT NULL,
    PRIMARY KEY (tipoProductoId)
);

-- Crear tabla de Proveedor
CREATE TABLE Proveedor (
    proveedorId INT NOT NULL AUTO_INCREMENT,
    nombreProveedor VARCHAR(150) NOT NULL,
    direccionProveedor VARCHAR(150) NOT NULL,
    telefonoProveedor VARCHAR(8) NOT NULL,
    correoProveedor VARCHAR(150) NOT NULL,
    PRIMARY KEY (proveedorId)
);

-- Crear tabla de Cliente
CREATE TABLE Cliente (
    clienteId INT NOT NULL AUTO_INCREMENT,
    nombresCliente VARCHAR(150) NOT NULL,
    apellidosCliente VARCHAR(150) NOT NULL,
    direccionCliente VARCHAR(150) NOT NULL,
    nit VARCHAR(10) NOT NULL,
    telefonoCliente VARCHAR(8) NOT NULL,
    correoCliente VARCHAR(150) NOT NULL,
    PRIMARY KEY (clienteId)
);

-- Crear tabla de TipoEmpleado
CREATE TABLE TipoEmpleado (
    tipoEmpleadoId INT NOT NULL AUTO_INCREMENT,
    descripcionTipoEmpleado VARCHAR(150) NOT NULL,
    PRIMARY KEY (tipoEmpleadoId)
);

-- Crear tabla de Empleado
CREATE TABLE Empleado (
    empleadoId INT NOT NULL AUTO_INCREMENT,
    nombresEmpleado VARCHAR(150) NOT NULL,
    apellidosEmpleado VARCHAR(150) NOT NULL,
    tipoEmpleadoId INT NOT NULL,
    fechaContratacion DATE NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (empleadoId),
    CONSTRAINT FK_Empleado_TipoEmpleado FOREIGN KEY (tipoEmpleadoId)
        REFERENCES TipoEmpleado (tipoEmpleadoId) ON DELETE CASCADE
);

-- Crear tabla de Producto
CREATE TABLE Producto (
    productoId INT NOT NULL AUTO_INCREMENT,
    nombreProducto VARCHAR(150) NOT NULL,
    descripcionProducto VARCHAR(150) NOT NULL,
    precioCompra DECIMAL(10,2) NOT NULL,
    precioVenta DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    tipoProductoId INT NOT NULL,
    proveedorId INT NOT NULL,
    PRIMARY KEY (productoId),
    CONSTRAINT FK_Producto_TipoProducto FOREIGN KEY (tipoProductoId)
        REFERENCES TipoProducto (tipoProductoId) ON DELETE CASCADE,
    CONSTRAINT FK_Producto_Proveedor FOREIGN KEY (proveedorId)
        REFERENCES Proveedor (proveedorId) ON DELETE CASCADE
);

-- Crear tabla de Compra
CREATE TABLE Compra (
    compraId INT NOT NULL AUTO_INCREMENT,
    fechaCompra DATE NOT NULL,
    proveedorId INT NOT NULL,
    PRIMARY KEY (compraId),
    CONSTRAINT FK_Compra_Proveedor FOREIGN KEY (proveedorId)
        REFERENCES Proveedor (proveedorId) ON DELETE CASCADE
);

-- Crear tabla de DetalleCompra
CREATE TABLE DetalleCompra (
    detalleCompraId INT NOT NULL AUTO_INCREMENT,
    compraId INT NOT NULL,
    productoId INT NOT NULL,
    cantidad INT NOT NULL,
    precioUnitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (detalleCompraId),
    CONSTRAINT FK_DetalleCompra_Compra FOREIGN KEY (compraId)
        REFERENCES Compra (compraId),
    CONSTRAINT FK_DetalleCompra_Producto FOREIGN KEY (productoId)
        REFERENCES Producto (productoId)
);

-- Crear tabla de Venta
CREATE TABLE Venta (
    ventaId INT NOT NULL AUTO_INCREMENT,
    fechaVenta DATE NOT NULL,
    clienteId INT NOT NULL,
    empleadoId INT NOT NULL,
    PRIMARY KEY (ventaId),
    CONSTRAINT FK_Venta_Cliente FOREIGN KEY (clienteId)
        REFERENCES Cliente (clienteId) ON DELETE CASCADE,
    CONSTRAINT FK_Venta_Empleado FOREIGN KEY (empleadoID)
        REFERENCES Empleado (empleadoId) ON DELETE CASCADE
);

-- Crear tabla de DetalleVenta
CREATE TABLE DetalleVenta (
    detalleVentaId INT NOT NULL AUTO_INCREMENT,
    ventaId INT NOT NULL,
    productoId INT NOT NULL,
    cantidadVendida INT NOT NULL,
    precioUnitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (detalleVentaId),
    CONSTRAINT FK_DetalleVenta_Venta FOREIGN KEY (ventaId)
        REFERENCES Venta (ventaId),
    CONSTRAINT FK_DetalleVenta_Producto FOREIGN KEY (productoId)
        REFERENCES Producto (productoId)
);

-- Crear tabla de Inventario
CREATE TABLE Inventario (
    inventarioId INT NOT NULL AUTO_INCREMENT,
    productoId INT NOT NULL,
    cantidadDisponible INT NOT NULL,
    PRIMARY KEY (inventarioId),
    CONSTRAINT FK_Inventario_Producto FOREIGN KEY (productoId)
        REFERENCES Producto (productoId) ON DELETE CASCADE
);


-- **********PROCEDIMIENTOS ALMACENADOR********** --

-- -------- PROCEDIMIENTOS ALMACENADOR DE LA ENTIDAD ROL ----------

-- AGREGAR --

Delimiter $$
	Create procedure sp_AgregarRol(in nombreRol varchar(50),in descripcionRol varchar(150))
    Begin
		Insert into Rol(nombreRol, descripcionRol)
			values (nombreRol, descripcionRol);
    End$$
Delimiter ;

call sp_AgregarRol('Administrador','Control total de la aplicación');
call sp_AgregarRol('Básico','Control limitado de la aplicación');

-- LISTAR --

Delimiter $$
	Create procedure sp_ListarRol()
    Begin
		Select
			R.rolId,
            R.nombreRol,
            R.descripcionRol
            from Rol R;
    End$$
Delimiter ;

call sp_ListarRol();

Delimiter $$
	Create procedure sp_BuscarRol();
    
Delimiter ;


























