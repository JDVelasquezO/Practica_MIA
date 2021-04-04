const conn = require('../config/conn');
const queryLoadData = require('../../res/DDL');
const queryBulkLoad = require('../../res/DML');
const controller = {}

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

module.exports = controller;
