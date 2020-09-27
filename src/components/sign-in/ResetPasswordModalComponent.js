import React, { Component } from 'react';
//import Logo from './logo.png';
import './loginCSS.css';


class ResetPasswordModalComponent extends Component{


    render (){

        return(

        <div>x1
        <div className="ui mini modal" id="forgot-modal">
        <div className="header"><i className="edit icon" style={{color: "white"}}></i>&nbsp;&nbsp;Reset Password</div>
        <div className="content">
            <div className="ui form">
                <div class="required field" id="reset-username-field">
                    <label>Username</label>
                    <input type="text" name="username" id="reset-username" placeholder="Username"></input>
                </div>
                <div className="required field" id="reset-password-field">
                    <label>Password</label>
                    <div data-tooltip="Password should contain 10 to 32 alphanumeric characters" data-position="right center">
                        <input type="password" name="password" id="reset-password" placeholder="Password"></input>
                    </div>
                </div>
                <div className="required field" id="reset-confirm-password-field">
                    <label>Confirm Password</label>
                    <div data-tooltip="Password should contain 10 to 32 alphanumeric characters" data-position="right center">
                        <input type="password" name="confirmPassword" id="reset-confirm-password" placeholder="Password"></input>
                    </div>
                </div>
            </div>
        </div>
        <div className="actions">
            <div className="ui right aligned floated labeled icon green button" id="reset-button">
                CONFIRM
                <i className="checkmark icon"></i>
            </div>
            <div className="ui right labeled icon cancel button">
                CANCEL
                <i className="cancel icon"></i>
            </div>
        </div>
        </div>
        
        </div>
          

        );
    }

}
export default ResetPasswordModalComponent;