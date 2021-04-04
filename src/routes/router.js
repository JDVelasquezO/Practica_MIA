const express = require('express');
const router = express.Router();
const controller = require('../controller/DatabaseController');

router.get('/', (req, res) => {
    res.json('Página de Bienvenida');
})
router.get('/cargarModelo', controller.loadModel);
router.get('/cargarTemporal', controller.bulkLoad);

module.exports = router;
