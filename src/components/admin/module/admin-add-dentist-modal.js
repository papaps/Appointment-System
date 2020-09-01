import React from "react";
import axios from "axios";
import {Modal, Icon, Popup, Button,  Form, Input} from 'semantic-ui-react'
import {toast} from 'react-semantic-toasts'


class AdminAddDentistModal extends React.Component{

    state = {
        firstname: '',
        lastname: '',
        username: '',
        password: '',
        confirmPassword: '',
    }

    handleOpen = () => this.props.handleModal("admin-add-dentist");

    handleClose = () => this.props.handleModal('none')

    handleChange = (e, { name, value }) => this.setState({ [name]: value })

    handleSubmit = event =>{
        event.preventDefault()
        const data = {
            firstname: this.state.firstname,
            lastname: this.state.lastname,
            username: this.state.username,
            password: this.state.password,
            type: 'dentist',
            status: 'Active'
        }
        axios.post('admin/addDentist', data)
        .then(res=>{
            console.log(res)
            console.log(res.data)
        })
        this.handleClose()
        setTimeout(() =>{
            toast({
                type: "success",
                title: 'Success',
                description: <p>"New dentist successfully added"</p>,
                icon: "check"
            })
        }, 1000)
    }

    render(){
        let open

        if(this.props.activeModal === "admin-add-dentist"){
            open = true
        }else{
            open = false
        }
        return(
            <Modal 
                closeIcon
                size="mini" 
                id="add-dentist-modal"
                onClose={()=>this.handleClose()}
                onOpen={()=>this.handleOpen()}
                open={open}
                >
                
                <Modal.Header as="h2">
                    <Icon name="user md"></Icon>
                    New Dentist
                </Modal.Header>

                <Modal.Content>
                    <Form onSubmit={this.handleSubmit}>
                        <Form.Field required id="firstname-field-dentist">
                            <label>First Name</label>
                            <Popup
                                trigger={  <Input name="firstname" id="add-firstname-dentist" autoComplete="false" placeholder="First Name" onChange={this.handleChange} />  }
                                content='Name should contain at least 2 characters'
                                position='right center'
                                /> 
                        </Form.Field>
                        <Form.Field required id="lastname-field-dentist">
                            <label>Last Name</label> 
                            <Popup
                                trigger={<Input name="lastname" id="add-lastname-dentist" autoComplete="false" placeholder="Last Name" onChange={this.handleChange}/>}
                                content='Name should contain at least 2 characters'
                                position='right center'
                                />
                        </Form.Field>
                        <Form.Field required id="username-field-dentist">
                            <label>Username</label>
                            <Popup
                                trigger={<Input name="username" id="add-username-dentist" autoComplete="false" placeholder="Username" onChange={this.handleChange} />}
                                content='You will not be able to change your username once created'
                                position='right center'
                                />
                        </Form.Field>
                        <Form.Field required id="password-field-dentist" >
                            <label>Password</label>
                            <Popup
                                trigger={<Input name="password" type="password" id="add-password-dentist" autoComplete="false" placeholder="Pasword" onChange={this.handleChange} />}
                                content='Password should contain 10 to 32 alphanumeric characters'
                                position='right center'
                                />
                        </Form.Field>
                        <Form.Field required id="confirm-password-field-dentist">
                            <label>Confirm Password</label>
                            <Popup
                                trigger={<Input name="confirmPassword" type="password"id="confirm-password-dentist" autoComplete="false" placeholder="Pasword" onChange={this.handleChange} />}
                                content='Password should contain 10 to 32 alphanumeric characters'
                                position='right center'
                                />
                        </Form.Field>
                    </Form>
                </Modal.Content>


                <Modal.Actions>
                    <Button icon labelPosition='left' color="green" id="create-dentist-button" onClick={this.handleSubmit}>
                        <Icon name='check' />
                        CREATE
                    </Button>
                </Modal.Actions>
            </Modal>
        )
    }
}

export default AdminAddDentistModal