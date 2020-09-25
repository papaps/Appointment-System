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
import axios from "axios";
import { toast } from "react-semantic-toasts";

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
            days: {
                mon: false,
                tue: false,
                wed: false,
                thu: false,
                fri: false,
                sat: false,
            },
            disabled: [],
        };
    }

    handleSubmit = (event, { datakey }) => {
        event.preventDefault();
        let days = this.state.days;
        let day_array = {
            mon: [],
            tue: [],
            wed: [],
            thu: [],
            fri: [],
            sat: [],
        };
        let break_array = {
            mon: [],
            tue: [],
            wed: [],
            thu: [],
            fri: [],
            sat: [],
        };

        let start = moment(this.state.start).format("k:mm");
        let end = moment(this.state.end).format("k:mm");
        let start_add;
        let end_add;
        if (this.state.start_add != null) {
            start_add = moment(this.state.start_add).format("k:mm");
        }
        if (this.state.end_add != null) {
            end_add = moment(this.state.end_add).format("k:mm");
        }

        moment()

        for (var day in days) {
            console.log(day);
            if (this.state.daily && this.state.custom) {
                day_array[day].push(start);
                day_array[day].push(end_add);
                break_array[day].push(end);
                break_array[day].push(start_add);
            } else if (this.state.daily) {
                day_array[day].push(start);
                day_array[day].push(end);
            } else if (this.state.repeat) {
                if (days[day]) {
                    if (this.state.custom) {
                        day_array[day].push(start);
                        day_array[day].push(end_add);
                        break_array[day].push(end);
                        break_array[day].push(start_add);
                    } else {
                        day_array[day].push(start);
                        day_array[day].push(end);
                    }
                }
            }
        }
        const data = {
            "monday[]": day_array["mon"],
            "tuesday[]": day_array["tue"],
            "wednesday[]": day_array["wed"],
            "thursday[]": day_array["thu"],
            "friday[]": day_array["fri"],
            "saturday[]": day_array["sat"],
            "mondaydifference[]": break_array["mon"],
            "tuesdaydifference[]": break_array["tue"],
            "wednesdaydifference[]": break_array["wed"],
            "thursdaydifference[]": break_array["thu"],
            "fridaydifference[]": break_array["fri"],
            "saturdaydifference[]": break_array["sat"],
            doctorID: datakey,
            defaultTime: "false",
        };

        console.log(data);
        axios.post("admin/addSchedule", data).then((response) => {
            if (response.data) {
                setTimeout(() => {
                    toast({
                        type: "success",
                        title: "Success",
                        description: <p>Dentist schedule successfully added</p>,
                        icon: "check",
                    });
                }, 1000);
                this.handleClose();
                this.setState({
                    start: null,
                    end: null,
                    start_add: null,
                    end_add: null,
                    daily: false,
                    repeat: false,
                    custom: false,
                    days: {
                        mon: false,
                        tue: false,
                        wed: false,
                        thu: false,
                        fri: false,
                        sat: false,
                    },
                    disabled: [],
                });
            }
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
        let days = this.state.days;
        let active = true;
        if (e.target.classList.contains("active")) {
            active = false;
        }
        days[name] = active;
        this.setState({ days: days });
    };

    render() {
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
        var  minTime = new Date();
        var maxTime = new Date();
        minTime.setHours(8);
        minTime.setMinutes(0);
        maxTime.setHours(18);
        maxTime.setMinutes(0);

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
                                minTime={minTime}
                                maxTime={maxTime}
                                onChange={(time) => this.handleStartAdd(time)}
                                customInput={
                                    <Input
                                        icon="time"
                                        iconPosition="left"
                                        placeholder="Start Time"
                                        id="start-add"
                                        autoComplete="false"
                                        name="start-add"
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
                                minTime={minTime}
                                maxTime={maxTime}
                                onChange={(time) => this.handleEndAdd(time)}
                                customInput={
                                    <Input
                                        icon="time"
                                        iconPosition="left"
                                        placeholder="End Time"
                                        id="end-add"
                                        autoComplete="false"
                                        name="end-add"
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
                            active={this.state.days.mon}
                            name="mon"
                            id="mon"
                            onClick={this.handleDays}
                        >
                            M
                        </Button>
                        <Button
                            circular
                            toggle
                            active={this.state.days.tue}
                            name="tue"
                            id="tue"
                            onClick={this.handleDays}
                        >
                            T
                        </Button>
                        <Button
                            circular
                            toggle
                            active={this.state.days.wed}
                            name="wed"
                            id="wed"
                            onClick={this.handleDays}
                        >
                            W
                        </Button>
                        <Button
                            circular
                            toggle
                            active={this.state.days.thu}
                            name="thu"
                            id="thu"
                            onClick={this.handleDays}
                        >
                            H
                        </Button>
                        <Button
                            circular
                            toggle
                            active={this.state.days.fri}
                            name="fri"
                            id="fri"
                            onClick={this.handleDays}
                        >
                            F
                        </Button>
                        <Button
                            circular
                            toggle
                            active={this.state.days.sat}
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
                                    minTime={minTime}
                                    maxTime={maxTime}
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
                                    minTime={minTime}
                                    maxTime={maxTime}
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
                            datakey={key}
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
