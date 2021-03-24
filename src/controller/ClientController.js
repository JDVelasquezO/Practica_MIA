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

module.exports = controller