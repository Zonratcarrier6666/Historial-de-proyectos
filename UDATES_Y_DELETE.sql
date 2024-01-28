INSERT INTO depto(clave_depto,nombre_depto,ubicacion) 
VALUES( 50,'DEVELOPMENT','DETROIT');

INSERT INTO depto(clave_depto,nombre_depto) 
VALUES( 60,'MIS');

INSERT INTO depto
VALUES(70,'FINANCE',NULL);

INSERT INTO emp(clave_emp, nombre_emp, puesto,
				jefe, fecha_inicio, salario, comision,
                clave_depto)
VALUES(7196, 'GREEN','SALESMAN',
	   7782,SYSDATE(),2000,NULL,10);
       
INSERT INTO emp
VALUES (2296,'AROMANO','SALESMAN',7782,
		DATE('1992-07-01'),1300,NULL,10);
-- ESTRUCTURA DE UN UPDATE
# UPDATE table							#
# SET column=value[column=value,...]	#
# [WHERE condition]; 					#

UPDATE emp 
SET clave_depto=20
WHERE clave_emp=7782;

UPDATE emp
SET clave_depto=20;

#NO ha error pero no funciona
UPDATE emp 
SET clave_depto =(SELECT clave_depto
					FROM emp
                    WHERE clave_emp=7788),
                    puesto = (SELECT puesto
                    FROM emp
                    WHERE clave_emp=7788)
WHERE clave_emp=7698;
#ESTE si funciona pero tubimos que poner el from en el update
# ademas lo que hcimos es crear una tabla de consulta la cual 
# trae el puesto y la clave_depto
UPDATE emp e,(SELECT puesto, clave_depto
			  FROM emp
              WHERE clave_emp=7788) AS B
SET e.puesto = b.puesto,e.clave_depto = b.clave_depto
WHERE e.clave_emp=7698;

###DELETE###

DELETE FROM depto
WHERE  nombre_depto ='DEVELOPMENT' AND clave_depto=50;

###ESTE NO FUNCIONA YA QUE NO SE PUEDE BORRAR SIN WHERE
DELETE FROM depto;
### ESTE SI DUNCIONA PERO como no existe el departamento SALES marcara error
DELETE FROM emp
WHERE clave_depto=
					(SELECT clave_depto
                    FROM depto
                    WHERE nombre_depto='SALES');
