import React, { Component } from 'react';
import Logo from './logo.png';
import loginStyles from './loginCSS.css';
import axios from 'axios';
import Modal from 'react-modal';
import ResetPasswordModalComponent from './ResetPasswordModalComponent';

class LoginComponent extends Component {

    constructor (props){
        super(props);

        this.onChangeUserName = this.onChangeUserName.bind(this);
        this.onChangePassword = this.onChangePassword.bind(this);
        this.onSubmit = this.onSubmit.bind(this);
        this.state={
            username: '',
            password: '',
        }
    }



    onChangeUserName(e){
        this.setState({
            username: e.target.value
        });
    }

    onChangePassword(e){
        this.setState({
            password: e.target.value
        });
    }

    onSubmit (e){
        e.preventDefault();

        const user ={
            username: this.state.username,
            password: this.state.password
        }



        console.log(user);
        axios.get('https://localhost:5000/test', user).then
        (res=>console.log(res.data)).catch((error)=>{
            console.log("Error: "+ error);
            console.log("Error Status:"+error.status);
            console.log("Error Code: "+error.code);
        });
      //  window.location = '/';
    }

    render(){
        return (
        
           <div style={loginStyles}>
             <head>
              <title>Access Dental Clinic | Login</title>
              <script src="javascript/jquery.js"></script>
              <link rel="stylesheet" type="text/css" href="semantic/dist/semantic.min.css"></link>
    
            </head>
           

<div className="ui middle aligned center aligned very padded grid">
<div className = "column" style ={{maxWidth: "300px"}}>
            {/*ADD LOGO*/}
            <div className="row" style ={{marginTop: "-100px"}}><img src = {Logo} alt="pic" className="ui image" /></div>
            
            {/*FORM*/}
            <form className="ui large form" id="form" onSubmit={this.onSubmit}>
                <div className="ui stacked segment">
                     <div className="field" id="username-input">
                         <div className="ui left icon input">
                             <i className="user icon"></i>
                             <input type="text" 
                                    name="username" 
                                    id="username" 
                                    placeholder="Username"
                                    value={this.state.username}
                                    onChange ={this.onChangeUserName}></input>
                         </div>
                     </div> 
                     <div className="field" id="password-input">
                         <div className="ui left icon input">
                             <i className="lock icon"></i>
                             <input type="password" 
                                    name="password" 
                                    id="password" 
                                    placeholder="Password"
                                    value={this.state.password}
                                    onChange={this.onChangePassword}></input>
                         </div>
                     </div>
                     <div>
                         <Modal isOpen ={false}>{ResetPasswordModalComponent}</Modal>
                     </div>
                     <div className="ui button" id="forgot" style={{paddingBottom: "15px", textDecoration: "underline", backgroundColor: "transparent"}}>Forgot password?</div>
                         <button type="button" id="submit" className="ui fluid large pink submit button" onClick = {this.onSubmit}>Login</button>
                        
                </div>
            </form>
            
            </div>
            
            </div>

           </div>
           

           


        );
    }
}

export default LoginComponent;
