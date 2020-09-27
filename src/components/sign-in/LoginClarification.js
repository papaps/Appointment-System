import React, { Component } from 'react';

class LoginClarification extends Component {
    render (){
        return(
            <div  id="confirm-admin-modal">
        <div class="header"><i class="edit icon" style={{color: "white"}}></i>&nbsp;&nbsp;Reset Password</div>
        <div class="content">
            <div class="ui form">
                <div class="required field" id="admin-input-field">
                    <label>Please input admin password</label>
                    <input type="password" name="admin" id="admin-input" placeholder="Admin Password"></input>
                </div>
            </div>
        </div>
        <div class="actions">
            <div class="ui right aligned floated labeled icon green button" id="reset-button-admin">
                CONFIRM
                <i class="checkmark icon"></i>
            </div>
            <div class="ui right labeled icon cancel button">
                CANCEL
                <i class="cancel icon"></i>
            </div>
        </div>
        </div>
        );
    }
}

export default LoginClarification;