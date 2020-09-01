import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import { Route, Link, BrowserRouter as Router } from 'react-router-dom';
import App from './App';
import Secretary from "./components/secretary/views/week_all.component";
import Admin from "./components/admin/pages/admin"
import * as serviceWorker from './serviceWorker';
import 'semantic-ui-css/semantic.min.css';
import {SemanticToastContainer} from 'react-semantic-toasts'


const routing = (
  <Router>
    <div className="App">
      <SemanticToastContainer />
      <Route path = "/" component={App}/>
      <Route path = "/secretary" component={Secretary}/>
      <Route path = "/admin" component={Admin}/>
    </div>
  </Router>
)
ReactDOM.render(
  routing,
  document.getElementById('root')
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
