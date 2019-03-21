
import React from 'react';
import _ from 'lodash';
import { connect } from 'react-redux';
import api from './api';
import store from './store';

export default connect(({tasks, task_form}) => { return {tasks, task_form};})((props) => {
  let rows = _.map(props.tasks, (t) => <Task key={t.id} task={t} />);
  return <div className="row">
    <div className="col-12">
      <table className="table table-striped">
        <thead>
          <tr>
            <th>Title</th>
            <th>Description</th>
            <th>Completed?</th>
            <th>Time taken</th>
            <th>Assignee</th>
            <th>Submit</th>
          </tr>
        </thead>
        <tbody>
          {rows}
          <NewTask props={props.task_form} />
        </tbody>
      </table>
    </div>
  </div>;
});

function Task(props) {
  let {task} = props;
  return <tr>
    <td>{task.title}</td>
    <td>{task.description}</td>
    <td>{task.completed ? "Yes" : "No"}</td>
    <td>{task.time_taken}</td>
    <td>{task.assignee.email}</td>
  </tr>;
}

function updateTaskForm(ev) {
  let data = {};
  data[ev.target.id] = ev.target.value;
  store.dispatch({
    type: 'UPDATE_TASK_FORM',
    data: data
  });
}

function NewTask(props) {
  let {title, description, completed, assignee, time_taken} = props;
  return <tr>
    <td>
      <input id="title"
        value={title}
        onChange={updateTaskForm}
        placeholder="Title"/>
    </td>
    <td>
      <input id="description"
        value={description}
        onChange={updateTaskForm}
        placeholder="Description"/>
    </td>
    <td>
      <input id="completed"
        value={completed}
        onChange={updateTaskForm}
        type="checkbox"/>
    </td>
    <td>
      <input id="time_taken"
        value={time_taken}
        onChange={updateTaskForm}
        placeholder="Time (in minutes, 15-min increments)"
        type="number"/>
    </td>
    <td>
      <input id="assignee"
        value={assignee}
        onChange={updateTaskForm}
        placeholder="Assignee Email"/>
    </td>
    <td>
      <button onClick={api.createTask.bind(api)}>Submit</button>
    </td>
  </tr>;
}
