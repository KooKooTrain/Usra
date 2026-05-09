const mongoose = require('mongoose');
const taskSchema = mongoose.Schema({
    title: { type: String, required: true },
    description: { type: String },
    assignedTo: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    familyId: { type: mongoose.Schema.Types.ObjectId, ref: 'Family', required: true },
    isCompleted: { type: Boolean, default: false }
}, { timestamps: true });
module.exports = mongoose.model('Task', taskSchema);