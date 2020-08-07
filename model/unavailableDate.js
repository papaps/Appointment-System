const mongoose = require("mongoose");
const Schema = mongoose.Schema;

var unavailableDateSchema = new Schema({
    momentDate1: String,
    stringDate1: String,
    momentDate2: String,
    stringDate2: String,
    doctor: {
        type: Schema.Types.ObjectId,
        ref: "Doctor"
    }
});
// gets a singular unavailable date
unavailableDateSchema.statics.getUnavailableDateByID = async function(unavailableDateID){
    return await this.findOne({
        _id: unavailableDateID
    }); 
};
// adds an unvailable date
unavailableDateSchema.statics.addUnavailableDate = function(unavailableDate, callback){
    unavailableDate.save().then(callback);
};
// deletes an unavailable date
unavailableDateSchema.statics.delete = async function(unavailableDateID){
    return await this.deleteOne({
        _id : unavailableDateID
    });
}
// updates an unavailable date
unavailableDateSchema.statics.updateUnavailableDate = async function(unavailableDateID, updated){
    return await this.updateOne({
        _id: unavailableDateID
    }, {
        momentDate1: updated.momentDate1,
        stringDate1: updated.stringDate1,
        momentDate2: updated.momentDate2,
        stringDate2: updated.stringDate2
    }, {
        new: true
    }); 
};
// gets all unavailable dates of a doctor
unavailableDateSchema.statics.getDoctorUnavailableDates = async function(doctorID){
    return await this.find({
        doctor:{
            "$in": [doctorID]
        }        
    }).sort({'stringDate1': 1});
};
//populates a table with all the doctors unavailable in a singular date
unavailableDateSchema.methods.populateDoctor = async function(){
    return await Appointment.findOne({
        _id: this._id
    }).populate("doctor");
};

var UnavailableDate = mongoose.model("UnavailableDate", unavailableDateSchema);


module.exports = {
    UnavailableDate
}