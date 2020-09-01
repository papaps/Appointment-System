import React from "react";
import axios from "axios";
import {Modal, Icon,  Button,  Form, Input} from 'semantic-ui-react'
import { toast } from "react-semantic-toasts";


class AdminAddProcedureModal extends React.Component{

    state = {
        procedure: '',
    }

    handleOpen = () => this.props.handleModal("admin-add-procedure");

    handleClose = () => this.props.handleModal('none')

    handleSubmit = event =>{
        event.preventDefault()
        const data = {
            name: this.state.procedure  
        }
        axios.post('admin/addProcess', data)
            .then(res=>{
                console.log(res)
                console.log(res.data)
            })
        this.handleClose()
        setTimeout(() =>{
            toast({
                type: "success",
                title: 'Success',
                description: <p>"New procedure successfully added"</p>,
                icon: "check"
            })
        }, 1000)
    }

    handleChange = (e, { name, value }) => this.setState({ [name]: value })

    render(){
        let open

        if(this.props.activeModal === "admin-add-procedure"){
            open = true
        }else{
            open = false
        }

        return(
            <Modal 
                closeIcon
                size="mini" 
                id="add-user-modal"
                onClose={()=>this.handleClose()}
                onOpen={()=>this.handleOpen()}
                open={open}
                >
                
                <Modal.Header as="h2">
                    <Icon name="clipboard"></Icon>
                    New Procedure
                </Modal.Header>

                <Modal.Content>
                    <Form onSubmit={this.handleSubmit}>
                        <Form.Field required id="procedure-field">
                            <label>Procedure Name</label>
                            <Input name="procedure" id="procedure-name" autoComplete="false" placeholder="Procedure Name" onChange={this.handleChange} /> 
                        </Form.Field>
                    </Form>
                </Modal.Content>


                <Modal.Actions>
                    <Button icon labelPosition='left' color="green" id="create-procedure-button" onClick={this.handleSubmit}>
                        <Icon name='check' />
                        CREATE
                    </Button>
                </Modal.Actions>
            </Modal>
        )
    }
}

export default AdminAddProcedureModal