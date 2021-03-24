const express = require('express');
const router = express.Router();
const controller = require('../controller/ClientController');

router.get('/', (req, res) => {
    res.json('Página de Bienvenida');
})
router.get('/clients', controller.list);

module.exports = router;
