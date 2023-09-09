/*
Nombre: Luis Mario Monterroso Juarez
Código Técnico: IN5BV
Carné: 2022135
Fecha de Creación: 30-03-2023
Fecha de Modificación: 28-04-2023
Fecha de Modificación: 12-05-2023  
*/
Drop database if exists DBTonysKinal2023;

Create database DBTonysKinal2023;
Use DBTonysKinal2023;

Create table Empresas(
	codigoEmpresa int auto_increment not null,
    nombreEmpresa varchar(150) not null,
    direccion varchar(150) not null,
    telefono varchar(10) not null,
    primary key PK_codigoEmpresa(codigoEmpresa) 
);

Create table TipoEmpleado(
	codigoTipoEmpleado int not null auto_increment,
    descripcion varchar(50) not null,
    primary key PK_codigoTipoEmpleado (codigoTipoEmpleado)
);
/*
Create table Empleados(
	codigoEmpleado int auto_increment not null,
    numeroEmpleado int not null,
    apellidosEmpleado varchar(150) not null,
    nombresEmpleado varchar(150) not null,
    direccionEmpleado varchar(150) not null,
    telefonoContacto varchar(10) not null,
    gradoCocinero varchar(50) not null,
    codigoTipoEmpleado int not null,
    
    primary key PK_codigoEmpleado(codigoEmpleado),
    constraint FK_Empleados_tipoEmpleado foreign key
    (codigoTipoEmpleado) references TipoEmpleado(codigoTipoEmpleado)
);
*/
Create table TipoPlato(
	codigoTipoPlato int auto_increment not null,
    descripcionTipo varchar(100) not null,
    primary key PK_codigoTipoPlato (codigoTipoPlato)
);

Create table Productos(
	codigoProducto int not null,
	nombreProducto varchar(150) not null,
    cantidad int not null,
    
    primary key PK_codigoProducto (codigoProducto)
);
/*
Create table Servicios(
	codigoServicio int auto_increment not null,
    fechaServicio date not null,
    tipoServicio varchar(150) not null,
    horaServicio time not null,
    lugarServicio varchar(150) not null,
    telefonoContacto varchar(10) not null,
    codigoEmpresa int not null,
    
    primary key PK_codigoServicio(codigoServicio),
    constraint FK_Servicios_Empresas foreign key (codigoEmpresa)
		references Empresas(codigoEmpresa)
);
*/ 

Create table Presupuestos(
	codigoPresupuesto int auto_increment not null,
    fechaSolicitud date not null,
    cantidadPresupuesto decimal(10,2) not null,
    codigoEmpresa int not null,
    primary key PK_Presupuestos_codigoPresupuesto (codigoPresupuesto),
    constraint FK_Presupuesto_Empresas foreign key (codigoEmpresa)
    references Empresas (codigoEmpresa) on delete cascade
);
/*
Create table Platos(
	codigoPlato int auto_increment not null,
    cantidad int not null,
    nombrePlato varchar(50) not null,
    descripcionPlato varchar(150) not null,
    precioPlato decimal(10,2) not null,
    codigoTipoPlato int not null,
	-- tipoPlato_codigoTipoPlato int not null,
    primary key PK_codigoPlato (codigoPlato),
	constraint FK_Platos_TipoPlato1 foreign key (codigoTipoPlato)
		references TipoPlato(codigoTipoPlato)
);

Create table Productos_has_Platos(
	Productos_codigoProducto int not null,
    codigoPlato int not null,
    codigoProducto int not null,
    primary key PK_Productos_codigoProducto(Productos_codigoProducto),
    constraint FK_Productos_has_Platos_Productos1 foreign key (codigoProducto)
		references Productos(codigoProducto),
	constraint FK_Productos_has_Platos_Platos1 foreign key (codigoPlato)
		references Platos(codigoPlato)    
);

Create table Servicios_has_Platos(
	Servicios_codigoServicio int not null,
    codigoPlato int not null,
    codigoServicio int not null,
    
    primary key PK_Servicios_codigoServicio (Servicios_codigoServicio),
	constraint FK_Servicios_has_Platos_Servicios1 foreign key (codigoServicio)
		references Servicios(codigoServicio),
	constraint FK_Servicios_has_Platos_Platos1 foreign key (codigoPlato)
		references Platos(codigoPlato)
);

Create table Servicios_has_Empleados(
	Servicios_codigoServicio int not null,
    codigoServicio int not null,
    codigoEmpleado int not null,
    fechaEvento date not null,
    horaEvento time not null,
    lugarEvento varchar(150) not null,
    
    primary key PK_Servicios_codigoServicio (Servicios_codigoServicio),
    constraint FK_Servicios_has_Empleados_Servicios1 foreign key (codigoServicio)
		references Servicios(codigoServicio),
	constraint FK_Servicios_has_Empleados_Empleados1 foreign key (codigoEmpleado)
		references Empleados(codigoEmpleado)
);*/
-- //////////////////////////////////// CRUD ///////////////////////////////////////// 
-- ----- Agregar ---------------------------------------------------------------------
-- -----------------------------------------------------------------------------------
Delimiter $$
create procedure sp_AgregarEmpresa(in nomEmp varchar(150), in direc varchar(150), in tel varchar(10))
	Begin
    Insert into Empresas(nombreEmpresa, direccion, telefono)
		values (nomEmp, direc, tel);
    End$$
Delimiter ;

call sp_AgregarEmpresa('McDonals',' Zona 11, Cdad. de Guatemala','2360 6363');
call sp_AgregarEmpresa('KFC','0calle 16-20zona 4 Metrocentro, Villa Nueva','2424 2424');
call sp_AgregarEmpresa('Chilis','21 Avenida 33-04, Cdad. de Guatemala','4072 4579');
-- -----------------------------------------------------------------------------------
Delimiter $$
create procedure sp_AgregarTipoEmpleado(in descrip varchar(50))
	Begin
		Insert into TipoEmpleado(descripcion)
			values (descrip);
	End$$
Delimiter ;

call sp_AgregarTipoEmpleado('Supervisor');
call sp_AgregarTipoEmpleado('Cocinero');
call sp_AgregarTipoEmpleado('Camarero');
-- ----------------------------------------------------------------------------------
/*
Delimiter $$
create procedure sp_AgregarEmpleado(in numEmpd int, in apellEmpd varchar(150), in nomEmpd varchar(150),
									in direcEmpd varchar(150), in telCon varchar(10),
                                    in gradCocinero varchar(50), in codTipoEmpleado int)
	Begin
		Insert into Empleados(numeroEmpleado, apellidosEmpleado, nombresEmpleado, direccionEmpleado,
							  telefonoContacto, gradoCocinero, codigoTipoEmpleado)
			values(numEmpd, apellEmpd, nomEmpd, direcEmpd, telCon, gradCocinero, codTipoEmpleado);
    End$$
Delimiter ;

call sp_AgregarEmpleado(123, 'Morales', 'Emily', 'wefq22d2', '43210987', 'alto', '1');
call sp_AgregarEmpleado(234, 'Morales', 'Emily', 'wefq22d2', '43210987', 'alto', '1');
call sp_AgregarEmpleado(345, 'Morales', 'Emily', 'wefq22d2', '43210987', 'alto', '1');
*/
-- -----------------------------------------------------------------------------------
Delimiter $$
create procedure sp_AgregarTipoPlato(in descTipo varchar(100))
	Begin
		Insert into TipoPlato(descripcionTipo)
			values(descTipo);
	End$$
Delimiter ;

call sp_AgregarTipoPlato('vegetariano');
call sp_AgregarTipoPlato('Italiano');
call sp_AgregarTipoPlato('Postre');
-- ----------------------------------------------------------------------------------
Delimiter $$
create procedure sp_AgregarProducto(in codProd int, in nomProd varchar(150), in cant int)
	Begin
		Insert into Productos(codigoProducto, nombreProducto, cantidad)
			values(codProd, nomProd, cant);
    End$$
Delimiter ;

call sp_AgregarProducto(11, 'Libras de Tomate', 50);
call sp_AgregarProducto(12, 'Libras de pasta', 12);
call sp_AgregarProducto(13, 'Libras de azucar', 70);
-- -----------------------------------------------------------------------------------
/*
Delimiter $$
Create procedure sp_AgregarServicio(in fecServ date, in tipoServ varchar(150), in horaServ time,
									in lugServ varchar(150), in telCon varchar(10), in codEmp int) 
	Begin
		Insert into Servicios(fechaServicio, tipoServicio, horaServicio, lugarServicio,
							  telefonoContacto, codigoEmpresa)
			values(fecServ, tipoServ, horaServ, lugServ, telCon, codEmp);
    End$$
Delimiter ;

call sp_AgregarServicio('2022-05-05','cumpleanios','00:02:10', 'casa', '1231312', 1);
call sp_AgregarServicio('2022-05-05','bautizo','00:02:10', 'casa', '1231312', 1);
call sp_AgregarServicio('2022-05-05','boda','00:02:10', 'casa', '1231312', 1);
*/
-- -----------------------------------------------------------------------------------

Delimiter $$
Create procedure sp_AgregarPresupuesto(in fecSoli date, in cantPres decimal(10,2), in codEmp int)
	Begin
		Insert into Presupuestos(fechaSolicitud, cantidadPresupuesto, codigoEmpresa)
			values(fecSoli, cantPres, codEmp);
    End$$
Delimiter ;

call sp_AgregarPresupuesto('2021-12-17', 300.50, 1);
call sp_AgregarPresupuesto('2021-12-17', 300.50, 3);
call sp_AgregarPresupuesto('2021-12-17', 300.50, 1);
/*
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_AgregarPlato(in cant int, in nomPlato varchar(50), in descrPlato varchar(150),
								 in precioPlato decimal(10,2), in codTipoPlato int)
	Begin
		Insert into Platos(cantidad, nombrePlato, descripcionPlato, precioPlato, codigoTipoPlato)
			values(cant, nomPlato, descrPlato, precioPlato, codTipoPlato);
    End$$
Delimiter ;

call sp_AgregarPlato(12, 'lenguene', 'afasdf', 65.50, 1);
call sp_AgregarPlato(12, 'lenguene', 'afasdf', 65.50, 1);
call sp_AgregarPlato(12, 'lenguene', 'afasdf', 65.50, 1);


-- ----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_AgregarProductos_has_Platos(in Productos_codProd int, in codPlato int, in codProducto int)
	Begin
		Insert into Productos_has_Platos(Productos_codigoProducto, codigoPlato, codigoProducto)
			values (Productos_codProd, codPlato, codProducto);
    End$$
Delimiter ;

call sp_AgregarProductos_has_Platos(111, 1, 11);
call sp_AgregarProductos_has_Platos(112, 1, 11);
call sp_AgregarProductos_has_Platos(113, 1, 11);
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_AgregarServicios_has_Platos(in Servicios_codServ int, in codPlato int, in codServicio int)
	Begin
		Insert into Servicios_has_Platos(Servicios_codigoServicio, codigoPlato, codigoServicio)
			values (Servicios_codServ, codPlato, codServicio); 
    End$$
Delimiter ; 

call sp_AgregarServicios_has_Platos(221, 1, 1);

call sp_AgregarServicios_has_Platos(222, 1, 1);
call sp_AgregarServicios_has_Platos(223, 1, 1);
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_AgregarServicios_has_Empleados(in Servicios_codServ int, in codServicio int, in codEmpleado int,
												   in fecEvento date, in horaEvento time, in lugEvento varchar(150))
	Begin
		Insert into Servicios_has_Empleados(Servicios_codigoServicio, codigoServicio, codigoEmpleado,
											fechaEvento, horaEvento, lugarEvento)
			values(Servicios_codServ, codServicio, codEmpleado, fecEvento, horaEvento, lugEvento);
    End$$
Delimiter ;

call sp_AgregarServicios_has_Empleados(331, 1, 1, '2022-03-30', '00:30:59', 'casaaa');
call sp_AgregarServicios_has_Empleados(332, 1, 1, '2022-03-30', '00:30:59', 'casaaa');
call sp_AgregarServicios_has_Empleados(333, 1, 1, '2022-03-30', '00:30:59', 'casaaa');
*/
-- -----------------------------------------------------------------------------------
-- ----- Listar ----------------------------------------------------------------------
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_ListarEmpresas()
Begin
	Select Eps.codigoEmpresa, Eps.nombreEmpresa, Eps.direccion, Eps.telefono
		from Empresas Eps;
End$$
Delimiter ;

call sp_ListarEmpresas();
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_ListarTipoEmpleados()
Begin
	Select TE.codigoTipoEmpleado, TE.descripcion
		from TipoEmpleado TE;
End$$
Delimiter ;

call sp_ListarTipoEmpleados();
-- -----------------------------------------------------------------------------------
/*
Delimiter $$
Create procedure sp_ListarEmpleados()
Begin
	Select E.codigoEmpleado, E.numeroEmpleado, E.apellidosEmpleado, E.nombresEmpleado,
			E.direccionEmpleado, E.telefonoContacto, E.gradoCocinero, TE.codigoTipoEmpleado
	from Empleados E
    Inner join TipoEmpleado TE on TE.codigoTipoEmpleado;
End$$
Delimiter ;

call sp_ListarEmpleados();
*/
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_ListarTipoPlatos()
Begin
	Select codigoTipoPlato, descripcionTipo
    from TipoPlato;
End$$
Delimiter ;

call sp_ListarTipoPlatos();
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_ListarProductos()
Begin
	Select Prod.codigoProducto, Prod.nombreProducto, Prod.cantidad
    from Productos Prod;
End$$
Delimiter ;

call sp_ListarProductos();
-- -----------------------------------------------------------------------------------
/*
Delimiter $$
Create procedure sp_ListarServicios()
Begin
	Select S.codigoServicio, S.fechaServicio, S.tipoServicio, S.horaServicio,
			S.lugarServicio, S.telefonoContacto, S.codigoEmpresa, Eps.nombreEmpresa
	from Servicios S
	Inner join Empresas Eps on Eps.codigoEmpresa = S.codigoEmpresa;
End$$
Delimiter ;

call sp_ListarServicios();
*/
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_ListarPresupuestos()
Begin
	Select Pst.codigoPresupuesto, Pst.fechaSolicitud, Pst.cantidadPresupuesto, 
			Pst.codigoEmpresa
	from Presupuestos Pst;
End$$
Delimiter ;

call sp_ListarPresupuestos();
/*
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_ListarPlatos()
Begin
	Select P.codigoPlato, P.cantidad, P.nombrePlato, P.descripcionPlato,
			P.precioPlato, P.codigoTipoPlato, TP.descripcionTipo
	from Platos P
    Inner join TipoPlato TP on TP.codigoTipoPlato = P.codigoTipoPlato; 
End$$
Delimiter ;

call sp_ListarPlatos();
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_ListarProductos_has_Platos()
Begin
	Select Ph_P.Productos_codigoProducto, Ph_P.codigoPlato, P.nombrePlato,
			Ph_P.codigoProducto, Prod.nombreProducto
	From Productos_has_Platos Ph_P
    Inner join	Platos P on P.codigoPlato = Ph_P.codigoPlato
    Inner join  Productos Prod on Prod.codigoProducto = Ph_P.codigoProducto ;
End$$
Delimiter ;
 
call sp_ListarProductos_has_Platos();
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_ListarServicios_has_Platos()
Begin
	Select Sh_P.Servicios_codigoServicio, Sh_P.codigoPlato, P.nombrePlato,
		Sh_P.codigoServicio, S.tipoServicio
        From Servicios_has_Platos Sh_P
        Inner join Platos P on P.codigoPlato = Sh_P.codigoPlato
        Inner join Servicios S on S.codigoServicio = Sh_P.codigoServicio;
End$$
Delimiter ;

call sp_ListarServicios_has_Platos();
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_ListarServicios_has_Empleados()
Begin
	Select Sh_E.Servicios_codigoServicio, Sh_E.codigoServicio, S.tipoServicio, Sh_E.codigoEmpleado,
			E.apellidosEmpleado, E.nombresEmpleado, Sh_E.fechaEvento, Sh_E.horaEvento, Sh_E.lugarEvento
	from Servicios_has_Empleados Sh_E
    Inner join 	Servicios S on S.codigoServicio = Sh_E.codigoServicio
    Inner join Empleados E on E.codigoEmpleado = Sh_E.codigoEmpleado;
End$$
Delimiter ;

call sp_ListarServicios_has_Empleados();
*/
-- -----------------------------------------------------------------------------------
-- ----- Buscar ----------------------------------------------------------------------

Delimiter $$
Create procedure sp_BuscarEmpresa(in id int)
Begin
	Select Eps.codigoEmpresa, Eps.nombreEmpresa, Eps.direccion, Eps.telefono
	from Empresas Eps
        where id = Eps.codigoEmpresa;
End$$
Delimiter ;

call sp_BuscarEmpresa(3);
/*
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_BuscarTipoEmpleado(in id int)
Begin
	Select TE.codigoTipoEmpleado, TE.descripcion
	from TipoEmpleado TE
        where id = TE.codigoTipoEmpleado;
End$$
Delimiter ;

call sp_BuscarTipoEmpleado(3);
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_BuscarEmpleado(in id int)
Begin
	select E.codigoEmpleado, E.numeroEmpleado, E.apellidosEmpleado, E.nombresEmpleado,
			E.direccionEmpleado, E.telefonoContacto, E.gradoCocinero, TE.codigoTipoEmpleado
	from Empleados E
    Inner join TipoEmpleado TE on TE.codigoTipoEmpleado
		where id = E.codigoEmpleado;
End$$
Delimiter ;

call sp_BuscarEmpleado(1);
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_BuscarTipoPlato(in id int)
Begin
	Select TP.codigoTipoPlato, TP.descripcionTipo
    from TipoPlato TP
		where id = TP.codigoTipoPlato;
End$$
Delimiter ;

call sp_BuscarTipoPlato(3);
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_BuscarProducto(in id int)
Begin
	Select Prod.codigoProducto, Prod.nombreProducto, Prod.cantidad
    from Productos Prod
		where id = Prod.codigoProducto;
End$$
Delimiter ;

call sp_BuscarProducto(11);
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_BuscarServicio(in id int)
Begin
	Select S.codigoServicio, S.fechaServicio, S.tipoServicio, S.horaServicio,
			S.lugarServicio, S.telefonoContacto, S.codigoEmpresa
	from Servicios S
	Inner join Empresas Eps on Eps.codigoEmpresa = S.codigoEmpresa
		where id = S.codigoServicio;
End$$
Delimiter ;

call sp_BuscarServicio(1);
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_BuscarPresupuesto(in id int)
Begin
	Select Pst.codigoPresupuesto, Pst.fechaSolicitud, Pst.cantidadPresupuesto, 
			Pst.codigoEmpresa, Eps.nombreEmpresa
	from Presupuestos Pst
    Inner join Empresas Eps on Pst.codigoEmpresa = Eps.codigoEmpresa
		where id = Pst.codigoEmpresa;
End$$
Delimiter ;

call sp_BuscarPresupuesto(1);
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_BuscarPlato(in id int )
Begin
	Select P.codigoPlato, P.cantidad, P.nombrePlato, P.descripcionPlato,
			P.precioPlato, P.codigoTipoPlato, TP.descripcionTipo
	from Platos P
    Inner join TipoPlato TP on TP.codigoTipoPlato = P.codigoTipoPlato
		where id = P.codigoPlato; 
End$$
Delimiter ;

call sp_BuscarPlato(1);
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_BuscarProductos_has_Plato(in id int)
Begin
	Select Ph_P.Productos_codigoProducto, Ph_P.codigoPlato, P.nombrePlato,
			Ph_P.codigoProducto, Prod.nombreProducto
	From Productos_has_Platos Ph_P
    Inner join	Platos P on P.codigoPlato = Ph_P.codigoPlato
    Inner join  Productos Prod on Prod.codigoProducto = Ph_P.codigoProducto 
		where id = Ph_P.Productos_codigoProducto;
End$$
Delimiter ;
 
call sp_BuscarProductos_has_Plato(111);
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_BuscarServicios_has_Plato(in id int)
Begin
	Select Sh_P.Servicios_codigoServicio, Sh_P.codigoPlato, P.nombrePlato,
		Sh_P.codigoServicio, S.tipoServicio
        From Servicios_has_Platos Sh_P
        Inner join Platos P on P.codigoPlato = Sh_P.codigoPlato
        Inner join Servicios S on S.codigoServicio = Sh_P.codigoServicio;
End$$
Delimiter ;

call sp_BuscarServicios_has_Plato(222);
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_BuscarServicios_has_Empleado(in id int)
Begin
	Select Sh_E.Servicios_codigoServicio, Sh_E.codigoServicio, S.tipoServicio, Sh_E.codigoEmpleado,
			E.apellidosEmpleado, E.nombresEmpleado, Sh_E.fechaEvento, Sh_E.horaEvento, Sh_E.lugarEvento
	from Servicios_has_Empleados Sh_E
    Inner join 	Servicios S on S.codigoServicio = Sh_E.codigoServicio
    Inner join Empleados E on E.codigoEmpleado = Sh_E.codigoEmpleado
		where Sh_E.Servicios_codigoServicio = id;
End$$
Delimiter ;

call sp_BuscarServicios_has_Empleado(333);
*/
-- -----------------------------------------------------------------------------------
-- ----- Eliminar --------------------------------------------------------------------
-- shp
/*
Delimiter $$
Create procedure sp_EliminarServicios_has_Plato(in id int)
Begin
	Delete from  Servicios_has_Platos where id = Servicios_codigoServicio;
End$$
Delimiter ;

call sp_EliminarServicios_has_Plato(1);
-- she
Delimiter $$
Create procedure sp_EliminarServicios_has_Empleado(in id int)
Begin 
	Delete from Servicios_has_Empleados where id = Servicios_codigoServicio;
End$$
Delimiter ;

call sp_EliminarServicios_has_Empleado(1);
-- php
Delimiter $$
Create procedure sp_EliminarProductos_has_Plato(in id int)
Begin
	Delete from Productos_has_Platos where id = Productos_codigoProducto;
End$$
Delimiter ;

call sp_EliminarProductos_has_Plato(1);
*/-- presupuesto
Delimiter $$
Create procedure sp_EliminarPresupuesto(in id int)
Begin
	Delete from  Presupuestos where codigoPresupuesto = id;
End$$
Delimiter ;

call sp_EliminarPresupuesto(4);
/*
-- servicios
Delimiter $$
Create procedure sp_EliminarServicio(in id int)
Begin
	Delete from Servicios where id = codigoServicio;
End$$
Delimiter ;  

call sp_EliminarServicio(10);
-- plato
Delimiter $$
Create procedure sp_EliminarPlato(in id int)
Begin
Delete from Platos where id = codigoPlato;
End$$
Delimiter ;

call sp_EliminarPlato(10);
-- empleado
Delimiter $$
Create procedure sp_EliminarEmpleado(in id int)
Begin
	Delete from Empleados where id = codigoEmpleado;
End$$
Delimiter ;

call sp_EliminarEmpleado(10);
*/
-- empresa
Delimiter $$
Create procedure sp_EliminarEmpresa(in id int)
Begin
	Delete from Empresas  where id =  codigoEmpresa;
End$$
Delimiter ;

call sp_ListarEmpresas();
call sp_EliminarEmpresa(10);
-- producto
Delimiter $$
Create procedure sp_EliminarProducto(in id int)
Begin
	Delete from Productos where id = codigoProducto;
End$$
Delimiter ;

call sp_EliminarProducto(10);
-- tipo plato
Delimiter $$
Create procedure sp_EliminarTipoPlato(in id int)
Begin
	Delete from TipoPlato where codigoTipoPlato = id;
End$$ 
Delimiter ;

call sp_EliminarTipoPlato(10);
-- tipo empleado
Delimiter $$
Create procedure sp_EliminarTipoEmpleado(in id int)
Begin
	Delete from TipoEmpleado where codigoTipoEmpleado = id;
End$$
Delimiter ;

call sp_EliminarTipoEmpleado(10);
-- -----------------------------------------------------------------------------------
-- ----- Editar ------------------------------------------------------------------
Delimiter $$
create procedure sp_EditarEmpresa(in id int ,in nomEmp varchar(150), in direc varchar(150), in tel varchar(10))
Begin
    Update Empresas set nombreEmpresa = nomEmp, direccion= direc , telefono = tel
		where id = codigoEmpresa;
End$$
Delimiter ;
-- 
Delimiter $$
create procedure sp_EditarTipoEmpleado(in id int, in descrip varchar(50))
	Begin
		Update TipoEmpleado set descripcion = descrip
			where id = codigoTipoEmpleado;
	End$$
Delimiter ;

--
/*
Delimiter $$
create procedure sp_EditarEmpleado(in id int, in numEmpd int, in apellEmpd varchar(150), in nomEmpd varchar(150),
									in direcEmpd varchar(150), in telCon varchar(10),
                                    in gradCocinero varchar(50), in codTipoEmpleado int)
	Begin
		Update Empleados set numeroEmpleado = numEmpd, apellidosEmpleado = apellEmpd, nombresEmpleado = nomEmpd,
							direccionEmpleado = direcEmpd, telefonoContacto = telCon, gradoCocinero = gradCocinero,
                            codigoTipoEmpleado = codTipoEmpleado
			where id = codigoEmpleado;
    End$$
Delimiter ;

call sp_EditarEmpleado(1,123, 'AAAAAA', 'Emily', 'wefq22d2', '43210987', 'alto', '1');
*/
-- 
Delimiter $$
create procedure sp_EditarTipoPlato(in id int,in descTipo varchar(100))
	Begin
		Update TipoPlato set descripcionTipo = descTipo
			where id = codigoTipoPlato;
	End$$
Delimiter ;

-- ----------------------------------------------------------------------------------
Delimiter $$
create procedure sp_EditarProducto(in id int, in nomProd varchar(150), in cant int)
	Begin
		Update Productos set nombreProducto = nomProd, cantidad = cant
			 where codigoProducto = id;
    End$$
Delimiter ;

-- -----------------------------------------------------------------------------------
/*
Delimiter $$
Create procedure sp_EditarServicio(in id int, in fecServ date, in tipoServ varchar(150), in horaServ time,
									in lugServ varchar(150), in telCon varchar(10), in codEmp int) 
	Begin
		Update Servicios set fechaServicio = fecServ, tipoServicio = tipoServ, horaServicio = horaServ, 
							lugarServicio = lugServ, telefonoContacto = telCon, codigoEmpresa = codEmp
			where id = codigoServicio;
    End$$
Delimiter ;

call sp_EditarServicio(1,'2022-05-05','cumpleanios','00:02:10', 'casa', '1231312', 1);
-- -----------------------------------------------------------------------------------
*/
Delimiter $$
Create procedure sp_EditarPresupuesto(in id int, in fecSoli date, in cantPres decimal(10,2), in codEmp int)
	Begin
		Update Presupuestos set fechaSolicitud = fecSoli, cantidadPresupuesto = cantPres, codigoEmpresa = codEmp
			where id = codigoPresupuesto;
    End$$
Delimiter ;

call sp_EditarPresupuesto(1,'2021-12-17', 300.50, 1);
/*
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_EditarPlato(in id int,in cant int, in nomPlato varchar(50), in descrPlato varchar(150),
								 in precioPlato decimal(10,2), in codTipoPlato int)
	Begin
		Update Platos set cantidad = cant, nombrePlato = nomPlato, descripcionPlato = descrPlato,
						precioPlato = precioPlato, codigoTipoPlato = codTipoPlato
			where id = codigoPlato;
    End$$
Delimiter ;

call sp_EditarPlato(1,12, 'lenguene', 'afasdf', 65.50, 1);
-- ----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_EditarProductos_has_Plato(in id int, in codPlato int, in codProducto int)
	Begin
		Update Productos_has_Platos set codigoPlato = codPlato, codigoProducto = codProducto
			where Productos_codigoProducto = id;
    End$$
Delimiter ;

call sp_EditarProductos_has_Plato(11, 1123, 1);
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_EditarServicios_has_Plato(in id int, in codPlato int, in codServicio int)
	Begin
		Update Servicios_has_Platos set codigoPlato = codPlato, codigoServicio = codServicio
			where id = Servicios_codigoServicio; 
    End$$
Delimiter ; 

call sp_EditarServicios_has_Plato(222, 1, 1);
-- -----------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_EditarServicios_has_Empleado(in id int, in codServicio int, in codEmpleado int,
												   in fecEvento date, in horaEvento time, in lugEvento varchar(150))
Begin
	Update Servicios_has_Empleados set codigoServicio = codServicio, codigoEmpleado = codEmpleado,
									fechaEvento = fecEvento, horaEvento = horaEvento, lugarEvento = lugEvento
		where Servicios_codigoServicio = id;
End$$
Delimiter ;

call sp_EditarServicios_has_Empleado(333, 1, 1, '2022-03-30', '00:30:59', 'BBBB');
*/

call sp_ListarEmpresas();
call sp_ListarProductos();
call sp_ListarTipoPlatos();
call sp_ListarTipoEmpleados();
call sp_ListarPresupuestos();


