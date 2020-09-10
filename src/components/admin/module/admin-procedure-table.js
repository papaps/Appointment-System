import React from "react";
import { Table } from "semantic-ui-react";
class AdminProcedureTable extends React.Component {
    //   const [datatable, setDatatable] = React.useState();
    state = {
        datatable: {
            columns: [
                {
                    label: "Name",
                    field: "Nname",
                    width: 150,
                    attributes: {
                        "aria-controls": "DataTable",
                        "aria-label": "Name",
                    },
                },
            ],
            rows: [],
        },
    };
    render() {
        return (
            <Table sortable singleLine selectable id="table">
                <Table.Header>
                    <Table.Row>
                        <Table.HeaderCell>Name</Table.HeaderCell>
                    </Table.Row>
                </Table.Header>
            </Table>
        );
    }
}

export default AdminProcedureTable;
