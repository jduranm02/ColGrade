CREATE DATABASE Colgrade_DataBase;

CREATE TABLE Login(
	id_login INTEGER NOT NULL AUTO_INCREMENT,
    usuario VARCHAR(30) NOT NULL UNIQUE,
    contrasenia VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_login)
);

INSERT INTO Login(usuario,contrasenia)
VALUES ("jduranm","455782");
INSERT INTO Login(usuario,contrasenia)
VALUES 
("brayani","4458582"),
("fjfjfjj","4524524");

CREATE TABLE Roles(
	id_roles INTEGER NOT NULL AUTO_INCREMENT,
    rol VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_roles)
);
INSERT INTO Roles(rol)
VALUES 
("Estudiante"),
("Profesor"),
("Acudiente"),
("Administrativo");

SELECT * FROM Roles; 

CREATE TABLE Perfiles(
	id_perfiles INTEGER NOT NULL AUTO_INCREMENT,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_perfiles)
);

ALTER TABLE Roles 
ADD COLUMN id_perfiles INTEGER,
ADD CONSTRAINT FK_Roles_id_perfiles FOREIGN KEY(id_perfiles) REFERENCES Perfiles(id_perfiles);

ALTER TABLE Roles
DROP COLUMN id_perfiles;

ALTER TABLE Perfiles
ADD COLUMN id_login INTEGER,
ADD CONSTRAINT FK_Perfiles_id_login FOREIGN KEY(id_login) REFERENCES Login(id_login);


CREATE TABLE Contacto(
	id_contacto INTEGER NOT NULL AUTO_INCREMENT,
	email VARCHAR(50) NOT NULL,
    celular VARCHAR(10) NOT NULL,
    PRIMARY KEY(id_contacto)
);

ALTER TABLE Perfiles
ADD COLUMN id_contacto INTEGER,
ADD CONSTRAINT FK_Perfiles_id_contacto FOREIGN KEY(id_contacto) REFERENCES Contacto(id_contacto);

CREATE TABLE Mensajes(
	id_mensajes INTEGER NOT NULL AUTO_INCREMENT,
    asunto VARCHAR(200) NOT NULL,
    contenido TEXT NOT NULL,
    PRIMARY KEY(id_mensajes)
);

CREATE TABLE Perfiles_Mensajes(
	id_perfiles_mensajes INTEGER NOT NULL,
	id_mensajes INTEGER NOT NULL,
    id_perfiles INTEGER NOT NULL,
    PRIMARY KEY(id_perfiles_mensajes),
    CONSTRAINT FK_Perfiles_id_mensajes FOREIGN KEY(id_mensajes) REFERENCES Mensajes(id_mensajes),
    CONSTRAINT FK_Mensajes_id_perfiles FOREIGN KEY(id_perfiles) REFERENCES Perfiles(id_perfiles)
);

ALTER TABLE Perfiles_Mensajes
MODIFY id_perfiles_mensajes INTEGER NOT NULL AUTO_INCREMENT;

CREATE TABLE Perfiles_Destinatario_Mensajes(
	id_destinatario INTEGER NOT NULL,
	id_perfiles_mensajes INTEGER NOT NULL,
    PRIMARY KEY(id_destinatario,id_perfiles_mensajes),
    CONSTRAINT FK_Destinatario_Perfil FOREIGN KEY(id_destinatario) REFERENCES Perfiles(id_perfiles),
    CONSTRAINT FK_Perfiles_mensajes_PerfilesMensajes FOREIGN KEY(id_perfiles_mensajes) REFERENCES Perfiles_Mensajes(id_perfiles_mensajes)
);

DROP TABLE perfiles_destinatario_mensajes;

CREATE TABLE Permisos(
	id_permisos INTEGER NOT NULL AUTO_INCREMENT,
	nombre_permiso VARCHAR(50) NOT NULL,
    acceso_permiso BOOL DEFAULT FALSE,
    descripcion_permiso TEXT NOT NULL,
    PRIMARY KEY(id_permisos)
);

CREATE TABLE Roles_Permisos(
	id_permisos INTEGER NOT NULL,
    id_roles INTEGER NOT NULL,
    PRIMARY KEY(id_permisos,id_roles),
    CONSTRAINT FK_Roles_Permisos_id_Permisos FOREIGN KEY(id_permisos) REFERENCES Permisos(id_permisos),
    CONSTRAINT FK_Roles_Permisos_id_Roles FOREIGN KEY(id_roles) REFERENCES Roles(id_roles)
);

CREATE TABLE Materias(
	id_materias INTEGER NOT NULL AUTO_INCREMENT,
    nombre_materia VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_materias)
);

CREATE TABLE Cursos(
	id_cursos INTEGER NOT NULL AUTO_INCREMENT,
    grado VARCHAR(3) NOT NULL,
    PRIMARY KEY(id_cursos)
);

CREATE TABLE Materias_Cursos(
	id_materias INTEGER NOT NULL,
    id_cursos INTEGER NOT NULL,
    PRIMARY KEY(id_materias,id_cursos),
    CONSTRAINT FK_Materias_Cursos_id_Materias FOREIGN KEY(id_materias) REFERENCES Materias(id_materias),
    CONSTRAINT FK_Materias_Cursos_id_Cursos FOREIGN KEY(id_cursos) REFERENCES Cursos(id_cursos)
);

CREATE TABLE Roles_Perfiles(
	id_roles INTEGER NOT NULL,
    id_perfiles INTEGER NOT NULL,
    PRIMARY KEY(id_roles,id_perfiles),
    CONSTRAINT FK_Roles_Perfiles_IDroles FOREIGN KEY (id_roles) REFERENCES Roles(id_roles),
	CONSTRAINT FK_Roles_Perfiles_IDperfiles FOREIGN KEY (id_perfiles) REFERENCES Perfiles(id_perfiles)
);

INSERT INTO Contacto(email,celular)
VALUES
("juanduran@gmail.com","3245245245"),
("brayan@gmail.com","3478524541"),
("jugadordsks@gmail.com","3457859875");

INSERT INTO Perfiles(nombres,apellidos,id_contacto,id_login)
VALUES
("Juan Sebastian","Duran Macias",1,1),
("Brayan Andres","Quintero Pinto",2,2),
("Jose Daniel","Peña Utria",3,3);

INSERT INTO Roles_Perfiles(id_roles,id_perfiles)
VALUES
(1,1),
(1,2),
(1,3);

INSERT INTO Cursos(grado)
VALUES
("11B"),
("9C"),
("5A");

INSERT INTO Materias(nombre_materia)
VALUES
("Física"),
("Matemática"),
("Castellano");

INSERT INTO Materias_Cursos(id_materias,id_cursos)
VALUES
(1,1),
(2,2),
(3,3);

INSERT INTO Permisos(nombre_permiso,acceso_permiso,descripcion_permiso)
VALUES
("Ver Notas",TRUE,"El rol tiene permitido ver notas"),
("Editar Notas",FALSE,"El rol tiene permitido editar notas"),
("Editar Perfil",TRUE,"El rol tiene permidito editar su perfil");

INSERT INTO Roles_Permisos(id_permisos,id_roles)
VALUES
(1,1),
(2,1),
(3,1);

INSERT INTO Mensajes(asunto,contenido)
VALUES
("Exposición de Ciencias Naturales","Hola, quisiera saber si quisieras ser mi grupo para la exposición de ciencias naturales, quedo atento a tu respuesta"),
("Materiales","Hey recuerda que debes llevar silicona, pegamento y papel bond para mañana");

INSERT INTO Perfiles_Mensajes(id_mensajes,id_perfiles)
VALUES
(1,2),
(2,3);

DELETE FROM Mensajes WHERE id_mensajes=3;
DELETE FROM Mensajes WHERE id_mensajes=4;

INSERT INTO Perfiles_Destinatario_Mensajes(id_destinatario,id_perfiles_mensajes)
VALUES
(1,1),
(2,2);


		

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Roles(
	id_roles INTEGER NOT NULL AUTO_INCREMENT,
    rol VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_roles)
);

CREATE TABLE Permisos(
	id_permisos INTEGER NOT NULL AUTO_INCREMENT,
     nombre_permiso VARCHAR(30) NOT NULL,
     acceso BOOLEAN DEFAULT FALSE NOT NULL,
    PRIMARY KEY(id_permisos)
);

/*Si ya cree una tabla Permisos con una columna acceso BOOLEAN 
cómo hago para modificar esa columna, es decir, si ahora quiero cambiar
el tipo de dato o agregar que esa columna es NOT NULL, Cómo se podría
hacer*/

CREATE TABLE Contacto(
	id_contacto INTEGER NOT NULL AUTO_INCREMENT,
	email VARCHAR(50) NOT NULL,
    celular VARCHAR(10) NOT NULL,
    id_mensajes INTEGER NOT NULL,
    PRIMARY KEY(id_contacto),
    FOREIGN KEY(id_mensajes) REFERENCES Mensajes(id_mensajes)
);
/*Que pasa si pongo FOREIGN KEY(id_mensajes) REFERENCES Mensajes(id_mensajes); sin agregar antes
ADD CONSTRAINT FK_Contacto_id_mensajes?*/
ALTER TABLE Contacto ADD CONSTRAINT FK_Contacto_id_mensajes FOREIGN KEY(id_mensajes) REFERENCES Mensajes(id_mensajes);

CREATE TABLE Perfiles(
	id_perfiles INTEGER NOT NULL AUTO_INCREMENT,
    nombres VARCHAR(200) NOT NULL,
    apellidos VARCHAR(200) NOT NULL,
    id_roles INTEGER NOT NULL,
    id_contacto INTEGER NOT NULL,
    PRIMARY KEY(id_perfiles),
    FOREIGN KEY(id_roles) REFERENCES Roles(id_roles),
    FOREIGN KEY(id_contacto) REFERENCES Contacto(id_contacto)
);
ALTER TABLE Perfiles ADD CONSTRAINT FK_Perfiles_id_roles FOREIGN KEY(id_roles) REFERENCES Roles(id_roles);
ALTER TABLE Perfiles ADD CONSTRAINT FK_Perfiles_id_contacto FOREIGN KEY(id_contacto) REFERENCES Contacto(id_contacto);

CREATE TABLE Estudiantes(
	id_estudiantes INTEGER NOT NULL AUTO_INCREMENT,
    id_login INTEGER NOT NULL,
    id_perfil INTEGER NOT NULL,
    PRIMARY KEY(id_estudiantes),
    CONSTRAINT FK_Estudiantes_id_login FOREIGN KEY(id_login) REFERENCES Login(id_login),
    CONSTRAINT FK_Estudiantes_id_perfil FOREIGN KEY(id_perfil) REFERENCES Perfiles(id_perfiles)
);

ALTER TABLE Estudiantes ADD CONSTRAINT FK_Estudiantes_id_login FOREIGN KEY(id_login) REFERENCES Login(id_login);
ALTER TABLE Estudiantes ADD CONSTRAINT FK_Estudiantes_id_perfil FOREIGN KEY(id_perfil) REFERENCES Perfiles(id_perfiles);

SELECT * FROM Estudiantes;

CREATE TABLE Cursos(
	id_cursos INTEGER NOT NULL AUTO_INCREMENT,
    id_estudiantes INTEGER NOT NULL,
    PRIMARY KEY(id_cursos),
    FOREIGN KEY(id_estudiantes) REFERENCES Estudiantes(id_estudiantes)
);

ALTER TABLE Estudiantes
ADD COLUMN promedio FLOAT,
ADD COLUMN id_cursos INTEGER NOT NULL,
ADD FOREIGN KEY(id_cursos) REFERENCES Cursos(id_cursos);

ALTER TABLE Estudiantes ADD CONSTRAINT FK_Estudiantes_id_cursos FOREIGN KEY(id_cursos) REFERENCES Cursos(id_cursos);

CREATE TABLE Profesores(
	id_profesores INTEGER NOT NULL AUTO_INCREMENT,
    id_login INTEGER NOT NULL,
    id_perfil INTEGER NOT NULL,
    id_cursos INTEGER NOT NULL,
    PRIMARY KEY(id_profesores),
    FOREIGN KEY(id_login) REFERENCES Login(id_login),
    FOREIGN KEY(id_perfil) REFERENCES Perfiles(id_perfiles),
    FOREIGN KEY(id_cursos) REFERENCES Cursos(id_cursos)
);

CREATE TABLE Materias(
	id_materias INTEGER NOT NULL AUTO_INCREMENT,
    nombre_materia VARCHAR(30) NOT NULL,
    id_profesores INTEGER NOT NULL,
    id_cursos INTEGER NOT NULL,
    PRIMARY KEY(id_materias),
    FOREIGN KEY(id_profesores) REFERENCES Profesores(id_profesores),
    FOREIGN KEY(id_cursos) REFERENCES Cursos(id_cursos)
);

ALTER TABLE Cursos
ADD COLUMN id_materias INTEGER NOT NULL,
ADD COLUMN id_profesores INTEGER NOT NULL,
ADD COLUMN grado VARCHAR(3) NOT NULL,
ADD FOREIGN KEY(id_materias) REFERENCES Materias(id_materias),
ADD FOREIGN KEY(id_profesores) REFERENCES Profesores(id_profesores);

CREATE TABLE Acudientes(
	id_acudientes INTEGER NOT NULL AUTO_INCREMENT,
    id_estudiantes INTEGER NOT NULL,
    id_login INTEGER NOT NULL,
    id_perfil INTEGER NOT NULL,
    PRIMARY KEY(id_acudientes),
    FOREIGN KEY(id_estudiantes) REFERENCES Estudiantes(id_estudiantes),
    FOREIGN KEY(id_login) REFERENCES Login(id_login),
    FOREIGN KEY(id_perfil) REFERENCES Perfiles(id_perfiles)
);

CREATE TABLE Administrativos(
	id_administrativos INTEGER NOT NULL AUTO_INCREMENT,
    id_login INTEGER NOT NULL,
    id_perfil INTEGER NOT NULL,
    id_roles INTEGER NOT NULL,
    id_curso INTEGER NOT NULL,
    PRIMARY KEY(id_administrativos),
    FOREIGN KEY(id_roles) REFERENCES Roles(id_roles),
    FOREIGN KEY(id_login) REFERENCES Login(id_login),
    FOREIGN KEY(id_perfil) REFERENCES Perfiles(id_perfiles),
    FOREIGN KEY(id_curso) REFERENCES Cursos(id_cursos)
);

ALTER TABLE Roles
ADD COLUMN id_permiso INTEGER NOT NULL,
ADD FOREIGN KEY(id_permiso) REFERENCES Permisos(id_permisos);

ALTER TABLE Permisos
ADD COLUMN id_rol INTEGER NOT NULL,
ADD FOREIGN KEY(id_rol) REFERENCES Roles(id_roles);

CREATE TABLE Cursos_Materias(
	id_Cursos_Materias INTEGER NOT NULL AUTO_INCREMENT,
	id_curso INTEGER NOT NULL,
    id_materia INTEGER NOT NULL,
    PRIMARY KEY(id_Cursos_Materias),
    FOREIGN KEY(id_curso) REFERENCES Cursos(id_cursos),
    FOREIGN KEY(id_materia) REFERENCES Materias(id_materias)
);
/*Cómo borrar una foreign key de una tabla? 
Necesito borrar id_cursos de Materias y necesito borrar 
id_materias de Cursos*/

CREATE TABLE Profesores_Cursos(
	id_Profesores_Cursos INTEGER NOT NULL AUTO_INCREMENT,
	id_curso INTEGER NOT NULL,
    id_profesor INTEGER NOT NULL,
    PRIMARY KEY(id_Profesores_Cursos),
    FOREIGN KEY(id_curso) REFERENCES Cursos(id_cursos),
    FOREIGN KEY(id_profesor) REFERENCES Profesores(id_profesores)
);

CREATE TABLE Estudiantes_Cursos(
	id_Estudiantes_Cursos INTEGER NOT NULL AUTO_INCREMENT,
	id_curso INTEGER NOT NULL,
    id_estudiante INTEGER NOT NULL,
    PRIMARY KEY(id_Estudiantes_Cursos),
    FOREIGN KEY(id_curso) REFERENCES Cursos(id_cursos),
    FOREIGN KEY(id_estudiante) REFERENCES Estudiantes(id_estudiantes)
);

INSERT INTO Login(usuario,contrasenia)
VALUES 
("jduranm","3114123273");

INSERT INTO Login(usuario,contrasenia)
VALUES
("dnunezr","1424563245"),
("bquinte","1457854245"),
("lvanesa","7854245456"),
("equinte","4785452646"),
("jdiegoa","4785424578"),
("llinare","4578563245"),
("barchil","7558563245"),
("jramire","9424563245"),
("mrocioa","7852454545"),
("sheryai","7885425645");

INSERT INTO Mensajes(asunto,contenido,destinario,remitente)
VALUES
("Hola","Quiero conseguir trabajo","dnuddjdj","hdddkdhd"),
("Hola","Quiero conseguir trabajo","dnuddjdj","hdddkdhd"),
("Hola","Quiero conseguir trabajo","dnuddjdj","hdddkdhd"),
("Hola","Quiero conseguir trabajo","dnuddjdj","hdddkdhd"),
("Hola","Quiero conseguir trabajo","dnuddjdj","hdddkdhd"),
("Hola","Quiero conseguir trabajo","dnuddjdj","hdddkdhd"),
("Hola","Quiero conseguir trabajo","dnuddjdj","hdddkdhd"),
("Hola","Quiero conseguir trabajo","dnuddjdj","hdddkdhd"),
("Hola","Quiero conseguir trabajo","dnuddjdj","hdddkdhd"),
("Hola","Quiero conseguir trabajo","dnuddjdj","hdddkdhd");

SELECT * FROM Login;
SELECT * FROM Mensajes;

INSERT INTO Roles(rol,id_permiso)
VALUES 
("Rector",0),
("Coordinador",4),
("Profesor",1),
("Profesor",2),
("Estudiante",6),
("Acudiente",5),
("Admin",3);

INSERT INTO Permisos(nombre_permiso,acceso,id_rol)
VALUES 
("Subir notas",TRUE,3),
("Eliminar usuario",TRUE,3),
("Editar usuario",FALSE,6),
("Contactar Acudiente",FALSE,2);

/*Por qué no me deja agregar valores a las columnas roles y permisos?*/

DROP TABLE Permisos;






