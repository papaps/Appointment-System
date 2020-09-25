import React from "react";
import AdminSidebar from "../module/admin-sidebar";
import AdminTable from "../module/admin-table";
import AdminCreateModal from "../module/admin-create-modal";
import AdminCreateScheduleModal from "../module/admin-create-schedule-modal";
import AdminAddDentistModal from "../module/admin-add-dentist-modal";
import AdminAddProcedureModal from "../module/admin-add-procedure-modal";
import AdminResetSecretaryModal from "../module/admin-reset-secretary-modal";
import AdminResetPasswordModal from "../module/admin-reset-password-modal";
import AdminFreeMemoryModal from "../module/admin-free-memory-modal";
import AdminEditProcedureModal from "../module/admin-edit-procedure-modal";
import "../../../css/admin.css";
import { Grid, Dimmer } from "semantic-ui-react";
import "semantic-ui-css/components/reset.min.css";
import "semantic-ui-css/components/site.min.css";
import "semantic-ui-css/components/container.min.css";
import "semantic-ui-css/components/icon.min.css";
import "semantic-ui-css/components/message.min.css";
import "semantic-ui-css/components/header.min.css";
import { SemanticToastContainer, toast } from "react-semantic-toasts";
import AdminDeleteProcedureModal from "../module/admin-delete-procedure-modal";
import AdminEditDentistModal from "../module/admin-edit-dentist-modal";
import AdminDeleteDentistModal from "../module/admin-delete-dentist-modal";
import AdminEditScheduleModal from "../module/admin-edit-schedule-modal"
import axios from "axios";
class Admin extends React.Component {
    constructor(props) {
        super(props);

        this.handleItem = this.handleItem.bind(this);
        this.handleModal = this.handleModal.bind(this);
        this.handleTable = this.handleTable.bind(this);
        this.handleUpdateDentistTable = this.handleUpdateDentistTable.bind(
            this
        );
        this.handleUpdateProcedureTable = this.handleUpdateProcedureTable.bind(
            this
        );
        this.handleShowDimmer = this.handleShowDimmer.bind(this);
        this.handleHideDimmer = this.handleHideDimmer.bind(this);
        this.state = {
            activeItem: "Dentist",
            activeModal: "none",
            activeTable: "Dentist",
            dentists: [],
            procedures: [],
            activeDimmer: false,
        };

        this.handleUpdateDentistTable();
        this.handleUpdateProcedureTable();
    }

    handleItem(name) {
        this.setState({
            activeItem: name,
        });
    }

    handleModal(name, data) {
        this.setState({
            activeModal: name,
            data: data,
        });
    }

    handleTable(name) {
        this.setState({
            activeTable: name,
        });
    }

    handleUpdateDentistTable() {
        this.handleShowDimmer();
        axios.get("admin/getAllDentists").then((response) => {
            this.setState({
                dentists: [
                    ...response.data.dentists.map((dentist) => {
                        return {
                            key: dentist._id,
                            firstname: dentist.firstname,
                            lastname: dentist.lastname,
                            status: dentist.status,
                            lastLogin: dentist.lastLogin,
                            username: dentist.username,
                        };
                    }),
                ],
            });
            this.handleHideDimmer();
        });
    }

    handleUpdateProcedureTable() {
        this.handleShowDimmer();
        axios.get("admin/getAllProcedures").then((response) => {
            this.setState({
                procedures: [
                    ...response.data.procedures.map((procedure) => {
                        return {
                            key: procedure._id,
                            processname: procedure.processname,
                        };
                    }),
                ],
            });
            this.handleHideDimmer();
        });
    }

    handleShowDimmer = () => this.setState({ activeDimmer: true });
    handleHideDimmer = () => this.setState({ activeDimmer: false });

    render() {
        return (
            <>
                <SemanticToastContainer position="top-center"></SemanticToastContainer>
                <Grid
                    columns={2}
                    id="container"
                    style={{ padding: 0 + "px", margin: 0 + "px" }}
                >
                    <AdminSidebar
                        handleItem={this.handleItem}
                        handleTable={this.handleTable}
                        handleModal={this.handleModal}
                        activeItem={this.state.activeItem}
                    />
                    <Grid.Column style={{ width: "85%", overflowY:"scroll", maxHeight: "100vh" }}>
                        <Dimmer
                            active={this.state.activeDimmer}
                            inverted
                            id="list-dimmer"
                            style={{maxHeight: "100%"}}
                        >
                            <div className="ui elastic huge green loader"></div>
                        </Dimmer>
                        <AdminTable
                            activeTable={this.state.activeTable}
                            handleModal={this.handleModal}
                            dentists={this.state.dentists}
                            procedures={this.state.procedures}
                            handleUpdateDentistTable={
                                this.handleUpdateDentistTable
                            }
                            handleUpdateProcedureTable={
                                this.handleUpdateProcedureTable
                            }
                        />
                    </Grid.Column>
                </Grid>
                <AdminCreateModal
                    handleModal={this.handleModal}
                    activeModal={this.state.activeModal}
                ></AdminCreateModal>
                <AdminAddDentistModal
                    handleModal={this.handleModal}
                    activeModal={this.state.activeModal}
                    handleUpdateTable={this.handleUpdateDentistTable}
                ></AdminAddDentistModal>
                <AdminCreateScheduleModal
                    handleModal={this.handleModal}
                    activeModal={this.state.activeModal}
                    data={this.state.data}
                ></AdminCreateScheduleModal>
                <AdminAddProcedureModal
                    handleModal={this.handleModal}
                    activeModal={this.state.activeModal}
                    handleUpdateTable={this.handleUpdateProcedureTable}
                ></AdminAddProcedureModal>
                <AdminResetSecretaryModal
                    handleModal={this.handleModal}
                    activeModal={this.state.activeModal}
                ></AdminResetSecretaryModal>
                <AdminResetPasswordModal
                    handleModal={this.handleModal}
                    activeModal={this.state.activeModal}
                ></AdminResetPasswordModal>
                <AdminFreeMemoryModal
                    handleModal={this.handleModal}
                    activeModal={this.state.activeModal}
                ></AdminFreeMemoryModal>
                <AdminEditProcedureModal
                    handleModal={this.handleModal}
                    activeModal={this.state.activeModal}
                    data={this.state.data}
                    handleUpdateTable={this.handleUpdateProcedureTable}
                ></AdminEditProcedureModal>
                <AdminEditDentistModal
                    handleModal={this.handleModal}
                    activeModal={this.state.activeModal}
                    data={this.state.data}
                    handleUpdateTable={this.handleUpdateDentistTable}
                ></AdminEditDentistModal>
                <AdminEditScheduleModal
                    handleModal={this.handleModal}
                    activeModal={this.state.activeModal}
                    data={this.state.data}
                ></AdminEditScheduleModal>
                <AdminDeleteProcedureModal
                    handleModal={this.handleModal}
                    activeModal={this.state.activeModal}
                    data={this.state.data}
                    handleUpdateTable={this.handleUpdateProcedureTable}
                ></AdminDeleteProcedureModal>
                <AdminDeleteDentistModal
                    handleModal={this.handleModal}
                    activeModal={this.state.activeModal}
                    data={this.state.data}
                    handleUpdateTable={this.handleUpdateDentistTable}
                ></AdminDeleteDentistModal>
            </>
        );
    }
}

export default Admin;
