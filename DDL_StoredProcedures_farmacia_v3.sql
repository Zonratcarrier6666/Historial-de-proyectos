DELIMITER //
CREATE PROCEDURE generarCodigoEmpleado (OUT codigo VARCHAR(8))
BEGIN
		DECLARE anio INT;
		DECLARE mes VARCHAR(2);
		DECLARE num VARCHAR(4);
		SET anio  = RIGHT(year(now()),2);
		SET mes   = LPAD(RIGHT(month(now()),2), 2, '0');
		SET num   = (SELECT LPAD(MAX(idUsuario) + 1, 4, '0') FROM usuario);
		SET codigo= CONCAT(anio,mes,num);
	END //
    DELIMITER ;






DROP PROCEDURE IF EXISTS insertarEmpleado;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarEmpleado`(/* Datos Personales */
                                    IN	var_nombre          VARCHAR(64),    --  1
                                    IN	var_apellidoPaterno VARCHAR(64),    --  2
                                    IN	var_apellidoMaterno VARCHAR(64),    --  3
                                    IN  var_genero          VARCHAR(2),     --  4
                                    IN  var_fechaNacimiento VARCHAR(11),    --  5
                                    IN  var_rfc             VARCHAR(14),    --  6
                                    IN  var_curp            VARCHAR(19),    --  7
                                    IN	var_domicilio       VARCHAR(129),   --  8
                                    IN  var_cp              VARCHAR(11),    --  9
                                    IN  var_ciudad          VARCHAR(46),    -- 10
                                    IN  var_estado          VARCHAR(40),    -- 11
                                    IN	var_telefono        VARCHAR(20),    -- 12
                                    IN	var_foto            LONGTEXT,       -- 13
                                    
                                  /* Datos del la Sucursal */
                                    IN  var_idSucursal      INT,            -- 14
                                    
                                  /* Datos del Usuario    */
                                    IN  var_rol             VARCHAR(10),    -- 15
                                    
                                  /* Datos del Empleado */
                                    IN  var_email           VARCHAR(65),    -- 16
                                    IN  var_puesto          VARCHAR(25),    -- 17
                                    IN  var_salarioBruto    FLOAT,          -- 18
                                  
                                  /* Parametros de Salida */
                                    OUT var_idPersona       INT,            -- 19
                                    OUT var_idUsuario       INT,            -- 20
                                    OUT var_idEmpleado      INT,            -- 21
                                    OUT var_codigoEmpleado  VARCHAR(9)      -- 22
                                 )
BEGIN
        -- Comenzamos insertando los datos de la Persona:
        INSERT INTO persona (nombre, apellidoPaterno, apellidoMaterno, genero,
                             fechaNacimiento, rfc, curp, domicilio, codigoPostal, 
                             ciudad, estado, telefono, foto)
                    VALUES( var_nombre, var_apellidoPaterno, var_apellidoMaterno, 
                            var_genero, STR_TO_DATE(var_fechaNacimiento, '%d/%m/%Y'),
                            var_rfc, var_curp, var_domicilio, var_cp,
                            var_ciudad, var_estado, var_telefono, var_foto);
        
        -- Obtenemos el ID de Persona que se genero:
        SET var_idPersona = LAST_INSERT_ID(); 
        
        -- Generamos el Codigo del Empleado porque lo necesitamos
        -- para generar el usuario:
        CALL generarCodigoEmpleado(var_codigoEmpleado);
        
        -- Insertamos los datos del Usuario que tendra el Empleado:
        INSERT INTO usuario (nombreUsuario, contrasenia, rol)
                    VALUES (var_codigoEmpleado, var_codigoEmpleado, var_rol);
        -- Recuperamos el ID de Usuario generado:
        SET var_idUsuario = LAST_INSERT_ID(); 
        
        -- Insertamos los datos del Empleado:
        INSERT INTO empleado(email, codigo, fechaIngreso, puesto, salarioBruto, activo,
                             idPersona, idUsuario, idSucursal)
                    VALUES(var_email, var_codigoEmpleado, NOW(), var_puesto, var_salarioBruto,
                           1, var_idPersona, var_idUsuario, var_idSucursal);
    END //
    
    DELIMITER;



DROP PROCEDURE IF EXISTS ActualizarEmpleado;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarEmpleado`(
                                        
    IN var_idEmpleado INT, -- Id de empleado  -- 1

    IN var_nombre VARCHAR(64),                -- 2
    IN var_ApellidoPaterno VARCHAR(64),       -- 3
    IN var_ApellidoMaterno VARCHAR(64),       -- 4
    IN var_genero VARCHAR(2),                 -- 5
    IN var_fechaNacimiento VARCHAR(11),       -- 6 
    IN var_rfc VARCHAR(14),                   -- 7
    IN var_curp VARCHAR(19),                  -- 8
    IN var_domicilio VARCHAR(129),            -- 9 
    IN var_cp VARCHAR(11),                    -- 10
    IN var_ciudad VARCHAR(46),                -- 11 
    IN var_estado VARCHAR(40),                -- 12
    IN var_telefono VARCHAR(29),              -- 13
    

    /* Datos de usuario */
   
    IN var_nombreUsuario VARCHAR(33),        -- 14
    IN var_contrasenia VARCHAR(16),          -- 15 
    IN var_rol VARCHAR(10) ,                 -- 16


    /* Datos de empleado */
    IN var_email VARCHAR(65),                -- 17
    IN var_fechaIngreso VARCHAR(11),         -- 18
    IN var_codigo VARCHAR (10),              -- 19
    IN var_puesto VARCHAR(45),               -- 20
    IN var_salarioBruto FLOAT                -- 21
    
  )
BEGIN

   --  Modificar datos de persona ---
    UPDATE persona
    SET nombre = var_nombre,
        apellidoPaterno = var_ApellidoPaterno,
        apellidoMaterno =  var_ApellidoMaterno,
        genero = var_genero,
        fechaNacimiento = var_fechaNacimiento,
        rfc =  var_rfc,
        curp  = var_curp        ,
        domicilio   = var_domicilio   ,
	    codigoPostal  = var_cp   ,
        ciudad       = var_ciudad   ,
        estado       = var_estado    ,
        telefono     = var_telefono  
   WHERE idPersona =(
         SELECT  idPersona 
         FROM    empleado
         WHERE   idEmpleado = var_idEmpleado
      ); 
      
      UPDATE usuario
      SET  nombreUsuario = var_nombreUsuario,
           contrasenia  =  var_contrasenia,
           rol          = var_rol
           WHERE idUsuario = (
           SELECT  idUsuario 
           FROM empleado
           WHERE idEmpleado = var_idEmpleado);
      -- Modificar datos de empleado --
      UPDATE empleado
      SET email = var_email,
		  fechaIngreso =var_fechaIngreso,
          codigo = var_codigo,
          puesto = var_puesto,
          salarioBruto = var_salarioBruto
      WHERE idEmpleado =var_idEmpleado;
         
END 
//
DELIMITER ;
USE sicefa;
DROP PROCEDURE IF EXISTS deleteEmpleado;
DELIMITER //
CREATE PROCEDURE deleteEmpleado(
IN var_idEmpleado INT
)
BEGIN
UPDATE empleado
SET activo = 0
WHERE idEmpleado = var_idEmpleado AND activo = 1;
END
//
DELIMITER; 

-- --  -  - - - - - - - - -  - - - - - - 
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarSucursal`(/* Datos Sucursal */
                                    IN	var_nombre          VARCHAR(49),    --  1
                                    IN	var_titular         VARCHAR(49),    --  2
                                    IN  var_rfc             VARCHAR(15),    --  3                                    
                                    IN	var_domicilio       VARCHAR(129),   --  4
                                    IN  var_colonia         VARCHAR(65),    --  5
                                    IN  var_codigoPostal    VARCHAR(11),    --  6
                                    IN  var_ciudad          VARCHAR(65),    --  7
                                    IN  var_estado          VARCHAR(49),    --  8                                    
                                    IN	var_telefono        VARCHAR(20),    --  9
                                    IN	var_latitud         VARCHAR(65),    -- 10
                                    IN	var_longitud        VARCHAR(65),    -- 11
                                    
                                  /* Parametros de Salida */
                                    OUT  var_idSucursal     INT,            -- 12
                                    OUT  var_idPersona      INT,            -- 13
                                    OUT  var_idUsuario      INT,            -- 14
                                    OUT  var_idEmpleado     INT,            -- 15
                                    OUT  var_codigoEmpleado VARCHAR( 9),    -- 16
                                    OUT  var_nombreUsuario  VARCHAR(33),    -- 17
                                    OUT  var_contrasenia    VARCHAR(33)     -- 18
                                 )
BEGIN
        DECLARE idUsuarioMax INT;
    
        -- Comenzamos insertando los datos de la Sucursal:
        INSERT INTO sucursal(nombre, titular, rfc, domicilio, colonia, codigoPostal,
                             ciudad, estado, telefono, latitud, longitud, estatus)
                    VALUES(var_nombre, var_titular, var_rfc, var_domicilio, var_colonia, var_codigoPostal,
                           var_ciudad, var_estado, var_telefono, var_latitud, var_longitud, 1);
        
        -- Recuperamos el ID de la Sucursal que se genero:
        SET var_idSucursal = LAST_INSERT_ID();
                
        -- Generamos el Codigo del Empleado porque lo necesitamos
        -- para generar el usuario:
        CALL generarCodigoEmpleado(var_codigoEmpleado);
        
        -- Generamos el nombre del Usuario Administrador que por default tendra la Sucursal:
        SET idUsuarioMax      = 1 + (SELECT MAX(idUsuario) FROM usuario);
        SET var_nombreUsuario = CONCAT('Admins', idUsuarioMax);
        SET var_contrasenia   = var_nombreUsuario;
        
        -- Insertamos los datos del Usuario que tendra el Empleado:
        INSERT INTO usuario (nombre, contrasenia, rol)
                    VALUES (var_nombreUsuario, var_contrasenia, 'ADMS');
        
        -- Recuperamos el ID de Usuario generado:
        SET var_idUsuario = LAST_INSERT_ID();
        
        -- Insertamos los datos personales:
        INSERT INTO persona (nombre, apellidoPaterno, apellidoMaterno, genero,
                             fechaNacimiento, rfc, curp, domicilio, codigoPostal, 
                             ciudad, estado, telefono, foto)
                    VALUES( CONCAT('Admins_', var_titular), '', '', 
                            'O', STR_TO_DATE('01/01/1901', '%d/%m/%Y'),
                            '', '', '', '',
                            '', '', '', '');
        
        -- Recuperamos el ID de la Persona que se genero:
        SET var_idPersona = LAST_INSERT_ID();
        
        -- Insertamos los datos del Empleado:
        INSERT INTO empleado(codigo, fechaIngreso, puesto, salarioBruto, activo,
                             idPersona, idUsuario, idSucursal)
                    VALUES(var_codigoEmpleado, NOW(), var_puesto, var_salarioBruto,
                           1, var_idPersona, var_idUsuario, var_idSucursal);
    END
    //
    DELIMITER ;
    
    -- -- -- -- -- -- - 
    DELIMITER  //
    CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarSucursal`(
										 IN var_idSucursal     INT,               
                                         IN var_nombre        VARCHAR(49),          
                                         IN var_tirular       VARCHAR(49),
                                         IN var_rfc           VARCHAR(15),
                                         IN var_domicilio     VARCHAR(129),
                                         IN var_colonia       VARCHAR(65),
                                         IN var_codigoPostal  VARCHAR(11),
                                         IN var_ciudad        VARCHAR(65),
                                         IN var_estado        VARCHAR(49)

										
                                                    )
BEGIN
        UPDATE sucursal
        SET
         nombre = var_nombre,
         titular = var_tirular,
         rfc = var_rfc,
         domicilio = var_domicilio,
         colonia = var_colonia,
         codigoPostal = var_codigoPostal,
         ciudad = var_ciudad,
         estado = var_estado
    WHERE idSucursal =  var_idSucursal ;
         
    END //
    DELIMITER ;
    
DROP PROCEDURE IF EXISTS deleteSucursal;
USE sicefa;
DELIMITER //
CREATE PROCEDURE deleteSucursal(
IN var_idSucursal INT
)
BEGIN
UPDATE sucursal
SET estatus  = 0
WHERE idSucursal = var_idSucursal AND estatus  = 1;
END
//
DELIMITER ;

DELIMITER //

-- Base datos de productos --
-- Actualizar Producto--

DELIMITER //

CREATE PROCEDURE `ActualizarProducto`(
    IN p_idProducto INT,
    IN p_nombre varchar(180),
    IN p_nombreGenerico varchar(200),
    IN p_formaFarmaceutica varchar(100),
    IN p_unidadMedida varchar(25),
    IN p_presentacion varchar(200),
    IN p_principalIndicacion varchar(255),
    IN p_contraindicaciones varchar(255),
    IN p_concentracion varchar(255),
    IN p_unidadesEnvase INT,
    IN p_precioCompra FLOAT,
    IN p_precioVenta FLOAT,
    IN p_foto LONGTEXT,
    IN p_rutaFoto varchar(254),
    IN p_codigoBarras varchar(65)
    
)
BEGIN
    UPDATE producto
    SET
        nombre = p_nombre,
        nombreGenerico = p_nombreGenerico,
        formaFarmaceutica = p_formaFarmaceutica,
        unidadMedida = p_unidadMedida,
        presentacion = p_presentacion,
        principalIndicacion = p_principalIndicacion,
        contraindicaciones = p_contraindicaciones,
        concentracion = p_concentracion,
        unidadesEnvase = p_unidadesEnvase,
        precioCompra = p_precioCompra,
        precioVenta = p_precioVenta,
        foto = p_foto,
        rutaFoto = p_rutaFoto,
        codigoBarras = p_codigoBarras
        
    WHERE
        idProducto = p_idProducto;
END //

DELIMITER ;


-- Store Procedure BorradoLogico producto --
DELIMITER //
CREATE PROCEDURE `BorrarProductoLogico`(
    IN p_idProducto INT
)
BEGIN
    -- Actualizar el estado del producto para indicar que ha sido eliminado lógicamente
    UPDATE producto
    SET estatus = 0 -- Cambia a 0 para indicar inactivo
   	WHERE idProducto = p_idProducto;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS insertarCliente;
DELIMITER $$
CREATE PROCEDURE insertarCliente(              /* DATOS PERSONA */
									IN	var_nombre          VARCHAR(64),    --  1
                                    IN	var_apellidoPaterno VARCHAR(64),    --  2
                                    IN	var_apellidoMaterno VARCHAR(64),    --  3
                                    IN  var_genero          VARCHAR(2),     --  4
                                    IN  var_fechaNacimiento VARCHAR(11),    --  5
                                    IN  var_rfc             VARCHAR(14),    --  6
                                    IN  var_curp            VARCHAR(19),    --  7
                                    IN	var_domicilio       VARCHAR(129),   --  8
                                    IN  var_cp              VARCHAR(11),    --  9
                                    IN  var_ciudad          VARCHAR(46),    -- 10
                                    IN  var_estado          VARCHAR(40),    -- 11
                                    IN	var_telefono        VARCHAR(20),    -- 12
                                    IN	var_foto            LONGTEXT,       -- 13
                                    
                                    
                                                 /* DATOS CLIENTE */
									IN  var_email            VARCHAR(45),   -- 14
                                    
                                    
                                    
                                              /* PARAMETROS DE SALIDA */
									OUT  var_idPersona       INT,			-- 15
                                    OUT  var_idCliente		 INT,			-- 16
                                    OUT var_fechaRegistro    VARCHAR(10)		-- 17
                                    )
BEGIN 
DECLARE fecha_reg DATETIME;
		-- Comenzamos insertando los datos de la Persona:
        INSERT INTO persona (nombre, apellidoPaterno, apellidoMaterno, genero,
                             fechaNacimiento, rfc, curp, domicilio, codigoPostal, 
                             ciudad, estado, telefono, foto)
                    VALUES( var_nombre, var_apellidoPaterno, var_apellidoMaterno, 
                            var_genero, STR_TO_DATE(var_fechaNacimiento, '%d/%m/%Y'),
                            var_rfc, var_curp, var_domicilio, var_cp,
                            var_ciudad, var_estado, var_telefono, var_foto);
                            
		 -- Obtenemos el ID de Persona que se genero:
        SET var_idPersona = LAST_INSERT_ID(); 
        
        -- Insetamos los datos del cliente:
        SET fecha_reg = NOW();
        SET var_fechaRegistro = DATE_FORMAT(fecha_reg, 'YY/mm/dd');
        INSERT INTO cliente (email, fechaRegistro, estatus, idPersona)
					VALUES (var_email,fecha_reg, 1, var_idPersona);
		SET var_idCliente = LAST_INSERT_ID(); 
	END
$$
DELIMITER ;

USE sicefa;
DROP PROCEDURE IF EXISTS modificarCliente;
DELIMITER $$
CREATE PROCEDURE modificarCliente( /* DATOS PERSONA */
									IN var_idCliente 		INT,			--  1 id del cliente a modificar 
                                    

									IN	var_nombre          VARCHAR(64),    --  2
                                    IN	var_apellidoPaterno VARCHAR(64),    --  3
                                    IN	var_apellidoMaterno VARCHAR(64),    --  4
                                    IN  var_genero          VARCHAR(2),     --  5
                                    IN  var_fechaNacimiento VARCHAR(11),    --  6
                                    IN  var_rfc             VARCHAR(14),    --  7
                                    IN  var_curp            VARCHAR(19),    --  8
                                    IN	var_domicilio       VARCHAR(129),   --  9
                                    IN  var_cp              VARCHAR(11),    --  10
                                    IN  var_ciudad          VARCHAR(46),    --  11
                                    IN  var_estado          VARCHAR(40),    --  12
                                    IN	var_telefono        VARCHAR(20),    --  13
                                    IN	var_foto            LONGTEXT,       --  14
                                    
									/* DATOS CLIENTE */
									IN  var_email            VARCHAR(45)	--  15
                                    )
BEGIN 
	-- Modificar los datos de la persona asociada al cliente
    UPDATE persona
    SET nombre = var_nombre,
		apellidoPaterno = var_apellidoPaterno,
        apellidoMaterno = var_apellidoMaterno,
        genero = var_genero,
        fechaNacimiento = var_fechaNacimiento, 
        rfc = var_rfc,
        curp = var_curp,
        domicilio = var_domicilio,
        codigoPostal = var_cp,
        ciudad = var_ciudad,
        estado = var_estado,
        telefono = var_telefono,
        foto = var_foto 
	WHERE idPersona = (
						SELECT idPersona
                        FROM cliente
                        WHERE idCliente = var_idCliente
					  );
                      
	-- Modificar los datos del cliente
   UPDATE cliente
   SET email = var_email
   WHERE idCliente = var_idCliente;
END
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS deleteCliente;
DELIMITER $$
CREATE PROCEDURE deleteCliente(
								IN var_idCliente INT
                                )
BEGIN 
	UPDATE cliente 
    SET estatus = 0
    WHERE idCliente = var_idCliente AND estatus = 1;
END
$$
DELIMITER ;


