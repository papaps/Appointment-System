import React, {Component} from 'react';
import moment from 'moment';
import {Modal, Form, Button, Icon, Card, Table, Tab} from 'semantic-ui-react'
import axios from 'axios'
import { SemanticToastContainer, toast } from 'react-semantic-toasts';
import 'react-semantic-toasts/styles/react-semantic-alert.css';
import '../secretary_css/secretary-view.css'

class SecretaryAvailabilityModal extends Component{

    constructor(props){
        super(props);

        this.state = {
            doctors:[],
            open: false,
            date:'',
        }

        this.setOpen = this.setOpen.bind(this)
    }
    setOpen(){
        this.setState({
            open:!this.state.open
        })
    }
    render(){
        return(
            <Modal
                    closeIcon
                    onClose={this.setOpen}
                    onOpen={this.setOpen}
                    open={this.state.open}
                    trigger={<Table.Cell id="secretary-available-table-cell" className="secretary-available-table-cell"
                    >
                        </Table.Cell>}
                >
                    <Modal.Header as={'h2'}>
                        
                    </Modal.Header>
                    <Modal.Content>
                        Are you sure you want to delete this appointment?
                    </Modal.Content>
                    <Modal.Actions>
                        <Button onClick={this.setOpen}>
                            {/* <Icon name="cancel"/> */}
                            Cancel
                        </Button>
                        <Button onClick={this.setOpen}>
                            {/* <Icon name="check"/> */}
                            Confirm
                        </Button>
                    </Modal.Actions>
                </Modal>
        )
    }

}
export default SecretaryAvailabilityModal