drop database if exists Colgrade_DataBase;
CREATE DATABASE Colgrade_DataBase;

use Colgrade_DataBase;

CREATE TABLE Login(
	id_login INTEGER NOT NULL AUTO_INCREMENT,
    usuario VARCHAR(30) NOT NULL UNIQUE,
    contrasenia VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_login)
);

CREATE TABLE Roles(
	id_roles INTEGER NOT NULL AUTO_INCREMENT,
    rol VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_roles)
);

CREATE TABLE Contacto(
	id_contacto INTEGER NOT NULL AUTO_INCREMENT,
	email VARCHAR(50) NOT NULL,
    celular VARCHAR(10) NOT NULL,
    PRIMARY KEY(id_contacto)
);

CREATE TABLE Perfiles(
	id_perfiles INTEGER NOT NULL AUTO_INCREMENT,
    nombres VARCHAR(200) NOT NULL,
    apellidos VARCHAR(200) NOT NULL,
    id_roles INTEGER NOT NULL,
    id_contacto INTEGER NOT NULL,
    PRIMARY KEY(id_perfiles),
	CONSTRAINT FK_Perfiles_id_roles FOREIGN KEY(id_roles) REFERENCES Roles(id_roles),
    CONSTRAINT FK_Perfiles_id_contacto FOREIGN KEY(id_contacto) REFERENCES Contacto(id_contacto)
);

CREATE TABLE Mensajes(
	id_mensajes INTEGER NOT NULL AUTO_INCREMENT,
    asunto VARCHAR(200) NOT NULL,
    contenido TEXT NOT NULL,
    PRIMARY KEY(id_mensajes)
);

CREATE TABLE Perfiles_Mensajes(
	id_perfiles_mensajes INTEGER NOT null AUTO_INCREMENT,
	id_mensajes INTEGER NOT NULL,
    id_perfiles INTEGER NOT NULL,
    PRIMARY KEY(id_perfiles_mensajes),
    CONSTRAINT FK_Perfiles_id_mensajes FOREIGN KEY(id_mensajes) REFERENCES Mensajes(id_mensajes),
    CONSTRAINT FK_Mensajes_id_perfiles FOREIGN KEY(id_perfiles) REFERENCES Perfiles(id_perfiles)
);

CREATE TABLE Perfiles_Destinatario_Mensajes(
	id_destinatario INTEGER NOT NULL,
	id_perfiles_mensajes INTEGER NOT NULL,
    PRIMARY KEY(id_destinatario,id_perfiles_mensajes),
    CONSTRAINT FK_Destinatario_Perfil FOREIGN KEY(id_destinatario) REFERENCES Perfiles(id_perfiles),
    CONSTRAINT FK_Perfiles_mensajes_PerfilesMensajes FOREIGN KEY(id_perfiles_mensajes) REFERENCES Perfiles_Mensajes(id_perfiles_mensajes)
);

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

CREATE TABLE Acudientes(
	id_acudiente INTEGER NOT NULL AUTO_INCREMENT,
    id_login INTEGER NOT NULL,
    id_perfil INTEGER NOT NULL,
    PRIMARY KEY(id_acudiente),
    CONSTRAINT FK_Acudientes_id_login FOREIGN KEY(id_login) REFERENCES Login(id_login),
    CONSTRAINT FK_Acudientes_id_perfil FOREIGN KEY(id_perfil) REFERENCES Perfiles(id_perfiles)
);

CREATE TABLE Estudiantes(
	id_estudiantes INTEGER NOT NULL AUTO_INCREMENT,
    id_login INTEGER NOT NULL,
    id_perfil INTEGER NOT NULL,
    id_acudiente INTEGER NOT NULL,
    promedio Float,
    PRIMARY KEY(id_estudiantes),
    CONSTRAINT FK_Estudiantes_id_login FOREIGN KEY(id_login) REFERENCES Login(id_login),
    CONSTRAINT FK_Estudiantes_id_perfil FOREIGN KEY(id_perfil) REFERENCES Perfiles(id_perfiles),
    CONSTRAINT FK_Estudiantes_id_acudiente FOREIGN KEY(id_acudiente) REFERENCES Acudientes(id_acudiente)
);

CREATE TABLE Cursos(
	id_cursos INTEGER NOT NULL AUTO_INCREMENT,
   	grado varchar(3) not null,
    PRIMARY KEY(id_cursos)
);

CREATE TABLE Estudiantes_Cursos(
	id_curso INTEGER NOT NULL,
    id_estudiante INTEGER NOT NULL,
    PRIMARY KEY(id_curso, id_estudiante),
    FOREIGN KEY(id_curso) REFERENCES Cursos(id_cursos),
    FOREIGN KEY(id_estudiante) REFERENCES Estudiantes(id_estudiantes)
);

CREATE TABLE Cursos_Materias(
	id_curso INTEGER NOT NULL,
    id_materia INTEGER NOT NULL,
    PRIMARY KEY(id_curso, id_materia),
    FOREIGN KEY(id_curso) REFERENCES Cursos(id_cursos),
    FOREIGN KEY(id_materia) REFERENCES Materias(id_materias)
);

CREATE TABLE Profesores(
	id_profesores INTEGER NOT NULL AUTO_INCREMENT,
    id_login INTEGER NOT NULL,
    id_perfil INTEGER NOT NULL,
    PRIMARY KEY(id_profesores),
    FOREIGN KEY(id_login) REFERENCES Login(id_login),
    FOREIGN KEY(id_perfil) REFERENCES Perfiles(id_perfiles)
);

CREATE TABLE Profesores_Materias(
	id_materias INTEGER NOT NULL,
    id_profesor INTEGER NOT NULL,
    PRIMARY KEY(id_materias, id_profesor),
    FOREIGN KEY(id_materias) REFERENCES Materias(id_materias),
    FOREIGN KEY(id_profesor) REFERENCES Profesores(id_profesores)
);

CREATE TABLE Administrativos(
	id_administrativos INTEGER NOT NULL AUTO_INCREMENT,
    id_login INTEGER NOT NULL,
    id_perfil INTEGER NOT NULL,
    PRIMARY KEY(id_administrativos),
    FOREIGN KEY(id_login) REFERENCES Login(id_login),
    FOREIGN KEY(id_perfil) REFERENCES Perfiles(id_perfiles)
);

create table login_backup (
	id_login integer primary key,
	usuario varchar (50),
	contrasenia varchar (50),
	fecha_registro DATETIME);
 
CREATE TRIGGER login_ai
  AFTER INSERT ON login
  FOR EACH ROW
  INSERT INTO login_backup
              (id_login,
               usuario,
               contrasenia,
               fecha_registro)
  VALUES      (NEW.id_login,
               NEW.usuario,
               NEW.contrasenia,
               Now()); 
