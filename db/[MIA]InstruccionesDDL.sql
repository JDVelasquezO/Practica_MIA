# USAR DB
USE GVE;

# CREACION DE TABLA TEMPORAL
CREATE TABLE IF NOT EXISTS Temp (
    NOMBRE_VICTIMA varchar(50),
    APELLIDO_VICTIMA varchar(50),
    DIRECCION_VICTIMA varchar(125),
    FECHA_PRIMERA_SOSPECHA varchar(50),
    FECHA_CONFIRMACION varchar(50),
    FECHA_MUERTE varchar(50),
    ESTADO_VICTIMA varchar(50),
    NOMBRE_ASOCIADO varchar(50),
    APELLIDO_ASOCIADO varchar(50),
    FECHA_CONOCIO varchar(50),
    CONTACTO_FISICO varchar(50),
    FECHA_INICIO_CONTACTO varchar(50),
    FECHA_FIN_CONTACTO varchar(50),
    NOMBRE_HOSPITAL varchar(50),
    DIRECCION_HOSPITAL varchar(50),
    UBICACION_VICTIMA varchar(50),
    FECHA_LLEGADA varchar(50),
    FECHA_RETIRO varchar(50),
    TRATAMIENTO varchar(50),
    FECHA_INICIO_TRATAMIENTO varchar(50),
    FECHA_FIN_TRATAMIENTO varchar(50),
    EFECTIVIDAD varchar(50),
    EFECTIVIDAD_EN_VICTIMA varchar(50)
);

# CREACION DE TABLAS
CREATE TABLE IF NOT EXISTS GPS (
	id_gps int PRIMARY KEY NOT NULL AUTO_INCREMENT,
	address varchar(50)
);

CREATE TABLE IF NOT EXISTS Hospital (
	id_hospital int AUTO_INCREMENT PRIMARY KEY NOT NULL,
	name varchar(50),
	address varchar(125)
);

CREATE TABLE IF NOT EXISTS Status_Victim (
	id_status int AUTO_INCREMENT PRIMARY KEY NOT NULL,
	name_status varchar(25)
);

CREATE TABLE IF NOT EXISTS Victim (
	id_victim int AUTO_INCREMENT PRIMARY KEY NOT NULL,
	first_name varchar(50),
	last_name varchar(50),
	address varchar(50),
	fk_IdStatus int,
	firstSuspicion_date DATETIME,
	confirm_date DATETIME,
	FOREIGN KEY (fk_IdStatus) 
	REFERENCES Status_Victim(id_status)
);

CREATE TABLE IF NOT EXISTS Victim_GPS (
	fk_idVictim int,
	fk_idGPS int,
	registration_date DATETIME,
	retirement_date DATETIME,
	FOREIGN KEY (fk_IdVictim) 
	REFERENCES Victim(id_victim),
	FOREIGN KEY (fk_idGPS) 
	REFERENCES GPS(id_gps),
	PRIMARY KEY (fk_IdVictim, fk_idGPS, registration_date)
);

CREATE TABLE IF NOT EXISTS Hospital_Victim (
	fk_IdHospital int,
	fk_IdVictim int,
	death_date DATETIME,
	FOREIGN KEY (fk_IdHospital) 
	REFERENCES Hospital(id_hospital),
	FOREIGN KEY (fk_IdVictim) 
	REFERENCES Victim(id_victim),
	PRIMARY KEY(fk_IdHospital, fk_IdVictim)
);

CREATE TABLE IF NOT EXISTS Treatment (
	id_treatment int PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name_treatment varchar(50)
);

CREATE TABLE IF NOT EXISTS Victim_Treatment (
	fk_IdVictim int,
	fk_IdTreatment int,
	effectiveness int,
	startTreatment_date DATETIME,
	finishTreatment_date DATETIME,
	FOREIGN KEY (fk_IdVictim)
	REFERENCES Victim(id_victim),
	FOREIGN KEY (fk_IdTreatment)
	REFERENCES Treatment(id_treatment),
	PRIMARY KEY (fk_IdVictim, fk_IdTreatment, startTreatment_date)
);

CREATE TABLE IF NOT EXISTS Associate_Person (
	id_associate_person int PRIMARY KEY NOT NULL AUTO_INCREMENT,
	first_name varchar(25),
	last_name varchar(25)
);

CREATE TABLE IF NOT EXISTS Type_Contact (
	id_contact int PRIMARY KEY NOT NULL AUTO_INCREMENT,
	type_contact varchar(50)
);

CREATE TABLE IF NOT EXISTS Victim_Associate (
	fk_idVictim int,
	fk_idAssociate int,
	fk_idTypeContact int,
	meet_date DATETIME,
	startContact_Date DATETIME,
	endContact_Date DATETIME,
	FOREIGN KEY (fk_IdVictim)
	REFERENCES Victim(id_victim),
	FOREIGN KEY (fk_idAssociate)
	REFERENCES Associate_Person(id_associate_person),
	FOREIGN KEY (fk_idTypeContact)
	REFERENCES Type_Contact(id_contact),
	PRIMARY KEY (fk_IdVictim, fk_idAssociate, fk_idTypeContact, startContact_Date)
);
