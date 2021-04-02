const conn = require('../config/conn');
const controller = {}

// controller.list = (req, res) => {
//     conn.query('SELECT * FROM cliente', (err, data) => {
//         res.json({
//             err: err,
//             clients: data
//         });
//     });
// }

controller.loadModel = (req, res) => {
    const queryLoadData = require('../../res/DDL');
    // console.log(queryLoadData);
    conn.query(queryLoadData, (err, data) => {
        res.json({
            err,
            success: data
        });
    });
}

controller.bulkLoad = (req, res) => {
    const queryBulkLoad = "LOAD DATA\
    INFILE '/var/lib/mysql-files/text.csv' INTO TABLE temp\
    FIELDS TERMINATED BY ';'\
    LINES TERMINATED BY '\n'\
    IGNORE 1 LINES\
    (id, name)";

    conn.query(queryBulkLoad, (err, data) => {
        res.json({
            err,
            result: data
        })
    })
}

controller.save = (req, res) => {
    const { id_cliente, nombre, nit } = req.body;
    conn.query('INSERT INTO cliente SET ?', {
        id_cliente, nombre, nit
    }, (err, result) => {
        res.json('Agregado correctamente');
    });
}

module.exports = controller;
