const mongoose = require('mongoose');
const user = require('../model/account');
const userData = {username: 'Kristen', password:'1234password', accountType:'dentist', salt:'1234password'}


//TODO: Write unit tests

describe('Checks if I can add an account', ()=>{
    beforeAll(async () =>{
        await mongoose.connect(global.__MONGO_URI__, { useNewUrlParser: true, useCreateIndex: true}, (err)=>{
            if(err){
                console.error(err);
                process.exit(1);
            }
        });
    });
    it('For trial', () => {
        const validUser = new UserModel(userData);
        

    });
});