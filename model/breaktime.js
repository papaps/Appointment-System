const mongoose = require("mongoose");
const Schema = mongoose.Schema;

//If no break for the day array = none
var breakTimeSchema = new Schema({
    sunday: Array,
    monday: Array,
    tuesday: Array,
    wednesday: Array,
    thursday: Array,
    friday: Array,
    saturday: Array
})

// gets existing breaktimes
breakTimeSchema.statics.getBreakTimeByID = async function(breakTimeID){
    return await this.findOne({
        _id: breakTimeID
    }); 
};
// adds rbreaktime
breakTimeSchema.statics.addBreakTime = function(breakTime, callback){
    breakTime.save().then(callback);
};

// detes an existing breaktime
breakTimeSchema.statics.delete = async function(breakTimeID){
    return await this.deleteOne({
        _id : breakTimeID
    });
}
// changes/updates an existing breaktime
breakTimeSchema.statics.updateBreakTime = async function(breakTimeID, breakTime){
    return await this.updateOne({
        _id: breakTimeID
    }, {
        sunday: breakTime.sunday,
        monday: breakTime.monday,
        tuesday: breakTime.tuesday,
        wednesday: breakTime.wednesday,
        thursday: breakTime.thursday,
        friday: breakTime.friday,
        saturday: breakTime.saturday
    }, {
        new: true
    }); 
};

breakTimeSchema.statics.findLast = async function(){
    return await this.find({}).sort({_id:-1}).limit(1);
};

var BreakTime= mongoose.model("BreakTime", breakTimeSchema)

module.exports = {
    BreakTime
}