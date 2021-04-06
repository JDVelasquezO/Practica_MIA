const conn = require('../config/conn');
const queryLoadData = require('../../res/DDL');
const queryBulkLoad = require('../../res/DML');
const queries = require('../../res/Queries');
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

controller.query1 = (req, res) => {
    conn.query(queries.query1, (err, data) => {
        res.json({
            err,
            result: data
        })
    })
}

controller.query2 = (req, res) => {
    conn.query(queries.query2, (err, data) => {
        res.json({
            err,
            result: data
        })
    })
}

controller.query3 = (req, res) => {
    conn.query(queries.query3, (err, data) => {
        res.json({
            err,
            result: data
        })
    })
}

controller.query4 = (req, res) => {
    conn.query(queries.query4, (err, data) => {
        res.json({
            err,
            result: data
        })
    })
}

controller.query5 = (req, res) => {
    conn.query(queries.query5, (err, data) => {
        res.json({
            err,
            result: data
        })
    })
}

controller.query6 = (req, res) => {
    conn.query(queries.query6, (err, data) => {
        res.json({
            err,
            result: data
        })
    })
}

controller.query7 = (req, res) => {
    conn.query(queries.query7, (err, data) => {
        res.json({
            err,
            result: data
        })
    })
}

controller.query8 = (req, res) => {
    conn.query(queries.query8, (err, data) => {
        res.json({
            err,
            result: data
        })
    })
}

controller.query9 = (req, res) => {
    conn.query(queries.query9, (err, data) => {
        res.json({
            err,
            result: data
        })
    })
}

controller.query10 = (req, res) => {
    conn.query(queries.query10, (err, data) => {
        res.json({
            err,
            result: data
        })
    })
}

controller.dropModel = (req, res) => {
    conn.query(queries.dropModel, (err, data) => {
        res.json({
            err,
            result: data
        })
    })
}

controller.dropTemp = (req, res) => {
    conn.query(queries.dropTemp, (err, data) => {
        res.json({
            err,
            result: data
        })
    })
}

module.exports = controller;
