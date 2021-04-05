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
SELECT
(SELECT id_victim FROM Victim WHERE Victim.first_name = Temp.NOMBRE_VICTIMA
    AND Victim.last_name = Temp.APELLIDO_VICTIMA AND Victim.address = Temp.DIRECCION_VICTIMA limit 1) AS id_victima,
(SELECT id_gps FROM GPS WHERE GPS.address = Temp.UBICACION_VICTIMA limit 1) AS id_gps,
FECHA_LLEGADA, FECHA_RETIRO
FROM Temp
WHERE FECHA_LLEGADA != '' AND FECHA_RETIRO != ''
GROUP BY id_victima, id_gps;

# INSERT HOSPITAL_VICTIM
INSERT INTO Hospital_Victim (fk_IdHospital, fk_IdVictim, registration_date, retirement_date, death_date)
SELECT
(SELECT Hospital.id_hospital FROM Hospital WHERE Temp.NOMBRE_HOSPITAL = Hospital.name AND
    Temp.DIRECCION_HOSPITAL = Hospital.address LIMIT 1) AS id_hospital,
(SELECT id_victim FROM Victim WHERE Victim.first_name = Temp.NOMBRE_VICTIMA
    AND Victim.last_name = Temp.APELLIDO_VICTIMA AND Victim.address = Temp.DIRECCION_VICTIMA limit 1) AS id_victima,
STR_TO_DATE(Temp.FECHA_LLEGADA, '%Y-%m-%d %H:%i:%s') AS Fecha_Llegada,
STR_TO_DATE(FECHA_RETIRO, '%Y-%m-%d %H:%i:%s') AS Fecha_Retiro,
STR_TO_DATE(FECHA_MUERTE, '%Y-%m-%d %H:%i:%s') AS Fecha_Muerte
FROM Temp
WHERE FECHA_LLEGADA != '' AND FECHA_RETIRO != '' AND FECHA_MUERTE != ''
AND NOMBRE_HOSPITAL != ''
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
GROUP BY id_victima, id_asociado, id_contacto;