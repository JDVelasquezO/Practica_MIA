const express = require('express');
const router = express.Router();
const controller = require('../controller/DatabaseController');

router.get('/', (req, res) => {
    res.json('Página de Bienvenida');
})
router.get('/cargarModelo', controller.loadModel);
router.get('/cargarTemporal', controller.bulkLoad);
router.get('/query1', controller.query1);
router.get('/query2', controller.query2);
router.get('/query3', controller.query3);
router.get('/query4', controller.query4);
router.get('/query5', controller.query5);
router.get('/query6', controller.query6);
router.get('/query7', controller.query7);
router.get('/query8', controller.query8);
router.get('/query9', controller.query9);
router.get('/query10', controller.query10);

module.exports = router;
