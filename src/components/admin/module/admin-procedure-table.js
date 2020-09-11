import React from "react";
import { Table, Button } from "semantic-ui-react";
import axios from "axios";

class AdminProcedureTable extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            procedures: [],
        };
    }

    handleShowDimmer = () => this.props.handleShowDimmer();
    handleHideDimmer = () => this.props.handleHideDimmer();
    handleModal(name, processname) {
        this.props.handleModal(name, processname);
    }

    componentDidMount() {
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
        });
        this.handleHideDimmer();
    }

    componentWillUnmount() {
        this.handleShowDimmer();
    }

    render() {
        return (
            <Table sortable singleLine selectable id="table">
                <Table.Header>
                    <Table.Row>
                        <Table.HeaderCell>Name</Table.HeaderCell>
                        <Table.HeaderCell textAlign="center"></Table.HeaderCell>
                    </Table.Row>
                </Table.Header>
                <Table.Body>
                    {this.state.procedures.map(({ key, processname }) => (
                        <Table.Row key={key}>
                            <Table.Cell>{processname}</Table.Cell>
                            <Table.Cell textAlign="right">
                                <Button
                                    onClick={() =>
                                        this.handleModal(
                                            "admin-edit-procedure",
                                            { key, processname }
                                        )
                                    }
                                >
                                    Edit
                                </Button>
                                <Button negative>Delete</Button>
                            </Table.Cell>
                        </Table.Row>
                    ))}
                </Table.Body>
            </Table>
        );
    }
}

export default AdminProcedureTable;
