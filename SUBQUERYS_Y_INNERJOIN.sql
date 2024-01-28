#########				#########
#########  SUB QUERYS   #########
#########				#########

#1. Mostrar los nobres de los empleados que sus salrio sea mayor al empleado 7566
SELECT nombre_emp, salario
FROM emp
WHERE salario > (SELECT salario
				 FROM emp
				 WHERE clave_emp = 7566);
#2. Mostar el nombre completo del empleado, su Puesto y el Salario, de aquellos que ganan el minimo
SELECT nombre_emp, puesto, salario
FROM emp
WHERE salario=(
				SELECT MIN(salario)
                FROM emp);									
#### OPERADORES PARA LOS SUB QUERYS que regresan Multiples Filas ####
# IN - Igual a cualquiera en la lista
# ANY - Compara valor con cada valor regresando de la sub consulta
# ALL - Compara valor con todos los valores Regresando por la sub consulta

#5) Mostrar el numero de empleado, su nombre y su actividad/Puesto,
# De aquellos que no son 'empleado' y su salario sea mayor
# que cualquiera de los 'empleados'.
# si usamos ALL, Mostrara la genete que gana mas que todos los empleados

SELECT clave_Emp, nombre_emp, puesto, salario
FROM emp
WHERE salario <ANY
				(SELECT salario
                FROM emp 
                Where puesto ='EMPLEADO')
 AND 		puesto <>"EMPLEADO";
#Con el ALL (SALE LOS NULL)
SELECT clave_Emp, nombre_emp, puesto, salario
FROM emp
WHERE salario <ALL
				(SELECT salario
                FROM emp 
                Where puesto ='EMPLEADO')
 AND 		puesto <>"EMPLEADO";
 ###INER JOIN### Consulta de o ampliacion de vista de tablas#
 # departamentos de los EMPLEADOS (Tabala A), y el salario promedio de los Empleados segun su DEPTO (Tabla B)
 SELECT a.nombre_emp, a.salario, a.clave_Depto, b.salario_Promedio
 FROM emp a, (SELECT clave_depto, AVG(salario) salario_Promedio
			  FROM emp 
              GROUP BY clave_depto) b
WHERE a.clave_depto= b.clave_depto;

### Consulta usando 2 tablas ###
SELECT nombre_Emp, emp.clave_Depto, nombre_depto
FROM emp, depto
WHERE emp.clave_depto= depto.clave_depto; # relacionamos PK comn FK

## Para saber quien anda de mañoso ##
SELECT a.nombre_emp, a.salario, salario/b.salario_promedio*100 porcentaje_diferente,a.clave_Depto, b.salario_promedio
FROM emp a, (SELECT clave_Depto, AVG(salario)salario_promedio
			 FROM emp
             GROUP BY clave_Depto) b 
WHERE a.clave_Depto = b.clave_Depto
ORDER BY porcentaje_diferente DESC;