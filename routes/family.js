const express = require('express');
const router = express.Router();
const { protect } = require('../middleware/auth');

router.get('/', protect, (req, res) => res.json({ message: 'Family info route ready' }));
router.post('/create', protect, (req, res) => res.json({ message: 'Create family route ready' }));

module.exports = router;