import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze';

function users(state = [], action) {
  switch (action.type) {
  case 'USER_LIST':
    return action.data;
  default:
    return state;
  }
}

function session(state = null, action) {
  switch (action.type) {
  case 'NEW_SESSION':
    return action.data;
  default:
    return state;
  }
}

let login_form0 = {email: "", password: ""};
function login_form(state = login_form0, action) {
  // TODO: update here to change form?
  return state;
}

function root_reducer(state0, action) {
  let reducer = combineReducers({users, session, login_form});
  let next_state = reducer(state0, action);
  return deepFreeze(next_state);
}

let store = createStore(root_reducer);
export default store;
