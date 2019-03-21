import store from './store';

class Server {
  get(path, callback) {
    $.ajax(path, {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: callback,
    });
  }

  post(path, data, callback) {
    $.ajax(path, {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify(data),
      success: callback,
      // TODO: add failure callback
    });
  }

  delete(path, callback) {
    $.ajax(path, {
      method: "delete",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: callback,
    })
  }

  fetch_users() {
    this.get(
      "/api/users",
      (resp) => {
        store.dispatch({
          type: 'USER_LIST',
          data: resp.data,
        });
      }
    );
  }

  fetch_tasks() {
    this.get(
      "/api/tasks",
      (resp) => {
        store.dispatch({
          type: 'TASK_LIST',
          data: resp.data,
        });
      }
    )
  }

  login() {
    let email = store.getState().login_form.email;
    let password = store.getState().login_form.password;
    this.post(
      "/api/auth",
      {email, password},
      (resp) => {
        store.dispatch({
          type: 'NEW_SESSION',
          data: resp.data,
        });
      }
    );
  }

  deleteTask(id) {
    this.delete("/api/tasks/" + id);
  }

  createTask() {
    let task_form = store.getState().task_form;
    let data = {
      "task": {
        "title": task_form.title,
        "desc": task_form.description,
        "completed": false,
        "assignee": task_form.assignee,
        "time_taken": task_form.time_taken
      }
    }
    this.post(
      "/api/tasks",
      data,
      (resp) => {
        store.dispatch({
          type: 'NEW_TASK',
          data: resp.data,
        })
      }
    )
  }
}

export default new Server();
