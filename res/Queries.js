const queries = {}

queries.query1 = `
    # Query 1
    SELECT Hospital.name, Hospital.address, COUNT(*) as Fallecidos
    FROM Hospital_Victim
    INNER JOIN Hospital
        ON Hospital_Victim.fk_IdHospital = Hospital.id_hospital
    WHERE death_date IS NOT NULL
    GROUP BY Hospital.name
`
queries.query2 = `
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
    AND Status_Victim.name_status = "En cuarentena"
`

queries.query3 = `
    # Query 3
    SELECT first_name, last_name, address FROM Victim_Associate
    INNER JOIN Victim
        ON Victim_Associate.fk_idVictim = Victim.id_victim
    INNER JOIN Hospital_Victim HV
        ON HV.fk_IdVictim = Victim.id_victim
    WHERE (
        SELECT COUNT(*)
        FROM Victim_Associate
        WHERE Victim_Associate.fk_idVictim = Victim.id_victim ) > 3
    AND HV.death_date IS NOT NULL
    GROUP BY Victim.first_name
`

queries.query4 = `
    # Query 4
    SELECT first_name, last_name, address FROM Victim_Associate
    INNER JOIN Victim
        ON Victim_Associate.fk_idVictim = Victim.id_victim
    INNER JOIN Status_Victim SV
        ON Victim.fk_IdStatus = SV.id_status
    INNER JOIN Type_Contact
        ON Victim_Associate.fk_idTypeContact = Type_Contact.id_contact
    INNER JOIN Hospital_Victim HV
        ON HV.fk_IdVictim = Victim.id_victim
    WHERE (
        SELECT COUNT(*)
        FROM Victim_Associate
        WHERE Victim_Associate.fk_idVictim = Victim.id_victim ) > 2
    AND SV.name_status = "Sospecha"
    AND Type_Contact.type_contact = "Beso"
    GROUP BY Victim.first_name
`

queries.query5 = `
    # Query 5
    SELECT first_name, last_name, COUNT(fk_IdTreatment) AS Cantidad_Tratamiento FROM Victim_Treatment
    INNER JOIN Victim
        ON Victim_Treatment.fk_IdVictim = Victim.id_victim
    INNER JOIN Treatment T
        ON Victim_Treatment.fk_IdTreatment = T.id_treatment
    WHERE T.name_treatment = "Oxigeno"
    GROUP BY first_name, last_name
    ORDER BY Cantidad_Tratamiento
    LIMIT 5
`

queries.query6 = `
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
    AND Hospital_Victim.death_date IS NOT NULL
`

queries.query7 = `
    # Query 7
    SELECT first_name, last_name, G.address FROM Victim_Associate
    INNER JOIN Victim
        ON Victim_Associate.fk_idVictim = Victim.id_victim
    INNER JOIN Victim_GPS VG
        ON Victim.id_victim = VG.fk_idVictim
    INNER JOIN GPS G
        ON VG.fk_idGPS = G.id_gps
    INNER JOIN Hospital_Victim HV
        ON HV.fk_IdVictim = Victim.id_victim
    INNER JOIN Victim_Treatment VT
        ON Victim.id_victim = VT.fk_IdVictim
    WHERE (
        SELECT COUNT(*)
        FROM Victim_Associate
        WHERE Victim_Associate.fk_idVictim = Victim.id_victim ) < 2
    AND Victim.id_victim = HV.fk_IdVictim
    AND (
        SELECT COUNT(*)
        FROM Victim_Treatment
        WHERE Victim.id_victim = Victim_Treatment.fk_IdVictim
        ) = 2
    GROUP BY Victim.first_name
`

queries.query8 = `
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
        ) b
`
queries.query9 = `
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
    GROUP BY Hospital.name
`
queries.query10 = `
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
    GROUP BY (Nombre)
`
module.exports = queries