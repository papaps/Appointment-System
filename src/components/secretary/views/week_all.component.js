import React, {Component} from 'react';
import Navbar from "../small_components/Navbar.component"
import AddAppointment from "../small_components/appointment_modal.component"

export default class week_all extends Component{
    render(){
        return(
            <div>
                {/* <Navbar/> */}
                <div className="item">
                    <AddAppointment/>
                </div>
            </div>
        )
            
            
    }
}