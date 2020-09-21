import React from "react";
import { Modal, Icon, Button, Segment } from "semantic-ui-react";

class AdminFreeMemoryModal extends React.Component {
    handleOpen = () => this.props.handleModal("admin-free-memory");

    handleClose = () => this.props.handleModal("none");

    render() {
        let open;

        if (this.props.activeModal === "admin-free-memory") {
            open = true;
        } else {
            open = false;
        }

        const segment_style = {
            textAlign: "center",
        };

        const paragraph_style = {
            textAlign: "center",
            fontWeight: "bold",
        };

        return (
            <>
                <Modal
                    closeIcon
                    size="tiny"
                    id="old-modal"
                    onClose={() => this.handleClose()}
                    onOpen={() => this.handleOpen()}
                    open={open}
                >
                    <Modal.Header as="h2">
                        <Icon name="recycle"></Icon>
                        Free-up Memory
                    </Modal.Header>

                    <Modal.Content>
                        <Segment basic style={segment_style}>
                            <Icon size="big" name="exclamation triangle"></Icon>
                        </Segment>
                        <p style={paragraph_style}>
                            This program was designed to handle 512MB to
                            maintain the free service. We will warn every year
                            to delete past appointments made 5 years ago and
                            beyond. We strongly recommend to continue this
                            action.
                        </p>
                    </Modal.Content>

                    <Modal.Actions>
                        <Button
                            icon
                            labelPosition="left"
                            color="red"
                            id="create-procedure-button"
                        >
                            <Icon name="trash" />
                            DELETE
                        </Button>
                    </Modal.Actions>
                </Modal>
            </>
        );
    }
}

export default AdminFreeMemoryModal;
