const Family = require('../models/family');
const User = require('../models/user');

const createFamily = async (req, res) => {
    const { name } = req.body;
    const joinCode = Math.random().toString(36).substring(2, 8).toUpperCase();

    try {
        const family = await Family.create({ name, joinCode });
        // Update the creator's familyId
        await User.findByIdAndUpdate(req.user, { familyId: family._id });
        res.status(201).json(family);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

const joinFamily = async (req, res) => {
    const { joinCode } = req.body;
    try {
        const family = await Family.findOne({ joinCode });
        if (!family) return res.status(404).json({ message: 'Family not found' });

        await User.findByIdAndUpdate(req.user, { familyId: family._id });
        res.status(200).json({ message: 'Joined successfully', family });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

module.exports = { createFamily, joinFamily };