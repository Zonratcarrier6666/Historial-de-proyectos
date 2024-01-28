USE sicefa;

DROP VIEW IF EXISTS v_empleado;
CREATE VIEW v_empleado AS
    SELECT  
            E.idEmpleado,
            E.email,
            E.codigo,
            DATE_FORMAT(E.fechaIngreso, '%Y-%m-%d') AS fechaIngreso,
            E.puesto,
            E.salarioBruto,
            E.activo,
            P.*,
            U.*,
            S.idSucursal,
            S.nombre AS nombreSucursal,
            S.titular,
            S.rfc AS rfc_sucursal,
            S.domicilio AS domicilio_sucursal,
            S.colonia AS colonia_sucursal,
            S.codigoPostal AS cp_sucursal,
            S.ciudad AS ciudad_sucursal,
            S.estado AS estado_sucursal,
            S.telefono AS telefono_sucursal,
            S.latitud,
            S.longitud,
            S.estatus AS estatus_sucursal
    FROM    empleado E
            INNER JOIN  persona  P ON P.idPersona = E.idPersona 
            INNER JOIN  usuario  U ON U.idUsuario = E.idUsuario
            INNER JOIN  sucursal S ON S.idSucursal = E.idSucursal 
            WHERE activo  = 1 ;
            
   DROP VIEW IF EXISTS v_sucursal;
   CREATE VIEW v_sucursal AS
   SELECT 
         S.idSucursal,
         S.nombre,
         S.titular,
         S.rfc,
         S.domicilio,
         S.colonia,
         S.codigoPostal,
         S.ciudad,
         S.estado,
         S.telefono,
         S.latitud,
         S.longitud,
         S.estatus
		 FROM sucursal S
         WHERE estatus = 1;
       ;
         
            
CREATE VIEW v_inventario AS


SELECT
    I.idInventario,
    PR.idProducto,
    S.idSucursal,
    PR.nombre AS nombreProducto,
    PR.nombreGenerico,
    PR.formaFarmaceutica,
    PR.unidadMedida,
    PR.presentacion,
    PR.principalIndicacion,
    PR.contraindicaciones,
    PR.concentracion,
    PR.unidadesEnvase,
    PR.precioCompra,
    PR.precioVenta,
    S.nombre AS nombreSucursal,
    S.titular,
    S.rfc AS rfc_sucursal,
    S.domicilio AS domicilio_sucursal,
    S.colonia AS colonia_sucursal,
    S.ciudad AS ciudad_sucursal,
    S.estado AS estado_sucursal,
    S.telefono AS telefono_sucursal,
    S.latitud,
    S.longitud,
    S.estatus AS estatus_sucursal
FROM inventario I
INNER JOIN producto PR ON PR.idProducto = I.idProducto
INNER JOIN sucursal S ON S.idSucursal = I.idSucursal;

DROP VIEW v_productos ;
-- Vista de productos --
-- Vista de productos --
CREATE VIEW `sicefa`.`v_productos` AS
    SELECT 
        `p`.`idProducto` AS `idProducto`,
        `p`.`nombre` AS `nombre`,
        `p`.`nombreGenerico` AS `nombreGenerico`,
        `p`.`formaFarmaceutica` AS `formaFarmaceutica`,
        `p`.`unidadMedida` AS `unidadMedida`,
        `p`.`presentacion` AS `presentacion`,
        `p`.`principalIndicacion` AS `principalIndicacion`,
        `p`.`contraindicaciones` AS `contraindicaciones`,
        `p`.`concentracion` AS `concentracion`,
        `p`.`unidadesEnvase` AS `unidadesEnvase`,
        `p`.`precioCompra` AS `precioCompra`,
        `p`.`precioVenta` AS `precioVenta`,
        `p`.`foto` AS `foto`,
        `p`.`rutaFoto` AS `rutaFoto`,
        `p`.`codigoBarras` AS `codigoBarras`,
        `p`.`estatus` AS `estatus`
    FROM
        `sicefa`.`producto` `p`
        WHERE `estatus` = 1;
        
        DROP VIEW IF EXISTS v_cliente;
CREATE VIEW v_cliente AS 
	SELECT 
			C.idCliente,
            C.email, 
            DATE_FORMAT(C.fechaRegistro, '%Y-%m-%d') AS fechaRegistro,
            C.estatus,
            P.*
	FROM cliente C
		 INNER JOIN persona P ON P.idPersona = C.idPersona
         WHERE estatus = 1;
