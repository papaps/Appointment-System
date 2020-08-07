const mongoose = require("mongoose");
const Schema = mongoose.Schema;

var doctorSchema = new Schema({
    firstname: String,
    lastname: String,
    status: String,
    schedule: {
        type: Schema.Types.ObjectId,
        ref: "Schedule"
    },
    breakTime: {
        type: Schema.Types.ObjectId,
        ref: "BreakTime"
    },
    lastLogin: String
})
// gets single doctor using ID
doctorSchema.statics.getDoctorByID = async function(doctorID){
    return await this.findOne({
        _id: doctorID
    }); 
};
// adds a doctor to the table
doctorSchema.statics.addDoctor = function(doctor, callback){
    doctor.save().then(callback);
};
// gets all existing doctor and arranges by last name
doctorSchema.statics.getAllDoctors = async function(){
    return await this.find({}).sort({'lastname': 1});
}
// deletes a singular doctor
doctorSchema.statics.delete = async function(doctorID){
    return await this.deleteOne({
        _id : doctorID
    });
}
// updates doctor information
doctorSchema.statics.updateDoctor = async function(doctorID, firstname, lastname){
    return await this.updateOne({
        _id: doctorID
    }, {
        firstname,
        lastname,
    }, {
        new: true
    }); 
};
// updates status of doctor (available or unavailable)
doctorSchema.statics.updateDoctorStatus = async function(doctorID, status) {
    return await this.updateOne({
        _id: doctorID
    }, {
        status
    });
}
// updates a single schedule of a doctor
doctorSchema.statics.updateDoctorSchedule = async function(doctorID, schedule){
    return await this.updateOne({
        _id: doctorID
    }, {
        schedule
    }, {
        new: true
    }); 
};
// updates the breaktime of a doctor
doctorSchema.statics.updateDoctorBreakTime = async function(doctorID, breakTime){
    return await this.updateOne({
        _id: doctorID
    }, {
        breakTime
    }, {
        new: true
    }); 
};
// for populating schedule of a doctor
doctorSchema.methods.populateSchedule = async function(){
    return await Doctor.findOne({
        _id: this._id
    }).populate("schedule");
};
// for populating table of doctor's breaktime
doctorSchema.methods.populateBreakTime = async function(){
    return await Doctor.findOne({
        _id: this._id
    }).populate("breakTime");
};
// updates the last login time of the doctor
doctorSchema.statics.updateLogin = async function(doctorID, lastLogin) {
    return await this.updateOne({
        _id: doctorID
    }, { $set: {
        lastLogin
    }})
}

var Doctor = mongoose.model("Doctor", doctorSchema)

module.exports = {
    Doctor
}