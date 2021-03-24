const mysql = require('mysql');

let conn = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: null,
    database: 'master_detalle_tienda'
});

conn.connect(err => {
    if (err) {
        console.log(err.code);
        console.log(err.fatal);
    }
});

module.exports = conn;
