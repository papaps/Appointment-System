import React from "react";
import { Grid, Table, Dimmer, Segment } from "semantic-ui-react";
import AdminDentistTable from "./admin-dentist-table";
import AdminProcedureTable from "./admin-procedure-table";

class AdminTable extends React.Component {
    state = {};
    constructor(props) {
        super(props);

        this.handleShowDimmer = this.handleShowDimmer.bind(this);
        this.handleHideDimmer = this.handleHideDimmer.bind(this);

        this.state = {
            active: true,
        };
    }

    handleShowDimmer = () => this.setState({ active: true });
    handleHideDimmer = () => this.setState({ active: false });
    render() {
        const { active } = this.state;
        let activeTable = this.props.activeTable;
        let table;
        if (activeTable === "Dentist") {
            table = (
                <AdminDentistTable
                    handleHideDimmer={this.handleHideDimmer}
                    handleShowDimmer={this.handleShowDimmer}
                    handleModal={this.props.handleModal}
                ></AdminDentistTable>
            );
        } else if (activeTable === "Procedure") {
            table = (
                <AdminProcedureTable
                    handleHideDimmer={this.handleHideDimmer}
                    handleShowDimmer={this.handleShowDimmer}
                    handleModal={this.props.handleModal}
                ></AdminProcedureTable>
            );
        }
        return (
            <>
                <Grid.Column style={{ width: "85%" }}>
                    <Dimmer active={active} inverted id="list-dimmer">
                        <div className="ui elastic huge green loader"></div>
                    </Dimmer>
                    {table}
                </Grid.Column>
            </>
        );
    }
}

export default AdminTable;
