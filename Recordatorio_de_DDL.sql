CREATE DATABASE ventas;
USE ventas;
CREATE TABLE depto(
	clave_Depto   INT UNSIGNED NOT NULL,
	nombre_Depto  VARCHAR(14) NOT NULL,
	ubicacion 	  VARCHAR(13),
	CONSTRAINT dept_clave_Depto_pk PRIMARY KEY (clave_Depto)
);
CREATE TABLE emp(
	clave_Emp 	INT UNSIGNED NOT NULL,
	nombre_Emp 	VARCHAR(10) NOT NULL,
	puesto 		VARCHAR(15),
	jefe 		INT UNSIGNED NOT NULL,
	fecha_Inicio DATE,
	salario 	FLOAT UNSIGNED NOT NULL,
	comision 	INT UNSIGNED,
	clave_Depto INT UNSIGNED NOT NULL,
	CONSTRAINT emp_clave_Emp_pk PRIMARY KEY (clave_Emp),
	CONSTRAINT emp_jefe_fk  FOREIGN KEY (jefe) REFERENCES emp (clave_Emp),
	CONSTRAINT emp_clave_Depto_fk FOREIGN KEY (clave_Depto) REFERENCES depto (clave_Depto)
);

CREATE TABLE tabla_Salarios(
	clave_Grado 			INT UNSIGNED,
	salario_Lim_Inferior 	INT UNSIGNED,
	salario_Lim_Superior 	INT UNSIGNED,
	CONSTRAINT tabla_Salarios_clave_Grado_pk PRIMARY KEY (clave_Grado)
);

CREATE TABLE productos(
	clave_Producto 	INT UNSIGNED NOT NULL,
	descripcion		VARCHAR(30) NOT NULL,
	CONSTRAINT prod_clave_Producto_pk PRIMARY KEY (clave_Producto)
);

CREATE TABLE clientes(
	clave_Cliente 	INT UNSIGNED NOT NULL,
	nombre 			VARCHAR(50) NOT NULL,
	direccion 		VARCHAR(40),
	ciudad 			VARCHAR(30),
	estatus 		VARCHAR(2),
	cod_Postal 		VARCHAR(9),
	area 			INT UNSIGNED,
	telefono 		VARCHAR(9),
	clave_Emp_Vendedor 	INT UNSIGNED NOT NULL,
	credito_Limite 		INT UNSIGNED,
	CONSTRAINT clientes_clave_Cliente_pk PRIMARY KEY (clave_Cliente),
	CONSTRAINT clientes_clave_Emp_Vendedor_fk FOREIGN KEY (clave_Emp_Vendedor) REFERENCES emp (clave_Emp)
);

CREATE TABLE precios(
	clave_Producto 	INT UNSIGNED NOT NULL,
	precios 		FLOAT UNSIGNED,
	precio_Minimo 	FLOAT UNSIGNED,
	fecha_Inicial 	DATE,
	fecha_Final 	DATE,
	CONSTRAINT precios_clave_Producto_fk FOREIGN KEY (clave_Producto) REFERENCES productos (clave_Producto)
);

CREATE TABLE pedidos(
	clave_Pedido 		INT UNSIGNED NOT NULL,
	fecha_Pedido 		DATE,
	comision_Tipo 		VARCHAR(1),
	clave_Cliente 		INT UNSIGNED NOT NULL,
	fecha_Embarque 		DATE,
	total 				FLOAT UNSIGNED,
	CONSTRAINT pedidos_clave_Pedido_pk PRIMARY KEY (clave_Pedido),
	CONSTRAINT pedidos_clave_Cliente_fk FOREIGN KEY (clave_Cliente) REFERENCES clientes (clave_Cliente)
);

CREATE TABLE detalles_Pedido(
	clave_Pedido 		INT UNSIGNED NOT NULL,
	renglon_Pedido   	INT UNSIGNED NOT NULL,
	clave_Producto 		INT UNSIGNED NOT NULL,
	precio_Pactado 		FLOAT UNSIGNED,
	cantidad 			INT UNSIGNED,
	renglon_Total 		FLOAT UNSIGNED,
	CONSTRAINT detalles_Pedido_clave_Producto_fk FOREIGN KEY (clave_Producto) REFERENCES productos (clave_Producto),
	CONSTRAINT detalles_Pedido_clave_Pedido_fk FOREIGN KEY (clave_Pedido) REFERENCES pedidos (clave_Pedido)
);

INSERT INTO depto VALUES (10,"CONTABILIDAD","NEW YORK");
INSERT INTO depto VALUES (20,"INVESTIGACION","DALLAS");
INSERT INTO depto VALUES (30,"VENTAS","CHICAGO");
INSERT INTO depto VALUES (40,"OPERACIONES","BOESTATUSON");

INSERT INTO emp VALUES (7839,"KING","PRESIDENTE","7839" ,"81/11/17",5000,0,10);
INSERT INTO emp VALUES (7698,"BLAKE","ADMINISTRADOR",7839,"81/05/01",2850,0,30);
INSERT INTO emp VALUES (7782,"CLARK","ADMINISTRADOR",7839,"81/06/09",2450,0,10);
INSERT INTO emp VALUES (7566,"JONES","ADMINISTRADOR",7839,"81/04/02",2975,0,20);
INSERT INTO emp VALUES (7654,"MARTIN","VENDEDOR",7698,"81/09/28",1250,1400,30);
INSERT INTO emp VALUES (7499,"ALLEN","VENDEDOR",7698,"81/02/20",1600,300,30);
INSERT INTO emp VALUES (7844,"TURNER","VENDEDOR",7698,"81/12/08",1500,0,30);
INSERT INTO emp VALUES (7900,"JAMES","EMPLEADO",7698,"81/02/03",950,0,20);
INSERT INTO emp VALUES (7521,"WARD","VENDEDOR",7698,"81/02/22",1250,500,30);
INSERT INTO emp VALUES (7902,"FORD","ANALISTA",7566,"81/12/03",3000,0,20);
INSERT INTO emp VALUES (7369,"SMITH","EMPLEADO",7902,"80/12/17",800,0,20);
INSERT INTO emp VALUES (7788,"SCOTT","ANALISTA",7566,"82/12/09",3000,0,20);
INSERT INTO emp VALUES (7876,"ADAMS","EMPLEADO",7788,"83/01/12",1100,0,20);
INSERT INTO emp VALUES (7934,"MILLER","EMPLEADO",7782,"82/01/23",1300,0,10);

INSERT INTO tabla_Salarios VALUES (1,700,1200);
INSERT INTO tabla_Salarios VALUES (2,1201,1400);
INSERT INTO tabla_Salarios VALUES (3,1401,2000);
INSERT INTO tabla_Salarios VALUES (4,2001,3000);
INSERT INTO tabla_Salarios VALUES (5,3001,9999);

INSERT INTO productos VALUES (100860,"ACE TENNIS RACKET I");
INSERT INTO productos VALUES (100861,"ACE TENNIS RACKET II");
INSERT INTO productos VALUES (100870,"ACE TENNIS BALL-3 PACK");
INSERT INTO productos VALUES (100871,"ACE TENNIS BALL-6 PACK");
INSERT INTO productos VALUES (100890,"ACE TENNIS NET");
INSERT INTO productos VALUES (101860,"SP TENNIS RACKET");
INSERT INTO productos VALUES (101863,"SP JUNIOR RACKET");
INSERT INTO productos VALUES (102130,"RH: GUIDE TO TENNIS");
INSERT INTO productos VALUES (200376,"SB ENERGY BAR-6 PACK");
INSERT INTO productos VALUES (200380,"SB VITA SNACK-6 PACK");

insert into clientes values (     100, " JOCKSPORTS", "345 VIEWRIDGE","  BELMONT ", "CA","96711",    415,"598-6609",7844,5000);
insert into clientes values (     101, " TKB SPORT SHOP", "490 BOLI RD.","  REDWOOD CITY ", "CA","94061",    415,"368-1223",7521,10000);
insert into clientes values (     102, " VOLLYRITE", "9722 HAMILTON","  BURLINGAME", "CA","95133",    415,"644-3341",7654,7000);
insert into clientes values (     103, " JUST TENNIS ", "HILLVIEW MALL","  BURLINGAME", "CA","97544",    415,"677-9312",7521,3000);
insert into clientes values (     104, " EVERY MOUNTAIN                              ", "574 SURRY RD.","  CUPERTINO ", "CA","93301",    408,"996-2323",7499,10000);
insert into clientes values (     105, " K + T SPORTS ", "3476 EL PASEO","  SANTA CLARA ", "CA","91003",    408,"376-9966",7844,5000);
insert into clientes values (     106, " SHAPE UP ", "908 SEQUOIA","  PALO ALTO", "CA","94301",    415,"364-9777",7521,6000);
insert into clientes values (     107, " WOMENS SPORTS                                ", "VALCO VILLAGE","  SUNNYVALE", "CA","93301",    408,"967-4398",7499,10000);
insert into clientes values (     108, " NORTH WOODS HEALTH AND FITNESS SUPPLY CENTER ", "98 LONE PINE WAY","  HIBBING ", "MN","55649",    612,"566-9123",7844,8000);

INSERT INTO pedidos VALUES (610,"87/01/07","A",101,"87/01/08",101.4);
INSERT INTO pedidos VALUES (611,"87/01/11","B",102,"87/01/11",45);
INSERT INTO pedidos VALUES (612,"87/01/15","C",104,"87/01/20",5860);
INSERT INTO pedidos VALUES (601,"86/05/01","A",106,"86/05/30",204);
INSERT INTO pedidos VALUES (602,"86/06/05","B",102,"86/06/20",56);
INSERT INTO pedidos VALUES (604,"86/06/15","A",106,"86/06/30",698);
INSERT INTO pedidos VALUES (605,"86/07/14","A",106,"86/07/30",8324);
INSERT INTO pedidos VALUES (606,"86/07/14","A",100,"86/07/30",3.4);
INSERT INTO pedidos VALUES (609,"86/08/01","B",100,"86/08/15",97.5);
INSERT INTO pedidos VALUES (607,"86/07/18","C",104,"86/07/18",5.6);
INSERT INTO pedidos VALUES (608,"86/07/25","C",104,"86/07/25",35.2);
INSERT INTO pedidos VALUES (603,"86/06/05","",102,"86/06/05",224);
INSERT INTO pedidos VALUES (620,"87/03/12","",100,"87/03/12",4450);
INSERT INTO pedidos VALUES (613,"87/02/01","",108,"87/02/01",6400);
INSERT INTO pedidos VALUES (614,"87/02/01","",102,"87/02/05",23940);
INSERT INTO pedidos VALUES (616,"87/02/03","",103,"87/02/10",764);
INSERT INTO pedidos VALUES (619,"87/02/22","",104,"87/02/04",1260);
INSERT INTO pedidos VALUES (617,"87/02/05","",105,"87/03/03",46370);
INSERT INTO pedidos VALUES (615,"87/02/01","",107,"87/02/06",710);
INSERT INTO pedidos VALUES (618,"87/02/15","A",102,"87/03/06",3510.5);
INSERT INTO pedidos VALUES (621,"87/03/15","A",100,"87/01/01",730);

INSERT INTO precios VALUES (100871,4.8,3.2,"85/01/01","85/12/01");
INSERT INTO precios VALUES (100890,58,46.4,"85/01/01","2021/02/20");
INSERT INTO precios VALUES (100890,54,40.5,"84/06/01","84/05/31");
INSERT INTO precios VALUES (100860,35,28,"86/06/01","2021/02/20");
INSERT INTO precios VALUES (100860,32,25.6,"86/01/01","86/05/31");
INSERT INTO precios VALUES (100860,30,24,"85/01/01","85/12/31");
INSERT INTO precios VALUES (100861,45,36,"86/06/01","2021/02/20");
INSERT INTO precios VALUES (100861,42,33.6,"86/01/01","86/05/31");
INSERT INTO precios VALUES (100861,39,31.2,"85/01/01","85/12/31");
INSERT INTO precios VALUES (100870,2.8,2.4,"86/01/01","2021/02/20");
INSERT INTO precios VALUES (100870,2.4,1.9,"85/01/01","85/12/01");
INSERT INTO precios VALUES (100871,5.6,4.8,"86/01/01","2021/02/20");
INSERT INTO precios VALUES (101860,24,18,"85/02/15","2021/02/20");
INSERT INTO precios VALUES (101863,12.5,9.4,"85/02/15","2021/02/20");
INSERT INTO precios VALUES (102130,3.4,2.8,"85/08/18","2021/02/20");
INSERT INTO precios VALUES (200376,2.4,1.75,"86/11/15","2021/02/20");
INSERT INTO precios VALUES (200380,4,3.2,"86/11/15","2021/02/20");

INSERT INTO detalles_Pedido VALUES (610,3,100890,58,1,58);
INSERT INTO detalles_Pedido VALUES (611,1,100861,45,1,45);
INSERT INTO detalles_Pedido VALUES (612,1,100860,30,100,3000);
INSERT INTO detalles_Pedido VALUES (601,1,200376,2.4,1,2.4);
INSERT INTO detalles_Pedido VALUES (602,1,100870,2.8,20,56);
INSERT INTO detalles_Pedido VALUES (604,1,100890,58,3,174);
INSERT INTO detalles_Pedido VALUES (604,2,100861,42,2,84);
INSERT INTO detalles_Pedido VALUES (604,3,100860,44,10,440);
INSERT INTO detalles_Pedido VALUES (603,2,100860,56,4,224);
INSERT INTO detalles_Pedido VALUES (610,1,100860,35,1,35);
INSERT INTO detalles_Pedido VALUES (610,2,100870,2.8,3,8.4);
INSERT INTO detalles_Pedido VALUES (613,4,200376,2.2,200,440);
INSERT INTO detalles_Pedido VALUES (614,1,100860,35,444,15540);
INSERT INTO detalles_Pedido VALUES (614,2,100870,2.8,1000,2800);
INSERT INTO detalles_Pedido VALUES (612,2,100861,40.5,20,810);
INSERT INTO detalles_Pedido VALUES (612,3,101863,10,150,1500);
INSERT INTO detalles_Pedido VALUES (620,1,100860,35,10,350);
INSERT INTO detalles_Pedido VALUES (620,2,200376,2.4,1000,2400);
INSERT INTO detalles_Pedido VALUES (620,3,102130,3.4,500,1700);
INSERT INTO detalles_Pedido VALUES (613,1,100871,5.6,100,560);
INSERT INTO detalles_Pedido VALUES (613,2,101860,24,200,4800);
INSERT INTO detalles_Pedido VALUES (613,3,200380,4,150,600);
INSERT INTO detalles_Pedido VALUES (619,3,102130,3.4,100,340);
INSERT INTO detalles_Pedido VALUES (617,1,100860,35,50,1750);
INSERT INTO detalles_Pedido VALUES (617,2,100861,45,100,4500);
INSERT INTO detalles_Pedido VALUES (614,3,100871,5.6,1000,5600);
INSERT INTO detalles_Pedido VALUES (616,1,100861,45,10,450);
INSERT INTO detalles_Pedido VALUES (616,2,100870,2.8,50,140);
INSERT INTO detalles_Pedido VALUES (616,3,100890,58,2,116);
INSERT INTO detalles_Pedido VALUES (616,4,102130,3.4,10,34);
INSERT INTO detalles_Pedido VALUES (616,5,200376,2.4,10,24);
INSERT INTO detalles_Pedido VALUES (619,1,200380,4,100,400);
INSERT INTO detalles_Pedido VALUES (619,2,200376,2.4,100,240);
INSERT INTO detalles_Pedido VALUES (615,1,100861,45,4,180);
INSERT INTO detalles_Pedido VALUES (607,1,100871,5.6,1,5.6);
INSERT INTO detalles_Pedido VALUES (615,2,100870,2.8,100,280);
INSERT INTO detalles_Pedido VALUES (617,3,100870,2.8,500,1400);
INSERT INTO detalles_Pedido VALUES (617,4,100871,5.6,500,2800);
INSERT INTO detalles_Pedido VALUES (617,5,100890,58,500,29000);
INSERT INTO detalles_Pedido VALUES (617,6,101860,24,100,2400);
INSERT INTO detalles_Pedido VALUES (617,7,101863,12.5,200,2500);
INSERT INTO detalles_Pedido VALUES (617,8,102130,3.4,100,340);
INSERT INTO detalles_Pedido VALUES (617,9,200376,2.4,200,480);
INSERT INTO detalles_Pedido VALUES (617,10,200380,4,300,1200);
INSERT INTO detalles_Pedido VALUES (609,2,100870,2.5,5,12.5);
INSERT INTO detalles_Pedido VALUES (609,3,100890,50,1,50);
INSERT INTO detalles_Pedido VALUES (618,1,100860,35,23,805);
INSERT INTO detalles_Pedido VALUES (618,2,100861,45.11,50,2255.5);
INSERT INTO detalles_Pedido VALUES (618,3,100870,45,10,450);
INSERT INTO detalles_Pedido VALUES (621,1,100861,45,10,450);
INSERT INTO detalles_Pedido VALUES (621,2,100870,2.8,100,280);
INSERT INTO detalles_Pedido VALUES (615,3,100871,5,50,250);
INSERT INTO detalles_Pedido VALUES (608,1,101860,24,1,24);
INSERT INTO detalles_Pedido VALUES (608,2,100871,5.6,2,11.2);
INSERT INTO detalles_Pedido VALUES (609,1,100861,35,1,35);
INSERT INTO detalles_Pedido VALUES (606,1,102130,3.4,1,3.4);
INSERT INTO detalles_Pedido VALUES (605,1,100861,45,100,4500);
INSERT INTO detalles_Pedido VALUES (605,2,100870,2.8,500,1400);
INSERT INTO detalles_Pedido VALUES (605,3,100890,58,5,290);
INSERT INTO detalles_Pedido VALUES (605,4,101860,24,50,1200);
INSERT INTO detalles_Pedido VALUES (605,5,101863,9,100,900);
INSERT INTO detalles_Pedido VALUES (605,6,102130,3.4,10,34);
INSERT INTO detalles_Pedido VALUES (612,4,100871,5.5,100,550);
INSERT INTO detalles_Pedido VALUES (619,4,100871,5.6,50,280);


#Mostrar los emplleados del depto 20, Nombre, clave, salario, anual Usar alias como atributos.alter
SELECT nombre_emp , clave_emp, salario,((salario *12)+comision) "Comision anual"  FROM emp;

# Buscar loa empleaods , que tengan el salario menor o igual a la comision
SELECT * From emp WHERE salario <= comision; 

# Mostarr los numeros de departamentos existentes en la tabla de empleados 
SELECT clave_Depto FROM emp;
#El resultado anterior repite numeros de departamentod, hacer la misma practica eliminando los numeros de depto duplicados, Usa alias.
SELECT DISTINCT clave_Depto FROM emp;

# Mostar los nombres de los empleados que sus salario este dentro  de 1000 a 1500
SELECT nombre_emp FROM emp WHERE salario >=1000 AND salario <= 1500;
SELECT nombre_emp FROM emp WHERE salario BETWEEN 1000 AND 1500;

#Mostrar los nomEmp, jefe, salario, numDepto que  su jefe sea 7902, 7566, 7788 
SELECT nombre_emp, jefe, salario, clave_Depto FROM emp WHERE jefe IN (7902, 7566,7788);
#La setencia "IN" ES PARA HACER LISTAS
SELECT nombre_emp, jefe, salario, clave_Depto FROM emp WHERE jefe =7902 OR jefe=7566 OR jefe=7788;

#Usando Operadosdres Logicos (AND, OR Y NOT )
SELECT claveemp, nombre_emp, puesto, salario
FROM emp
WHERE salrio >= 1100 AND puesto='ANALISTA'; 

SELECT nombre_emp, puesto
FROM emp
WHERE puesto NOT IN ('Empleado','ADMINISTRADOR', 'ANALISTA');
#CLAUSULAS PARA ORDENAR CONSULTAS

SELECT nombre_emp, puesto, clave_Depto, fecha_inicio
FROM emp
ORDER BY fecha_inicio DESC;

SELECT nombre_emp, clave_Depto, salario
FROM emp
ORDER BY clave_Depto, salario DESC;

select clave_Emp, lower(nombre_emp), upper(nombre_emp), clave_Depto
FROM emp
WHERE nombre_emp="blake";

#FUNCIONES DE MANIPULACION DE CARACTERES
#CONCAT= UNIR, JUNTAR PEGAR
#LENGHT

SELECT nombre_emp, CONCAT(nombre_emp," es ", puesto), LENGTH(nombre_emp),
INSTR(nombre_emp, 'A')
FROM emp;
 
 SELECT nombre_emp, SUBSTR(nombre_emp,3,2),LPAD(SALARIO,10,'_'),
 TRIM('A' FROM PUESTO)
 FROM EMP;
 
 #FUNCION DE REONDEO
 # ROUND (45.926 , 2)   45,93
 #TRUNCATE (45.926 ,2 )    45,92
 #MOD (1600,300)        100(Residuo  de ladiivision de ls numeros)
 
 SELECT nombre_emp, salario/30.4 Salario_diario,
 ROUND (salario/30.4,2) Salario_diario_Red,
 TRUNCATE(salario/30.4,2) Salario_Diario_Truncate,
 salario, comision MOD(salario, comision)
 FROM emp
 WHERE puesto='VENDEDOR';
 
 ####  LOS CORCHETES INDICAN QUE ES OPCIONAL LA CLAUSULA ####
 #1)
 SELECT puesto, AVG(salario), MAX(salario), MIN(salario), SUM(salario), COUNT(*)
 FROM emp
 WHERE puesto LIKE 'VENDE%'
 GROUP BY puesto;
 #2) La fecha mas antigua y la mas actual
 SELECT MIN(fecha_inicio), MAX(fecha_inicio)
 FROM emp;
 #3) conteo de empleados en el depto 30
 SELECT COUNT(*)
 FROM emp
 WHERE clave_Depto=30;
 # No cuenta los valores NULL, si alguna comisiom es NULL no la cuenta
 SELECT COUNT(comision)
 FROM emp
 WHERE clave_Depto =30;
 #nO CUENTA LOS VALORES NULL, SI ALGUNA COMISION ES "NULL" NO LA CUENTA
select COUNT (comision)
FROM emp
WHERE clave_Depto =30;
# IGNORA LOS VALORES NULL
SELECT AVG (comision)
FROM emp;
# AHORA SI USAMOS GROUP BY, PARA AGRUPAR
SELECT clave_Depto, AVG(salario)
FROM emp
GROUP BY clave_Depto;
#Mejora de la consulta anterior usando redondeos de decimales
SELECT clave_Depto, ROUND(AVG(salario),2)
FROM emp
GROUP BY clave_Depto;
#Mejora de la consulta anterior usando redondeos de decimales USANDO LPAD
SELECT clave_Depto,LPAD( ROUND(AVG(salario),2),10,'_')
FROM emp
GROUP BY clave_Depto;
#Obtenemos las suas de salario por grupos de claves y puestos
SELECT clave_Depto, puesto, SUM(salario) sum_salarios
FROM emp
GROUP BY clave_Depto, puesto
ORDER BY clave_Depto, sum_salarios DESC;
# La misma consultra pero ordenada 
SELECT clave_Depto, puesto, SUM(salario) sueldo
FROM emp
GROUP BY clave_Depto, puesto
ORDER BY clave_Depto, sueldo DESC;