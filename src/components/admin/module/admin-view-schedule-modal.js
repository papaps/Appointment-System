import React from "react";
import {
    Modal,
    Icon,
    Grid,
    Button,
    Segment,
    Table,
    Dimmer,
} from "semantic-ui-react";
class AdminViewScheduleModal extends React.Component {
    state = {
        activeTable: "weekly",
    };

    handleOpen = () => this.props.handleModal("admin-view-schedule");

    handleClose = () => this.props.handleModal("none");

    handleModal(name) {
        this.props.handleModal(name);
    }

    render() {
        let open;

        if (this.props.activeModal === "admin-view-schedule") {
            open = true;
        } else {
            open = false;
        }

        let firstname;
        let lastname;
        let key;
        if (
            this.props.data != null &&
            this.props.data.firstname != null &&
            this.props.data.lastname != null
        ) {
            key = this.props.data.key;
            firstname = this.props.data.firstname;
            lastname = this.props.data.lastname;
        }

        const icon_styling = {
            marginRight: 13.5 + "px",
        };

        let schedule = this.props.schedule;
        let schedule_table;
        let buttons;
        if (this.state.activeTable == "weekly") {
            buttons = (
                <>
                    <Button id="weekly" color="green">
                        Weekly Schedule
                    </Button>
                    <Button id="unavailable">Unavailable Date</Button>
                </>
            );
            if (schedule != null) {
                schedule_table = (
                    <>
                        {schedule.map(({ key, name, time }) => (
                            <Table.Row>
                                <Table.Cell
                                    style={{
                                        textAlign: "center",
                                        fontWeight: "bold",
                                        width: "46%",
                                    }}
                                >
                                    {name}
                                </Table.Cell>
                                <Table.Cell
                                    style={{
                                        textAlign: "center",
                                        width: "46%",
                                    }}
                                >
                                    {time.map(({ range }) => (
                                        <>
                                            {range} <br />
                                        </>
                                    ))}
                                </Table.Cell>
                                <Table.Cell
                                    textAlign="right"
                                    style={{ width: "8%" }}
                                >
                                    <Icon
                                        name="edit"
                                        id={name.toString() + "-edit"}
                                        size="large"
                                        key={key}
                                    ></Icon>
                                </Table.Cell>
                            </Table.Row>
                        ))}
                    </>
                );
            }
        } else {
            buttons = (
                <>
                    <Button id="weekly">Weekly Schedule</Button>
                    <Button id="unavailable" color="green">
                        Unavailable Date
                    </Button>
                </>
            );
        }

        return (
            <>
                <Modal
                    size="small"
                    id="schedule-modal"
                    onClose={() => this.handleClose()}
                    onOpen={() => this.handleOpen()}
                    open={open}
                >
                    <Icon
                        name="close"
                        onClick={this.handleClose}
                        id="close-schedule-modal"
                    ></Icon>
                    <Modal.Header as="h2">
                        <Icon name="calendar" />
                        Schedule
                    </Modal.Header>

                    <Modal.Content scrolling>
                        <Grid>
                            <Grid.Row>
                                <Grid.Column width={13}>
                                    <Icon
                                        name="user"
                                        size="big"
                                        style={icon_styling}
                                    />
                                    <span
                                        id="doctor-name-schedule"
                                        style={{
                                            fontWeight: "bold",
                                            fontSize: 20 + "px",
                                        }}
                                    >
                                        {firstname}&nbsp;
                                        {lastname}
                                    </span>
                                </Grid.Column>
                                <Grid.Column width={3} textAlign="right">
                                    <Button
                                        id="add-schedule"
                                        color="green"
                                        key={key}
                                    >
                                        Reset
                                    </Button>
                                </Grid.Column>
                            </Grid.Row>
                            <Grid.Row centered={true}>{buttons}</Grid.Row>
                            <Table celled selectable id="schedule-table">
                                <Table.Body id="table-schedule">
                                    {schedule_table}
                                </Table.Body>
                            </Table>
                            <Dimmer
                                active={this.props.activeDimmer}
                                inverted
                                id="table-dimmer"
                            >
                                <div className="ui elastic huge green loader"></div>
                            </Dimmer>
                        </Grid>
                    </Modal.Content>

                    <Modal.Actions></Modal.Actions>
                </Modal>
            </>
        );
    }
}

export default AdminViewScheduleModal;
