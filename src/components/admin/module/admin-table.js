import React from "react";

class AdminTable extends React.Component{

    render(){
        return(
            <div className="column" style={{width: 85 + '%'}}>
                <table className="ui striped selectable table" id="table"> 
                    <div className="ui inverted dimmer" id="list-dimmer">
                        <div className="ui elastic huge green loader"></div>
                    </div>
                </table>
            </div>
        )
    }
}

export default AdminTable