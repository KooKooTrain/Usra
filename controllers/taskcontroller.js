const Task = require('../models/task');
const getTasks = async (req, res) => {
    try {
        const tasks = await Task.find(); 
        res.status(200).json(tasks);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
const createTask = async (req, res) => {
    try {
        if (!req.body.title) {
            return res.status(400).json({ message: 'Please add a text field' });
        }

        const task = await Task.create({
            title: req.body.title,
            description: req.body.description,
            familyId: req.body.familyId 
        });

        res.status(201).json(task);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
const updateTask = async (req, res) => {
    try {
        const task = await Task.findByIdAndUpdate(req.params.id, req.body, { new: true });
        res.status(200).json(task);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
const deleteTask = async (req, res) => {
    try {
        await Task.findByIdAndDelete(req.params.id);
        res.status(200).json({ id: req.params.id, message: 'Task deleted' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
module.exports = { getTasks, createTask, updateTask, deleteTask };