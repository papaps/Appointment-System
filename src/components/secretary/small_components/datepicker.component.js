import React, {Component} from 'react';
import DatePicker from 'react-datepicker';
import moment from 'moment';
import {FontAwesomeIcon} from '@fortawesome/react-fontawesome'
import {faCalendar} from '@fortawesome/free-solid-svg-icons'



import '../secretary_css/pickerStyle.scss'
import "react-datepicker/dist/react-datepicker.css"

export default class Picker extends Component {
    constructor(props){
        super(props);
        this.state = {
            date: moment().toDate(),
            time: moment().toDate().getTime()
        };

        this.onChangeDate = this.onChangeDate.bind(this);
        this.toToday = this.toToday.bind(this);
        this.next = this.next.bind(this);
        this.prev = this.prev.bind(this)
        this.handleDateChange = this.handleDateChange.bind(this)
        

    }

    getDate(){
        return this.state.date
    }
    //From the Calendar, when the value of the calendar changes, this updates the current date
    onChangeDate(date){
        console.log('changing date to', date);
        if(date == null){
            this.setState({
                date: moment().toDate(),
                time: moment().toDate().getTime()
                
            });
        }
        else{
            this.setState({
            date:date,
            time:moment(date).toDate().getTime()
            });
        } 
        this.handleDateChange(date)       
    }

    //Changes the date to the current date
    toToday(dateNow){
        dateNow = moment().toDate()
        console.log("change to: ", moment().toDate())
        this.setState({
            date:dateNow
        })
        this.handleDateChange(dateNow)
    }
    
    //Changes to previous date and updates the Calendar as well
    prev(){
        let prev_date = moment(this.state.date).clone().subtract(1, 'day').toDate()
        console.log('change to: ', prev_date)
        this.setState({
            date: prev_date
        })
        this.handleDateChange(prev_date)
        
        
    }
    
    //Changes to the next date and updates the Calendar as well
    next(){
        let next_date = moment(this.state.date).clone().add(1, 'day').toDate()
        console.log('change to: ', next_date)
        this.setState({
            date: next_date
        })
        this.handleDateChange(next_date)
        
    }

    //Sends the date (data) to the parent function AKA Navbar; prop.parentCall() comes from parent function
    handleDateChange(date){
        this.props.parentCall(date)
        
    }

    render(){
        return(
            <div class="item">
                <div className="picker">
                    {/* <FontAwesomeIcon icon={faCalendar}  className="calendarIcon"/> */}
                    <DatePicker
                        selected={this.state.date}
                        onChange={this.onChangeDate}
                        minDate={this.state.date}
                        minTime={this.state.time}
                    />
                </div> 
                <div className="today" class="ui basic button with tooltip" data-title="Today (SPACEBAR)"
                    data-content="Moves focus date to today" data-variation="basic" data-position="bottom center"
                    id="today" onClick={this.toToday}>
                    TODAY
                </div>
                <div class="ui icon basic buttons">
                    <div class="ui button with tooltip" data-title="Previous (←)"
                        data-content="Moves focused date to yesterday" data-position="bottom center" data-inverted=""
                        data-variation="basic" id="prev-button" onClick={this.prev}>
                        <i class="angle left icon"></i>
                    </div>
                    <div class="ui button with tooltip" data-title="Next (→)" data-content="Moves focused date to tomorrow"
                        data-position="bottom center" data-inverted="" data-variation="basic" id="next-button" onClick={this.next}>
                        <i class="angle right icon"></i>
                    </div>
                </div>
            </div>
        )
    }

}


