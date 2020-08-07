const mongoose = require("mongoose");
const Schema = mongoose.Schema;

//If no schedule for the day array = none
var scheduleSchema = new Schema({
    sunday: Array,
    monday: Array,
    tuesday: Array,
    wednesday: Array,
    thursday: Array,
    friday: Array,
    saturday: Array
})
// gets a singular schedule
scheduleSchema.statics.getScheduleByID = async function(scheduleID){
    return await this.findOne({
        _id: scheduleID
    }); 
};
// adds a schedule to the db
scheduleSchema.statics.addschedule = function(schedule, callback){
    schedule.save().then(callback);
};

// deletes a currently existing schedule
scheduleSchema.statics.delete = async function(scheduleID){
    return await this.deleteOne({
        _id : scheduleID
    });
}
// updates a schedule
scheduleSchema.statics.updateSchedule = async function(scheduleID, schedule){
    return await this.updateOne({
        _id: scheduleID
    }, {
        sunday: schedule.sunday,
        monday: schedule.monday,
        tuesday: schedule.tuesday,
        wednesday: schedule.wednesday,
        thursday: schedule.thursday,
        friday: schedule.friday,
        saturday: schedule.saturday
    }, {
        new: true
    }); 
};

scheduleSchema.statics.findLast = async function(){
    return await this.find({}).sort({_id:-1}).limit(1);
};

var Schedule= mongoose.model("Schedule", scheduleSchema)

module.exports = {
    Schedule
}