CREATE DATABASE PELIS;
USE PELIS;
CREATE TABLE movies(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(108) UNIQUE NOT NULL,
    etiquetas JSON NOT NULL
);

INSERT INTO movies(titulo, etiquetas)
Values('the world',
		'{"acerca":
					{"genero":"accion","cool":"Buena","productor":"Iñarritu"}
	   }');

INSERT INTO movies(titulo, etiquetas)
Values('Godzila',
		'{"acerca":
					{"genero":"accion","cool":"Regulas","productor":"KAWASAKI"}
	   }');
INSERT INTO movies(titulo, etiquetas)
Values('Barbie',
		'{"acerca":
					{"genero":"comedia","cool":"Regular","productor":"Grupo Marrano"}
	   }');

#JSON EN MY SQL#
SELECT id, titulo, JSON_EXTRACT(etiquetas, '$.acerca.genero')AS Genero FROM movies;
#Como ver el JSON de un solo valor "Gnero"#
SELECT id, titulo, JSON_EXTRACT(etiquetas, '$.acerca.productor')AS Productor FROM movies;
       
SELECT id, titulo, JSON_EXTRACT(etiquetas, '$.acerca.productor','$.acerca.cool')AS Productor_y_cool FROM movies;
# Consultas de varios JSON_EXTRACT
SELECT titulo, etiquetas->'$.acerca.productor' AS Productor,
			   etiquetas-> '$.acerca.cool' AS Cool,
                etiquetas-> '$.acerca.genero' AS Genero FROM movies;
UPDATE movies SET etiquetas= JSON_REPLACE(etiquetas,'$.acerca.genero','romance')
WHERE titulo= 'the world'; 

DELETE FROM movies WHERE id= 1 AND JSON_EXTRACT(etiquetas, '$.acerca.genero')="romance";