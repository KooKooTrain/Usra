const mongoose = require('mongoose');
const familySchema = mongoose.Schema({
    name: { type: String, required: true },
    joinCode: { type: String, required: true, unique: true }, 
}, { timestamps: true });
module.exports = mongoose.model('Family', familySchema);