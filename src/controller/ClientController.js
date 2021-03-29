const conn = require('../config/conn');
const controller = {}

controller.list = (req, res) => {
    conn.query('SELECT * FROM cliente', (err, data) => {
        res.json({
            err: err,
            clients: data
        });
    });
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