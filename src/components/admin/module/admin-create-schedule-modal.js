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

class AdminCreateScheduleModal extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            start: null,
            end: null,
            start_add: null,
            end_add: null,
            daily: false,
            repeat: false,
            custom: false,
            mon: false,
            tue: false,
            wed: false,
            thu: false,
            fri: false,
            sat: false,
            disabled: [],
        };

        this.onChangeTime = this.onChangeTime.bind(this);
    }

    onChangeTime = (time) => {
        this.setState({
            time: time,
        });
    };

    handleOpen = () => this.props.handleModal("admin-create-schedule");

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
        let disabled = this.state.disabled;
        if (name == "daily") {
            disabled["repeat"] = !this.state.disabled["repeat"];
        } else if (name == "repeat") {
            disabled["daily"] = !this.state.disabled["daily"];
        }
        this.setState({ disabled: disabled });
    };

    handleDays = (e, { name }) => {
        let active = true;
        if (e.target.classList.contains("active")) {
            active = false;
        }
        this.setState({ [name]: active });
    };

    render() {
        console.log(this.state);
        let open;

        if (this.props.activeModal === "admin-create-schedule") {
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
                                id="second-schedule"
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
                                        id="start-add"
                                        autoComplete="false"
                                        name="start_add"
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
                                        id="end-add"
                                        autoComplete="false"
                                        name="end_add"
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
        if (this.state.repeat) {
            repeat_buttons = (
                <>
                    <Grid
                        centered
                        columns={1}
                        style={{
                            fontWeight: "bold",
                            padding: "0 0 10px 0",
                        }}
                    >
                        Repeat on
                    </Grid>
                    <Grid centered columns={6}>
                        <Button
                            circular
                            toggle
                            active={this.state.mon}
                            name="mon"
                            id="mon"
                            onClick={this.handleDays}
                        >
                            M
                        </Button>
                        <Button
                            circular
                            toggle
                            active={this.state.tue}
                            name="tue"
                            id="tue"
                            onClick={this.handleDays}
                        >
                            T
                        </Button>
                        <Button
                            circular
                            toggle
                            active={this.state.wed}
                            name="wed"
                            id="wed"
                            onClick={this.handleDays}
                        >
                            W
                        </Button>
                        <Button
                            circular
                            toggle
                            active={this.state.thu}
                            name="thu"
                            id="thu"
                            onClick={this.handleDays}
                        >
                            H
                        </Button>
                        <Button
                            circular
                            toggle
                            active={this.state.fri}
                            name="fri"
                            id="fri"
                            onClick={this.handleDays}
                        >
                            F
                        </Button>
                        <Button
                            circular
                            toggle
                            active={this.state.sat}
                            name="sat"
                            id="sat"
                            onClick={this.handleDays}
                        >
                            S
                        </Button>
                    </Grid>
                </>
            );
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
                    closeIcon
                    size="small"
                    id="adding-schedule-modal"
                    onClose={() => this.handleClose()}
                    onOpen={() => this.handleOpen()}
                    open={open}
                >
                    <Modal.Header as="h2">
                        <Icon name="calendar" />
                        Set Schedule
                    </Modal.Header>

                    <Modal.Content>
                        <Grid centered columns={1}>
                            <Grid.Column style={column_style}>
                                <Grid.Row>
                                    <Icon size="huge" name="user md"></Icon>
                                </Grid.Row>
                                <Grid.Row>
                                    <span
                                        id="doctor-name"
                                        style={{
                                            fontWeight: "bold",
                                            fontSize: 25 + "px",
                                        }}
                                    >
                                        {firstname} {lastname}
                                    </span>
                                </Grid.Row>
                            </Grid.Column>
                        </Grid>

                        <Divider horizontal> Customize Your Schedule</Divider>
                        <Grid centered columns={2}>
                            <Checkbox
                                disabled={this.state.disabled.daily}
                                style={checkbox_style}
                                id="daily"
                                label="Repeat Daily"
                                name="daily"
                                onChange={this.handleCheckbox}
                                checked={this.state.daily}
                            ></Checkbox>
                            <Checkbox
                                disabled={this.state.disabled.repeat}
                                style={checkbox_style}
                                id="repeat"
                                label="Customized Recurrence"
                                name="repeat"
                                onChange={this.handleCheckbox}
                                checked={this.state.repeat}
                            ></Checkbox>
                        </Grid>
                        <Grid centered columns={1}>
                            <Checkbox
                                style={checkbox_style}
                                id="custom"
                                label="Customized Working Hours"
                                name="custom"
                                onChange={this.handleCheckbox}
                                checked={this.state.custom}
                            ></Checkbox>
                        </Grid>

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
                        <Grid centered columns={3}>
                            <Grid.Row style={{ padding: "0" }}>
                                <span
                                    style={first_session_style}
                                    id="first-schedule"
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
                                            id="start"
                                            autoComplete="false"
                                            name="start"
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
                                            id="end"
                                            autoComplete="false"
                                            name="end"
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

export default AdminCreateScheduleModal;
