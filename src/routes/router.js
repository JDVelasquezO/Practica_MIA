const express = require('express');
const router = express.Router();
const controller = require('../controller/DatabaseController');

router.get('/', (req, res) => {
    res.json('Página de Bienvenida');
})
router.get('/cargarModelo', controller.loadModel);
router.get('/cargarTemporal', controller.bulkLoad);
router.get('/consulta1', controller.query1);
router.get('/consulta2', controller.query2);
router.get('/consulta3', controller.query3);
router.get('/consulta4', controller.query4);
router.get('/consulta5', controller.query5);
router.get('/consulta6', controller.query6);
router.get('/consulta7', controller.query7);
router.get('/consulta8', controller.query8);
router.get('/consulta9', controller.query9);
router.get('/consulta10', controller.query10);
router.get('/eliminarModelo', controller.dropModel);
router.get('/eliminarTemporal', controller.dropTemp);

module.exports = router;
