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

/* Este script sirve para saber un poco más de cada estudiante */
SELECT Perfiles.id_perfiles,
	    Perfiles.nombres,
	    Perfiles.apellidos,
       Login.usuario,
       Login.contrasenia,
       Contacto.email,
       Contacto.celular,
       Roles.rol
        FROM Perfiles
	LEFT JOIN Login 
		ON perfiles.id_login=login.id_login
    LEFT JOIN Contacto 
		ON perfiles.id_contacto=contacto.id_contacto
	 LEFT JOIN roles_perfiles
		ON perfiles.id_perfiles=roles_perfiles.id_perfiles
	LEFT JOIN roles
		ON roles.id_roles=1;

/* Este script sirve para saber un poco más de cada rol y su respectivo permiso */
SELECT Roles.rol,
       Permisos.nombre_permiso,
       Permisos.acceso_permiso,
       Permisos.descripcion_permiso
FROM Roles 
LEFT JOIN Roles_Permisos 
	ON Roles.id_Roles=Roles_Permisos.id_Roles
LEFT JOIN Permisos
	ON Permisos.id_Permisos=Roles_Permisos.id_Permisos;

/* Este script sirve para conocer quien envió el mensaje*/
SELECT Perfiles_mensajes.id_perfiles as Remitente,
	   Mensajes.asunto,
       Mensajes.contenido,
       Perfiles_destinatario_mensajes.id_destinatario as Destinatario
FROM Mensajes
LEFT JOIN Perfiles_Mensajes
	ON Mensajes.id_mensajes=Perfiles_Mensajes.id_Mensajes
LEFT JOIN perfiles_destinatario_mensajes
	ON perfiles_destinatario_mensajes.id_perfiles_mensajes=Perfiles_Mensajes.id_Mensajes
LEFT JOIN Perfiles
	ON Perfiles.id_perfiles=Perfiles_destinatario_mensajes.id_destinatario
    or Perfiles.id_perfiles=Perfiles_mensajes.id_perfiles;


/*Para consultar que perfil envió el mensaje*/
SELECT Perfiles.id_perfiles,
	   Login.usuario,
	   Perfiles.nombres,
	   Perfiles.apellidos,
       Roles.Rol
FROM Perfiles
LEFT JOIN Login
	ON Perfiles.id_login=Login.id_login
LEFT JOIN Contacto
	ON Perfiles.id_contacto=contacto.id_contacto
LEFT JOIN Roles_Perfiles
	ON Perfiles.id_perfiles=Roles_Perfiles.id_perfiles
LEFT JOIN Roles 
	ON Roles.id_roles=Roles_Perfiles.id_Roles;


/*Insertando datos Aleatorios para realizar pruebas en la base de datos*/
INSERT INTO Contacto(email,celular)
VALUES
("purus.maecenas@eratvivamus.com","3076866946"),
("feugiat.lorem@tincidunttempusrisus.org","3055717407"),
("sapien.imperdiet@odiophasellus.org","3010148714"),
("turpis.vitae@etlibero.org","3095670438"),
("mattis@atnisi.ca","3068859136"),
("cum.sociis@inornare.com","3047437852"),
  ("tellus.non@nuncquis.co.uk","3005157753"),
  ("turpis.egestas@namporttitor.ca","3087248593"),
  ("luctus.ipsum.leo@massa.edu","3028744240"),
  ("eleifend.nec.malesuada@pellentesqueegetdictum.net","3070249375"),
  ("aliquam@donec.org","3034226414"),
  ("at.auctor.ullamcorper@eget.ca","3095457806"),
  ("nec.mauris@integervitae.com","3027217328"),
  ("donec.nibh@faucibusorciluctus.edu","3093780473"),
  ("convallis.in@acfermentum.org","3022767715"),
  ("libero.dui@vestibulum.co.uk","3084687442"),
  ("suspendisse.sed@utipsumac.net","3032443764"),
  ("tellus.lorem@convallisliguladonec.edu","3045337549"),
  ("feugiat@tellusnunc.org","3021578721"),
  ("donec.tincidunt@risus.ca","3056726999"),
  ("convallis.convallis@blanditat.ca","3009882484"),
  ("sodales.elit@egetmassa.org","3035027583"),
  ("non.sollicitudin@amet.edu","3041735400"),
  ("eu.dui.cum@hendrerita.co.uk","3045458274"),
  ("lectus.pede@donectincidunt.net","3045356792"),
  ("aliquet.magna@anteipsum.co.uk","3007157274"),
  ("adipiscing.fringilla@integervulputate.co.uk","3037977834"),
  ("phasellus.dolor.elit@iaculisquis.edu","3073111456"),
  ("nisi.magna@incondimentum.net","3065872488"),
  ("eu.sem@consectetuereuismod.com","3057024218"),
  ("a@venenatisvel.co.uk","3086518494"),
  ("luctus.lobortis@vestibulumanteipsum.net","3000767512"),
  ("sagittis@vestibulumnequesed.org","3097773517"),
  ("nunc@nunc.com","3046457442"),
  ("dolor.elit@non.edu","3062433529"),
  ("id.ante@mienimcondimentum.ca","3064882975"),
  ("parturient@magna.net","3097365728"),
  ("urna@imperdietdictum.co.uk","3011756734"),
  ("nam.interdum.enim@egestas.com","3040817577"),
  ("cursus.luctus.ipsum@nonmassa.co.uk","3056279451"),
  ("morbi@orcitincidunt.com","3010543842"),
  ("ac@dictumeueleifend.net","3010576013"),
  ("ligula.eu.enim@sodalesmauris.com","3032544537"),
  ("gravida.sit.amet@curabituregestas.edu","3099444162"),
  ("augue.eu@ettristique.edu","3078223636"),
  ("sem.egestas@euodiophasellus.ca","3010116526"),
  ("auctor.vitae.aliquet@vivamus.ca","3049754619"),
  ("sed.libero@etliberoproin.org","3026163321"),
  ("ligula.aenean@quisqueimperdiet.com","3003616995"),
  ("nulla.dignissim@ultricesduisvolutpat.org","3040284218"),
  ("nonummy.ultricies@dolordolor.co.uk","3092612251"),
  ("semper.et@eget.edu","3032327522"),
  ("arcu.vestibulum@posuerecubilia.com","3095473913"),
  ("sit.amet@etiamlaoreetlibero.net","3014602632"),
  ("a.neque@feugiattellus.edu","3017535556"),
  ("volutpat@nonhendrerit.ca","3092425775"),
  ("ac@etultrices.net","3082941144"),
  ("in.mi.pede@acliberonec.com","3018931122"),
  ("inceptos@nec.com","3085325687"),
  ("sodales.at.velit@semper.co.uk","3048531101"),
  ("ullamcorper.magna@dictumcursus.net","3031298761"),
  ("nec.mauris@augue.ca","3055314472"),
  ("id.enim@ametrisus.com","3011488035"),
  ("duis@utnisia.org","3017644323"),
  ("quisque@ut.edu","3027586202"),
  ("ante@scelerisquesed.ca","3099713313"),
  ("mauris.rhoncus.id@ligula.co.uk","3069979114"),
  ("nonummy.ac.feugiat@feugiat.com","3055644762"),
  ("tempor@sedturpis.edu","3030474400"),
  ("sagittis.duis@vulputateullamcorper.ca","3079155281"),
  ("enim.etiam.gravida@mollisnon.ca","3027222221"),
  ("a.purus@ligulaeu.net","3024153719"),
  ("curabitur.vel.lectus@tinciduntcongueturpis.net","3005180313"),
  ("quam@liguladonec.com","3082741244"),
  ("pharetra.felis@sedeunibh.ca","3062946849"),
  ("sed@auctornonfeugiat.com","3045087347"),
  ("auctor@tempor.org","3037685272"),
  ("a.purus.duis@miacmattis.ca","3071541268"),
  ("et.eros@adipiscingelit.com","3067262726"),
  ("sodales.purus@acrisusmorbi.ca","3026706578");
  
  INSERT INTO Login(usuario,contrasenia)
  VALUES
  ("jqsusuarioar2","WJE28VAX8NU"),
  ("mpnusuariodg9","GLH65UHB6VF"),
  ("vftusuarioxc3","RCX32NGH5LD"),
  ("nfcusuariooo7","KXE68EIL6SM"),
  ("qwfusuariouk0","KFG88BWO1HR"),
  ("esausuariopb3","OLC93GSK2EH"),
  ("kshusuariodn4","TDG51WIV1JN"),
  ("jopusuarioqi5","TYC37XOD9XQ"),
  ("mpqusuariomn2","EGN23WRJ7SP"),
  ("xwjusuarioch5","ZPN89EXK5QX"),
("dyousuarioxew4","BBQ33GOV3NC"),
  ("syeusuarioqji9","PNM20SQC4UH"),
  ("wzmusuariokso2","MKO63DID2XC"),
  ("tvqusuarioamk4","HUD21SDV9SL"),
  ("ansusuarioxfc1","MFN43CIC6WM"),
  ("acnusuariodqu2","NHZ12CKE1NA"),
  ("pcyusuariodff1","PKO39EMG7JF"),
  ("yubusuarioylq0","VEZ42XHF5UO"),
  ("uuhusuariodve7","RIY63RZW1NX"),
  ("wprusuarioivd4","PWK83NPH2BX"),
   ("vrsusuariozmd8","MIQ06ECV8AG"),
  ("huausuarioykb4","USC94TZF3KJ"),
  ("rsqusuariopih3","KJZ33TWD3RO"),
  ("jkwusuariowbk2","CGK64LNH6UQ"),
  ("toousuariorjt5","QUU60FGK8GR"),
   ("wogusuariovtc1","HQO18EBN5VS"),
  ("gkcusuariobuu3","WLX85CXN7BB"),
  ("jkuusuariofxg7","KEG58MOO4HD"),
  ("hmqusuarionmw5","GDQ44BJH9VQ"),
  ("bztusuarioqro8","XKQ91QDJ2CH"),
  ("kmpusuarioooj5","STC95ITJ7ZW"),
  ("socusuariokpu2","KMT61HSP4IE"),
  ("neuusuarioqwa8","INY37OYD1GY"),
  ("xqousuarioiku5","GGV88JCQ8QN"),
  ("gdousuariobdt9","SWW54HUF3OY"),
  ("lgvusuarioqjf0","FMN16NMN5SC"),
  ("rxsusuarioyfd5","TGH56JWL1DO"),
  ("dnhusuariomlf4","VRO86TOC4CL"),
  ("bwnusuariowsi1","HSL38EWA2NG"),
  ("poiusuariolrm5","LBO33DRI3FT"),
  ("vnuusuariotkl5","TSS24LSY4KH"),
  ("xsgusuariolcj2","TOS29QOF1IM"),
  ("eolusuariohsa8","OZW35WUN1YO"),
  ("quxusuariojyw5","WDK07TDZ5LV"),
  ("brtusuariowet7","WPD69RBU4XS"),
  ("wjqusuariosxg1","QYF56MTO9OM"),
  ("jcousuariolqw8","MDC74CTT8DM"),
  ("wreusuariooeh6","IZT77ANS4GD"),
  ("psdusuariobut4","CYI11MPU3FV"),
  ("veeusuariondo9","LBT22GBW6YS"),
  ("hbyusuariobjn1","GJY67UNP2NI"),
  ("ikhusuarioopy1","KYC72LAY4PG"),
  ("fsiusuariotgw8","YPJ52OJL2MO"),
  ("llsusuariomsf5","SYE96TNB7UL"),
  ("kakusuariootf8","VWC23EUI1SB"),
  ("lstusuariokyi6","BGP73TXE7UW"),
  ("hkpusuariofxr5","KNP86YTZ6DT"),
  ("qwtusuarioatt1","JAJ49NZI2QW"),
  ("disusuariouvm6","FYQ17OBS5QK"),
  ("cfdusuariopoo6","FNB69TFH2SM"),
  ("jssusuarioshb5","QTB67IRG1YF"),
  ("qmhusuarioknh2","VCY47VLX8VU"),
  ("cvkusuariopoj1","UIU33PTX1CE"),
  ("afcusuariowla3","VOA11MFU8GF"),
  ("vwyusuariospr4","JNR62WQY4OS"),
   ("jzlusuarioyen0","UXP27LHO4SL"),
  ("uqnusuarioorq1","FDC13MRF9RY"),
  ("ofhusuariocmt4","PKU19DZC8SR"),
  ("wqqusuarioduw5","ULP58JZZ5ON"),
  ("uzbusuariocpk2","FWM74DFQ1XJ"),
  ("lrkusuariohcb3","UVE81ITT7SG"),
  ("xdousuariohgv5","MOJ95XCG8WW"),
  ("stousuarioivs9","YUF88GDF0UY"),
  ("skjusuarioedg9","UFJ71WKZ1DV"),
  ("tfwusuariohgi6","KOL16ORC5WA"),
    ("xlpusuariowcm8","VXJ21KIY2EK"),
  ("rdlusuariokxp4","NBT36FFR9NC"),
  ("dhfusuariobnc5","XHH38PMV7DG"),
  ("xoiusuarioxmx3","BAI24HHJ7LQ"),
  ("fylusuariokyg8","QJQ73MAG8WE"),
  ("mxsusuariotbp4","ZSF82UPG8JJ"),
  ("tpfusuarioouz5","BVY44ZSK0WU"),
  ("gsrusuariocul8","YYO11EQU2SP"),
  ("lbousuariolpj1","DTL17RTZ2KJ"),
  ("vvlusuariotww5","DQY81VGO8HH"),
  ("dzfusuariowsc2","QTW76DBE0LH"),
  ("ylousuariomec5","WJB74JIQ2LN"),
  ("clmusuariohaw0","MAY11NYE8FK"),
  ("gtcusuariodho8","TJB15TEM1YL"),
  ("bfgusuarioyfd5","XZF63ROU6EF"),
  ("tpyusuarioxhd8","JIO52QHQ6RT"),
  ("qtgusuariosdd5","QYE31BWC6TO"),
  ("jgcusuariopqg7","KQK41DIE7XS"),
  ("hywusuariofvy3","RQJ70JIP8MH"),
  ("vicusuarioccn7","JXY58RCA7FI"),
  ("tgcusuariobti2","WDS44YOI5VQ"),
  ("eeyusuarioslu5","CTM60KPS5JE"),
  ("rfvusuariojvk4","TTE26VBG8UX"),
  ("fxxusuariovoy1","ILV67PVO5YC"),
  ("hmmusuarioqgj0","PBI76PAQ4UY"),
  ("xljusuarioehs8","LWY21KTU7YP"),
  ("paeusuarioidi7","VHC03QFJ8QU"),
  ("imrusuarioedl3","QQV79UJJ1SX"),
  ("btuusuarioafu4","SSM83FIE4CH"),
  ("wapusuarioxtk3","KHS28MNF8RF"),
  ("gshusuarioyqw8","EDU91PDP9PQ"),
  ("dndusuariogcz3","XDF04DKH7NS"),
  ("bbdusuariovie8","POY60KES7YM"),
  ("mktusuariohtq7","LXD31XMF1VX"),
  ("jcjusuariolgb8","UIO15YVF4SH"),
  ("vwdusuariofzq6","VXC13RUJ3XC"),
  ("tgyusuariouoj3","LCE71MKT0CH"),
  ("kbtusuariombn1","LQT43EFA4BE"),
  ("ufqusuarioqlj9","VLP52TUK7DR"),
  ("cohusuarioieo7","IRJ25NYG8RS"),
  ("tjkusuariojvg6","VEZ00HDX2BJ"),
  ("kkwusuariomov7","ZLN41MKW7RN"),
  ("mnbusuariorrh6","ALW51KEX0WS"),
  ("rycusuarioqrp2","JSZ33QIR7DJ"),
  ("ecbusuariogdm1","URP26UBE4CY"),
  ("klsusuariojto3","KOD14NKJ1UR"),
  ("hnnusuariosuo6","XGL22KLS7BY"),
  ("fbmusuariozlu5","OEK48VWJ8RL"),
  ("rckusuariolkg0","JGO31RIQ6TW"),
  ("ldeusuarioalv1","RYR41OLD2UK");
  
INSERT INTO Perfiles(nombres,apellidos,id_contacto,id_login)
VALUES 
  ("Maxine Abel","Saunders Moreno",1,1),
  ("Anika Diana","Vance Rice",2,2),
  ("Hanae Joy","Clemons Garrison",3,3),
  ("Amela Kermit","Hartman Greer",4,4),
  ("Cruz Abbot","Webb Schmidt",5,5),
  ("Melyssa Quinn","Bray Horn",6,6),
  ("Rogan Chantale","Villarreal Jenkins",7,7),
  ("Hasad Chaney","Castillo Donovan",8,8),
  ("Nina Hu","Turner Jacobs",9,9),
  ("Ross Barry","Buck Benson",10,10),
  ("Bethany Beatrice","Jennings Bradshaw",11,11),
  ("Helen Harper","Hess Garza",12,12),
  ("Miranda Asher","Velez Willis",13,13),
  ("Iola Brett","Park Stein",14,14),
  ("Hermione Gavin","Williamson Rich",15,15),
  ("Erin Phillip","Mitchell Barry",16,16),
  ("Jorden Christian","Gill Beard",17,17),
  ("Mohammad Alisa","Baldwin Mueller",18,18),
  ("Devin Neil","Dawson Summers",19,19),
  ("Howard Blossom","Wooten Montgomery",20,20),
  ("Irene Patience","Faulkner White",21,21),
  ("Macon Dean","Bradshaw Grant",22,22),
  ("Raya Venus","Fisher Mcfadden",23,23),
  ("Raja Lysandra","Sutton Simon",24,24),
  ("Xaviera Fletcher","Mccullough Sexton",25,25),
  ("Richard Mari","Kent Bender",26,26),
  ("Merritt Logan","England Sullivan",27,27),
  ("Erin Quentin","Harmon Knapp",28,28),
  ("Alden Martin","Barrera Juarez",29,29),
  ("Lareina Merritt","Gross Wade",30,30),
  ("Adara May","Neal Jimenez",31,31),
  ("Nissim Rachel","Glover Horn",32,32),
  ("Ferdinand Davis","Jennings Ferguson",33,33),
  ("Ross Kimberley","Dotson Mercer",34,34),
  ("Galvin Raymond","Mejia Raymond",35,35),
  ("Eleanor Signe","Mccarthy Berger",36,36),
  ("Galvin Felicia","Herman Gordon",37,37),
  ("Gannon Theodore","Ayala Dyer",38,38),
  ("Aline Gregory","Porter Sosa",39,39),
  ("Alea Nissim","Saunders Butler",40,40),
  ("Plato Elaine","Hudson Hunter",41,41),
  ("Fredericka Dean","Mercer Rice",42,42),
  ("Shay Ora","Washington Wolfe",43,43),
  ("Gabriel Daniel","Stanton Palmer",44,44),
  ("Adria Janna","Ingram Blackburn",45,45),
  ("Anika Madeson","Pierce Bass",46,46),
  ("Charde Edan","Wheeler Rogers",47,47),
  ("Simon Victoria","Gonzales Wiggins",48,48),
  ("Carolyn Derek","Burt Gibson",49,49),
  ("Amery Quyn","Mccarthy Mcintosh",50,50),
  ("Trevor Melodie","Mcguire Moran",51,51),
  ("Alexandra Devin","Dean Lamb",52,52),
  ("Nolan Buffy","House Compton",53,53),
  ("MacKenzie Kenyon","Patton Case",54,54),
  ("Barry Drake","Anderson Mcpherson",55,55),
  ("Heidi Patience","Mcknight Herman",56,56),
  ("Reuben Quintessa","Suarez Mcgowan",57,57),
  ("Brian Wade","Frye Herman",58,58),
  ("Stella Elaine","Castillo Montoya",59,59),
  ("Danielle Isaiah","Golden Leblanc",60,60),
  ("Camden Jack","Trujillo Salinas",61,61),
  ("Joshua May","Figueroa Dunlap",62,62),
  ("Xantha Evan","Mcmillan Ross",63,63),
  ("Cedric Gray","Clayton Battle",64,64),
  ("Barrett Dale","Phillips Strong",65,65),
  ("Marvin Nicholas","Blanchard Mejia",66,66),
  ("Lani Elijah","Peters Gross",67,67),
  ("Dorothy Brenna","Kidd Flores",68,68),
  ("Scarlett Roary","Matthews Stanley",69,69),
  ("Farrah Hedda","Hammond Joseph",70,70),
  ("Wade Lenore","Richard Rogers",71,71),
  ("Orli Anjolie","Davidson Cole",72,72),
  ("Ginger Diana","Craft Mcintosh",73,73),
  ("Haley Mason","Mejia Mcguire",74,74),
  ("Oliver Ronan","Strickland Davidson",75,75),
  ("Dara Nyssa","Cook Simon",76,76),
  ("Jelani Kevyn","Mckenzie Haley",77,77),
  ("Whilemina Nora","Stokes Stout",78,78),
  ("Robert Allistair","Livingston Santos",79,79),
  ("Illiana Ian","Garner Serrano",80,80);
  
DELETE FROM Perfiles 
WHERE id_perfiles=4;
DELETE FROM Perfiles 
WHERE id_perfiles=5;
DELETE FROM Perfiles 
WHERE id_perfiles=6;

SELECT * FROM Perfiles;

SELECT * FROM Cursos;

INSERT INTO Cursos(grado)
VALUES
("1A"),
("1B"),
("2A"),
("2B"),
("3A"),
("3B"),
("4A"),
("4B"),
("5B"),
("6A"),
("6B"),
("6C"),
("7A"),
("7B"),
("7C"),
("8A"),
("8B"),
("8C"),
("9A"),
("9B"),
("10A"),
("10B"),
("10C"),
("11A"),
("11C");

SELECT * FROM Materias;
INSERT INTO Materias(nombre_materia)
VALUES
("Ed.Fisica"),
("Ciencias Naturales"),
("Etica"),
("Informatica"),
("Ingles"),
("Ecologia"),
("Programación"),
("Quimica"),
("Pensamiento Critico"),
("Arte"),
("Danza"),
("Sociales"),
("Civica"),
("Historia"),
("Geografia"),
("Geometria"),
("Educación Sexual");





	
		

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






