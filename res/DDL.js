const queryData = `# RESETEO DE BASE DE DATOS
    # USAR DB
    USE GVE;

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
        death_date DATETIME,
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
    
    # INSERT GPS
    INSERT INTO GPS (address)
    SELECT UBICACION_VICTIMA FROM Temp
    WHERE UBICACION_VICTIMA != ''
    GROUP BY UBICACION_VICTIMA;

    # INSERT HOSPITAL
    INSERT INTO Hospital (name, address)
    SELECT DISTINCT NOMBRE_HOSPITAL, DIRECCION_HOSPITAL FROM Temp
    WHERE NOMBRE_HOSPITAL != ''
    AND DIRECCION_HOSPITAL != '';

    # INSERT STATUS VICTIM
    INSERT INTO Status_Victim (name_status)
    SELECT DISTINCT ESTADO_VICTIMA FROM Temp
    WHERE ESTADO_VICTIMA != '';

    # INSERT VICTIM
    INSERT INTO Victim (first_name, last_name, address, fk_IdStatus, firstSuspicion_date, confirm_date, death_date)
    SELECT DISTINCT NOMBRE_VICTIMA, APELLIDO_VICTIMA, DIRECCION_VICTIMA, Status_Victim.id_status,
        FECHA_PRIMERA_SOSPECHA, FECHA_CONFIRMACION, 
        STR_TO_DATE(FECHA_MUERTE, '%Y-%m-%d %H:%i:%s')
    FROM Temp
    INNER JOIN Status_Victim
    ON Temp.ESTADO_VICTIMA = Status_Victim.name_status
    WHERE NOMBRE_VICTIMA != '' AND APELLIDO_VICTIMA != '' AND DIRECCION_VICTIMA != ''
        AND FECHA_PRIMERA_SOSPECHA != '' AND FECHA_CONFIRMACION != ''
    GROUP BY NOMBRE_VICTIMA, APELLIDO_VICTIMA, DIRECCION_VICTIMA, ESTADO_VICTIMA;

    # INSERT VICTIM_GPS
    INSERT INTO Victim_GPS (fk_idVictim, fk_idGPS, registration_date, retirement_date)
    SELECT
    (SELECT id_victim FROM Victim WHERE Victim.first_name = Temp.NOMBRE_VICTIMA
        AND Victim.last_name = Temp.APELLIDO_VICTIMA AND Victim.address = Temp.DIRECCION_VICTIMA limit 1) AS id_victima,
    (SELECT id_gps FROM GPS WHERE GPS.address = Temp.UBICACION_VICTIMA limit 1) AS id_gps,
    FECHA_LLEGADA, FECHA_RETIRO
    FROM Temp
    WHERE FECHA_LLEGADA != '' AND FECHA_RETIRO != ''
    GROUP BY id_victima, id_gps;

    # INSERT HOSPITAL_VICTIM
    INSERT INTO Hospital_Victim (fk_IdHospital, fk_IdVictim)
    SELECT
    (SELECT Hospital.id_hospital FROM Hospital WHERE Temp.NOMBRE_HOSPITAL = Hospital.name AND
        Temp.DIRECCION_HOSPITAL = Hospital.address LIMIT 1) AS id_hospital,
    (SELECT id_victim FROM Victim WHERE Victim.first_name = Temp.NOMBRE_VICTIMA
        AND Victim.last_name = Temp.APELLIDO_VICTIMA AND Victim.address = Temp.DIRECCION_VICTIMA limit 1) AS id_victima
    FROM Temp
    WHERE NOMBRE_HOSPITAL != '' AND NOMBRE_VICTIMA != ''
    GROUP BY id_victima, id_hospital;

    # INSERT TREATMENT
    INSERT INTO Treatment (name_treatment)
    SELECT DISTINCT TRATAMIENTO FROM Temp
    WHERE TRATAMIENTO != '';

    # INSERT VICTIM TREATMENT
    INSERT INTO Victim_Treatment (fk_IdVictim, fk_IdTreatment, effectiveness,
                                startTreatment_date, finishTreatment_date)
    SELECT DISTINCT
    (SELECT id_victim FROM Victim WHERE Victim.first_name = Temp.NOMBRE_VICTIMA
    AND Victim.last_name = Temp.APELLIDO_VICTIMA AND Victim.address = Temp.DIRECCION_VICTIMA limit 1) AS id_victima,
    (SELECT id_treatment FROM Treatment WHERE Treatment.name_treatment = Temp.TRATAMIENTO) AS id_tratamiento,
    EFECTIVIDAD_EN_VICTIMA, FECHA_INICIO_TRATAMIENTO, FECHA_FIN_TRATAMIENTO
    FROM Temp
    WHERE EFECTIVIDAD_EN_VICTIMA != '' AND FECHA_INICIO_TRATAMIENTO != ''
    AND FECHA_FIN_TRATAMIENTO != ''
    ORDER BY id_victima, id_tratamiento, FECHA_INICIO_TRATAMIENTO;

    # INSERT ASSOCIATE
    INSERT INTO Associate_Person (first_name, last_name)
    SELECT DISTINCT NOMBRE_ASOCIADO, APELLIDO_ASOCIADO FROM Temp
    WHERE NOMBRE_ASOCIADO != '' AND APELLIDO_ASOCIADO != '';

    # INSERT TYPE_CONTACT
    INSERT INTO Type_Contact (type_contact)
    SELECT DISTINCT CONTACTO_FISICO FROM Temp
    WHERE CONTACTO_FISICO != '';

    # INSERT VICTIM ASSOCIATE
    INSERT INTO Victim_Associate(fk_idVictim, fk_idAssociate, fk_idTypeContact, meet_date, startContact_Date,
        endContact_Date)
    SELECT
    (SELECT id_victim FROM Victim WHERE Victim.first_name = Temp.NOMBRE_VICTIMA
        AND Victim.last_name = Temp.APELLIDO_VICTIMA AND Victim.address = Temp.DIRECCION_VICTIMA limit 1) AS id_victima,
    (SELECT id_associate_person FROM Associate_Person WHERE Associate_Person.first_name = Temp.NOMBRE_ASOCIADO
        AND Associate_Person.last_name = Temp.APELLIDO_ASOCIADO limit 1) AS id_asociado,
    (SELECT id_contact FROM Type_Contact WHERE Type_Contact.type_contact = Temp.CONTACTO_FISICO limit 1) AS id_contacto,
    FECHA_CONOCIO, FECHA_INICIO_CONTACTO, FECHA_FIN_CONTACTO
    FROM Temp
    WHERE Temp.CONTACTO_FISICO != ''
    GROUP BY FECHA_CONOCIO, FECHA_INICIO_CONTACTO, FECHA_FIN_CONTACTO, id_victima, id_asociado, id_contacto;


    
`;

module.exports = queryData;
