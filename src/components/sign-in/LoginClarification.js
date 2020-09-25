import React, { Component } from 'react';
import {Modal, Icon, Popup, Button,  Form, Input} from 'semantic-ui-react'
import axios from 'axios';

class LoginClarification extends Component {

    constructor (props){
        super(props);

        this.onClickConfirmButton = this.onClickConfirmButton.bind(this);
        this.onChangeAdminPassword = this.onChangeAdminPassword.bind(this);
        this.onAdminValidation = this. onAdminValidation.bind(this);
        this.state={
            open: false,
            username: '',
            password: '',
            confirmPassword: '',
            adminPassword:''

        }

    }

    onChangeAdminPassword(e){
        this.setState({
            adminPassword: e.target.value
        });
    }

    onClickConfirmButton (){

        this.state.username = this.props.username;
        this.state.password = this.props.password;
        this.state.confirmPassword = this.props.confirmPassword;


        const user ={
            username: this.state.username
        }

        axios.post('admin/validateUsername', user).then(res=>{

            alert('res: '+ res.data.message);
            if (res.data.message===true){
                
                if (this.state.password===this.state.confirmPassword){

                    if (this.state.password.length>=10&&this.state.password.length<=32){
                        this.setState({
                            open: !this.state.open
                        })
                    }
                    else{
                        alert('Password should contain 10 to 32 alphanumeric characters');
                    }
                }
                else{
                    alert('Passwords do not match.');
                }
                
                alert(this.props.username +" "+ this.props.password+" "+ this.props.confirmPassword);

            }
            else{
               // alert('Not found');
            }
            
        })


        
        
    }

    onAdminValidation(){


        const creds ={
            password:this.state.adminPassword
        }
        axios.post('admin/checkCurrentAdminPassword', creds).then
        (res=>{

            alert("MSG: "+res.data)

            if (res.data ===true){

                const user ={
                    username:this.state.username,
                    password:this.state.password
                }
                axios.post('admin/updateAccountPassword', user).then(res=>{
                  //  alert("CHANGED: ", res.message);
                  this.setState({
                    open: !this.state.open
                })

                }).catch((error)=>{
                        //alert("Error: "+ error);
                        console.log("Error Status:"+error.status);
                        console.log("Error Code: "+error.code);
                 });
            }
               
           
            
        
        }).catch((error)=>{
           // alert("Error: "+ error);
            console.log("Error Status:"+error.status);
            console.log("Error Code: "+error.code);
        });

       // alert('passed through');
        
    }


    render (){
        let open
        return(
            <div>
                <div className="ui right aligned floated labeled icon green button" id="reset-button" onClick = {this.onClickConfirmButton}>
                            CONFIRM
                            <i className="checkmark icon"></i>
                        </div>

                 <Modal id="login-clarification-modal" open={this.state.open}centered>
                    <Modal.Header>
                    <div className="header"><i className="edit icon" style={{color: "white"}}></i>&nbsp;&nbsp;Reset Password</div>
                    </Modal.Header>

                 <Modal.Content>
                <div className="header"><i className="edit icon" style={{color: "white"}}></i>&nbsp;&nbsp;Reset Password</div>
                    <div className="content">
                        <div className="ui form">
                         <div className="required field" id="admin-input-field">
                            <label>Please input admin password</label>
                            <input type="password" name="admin" id="admin-input" placeholder="Admin Password"value={this.state.adminPassword} onChange={this.onChangeAdminPassword}/>
                        </div>
                    </div>
                </div>
                <div className="actions">
                    <div className="ui right aligned floated labeled icon green button" id="reset-button-admin" onClick = {this.onAdminValidation}>
                        CONFIRM
                        <i className="checkmark icon"></i>
                    </div>
                    <div className="ui right labeled icon cancel button" onClick = {this.onClickConfirmButton}>
                        CANCEL
                        <i className="cancel icon"></i>
                    </div>
                </div>

                </Modal.Content>
               
            </Modal>


            </div>
           

            
      
       
       
        );
    }
}

export default LoginClarification;