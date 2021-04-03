const conn = require('../config/conn');
const queryLoadData = require('../../res/DDL');
const queryBulkLoad = require('../../res/DML');
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
    conn.query(queryLoadData, (err, data) => {
        res.json({
            err,
            success: data
        });
    });
}

controller.bulkLoad = (req, res) => {
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
