import React, {Component} from 'react';
import moment from 'moment';
import {Modal, Form, Button, Icon, Card, Table, Tab} from 'semantic-ui-react'
import axios from 'axios'
import { SemanticToastContainer, toast } from 'react-semantic-toasts';
import 'react-semantic-toasts/styles/react-semantic-alert.css';
import '../secretary_css/secretary-view.css'


class SecretaryAvailability extends Component{

    constructor(props){
        super(props);

        this.state = {
            weekAvailable:this.props.weekAvailable,
            weeks:this.props.week,
        }
    }

    componentDidUpdate(){

        if(this.props.week != this.state.weeks){
            console.log("Updating week in Availability...")
            this.props.handleWeekAvailable();
            this.setState({
                weeks: this.props.week,
                weekAvailable: this.props.weekAvailable.doctors,
            })
        }
    }

    render(){
        return(
            <>
                <Table id="week-available" compact celled fixed textAlign='center'>
                    <Table.Body>
                        {
                            this.props.weekAvailable.doctors.map(({availability, firstname, lastname}, index)=>{
                                return(
                                    <Table.Row key={index}>
                                        <Table.Cell id='week-availability-time-cell'>{firstname}, {lastname}</Table.Cell>
                                        {
                                            availability.map((available)=>{
                                                if(available[1]=='past' || moment(available[0]).days() == 0){
                                                    let backgroundColor ='grey'
                                                    return(
                                                        <Table.Cell id="secretary-available-table-cell" style={{backgroundColor}}>
                                                        </Table.Cell>
                                                    )
                                                }else{
                                                    let backgroundColor ='green'
                                                    return(
                                                        <Table.Cell id="secretary-available-table-cell" style={{backgroundColor}}>
                                                        </Table.Cell>
                                                    )
                                                }
                                            })
                                        }
                                    </Table.Row>
                                )
                            })
                        }
                    </Table.Body>

                </Table>
            </>
        )
    }

}
export default SecretaryAvailability