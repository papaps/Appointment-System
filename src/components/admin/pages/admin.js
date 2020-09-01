import React from "react";
import AdminSidebar from "../module/admin-sidebar"
import AdminTable from "../module/admin-table"
import AdminCreateModal from "../module/admin-create-modal"
import AdminAddDentistModal from "../module/admin-add-dentist-modal"
import AdminAddProcedureModal from "../module/admin-add-procedure-modal"
import AdminResetSecretaryModal from "../module/admin-reset-secretary-modal"
import AdminResetPasswordModal from "../module/admin-reset-password-modal"
import AdminFreeMemoryModal from "../module/admin-free-memory-modal"
import "../../../css/admin.css"
import {Grid} from 'semantic-ui-react'
import {SemanticToastContainer} from 'react-semantic-toasts'
class Admin extends React.Component{
    
    constructor(props){
        super(props)

        this.handleItem = this.handleItem.bind(this)
        this.handleModal = this.handleModal.bind(this)

        this.state = {
            activeItem : 'Dentist',
            activeModal : 'none',
        }
    
    }

    handleItem(name){
        this.setState({
            activeItem : name,
        })
    }

    handleModal(name){
        this.setState({
            activeModal : name,
        })
    }
    
    render(){
        return(
            <>
                <Grid columns={2} id="container" style={{padding: 0+"px", margin: 0+"px"}}>
                    <AdminSidebar handleItem={this.handleItem} handleModal={this.handleModal} activeItem={this.state.activeItem} />
                    <AdminTable />
                </Grid>
                <SemanticToastContainer />
                <AdminCreateModal handleModal={this.handleModal} activeModal={this.state.activeModal}></AdminCreateModal>
                <AdminAddDentistModal handleModal={this.handleModal} activeModal={this.state.activeModal}></AdminAddDentistModal>
                <AdminAddProcedureModal handleModal={this.handleModal} activeModal={this.state.activeModal}></AdminAddProcedureModal>
                <AdminResetSecretaryModal handleModal={this.handleModal} activeModal={this.state.activeModal}></AdminResetSecretaryModal>
                <AdminResetPasswordModal handleModal={this.handleModal} activeModal={this.state.activeModal}></AdminResetPasswordModal>
                <AdminFreeMemoryModal handleModal={this.handleModal} activeModal={this.state.activeModal}></AdminFreeMemoryModal>
            </>
        )
    }
}

export default Admin