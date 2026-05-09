const mongoose = require('mongoose');

const familySchema = mongoose.Schema({
    name: { type: String, required: true },
    joinCode: { type: String, required: true, unique: true }, // E.g., 'SMITH123' to invite others
}, { timestamps: true });

module.exports = mongoose.model('Family', familySchema);