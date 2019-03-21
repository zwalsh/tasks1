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

function tasks(state = [], action) {
  switch (action.type) {
    case 'TASK_LIST':
      return action.data;
    case 'NEW_TASK':
      return state.concat(action.data);
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
  switch (action.type) {
    case 'LOGIN_FORM_SET_EMAIL':
      return _.assign({}, state, {email: action.data.email});
    case 'LOGIN_FORM_SET_PASSWORD':
      return _.assign({}, state, {password: action.data.password});
    default:
      return state;
  }
}

let task_form0 = {title: "", description: "", completed: false, assignee: ""}
function task_form(state = task_form0, action) {
  switch (action.type) {
    case 'UPDATE_TASK_FORM':
      return _.assign({}, state, action.data);
    case 'NEW_TASK':
      return task_form0;
    default:
      return state;
  }
}

function root_reducer(state0, action) {
  let reducer = combineReducers({users, tasks, session, login_form, task_form});
  let next_state = reducer(state0, action);
  return deepFreeze(next_state);
}

let store = createStore(root_reducer);
export default store;
