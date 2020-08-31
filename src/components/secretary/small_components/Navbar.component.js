import React, {Component, useState} from 'react';
import 'react-datepicker/dist/react-datepicker.css'
import Picker from './datepicker.component'
import Modal from './appointment_modal.component'
import Example from "./appointment_modal.component";


//container

export default class Navbar extends Component{

    
    constructor(props){
        let Pick = new Picker();
        super(props);
        this.state = {
            date: Pick.getDate(),
            doctors: [],
           
            

        }
        this.updateCurrentDate = this.updateCurrentDate.bind(this)
       
        

    }
    //callbackfunction
    updateCurrentDate(date){
        this.setState={
            date:date
        }
        console.log("updating to: ", date)
    }
    //For immediate load of dropdown
    componentDidMount(){

    }

  
    render(){
        return(
        <div class="ui top fixed sticky borderless menu" id="main-menu">
            <div class="item ">
                <Picker
                sendData = {this.state.date}
                parentCall = {this.updateCurrentDate}
                />
            </div>
            <div class="item ">
                <span class="ui large text" id="focus-date-header">
                </span>
            </div>
            <div class="right borderless menu">
                <div class="item">
                    <div class="ui fluid selection dropdown" id="view-chooser">
                        <input type="hidden" name="view"/>
                        <div class="default text">View</div>
                        <i class="dropdown icon"></i>
                        <div class="menu">
                            <div class="item" data-value="day-view">DAY</div>
                            <div class="item" data-value="week-view">WEEK</div>
                        </div>
                    </div>
                </div>
                <div class="ui item">
                    <div class="ui selection very long dropdown" id="filter-dropdown">
                        <div class="default text">Filter</div>
                        <i class="dropdown icon"></i>
                        <div class="menu">
                            <div class="item" data-value="all">APPOINTMENTS
                            </div>
                            <div class="item" data-value="availability">AVAILABILITY</div>
                            <div class="item" data-value="all1">
                                <i class="dropdown icon"></i>
                                <span class="text">DOCTORS</span>
                                <div class="menu">
                                    {/* {{#each doctor}}
                                    <div class="item" data-value="{{_id}}">Dr. {{lastname}}</div>
                                    {{else}}
                                    <div class="item disabled" >[NO DOCTORS YET]</div>
                                    {{/each}} */
                                      
                                    }
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <i id="shortcutsInfo" class="large info circle icon"></i>
                </div>
                <div class="item ">
                    <i id="logoutButton" class="large sign out icon link"></i>
                </div>
            </div>
        </div>
        
        )
    }
}