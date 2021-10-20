select * from estudiantes;
select * from acudientes;
select * from perfiles;
select * from materias;
select * from cursos;
select * from cursos_materias;

/* ver estudiantes que estan en determinado curso */
SELECT e.id_estudiantes,
       p.nombres,
       p.apellidos,
       c.grado
FROM   estudiantes AS e
       LEFT JOIN estudiantes_cursos AS ec
              ON ec.id_estudiante = e.id_estudiantes
       LEFT JOIN cursos AS c
              ON ec.id_curso = c.id_cursos
       LEFT JOIN perfiles AS p
              ON e.id_perfil = p.id_perfiles
WHERE  c.grado = "1a"; 

/* Ver profesores que dictan en un curso */
SELECT p.id_profesores,
       pe.nombres,
       pe.apellidos,
       c.grado
FROM   profesores AS p
       LEFT JOIN profesores_materias AS pm
              ON pm.id_profesor = p.id_profesores
       LEFT JOIN materias AS m
              ON pm.id_materias = m.id_materias
       LEFT JOIN cursos_materias AS cm
              ON m.id_materias = cm.id_materia
       LEFT JOIN cursos AS c
              ON cm.id_curso = c.id_cursos
       LEFT JOIN perfiles AS pe
              ON p.id_perfil = pe.id_perfiles
WHERE  c.grado = "1a"
GROUP  BY p.id_profesores; 



/* Bucar estudiantes segun nombre de acudiente */
SELECT p.nombres   AS N_Acudiente,
       p.apellidos AS A_Acudiente,
       r.rol,
       pe.nombres,
       pe.apellidos
FROM   estudiantes AS es
       LEFT JOIN acudientes AS ac
              ON es.id_acudiente = ac.id_acudiente
       LEFT JOIN perfiles AS pe
              ON es.id_perfil = pe.id_perfiles
       LEFT JOIN roles AS r
              ON r.id_roles = pe.id_roles
       LEFT JOIN perfiles AS p
              ON ac.id_perfil = p.id_perfiles
WHERE  p.nombres LIKE "nina%"; 


