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
INSERT INTO Victim (first_name, last_name, address, fk_IdStatus, firstSuspicion_date, confirm_date)
SELECT DISTINCT NOMBRE_VICTIMA, APELLIDO_VICTIMA, DIRECCION_VICTIMA, Status_Victim.id_status,
                FECHA_PRIMERA_SOSPECHA, FECHA_CONFIRMACION
FROM Temp
INNER JOIN Status_Victim
ON Temp.ESTADO_VICTIMA = Status_Victim.name_status
WHERE NOMBRE_VICTIMA != '' AND APELLIDO_VICTIMA != '' AND DIRECCION_VICTIMA != ''
  AND FECHA_PRIMERA_SOSPECHA != '' AND FECHA_CONFIRMACION != ''
GROUP BY NOMBRE_VICTIMA, APELLIDO_VICTIMA, DIRECCION_VICTIMA, ESTADO_VICTIMA;

# INSERT VICTIM_GPS
INSERT INTO Victim_GPS (fk_idVictim, fk_idGPS, registration_date, retirement_date)
SELECT DISTINCT Victim.id_victim, GPS.id_gps, FECHA_LLEGADA, FECHA_RETIRO
FROM Temp
INNER JOIN Victim
    ON Temp.NOMBRE_VICTIMA = Victim.first_name
    AND Temp.APELLIDO_VICTIMA = Victim.last_name
INNER JOIN GPS
    ON Temp.UBICACION_VICTIMA = GPS.address;

# INSERT HOSPITAL_VICTIM
INSERT INTO Hospital_Victim (fk_IdHospital, fk_IdVictim, registration_date, retirement_date, death_date)
SELECT Hospital.id_hospital, Victim.id_victim, STR_TO_DATE(Temp.FECHA_LLEGADA, '%Y-%m-%d %H:%i:%s'),
       STR_TO_DATE(FECHA_RETIRO, '%Y-%m-%d %H:%i:%s'), STR_TO_DATE(FECHA_MUERTE, '%Y-%m-%d %H:%i:%s')
FROM Hospital
INNER JOIN Temp
ON Temp.NOMBRE_HOSPITAL = Hospital.name
INNER JOIN Victim
ON Temp.NOMBRE_VICTIMA = Victim.first_name
    AND Temp.APELLIDO_VICTIMA = Victim.last_name
GROUP BY Hospital.id_hospital, Victim.first_name, Victim.last_name;

# INSERT TREATMENT
INSERT INTO Treatment (name_treatment)
SELECT DISTINCT TRATAMIENTO FROM Temp
WHERE TRATAMIENTO != '';

# INSERT VICTIM TREATMENT
INSERT INTO Victim_Treatment (fk_IdVictim, fk_IdTreatment, effectiveness,
                              startTreatment_date, finishTreatment_date)
SELECT DISTINCT id_victim, id_treatment, EFECTIVIDAD_EN_VICTIMA, FECHA_INICIO_TRATAMIENTO,
       FECHA_FIN_TRATAMIENTO FROM Victim
INNER JOIN Temp
ON Temp.NOMBRE_VICTIMA = Victim.first_name
    AND Temp.APELLIDO_VICTIMA = Victim.last_name
INNER JOIN Treatment
ON Temp.TRATAMIENTO = Treatment.name_treatment
WHERE FECHA_INICIO_TRATAMIENTO != '' AND FECHA_FIN_TRATAMIENTO != ''
AND EFECTIVIDAD_EN_VICTIMA != '';

# INSERT ASSOCIATE
INSERT INTO Associate_Person (first_name, last_name)
SELECT DISTINCT NOMBRE_ASOCIADO, APELLIDO_ASOCIADO FROM Temp
WHERE NOMBRE_ASOCIADO != '' AND APELLIDO_ASOCIADO != '';

# INSERT TYPE_CONTACT
INSERT INTO Type_Contact (type_contact)
SELECT DISTINCT CONTACTO_FISICO FROM Temp
WHERE CONTACTO_FISICO != '';

# INSERT VICTIM ASSOCIATE
INSERT INTO Victim_Associate (fk_idVictim, fk_idAssociate, fk_idTypeContact,
                              meet_date, startContact_Date, endContact_Date)
SELECT DISTINCT id_victim, id_associate_person, id_contact,
       FECHA_CONOCIO, FECHA_INICIO_CONTACTO, FECHA_FIN_CONTACTO FROM Temp
LEFT JOIN Victim
ON Temp.NOMBRE_VICTIMA = Victim.first_name
LEFT JOIN Associate_Person
ON Temp.NOMBRE_ASOCIADO = Associate_Person.first_name
LEFT JOIN Type_Contact
ON Temp.CONTACTO_FISICO = type_contact
WHERE id_victim IS NOT NULL AND id_contact IS NOT NULL
GROUP BY id_associate_person;