INSERT INTO GPS (address)
SELECT DISTINCT UBICACION_VICTIMA FROM Temp
WHERE UBICACION_VICTIMA IS NOT NULL

INSERT INTO GPS VALUES
(1, 'Port Aftonshire, CA 43816'),
(2, '1987 Delphine Well'),
(3, '57148 Nikolaus Isle Suite 149'),
(4, '8184 Fahey Grove');

lINSERT INTO Hospital VALUES
(1, 'San Juan', 'Zona 1'),
(2, 'Roosevelt', 'Zona 11'),
ER_BAD_DB_ERROR
(3, 'Santa Marta', 'Zona 3');

INSERT INTO Status_Victim VALUES
(1, 'En cuarentena'),
(2, 'Introspección'),
(3, 'En Estudios'),
(4, 'Sospecha'),
(5, 'Reclusión'),
(6, 'Muerte');

INSERT INTO Victim VALUES
(1, 'Charles', 'Manson', 'direccion' 6, '2019-08-12 00:00:00', '2019-08-12 00:00:00'),
(2, 'Aldo', 'Raine', 'direccion' 2, '2019-08-12 00:00:00', '2019-08-12 00:00:00'),
(3, 'Oso', 'Judío', 'direccion', 6, '2019-08-12 00:00:00', '2019-08-12 00:00:00'),
(4, 'JD', 'Velasquez', 'direccion', 6, '2019-08-12 00:00:00', '2019-08-12 00:00:00'),
(5, 'Lizzie', 'Aby', 'direccion', 6, '2019-08-12 00:00:00', '2019-08-12 00:00:00'),
(6, 'Yessi', 'Lara', 'direccion', 4, '2019-08-12 00:00:00', '2019-08-12 00:00:00'),
(8, 'Kübra', 'Bozkizil', 'direccion', 1, '2019-08-12 00:00:00', '2019-08-12 00:00:00'),
(9, 'Zeynep', 'Okul', 'direccion', 1, '2019-08-12 00:00:00', '2019-08-12 00:00:00'),
(10, 'Nicole', 'Guidi', 'direccion', 1, '2019-08-12 00:00:00', '2019-08-12 00:00:00'),
(11, 'Cristian', 'Caceres', 'direccion', 1, '2019-08-12 00:00:00', '2019-08-12 00:00:00'),
(12, 'Daniel', 'Orozco', 'direccion', 1, '2019-08-12 00:00:00', '2019-08-12 00:00:00'),
(13, 'Ana', 'Luiza', 'direccion', 4, '2019-08-12 00:00:00', '2019-08-12 00:00:00'),
(14, 'Laura', 'Elizabeth', 'direccion', 4, '2019-08-12 00:00:00', '2019-08-12 00:00:00');

INSERT INTO Victim_GPS VALUES
(1, 2),
(2, 2),
(3, 3),
(3, 1),
(1, 4),
(2, 1),
(1, 2),
(5, 1),
(12, 2);

INSERT INTO Hospital_Victim VALUES
(1, 1, '2019-10-12 00:00:00', '2019-10-12 00:00:00', '2019-08-12 00:00:00'),
(2, 2, '2019-10-12 00:00:00', NULL, '2019-10-01 00:00:00'),
(1, 3, '2019-10-12 00:00:00', '2020-11-01 00:00:00', '2020-10-01 00:00:00'),
(2, 4, '2019-10-12 00:00:00', '2019-10-12 00:00:00', '2019-08-12 00:00:00'),
(3, 5, '2019-10-12 00:00:00', '2019-10-12 00:00:00', '2019-08-12 00:00:00'),
(2, 6, '2019-10-12 00:00:00', '2019-10-12 00:00:00', '2019-08-12 00:00:00'),
(2, 8, '2019-10-12 00:00:00', '2019-10-12 00:00:00', '2019-08-12 00:00:00'),
(2, 9, '2019-10-12 00:00:00', '2019-10-12 00:00:00', '2019-08-12 00:00:00'),
(2, 10, '2019-10-12 00:00:00', '2019-10-12 00:00:00', '2019-08-12 00:00:00'),
(2, 11, '2019-10-12 00:00:00', '2019-10-12 00:00:00', '2019-08-12 00:00:00'),
(2, 12, '2019-10-12 00:00:00', '2019-10-12 00:00:00', '2019-08-12 00:00:00');
(1, 13, '2019-10-12 00:00:00', '2019-10-12 00:00:00', NULL),
(1, 14, '2019-10-12 00:00:00', '2019-10-12 00:00:00', NULL);

INSERT INTO Treatment VALUES
(1, 'Manejo Presion Arterial'),
(2, 'Transfusiones de sangre'),
(3, 'Oxigeno'),
(4, 'Tratamento para infeccion'),
(5, 'Liquido por ultravenosa');

INSERT INTO Victim_Treatment VALUES
(4, 1, 6, '2020-11-01 00:00:00', '2020-10-01 00:00:00'),
(8, 1, 6, '2020-11-01 00:00:00', '2020-10-01 00:00:00'),
(9, 1, 2, '2020-11-01 00:00:00', '2020-10-01 00:00:00'),
(10, 2, 5, '2020-11-01 00:00:00', '2020-10-01 00:00:00'),
(11, 3, 10, '2020-11-01 00:00:00', '2020-10-01 00:00:00'),
(12, 1, 7, '2020-11-01 00:00:00', '2020-10-01 00:00:00');

INSERT INTO Associate_Person VALUES
(1, 'Hans', 'Landa'),
(2, 'Brad', 'Pitt'),
(3, 'Shosanna', 'Dreyfus'),
(4, 'Perrier', 'LaPedite'),
(5, 'Oso', 'Polar'),
(6, 'Carnero', 'Cimarron');

INSERT INTO Type_Contact VALUES
(1, 'Abrazo'),
(2, 'Beso'),
(3, 'Saludo'),
(4, 'Estrechar Manos');

INSERT INTO Victim_Associate VALUES
(1, 1, 1, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(1, 2, 2, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(1, 3, 3, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(1, 6, 4, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(13, 1, 2, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(13, 2, 2, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(13, 3, 2, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(13, 4, 2, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(14, 1, 2, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(14, 2, 2, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(14, 3, 2, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(14, 4, 2, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(2, 1, 1, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(2, 3, 3, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(4, 6, 3, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(4, 5, 1, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(4, 1, 3, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(4, 2, 3, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(4, 6, 4, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00'),
(5, 6, 1, '2020-11-01 00:00:00', '2020-11-01 00:00:00', '2020-11-01 00:00:00');