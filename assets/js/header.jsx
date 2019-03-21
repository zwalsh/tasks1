
import React from 'react';
import _ from 'lodash';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';
import api from './api';
import store from './store';

function Header(props) {
  let {session, email, password} = props;
  let session_info;
  if (session == null) {
    session_info = <div className="form-inline my-2">
      <input type="email"
              placeholder="email"
              value={email}
              onChange={updateEmail}/>
      <input type="password"
              placeholder="password"
              value={password}
              onChange={updatePassword}/>
      <button className="btn btn-secondary" onClick={api.login.bind(api)}>Login</button>
      <button className="btn btn-secondary" onClick={api.register.bind(api)}>Register</button>
    </div>;
  }
  else {
    session_info = <div className="my-2">
      <p>Logged in as {session.user_id}</p>
      <button onClick={logout}>Logout</button>
    </div>
  }

  return <div className="row my-2">
          <div className="col-4">
            <h3>Task Tracker</h3>
          </div>
          <div className="col-4">
            <p>
              <Link to={"/users"}>Users</Link>
            </p>
            <p>
              <Link to={"/tasks"}>Tasks</Link>
            </p>
          </div>
          <div className="col-4">
            {session_info}
          </div>
        </div>;
}

function logout() {
  console.log('logging out');
  store.dispatch({
    type: 'DELETE_SESSION',
    data: {},
  });
}

function updateEmail(ev) {
  store.dispatch({
    type: 'LOGIN_FORM_SET_EMAIL',
    data: {
      email: ev.target.value
    }
  });
}

function updatePassword(ev) {
  store.dispatch({
    type: 'LOGIN_FORM_SET_PASSWORD',
    data: {
      password: ev.target.value
    }
  });
}

function state2props(state) {
  return {
    session: state.session,
    email: state.login_form.email,
    password: state.login_form.password
  };
}

export default connect(state2props)(Header);
