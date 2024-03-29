const queryBulkLoad = `# RESETEO DE BASE DE DATOS
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

    LOAD DATA
    INFILE '/var/lib/mysql-files/GRAND_VIRUS_EPICENTER.csv' INTO TABLE Temp
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (NOMBRE_VICTIMA, APELLIDO_VICTIMA, DIRECCION_VICTIMA, FECHA_PRIMERA_SOSPECHA, FECHA_CONFIRMACION,
        FECHA_MUERTE, ESTADO_VICTIMA, NOMBRE_ASOCIADO, APELLIDO_ASOCIADO, FECHA_CONOCIO, CONTACTO_FISICO,
        FECHA_INICIO_CONTACTO, FECHA_FIN_CONTACTO, NOMBRE_HOSPITAL, DIRECCION_HOSPITAL, UBICACION_VICTIMA,
        FECHA_LLEGADA, FECHA_RETIRO, TRATAMIENTO, EFECTIVIDAD, FECHA_INICIO_TRATAMIENTO,
        FECHA_FIN_TRATAMIENTO, EFECTIVIDAD_EN_VICTIMA)`;

module.exports = queryBulkLoad;