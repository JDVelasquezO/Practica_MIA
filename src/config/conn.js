const mysql = require('mysql');

let conn = mysql.createConnection({
    multipleStatements: true,
    connectionLimit: 150,
    host: 'localhost',
    user: 'root',
    password: null,
    database: 'GVE'
});

conn.connect(err => {
    if (err) {
        console.log(err.code);
        console.log(err.fatal);
    }
});

module.exports = conn;
