const Event = require('../models/event');

const getEvents = async (req, res) => {
    try {
        const events = await Event.find({ familyId: req.body.familyId });
        res.status(200).json(events);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

const createEvent = async (req, res) => {
    try {
        const event = await Event.create({
            ...req.body,
            createdBy: req.user // From auth middleware
        });
        res.status(201).json(event);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

module.exports = { getEvents, createEvent };