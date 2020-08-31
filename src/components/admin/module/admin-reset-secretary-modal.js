import React from "react";
import {Modal, Icon, Popup, Button,  Form, Input} from 'semantic-ui-react'


class AdminResetSecretaryModal extends React.Component{

    handleOpen = () => this.props.handleModal("admin-reset-secretary");

    handleClose = () => this.props.handleModal('none')

    handleModal(name){
        this.props.handleModal(name)
    }

    render(){
        let open

        if(this.props.activeModal === "admin-reset-secretary"){
            open = true
        }else{
            open = false
        }
        return(
            <Modal 
                closeIcon
                size="mini" 
                id="reset-secretary-modal"
                onClose={()=>{this.handleClose()}}
                onOpen={()=>this.handleOpen()}
                open={open}
                >
                
                <Modal.Header as="h2">
                    <Icon name="edit"></Icon>
                    Edit Secretary Password
                </Modal.Header>

                <Modal.Content>
                    <Form>
                        <Form.Field required id="sec-current-password-field" >
                            <label>Current Password</label>
                            <Input name="currentPassword" type="password" id="sec-current-password" autoComplete="false" placeholder="Confirm Password" />
                        </Form.Field>
                        <Form.Field required id="sec-new-password-field" >
                            <label>New Password</label>
                            <Popup
                                trigger={<Input name="newPassword" type="password" id="sec-new-password" autoComplete="false" placeholder="New Password" />}
                                content='Password should contain 10 to 32 alphanumeric characters'
                                position='right center'
                                />
                        </Form.Field>
                        <Form.Field required id="sec-confirm-new-password-field">
                            <label>Confirm New Password</label>
                            <Popup
                                trigger={<Input name="confirmNewPassword" type="password"id="sec-confirm-new-password" autoComplete="false" placeholder="Confirm New Password" />}
                                content='Password should contain 10 to 32 alphanumeric characters'
                                position='right center'
                                />
                        </Form.Field>
                    </Form>
                </Modal.Content>


                <Modal.Actions>
                    <Button icon labelPosition='left' color="green" id="sec-save-password">
                        <Icon name='check' />
                        CONFIRM
                    </Button>
                </Modal.Actions>
            </Modal>
        )
    }
}

export default AdminResetSecretaryModal