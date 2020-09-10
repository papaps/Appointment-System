import React from "react";
import { Grid, Table, Dimmer, Segment } from "semantic-ui-react";
import AdminDentistTable from "./admin-dentist-table";
import AdminProcedureTable from "./admin-procedure-table";

class AdminTable extends React.Component {
    state = {};
    constructor(props) {
        super(props);
    }

    handleShowDimmer = () => this.setState({ active: true });
    handleHideDimmer = () => this.setState({ active: false });
    render() {
        const { active } = this.state;
        let activeItem = this.props.activeItem;
        let table;
        if (activeItem === "Dentist") {
            table = <AdminDentistTable></AdminDentistTable>;
        } else {
            table = <AdminProcedureTable></AdminProcedureTable>;
        }
        return (
            <>
                <Dimmer active={active} inverted id="list-dimmer">
                    <div className="ui elastic huge green loader"></div>
                </Dimmer>
                <Grid.Column style={{ width: "85%" }}>{table}</Grid.Column>
            </>
        );
    }
}

export default AdminTable;
