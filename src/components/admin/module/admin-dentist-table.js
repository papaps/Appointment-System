import React from "react";
import { Table, Button, Icon } from "semantic-ui-react";
import axios from "axios";

class AdminDentistTable extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            dentists: [],
        };
    }

    handleShowDimmer = () => this.props.handleShowDimmer();
    handleHideDimmer = () => this.props.handleHideDimmer();

    handleModal(name, processname) {
        this.props.handleModal(name, processname);
    }

    componentDidMount() {
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
                            username: dentist.username
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
                        <Table.HeaderCell>First Name</Table.HeaderCell>
                        <Table.HeaderCell>Last Name</Table.HeaderCell>
                        <Table.HeaderCell>Last Login</Table.HeaderCell>
                        <Table.HeaderCell textAlign="center">
                            Status
                        </Table.HeaderCell>
                        <Table.HeaderCell textAlign="center">
                            Schedule
                        </Table.HeaderCell>
                        <Table.HeaderCell textAlign="right"></Table.HeaderCell>
                    </Table.Row>
                </Table.Header>
                <Table.Body>
                    {this.state.dentists.map(
                        ({ key, firstname, lastname, status, lastLogin, username }) => (
                            <Table.Row key={key}>
                                <Table.Cell>{firstname}</Table.Cell>
                                <Table.Cell>{lastname}</Table.Cell>
                                <Table.Cell>{lastLogin}</Table.Cell>
                                <Table.Cell textAlign="center">
                                    {status}
                                </Table.Cell>
                                <Table.Cell textAlign="center">
                                    <Button color="green">View</Button>
                                </Table.Cell>
                                <Table.Cell textAlign="right">
                                    <Icon name="edit" size="large"
                                    onClick={() =>
                                        this.handleModal(
                                            "admin-edit-dentist",
                                            { key, firstname, lastname }
                                        )
                                    }></Icon>
                                    <Icon name="trash" size="large"
                                    onClick={() =>
                                        this.handleModal(
                                            "admin-delete-dentist",
                                            { key, firstname, lastname }
                                        )
                                    }></Icon>
                                </Table.Cell>
                            </Table.Row>
                        )
                    )}
                </Table.Body>
            </Table>
        );
    }
}

export default AdminDentistTable;
