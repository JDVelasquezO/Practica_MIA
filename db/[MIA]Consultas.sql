# Query 1
SELECT Hospital.name, Hospital.address, COUNT(*) as Fallecidos
FROM Hospital_Victim
INNER JOIN Hospital
    ON Hospital_Victim.fk_IdHospital = Hospital.id_hospital
INNER JOIN Victim V on Hospital_Victim.fk_IdVictim = V.id_victim
WHERE death_date != ''
GROUP BY Hospital.name;

# Query 2
SELECT first_name, last_name FROM Victim_Treatment
INNER JOIN Victim
    ON Victim.id_victim = fk_IdVictim
INNER JOIN Status_Victim
    ON Victim.fk_IdStatus = Status_Victim.id_status
INNER JOIN Treatment
    ON Victim_Treatment.fk_IdTreatment = Treatment.id_treatment
WHERE effectiveness > 5
AND Treatment.name_treatment = "Transfusiones de sangre"
AND Status_Victim.name_status = "En cuarentena";

# Query 3
SELECT first_name, last_name, address, Cantidad_Contacto,death_date FROM
(SELECT first_name, last_name, address, death_date, COUNT(*) Cantidad_Contacto FROM
    (SELECT first_name, last_name, address, death_date, COUNT(*) Cantidad_Contactos FROM Victim_Associate
        INNER JOIN Victim V on Victim_Associate.fk_idVictim = V.id_victim
        WHERE Victim_Associate.fk_idVictim = V.id_victim
        GROUP BY fk_idVictim, fk_idAssociate) AS Cantidad
    GROUP BY first_name, last_name) AS Cantidad2
WHERE Cantidad_Contacto >= 3
AND death_date != '';

# Query 4
SELECT first_name, last_name, address
FROM Victim
INNER JOIN Victim_Associate VA on Victim.id_victim = VA.fk_idVictim
WHERE Victim.fk_IdStatus = 5
AND VA.fk_idVictim = Victim.id_victim
AND (
    SELECT COUNT(*) FROM Victim_Associate
    WHERE Victim_Associate.fk_idVictim = Victim.id_victim
    AND Victim_Associate.fk_idTypeContact = 6 ) > 2
GROUP BY Victim.first_name, Victim.last_name;

# Query 5
SELECT first_name, last_name, COUNT(fk_IdTreatment) AS Cantidad_Tratamiento FROM Victim_Treatment
INNER JOIN Victim
    ON Victim_Treatment.fk_IdVictim = Victim.id_victim
INNER JOIN Treatment T
    ON Victim_Treatment.fk_IdTreatment = T.id_treatment
WHERE T.name_treatment = "Oxigeno"
GROUP BY first_name, last_name
ORDER BY Cantidad_Tratamiento
LIMIT 5;

# Query 6
SELECT first_name, last_name, death_date FROM Victim
INNER JOIN Victim_Treatment VT
    ON Victim.id_victim = VT.fk_IdVictim
INNER JOIN Hospital_Victim
    ON Victim.id_victim = Hospital_Victim.fk_IdVictim
INNER JOIN Victim_GPS VG
    ON Victim.id_victim = VG.fk_idVictim
INNER JOIN GPS G
    ON G.id_gps = VG.fk_idGPS
INNER JOIN Treatment T
    ON VT.fk_IdTreatment = T.id_treatment
WHERE G.address = "1987 Delphine Well"
AND T.name_treatment = "Manejo de la Presion Arterial"
AND death_date IS NOT NULL;

# Query 7
SELECT Victim.first_name, Victim.last_name, Victim.address FROM Victim_Associate
INNER JOIN Victim
    ON Victim_Associate.fk_idVictim = Victim.id_victim
INNER JOIN Hospital_Victim HV
    ON HV.fk_IdVictim = Victim.id_victim
WHERE (
    SELECT COUNT(*)
    FROM Victim_Associate
    WHERE Victim_Associate.fk_idVictim = Victim.id_victim ) = 1
AND HV.fk_IdVictim IS NOT NULL
AND (
    SELECT COUNT(*)
    FROM Victim_Treatment
    WHERE Victim.id_victim = Victim_Treatment.fk_IdVictim ) = 2
GROUP BY Victim.first_name;

# Query 8
SELECT * FROM (
    SELECT first_name, last_name, MONTH(firstSuspicion_date) AS Mes_Inicio_Sospecha,
       COUNT(fk_IdTreatment) AS Cantidad_Tratamientos
    FROM Treatment
    INNER JOIN Victim_Treatment VT
        ON Treatment.id_treatment = VT.fk_IdTreatment
    INNER JOIN Victim V
        ON VT.fk_IdVictim = V.id_victim
    GROUP BY V.first_name
    ORDER BY Cantidad_Tratamientos DESC
    LIMIT 5
    ) a
UNION
SELECT * FROM (
    SELECT first_name, last_name, MONTH(firstSuspicion_date) AS Mes_Inicio_Sospecha,
       COUNT(fk_IdTreatment) AS Cantidad_Tratamientos
    FROM Treatment
    INNER JOIN Victim_Treatment VT
        ON Treatment.id_treatment = VT.fk_IdTreatment
    INNER JOIN Victim V
        ON VT.fk_IdVictim = V.id_victim
    GROUP BY V.first_name
    ORDER BY Cantidad_Tratamientos ASC
    LIMIT 5
    ) b;

# Query 9
SELECT name, address, COUNT(*) AS Cantidad, CONCAT(
        ROUND(
            (COUNT(*) / ( SELECT COUNT(*) FROM Hospital
                    INNER JOIN Hospital_Victim HV 
                    on Hospital.id_hospital = HV.fk_IdHospital) * 100
            ), 2
        ), "%"
    ) AS Porcentaje
FROM Hospital
INNER JOIN Hospital_Victim
ON Hospital.id_hospital = Hospital_Victim.fk_IdHospital
GROUP BY Hospital.name;

# Query 10
SELECT Nombre, Contacto, Cantidad, Porcentaje FROM (
    SELECT Hospital.name AS Nombre, type_contact AS Contacto, COUNT(*) AS Cantidad,
           CONCAT(
                ROUND(
                    (COUNT(*) / ( SELECT COUNT(*) FROM Hospital_Victim
                        INNER JOIN Victim V
                            ON Hospital_Victim.fk_IdVictim = V.id_victim
                        INNER JOIN Hospital
                            ON Hospital_Victim.fk_IdHospital = Hospital.id_hospital
                        INNER JOIN Victim_Associate VA
                            ON V.id_victim = VA.fk_idVictim
                        INNER JOIN Type_Contact TC
                            ON VA.fk_idTypeContact = TC.id_contact ) * 100
                    ), 2
                ), "%"
           ) AS Porcentaje
    FROM Hospital_Victim
    INNER JOIN Victim V
        ON Hospital_Victim.fk_IdVictim = V.id_victim
    INNER JOIN Hospital
        ON Hospital_Victim.fk_IdHospital = Hospital.id_hospital
    INNER JOIN Victim_Associate VA
        ON V.id_victim = VA.fk_idVictim
    INNER JOIN Type_Contact TC
        ON VA.fk_idTypeContact = TC.id_contact
    GROUP BY Hospital.id_hospital, type_contact
    ORDER BY Cantidad DESC
) AS Victimas
GROUP BY (Nombre);

# Query Drop Model
DROP TABLE Victim_Associate, Associate_Person, Type_Contact, Victim_Treatment, Treatment,
    Hospital_Victim, Victim_GPS, Victim, Status_Victim, Hospital, GPS;

# Query Drop Temp
TRUNCATE TABLE Temp;
