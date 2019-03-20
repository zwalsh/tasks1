
import React from 'react';
import ReactDOM from 'react-dom';
import { Link, BrowserRouter as Router, Route } from 'react-router-dom';
import _ from 'lodash';
import $ from 'jquery';
import { Provider } from 'react-redux';

import api from './api';

import Header from './header';
import UserList from './user_list';
import TaskList from './task_list';

export default function root_init(node, store) {
  ReactDOM.render(
    <Provider store={store}>
      <Root />
    </Provider>, node);
}

class Root extends React.Component {
  constructor(props) {
    super(props);

    // do API calls here to initialize state
  }

  render() {
    return <div>
      <Router>
        <div>
          <Header />
          <div className="row">
            <div className="col-8">
              <Route path="/" exact={true} render={() =>
                <UserList />
              } />
              <Route path="/users" exact={true} render={() =>
                <UserList />
              } />
              <Route path="/tasks" exact={true} render={() =>
                <TaskList />
              } />
            </div>
          </div>
        </div>
      </Router>
    </div>;
  }
}
