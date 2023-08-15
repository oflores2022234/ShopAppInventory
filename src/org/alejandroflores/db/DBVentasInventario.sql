Drop database if exists DBVentasInventario;
Create database DBVentasInventario;

Use DBVentasInventario;

Create table TipoProducto(
	tipoProductoId int not null auto_increment,
    nombreTipoProducto varchar(150) not null,
    descripcionTipoProducto varchar(200) not null,
    primary key PK_tipoProductoId(tipoProductoId)
);

Create table Proveedor(
	proveedorId int not null auto_increment,
    nombreProveedor varchar(150) not null,
    direccionProveedor varchar(150) not null,
    telefonoProveedor varchar(8) not null,
    correoProveedor varchar(150) not null,
    primary key PK_proveedorId(proveedorId)
);

Create table Cliente(
	clienteId int not null auto_increment,
    nombresCliente varchar(150) not null,
    apellidosCliente varchar(150) not null,
    direccionCliente varchar(150) not null,
    telefonoCliente varchar(8) not null,
    correoCliente varchar(150) not null,
    primary key PK_clienteId(clienteId)
);

Create table TipoEmpleado(
	tipoEmpleadoId int not null auto_increment,
    descripcionTipoEmpleado varchar(150) not null,
    primary key PK_tipoEmpleadoId(tipoEmpleadoId)
);

Create table Empleado(
	empleadoId int not null auto_increment,
    nombresEmpleado varchar(150) not null,
    apellidosEmpleado varchar(150) not null,
    tipoEmpleadoId int not null,
    fechaContratacion date not null,
    salario decimal(10,2) not null,
    primary key PK_empleadoId(empleadoId),
    constraint FK_Empleado_TipoEmpleado foreign key (tipoEmpleadoId)
		references TipoEmpleado (tipoEmpleadoId) on delete cascade
);

Create table Usuario(
	codigoUsuario int not null auto_increment,
    nombreUsuario varchar(150) not null,
    apellidoUsuario varchar(150) not null,
    usuarioLogin varchar(50) not null,
    contrasena varchar(50) not null,
    primary key Pk_codigoUsuario (codigoUsuario)
);

Create table Login(
	usuarioMaster varchar(50) not null,
    passwordLogin varchar(50) not null,
    primary key PK_usuarioMaster (usuarioMaster)
);

create table Producto(
	productoId int not null auto_increment,
    nombreProducto varchar(150) not null,
    descripcionProducto varchar(150) not null,
    precioCompra decimal (10,2) not null,
    precioVenta decimal (10,2) not null,
    stock int not null,
    tipoProductoId int not null,
    proveedorId int not null,
    primary key PK_productoId (productoId),
    constraint FK_Producto_TipoProducto foreign key (tipoProductoId)
		references TipoProducto (tipoProductoId) on delete cascade,
	constraint FK_Producto_Proveedor foreign key (proveedorId)
		references Proveedor (proveedorId) on delete cascade
);

create table Compra(
	compraId int not null auto_increment,
    fechaComprea date not null,
    proveedorId int not null,
    primary key PK_compraId (compraId),
    constraint FK_Compra_Proveedor foreign key (proveedorId)
		references Proveedor (proveedorId)
);

create table DetalleCompra(
    detalleCompraId int not null auto_increment,
    compraId int not null,
    productoId int not null,
    cantidad int not null,
    precioUnitario decimal(10,2) not null,
    primary key PK_detalleCompraId (detalleCompraId),
    constraint FK_DetalleCompra_Compra foreign key (compraId)
        references Compra (compraId),
    constraint FK_DetalleCompra_Producto foreign key (productoId)
        references Producto (productoId)
);

create table Venta(
    ventaId int not null auto_increment,
    fechaDeVenta date not null,
    clienteId int not null,
    primary key PK_ventaId (ventaId),
    constraint FK_Venta_Cliente foreign key (clienteId)
        references Cliente (clienteId)
);

create table DetalleVenta(
    detalleVentaId int not null auto_increment,
    ventaId int not null,
    productoId int not null,
    cantidadVendida int not null,
    precioUnitario decimal(10,2) not null,
    primary key PK_detalleVentaId (detalleVentaId),
    constraint FK_DetalleVenta_Venta foreign key (ventaId)
        references Venta (ventaId),
    constraint FK_DetalleVenta_Producto foreign key (productoId)
        references Producto (productoId)
);

create table Inventario (
    inventarioId int not null auto_increment,
    productoId int not null,
    cantidadDisponible int not null,
    primary key PK_inventarioId (inventarioId),
    constraint FK_Inventario_Producto foreign key (productoId)
        references Producto (productoId)
);


/*PROCEDIMIENTOS DE AGREGAR*/
-- TIPO PRODUCTO
Delimiter $$
    Create procedure sp_AgregarTipoProducto (in nombreTipoProducto varchar(150), in descripcionTipoProducto varchar(200))
    Begin
        insert into TipoProducto(nombreTipoProducto,descripcionTipoProducto)
            values (nombreTipoProducto, descripcionTipoProducto);
    End$$
Delimiter ;

call sp_AgregarTipoProducto("Limpieza", "Artículos Para el Hogar");

-- PROVEEDOR
describe proveedor;
Delimiter $$
	Create procedure sp_AgregarProveedor (in nombreProveedor varchar(150), in direccionProveedor varchar(150), in telefonoProveedor varchar(8), in correoProveedor varchar(150))
    Begin
		insert into Proveedor(nombreProveedor, direccionProveedor, telefonoProveedor, correoProveedor)
			values (nombreProveedor, direccionProveedor, telefonoProveedor, correoProveedor);
    End$$
Delimiter ;

call sp_AgregarProveedor('Coca Cola', 'Chimaltenango', '78428571', 'cocacola@gmail.com');

-- CLIENTE
describe cliente;
Delimiter $$
	Create procedure sp_AgregarCliente (in nombresCliente varchar(150), in apellidosCliente varchar(150), in direccionCliente varchar(150), in telefonoCliente varchar(8), in correoCliente varchar(150))
    Begin
		insert into Cliente(nombresCliente, apellidosCliente, direccionCliente, telefonoCliente, correoCliente)
			values (nombresCliente, apellidosCliente, direccionCliente, telefonoCliente, correoCliente);
    End$$
Delimiter ;

call sp_AgregarCliente('Oscar Alejandro', 'Flores Yllescas', 'Antigua Guatemala', '42363512', 'ayllescas34@gmail.com');


-- TIPO EMPLEADO
describe TipoEmpleado;
Delimiter $$
	Create procedure sp_AgregarTipoEmpleado (in descripcionTipoEmpleado varchar(150))
	Begin
		insert into TipoEmpleado(descripcionTipoEmpleado)
			values (descripcionTipoEmpleado);
    End$$
Delimiter ;

call sp_AgregarTipoEmpleado('Administrativo');


-- EMPLEADO
describe Empleado;

Delimiter $$
	Create procedure sp_AgregarEmpleado (in nombresEmpleado varchar(150), in apellidosEmpleado varchar(150), in tipoEmpleadoId int, in fechaContratacion date, in salario decimal(10,2))
    Begin
		insert into Empleado(nombresEmpleado, apellidosEmpleado, tipoEmpleadoId, fechaContratacion, salario)
			values (nombresEmpleado, apellidosEmpleado, tipoEmpleadoId, fechaContratacion, salario);
    End$$
Delimiter ;

call sp_AgregarEmpleado ('Oscar Alejandro', 'Flores Yllescas', 1, now(), 25000.00);


-- USUARIO
describe Usuario;
Delimiter $$
	Create procedure sp_AgregarUsuario(in nombreUsuario varchar(100), in apellidoUsuario varchar(100),
		in usuarioLogin varchar(50), in contrasena varchar(50))
	Begin
		Insert into Usuario(nombreUsuario, apellidoUsuario, usuarioLogin, contrasena)
			values(nombreUsuario, apellidoUsuario, usuarioLogin,contrasena);
    End$$
Delimiter ;

call sp_AgregarUsuario('Alejandro', 'Flores', 'oflores','1236');


-- PRODUCTO
describe producto;
Delimiter $$
	create procedure sp_AgregarProducto(in nombreProducto varchar(150), in descripcionProducto varchar(150), in precioCompra decimal(10,2), in precioVenta decimal(10,2)
	in stock int, in tipoProductoId int, in proveedorId int)
				Begin
					insert into Producto(nombreProducto, descripcionProducto, precioCompra, precioVenta, stock, tipoProductoId, proveedorId)
					values (nombreProducto, descripcionProducto, precioCompra, precioVenta, stock, tipoProductoId, proveedorId);
                End$$
Delimiter ;

call sp_AgregarProducto('Azistin', 'Con cloro y aroma a lavanda', 1.50, 2.50, 250, 1,1);
select * from producto;



/*EJEMPLO CRUD*/

/*Delimiter $$
	Create procedure sp_AgregarEmpresa (in nombreEmpresa varchar(150),in direccion varchar(150), in telefono varchar(10))
    Begin
		insert into Empresas(nombreEmpresa, direccion, telefono)
			values (nombreEmpresa, direccion, telefono);
    End$$
Delimiter ;*/

/*Delimiter $$
	Create procedure sp_ListarEmpresas ()
    Begin
		Select E.codigoEmpresa,
			E.nombreEmpresa,
            E.direccion,
            E.telefono
            from Empresas E;
    End$$
Delimiter ;*/

/*Delimiter $$
	Create procedure sp_BuscarEmpresa(in codEmpre int)
    Begin
		Select E.codigoEmpresa,
			E.nombreEmpresa,
            E.direccion,
            E.telefono
            from Empresas E where E.codigoEmpresa = codEmpre;
    End$$
Delimiter ;*/

/*Delimiter $$
	Create procedure sp_EliminarEmpresa(in codEmpre int)
    Begin
		Delete from Empresas
			where codigoEmpresa = codEmpre;
    End$$
Delimiter ;*/

/*Delimiter $$
	Create procedure sp_EditarEmpresa(in codEmpresa int, in nomEmpresa varchar(150), in dire varchar(150), in tel varchar(10))
    Begin
		Update Empresas E
			Set E.nombreEmpresa = nomEmpresa,
            E.direccion = dire,
            E.telefono = tel
            where E.codigoEmpresa = codEmpresa;
    End$$
Delimiter ;*/

