import React from "react";
import {
    Modal,
    Icon,
    Grid,
    Button,
    Segment,
    Divider,
    Checkbox,
    Header,
    Input,
} from "semantic-ui-react";
import DatePicker from "react-datepicker";
import moment from "moment";

class AdminEditScheduleModal extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            start: null,
            end: null,
            start_add: null,
            end_add: null,
            custom: false,
        };

        this.onChangeTime = this.onChangeTime.bind(this);
    }

    onChangeTime = (time) => {
        this.setState({
            time: time,
        });
    };

    handleOpen = () => this.props.handleModal("admin-edit-schedule");

    handleClose = () => this.props.handleModal("none");

    handleModal(name) {
        this.props.handleModal(name);
    }

    handleChange = (e, { name, value }) => this.setState({ [name]: value });

    handleStartAdd(time) {
        this.setState({ start_add: time });
    }

    handleEndAdd(time) {
        this.setState({ end_add: time });
    }

    handleStart(time) {
        this.setState({ start: time });
    }

    handleEnd(time) {
        this.setState({ end: time });
    }

    handleCheckbox = (e, { name }) => {
        this.setState({ [name]: e.target.checked });
    };

    handleDays = (e, { name }) => {
        let active = true;
        if (e.target.classList.contains("active")) {
            active = false;
        }
        this.setState({ [name]: active });
    };

    render() {
        let open;

        if (this.props.activeModal === "admin-edit-schedule") {
            open = true;
        } else {
            open = false;
        }

        const column_style = {
            textAlign: "center",
        };

        const checkbox_style = {
            margin: "20px 0 0 0",
        };

        let first_session_style = {
            fontWeight: "bold",
            color: "white",
        };
        let second_schedule;
        let repeat_buttons;
        if (this.state.custom) {
            second_schedule = (
                <>
                    <Grid centered columns={3}>
                        <Grid.Row style={{ padding: "0" }}>
                            <span
                                style={{ fontWeight: "bold" }}
                                id="edit-second-schedule"
                            >
                                Second Session
                            </span>
                        </Grid.Row>
                        <Grid.Column>
                            <DatePicker
                                placeholderText="Start Time"
                                required
                                showTimeSelect
                                showTimeSelectOnly
                                selected={this.state.start_add}
                                timeIntervals={30}
                                dateFormat="H:mm"
                                minTime={moment().toDate().setHours(8)}
                                maxTime={moment().toDate().setHours(18)}
                                onChange={(time) => this.handleStartAdd(time)}
                                customInput={
                                    <Input
                                        icon="time"
                                        iconPosition="left"
                                        placeholder="Start Time"
                                        id="edit-start-add"
                                        autoComplete="false"
                                        name="edit-start-add"
                                        required
                                    ></Input>
                                }
                            ></DatePicker>
                        </Grid.Column>
                        <Segment
                            basic
                            style={{
                                margin: "6px 0 0 0",
                                fontWeight: "bold",
                            }}
                        >
                            to
                        </Segment>
                        <Grid.Column>
                            <DatePicker
                                placeholderText="End Time"
                                required
                                showTimeSelect
                                showTimeSelectOnly
                                selected={this.state.end_add}
                                timeIntervals={30}
                                dateFormat="H:mm"
                                minTime={moment().toDate().setHours(8)}
                                maxTime={moment().toDate().setHours(18)}
                                onChange={(time) => this.handleEndAdd(time)}
                                customInput={
                                    <Input
                                        icon="time"
                                        iconPosition="left"
                                        placeholder="End Time"
                                        id="edit-end-add"
                                        autoComplete="false"
                                        name="edit-end-add"
                                        required
                                    ></Input>
                                }
                            ></DatePicker>
                        </Grid.Column>
                    </Grid>
                </>
            );
            first_session_style = {
                fontWeight: "bold",
            };
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

        return (
            <>
                <Modal
                    size="small"
                    id="edit-schedule-modal"
                    onClose={() => this.handleClose()}
                    onOpen={() => this.handleOpen()}
                    open={open}
                >
                    <Icon
                        name="close"
                        onClick={this.handleClose}
                        id="close-edit-schedule-modal"
                    ></Icon>
                    <Modal.Header as="h2">
                        <Icon name="edit" />
                        Edit Schedule
                    </Modal.Header>

                    <Modal.Content>
                        <Grid centered columns={1}>
                            <Grid.Column
                                style={{
                                    textAlign: "center",
                                    margin: "15px 0 0 0",
                                }}
                            >
                                <Grid.Row>
                                    <Header as="h3">Working Hours</Header>
                                </Grid.Row>
                            </Grid.Column>
                        </Grid>
                        <Grid centered columns={1}>
                            <Checkbox
                                style={checkbox_style}
                                id="edit-custom"
                                label="Customized Working Hours"
                                name="custom"
                                onChange={this.handleCheckbox}
                                checked={this.state.custom}
                            ></Checkbox>
                        </Grid>

                        <Grid
                            centered
                            columns={3}
                            style={{ margin: "40px 0 0 0" }}
                        >
                            <Grid.Row style={{ padding: "0" }}>
                                <span
                                    style={first_session_style}
                                    id="edit-first-schedule"
                                >
                                    First Session
                                </span>
                            </Grid.Row>
                            <Grid.Column>
                                <DatePicker
                                    placeholderText="Start Time"
                                    required
                                    showTimeSelect
                                    showTimeSelectOnly
                                    selected={this.state.start}
                                    timeIntervals={30}
                                    dateFormat="H:mm"
                                    minTime={moment().toDate().setHours(8)}
                                    maxTime={moment().toDate().setHours(18)}
                                    onChange={(time) => this.handleStart(time)}
                                    customInput={
                                        <Input
                                            icon="time"
                                            iconPosition="left"
                                            placeholder="Start Time"
                                            id="edit-start"
                                            autoComplete="false"
                                            name="edit-start"
                                            required
                                        ></Input>
                                    }
                                ></DatePicker>
                            </Grid.Column>
                            <Segment
                                basic
                                style={{
                                    margin: "6px 0 0 0",
                                    fontWeight: "bold",
                                }}
                            >
                                to
                            </Segment>
                            <Grid.Column>
                                <DatePicker
                                    placeholderText="End Time"
                                    required
                                    showTimeSelect
                                    showTimeSelectOnly
                                    selected={this.state.end}
                                    timeIntervals={30}
                                    dateFormat="H:mm"
                                    minTime={moment().toDate().setHours(8)}
                                    maxTime={moment().toDate().setHours(18)}
                                    onChange={(time) => this.handleEnd(time)}
                                    customInput={
                                        <Input
                                            icon="time"
                                            iconPosition="left"
                                            placeholder="End Time"
                                            id="edit-end"
                                            autoComplete="false"
                                            name="edit-end"
                                            required
                                        ></Input>
                                    }
                                ></DatePicker>
                            </Grid.Column>
                        </Grid>
                        {second_schedule}
                        {repeat_buttons}
                    </Modal.Content>

                    <Modal.Actions>
                        <Button
                            icon
                            labelPosition="left"
                            color="green"
                            id="add-schedule-button"
                            onClick={this.handleSubmit}
                        >
                            <Icon name="check" />
                            FINISH
                        </Button>
                    </Modal.Actions>
                </Modal>
            </>
        );
    }
}

export default AdminEditScheduleModal;
