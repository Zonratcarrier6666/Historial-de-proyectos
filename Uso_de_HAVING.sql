# EXCLUYENDO / FILTRANDO GRUPOS DE RESULTADOS USAMOS EL HAVING
#ESTRUCTURAS MAS COMPLETA DEL SELECT
#SELECT column, group_function
#FROM     table
#[WHERE condition]
#[GROUP BY 		group_by_xpression ]
#[HAVING group_condition]
#[ORDER BY column];

## PASOS PARA ENTENDER EL HAVING ###
# PASO (1) Obtener la informacion de los salarios por grupo en un depto.alter
SELECT clave_Depto,MAX(salario)
FROM emp
GROUP BY clave_Depto;
# PASO (2) Aplicamos el HAVING para eliminar GRRUPOS de datos que cumplan con la condicion del HAVING
SELECT clave_Depto, MAX(salario)
FROM emp
GROUP BY  clave_Depto
HAVING MAX(salario)>2900;
### EXTRA ###
SELECT puesto, SUM(salario)Pagos
FROM emp
WHERE puesto NOT LIKE 'vende%'
GROUP BY puesto
HAVING Pagos > 5000
ORDER BY Pagos DESC;
# Anidando Funciones
SELECT nombre_emp, LOWER(CONCAT(nombre_emp," es ", puesto)),
				LENGTH(nombre_emp),INSTR(nombre_emp,'A')
FROM emp;