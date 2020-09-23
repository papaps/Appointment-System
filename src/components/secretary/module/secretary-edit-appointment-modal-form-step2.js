/**
 *  Description: Contains the first two steps in creating an Appointment.
 *  
 *  Includes: Date Picking, Time Picking, Next Button, Cancel Button
 * 
 * 
 */
import React, {Component, useState} from 'react';
import moment from 'moment';
import { Button, Header, Image, Modal, Form, Dropdown, Step, TextArea } from 'semantic-ui-react'
import axios from 'axios'
import _ from 'lodash'

class addProcStep2 extends Component {

    constructor(props){
        super(props);
        
        this.state = {
            procedures:[],
            doctors:[],
            value:[],
            currentProcs:this.props.values.procedures,
            currentDocs:this.props.values.doctors,
            multiple: true
        }
    }


    
    componentDidMount(){

        
        axios.get('http://localhost:3000/secretary/getProcess')
            .then(response => {
                if(response.data.length > 0){
                    this.setState({
                        procedures: [
                            ...response.data.map(procedure =>{
                                return{
                                    text: procedure.processname,
                                    value: procedure._id
                                }
                            })
                        ],
                        // procedures: response.data.map(procedure => procedure.processname),
                        // procedure: response.data[0].processname, 

                    })
                }
            })
        
        axios.get('http://localhost:3000/secretary/getDoctors')
            .then(response => {
                if(response.data.length > 0){
                    this.setState({   
                        doctors: [
                            ...response.data.map(doctor =>{
                                return{
                                    text: doctor.firstname+" "+doctor.lastname,
                                    value: doctor._id
                                }
                            })
                        ],
                        // doctor: response.data[0].firstname
                    })
                }
            })
        
            
        

    }

    
    render(){
        console.log(this.state.procedures)
        console.log(this.props.values.procedures)
        const {values, handleChange, handleDoctorChange, handleProcessChange} = this.props
        return(
            <Form>
                <Form.Input required
                    placeholder='First Name'
                    onChange = {handleChange('firstname')}
                    label="First Name"
                    name="firstname"
                    id= "processFirstName"
                    value={this.props.values.firstname}
                    
                />
                <Form.Input required
                    placeholder='Last Name'
                    onChange = {handleChange('lastname')}
                    label="Last Name"
                    name="lastname"
                    id= "processLastName"
                    value={this.props.values.lastname}
                />
                <Form.Input required
                    placeholder='Contact Number'
                    onChange = {handleChange('patientcontact')}
                    label="Contact Number"
                    name="patientcontact"
                    id= "processPatientContact"
                    value={this.props.values.patientcontact}
                />
                <Form.Dropdown
                    placeholder='Procedure/s'
                    onChange={handleProcessChange}
                    value={this.state.currentProcs}
                    selection fluid multiple
                    id= "processDropProc"
                    options={this.state.procedures}
                    >
                    
                </Form.Dropdown>
                <Form.TextArea required
                    placeholder='Notes'
                    onChange = {handleChange('notes')}
                    label="notes"
                    name="notes"
                    id= "processNotes"
                    value={this.props.values.notes}
                />
                <Form.Dropdown
                    placeholder='Doctor/s'
                    onChange={handleDoctorChange}
                    value={this.state.currentDocs}
                    options={this.state.doctors}
                    selection fluid multiple
                    id= "processDropDoctor"
                    >
                </Form.Dropdown>

                
            </Form>
        )
    }
}
export default addProcStep2