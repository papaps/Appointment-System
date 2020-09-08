import React from "react";
import { Grid, Table, Dimmer, Segment } from "semantic-ui-react";

class AdminTable extends React.Component {
    state = {};

    handleShowDimmer = () => this.setState({ active: true });
    handleHideDimmer = () => this.setState({ active: false });
    render() {
        const { active } = this.state;
        return (
            <Grid.Column style={{ width: "85%" }}>
                <Table singleLine selectable id="table">
                    <Dimmer active={active} inverted id="list-dimmer">
                        <div className="ui elastic huge green loader"></div>
                    </Dimmer>
                </Table>
            </Grid.Column>
        );
    }
}

export default AdminTable;
