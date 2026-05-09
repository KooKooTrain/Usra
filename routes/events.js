const express = require('express');
const router = express.Router();
const { getEvents, createEvent, updateEvent, deleteEvent } = require('../controllers/eventController');
const { protect } = require('../middleware/auth');

// router.route('/').get(protect, getEvents).post(protect, createEvent);
// router.route('/:id').put(protect, updateEvent).delete(protect, deleteEvent);

router.get('/', (req, res) => res.json({ message: 'Events route ready' }));

module.exports = router;