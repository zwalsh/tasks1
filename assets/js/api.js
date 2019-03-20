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

  fetch_users() {
    this.get(
      "/api/v1/users",
      (resp) => {
        store.dispatch({
          type: 'USER_LIST',
          data: resp.data,
        });
      }
    );
  }

  create_session(email, password) {
    this.post(
      "/api/v1/auth",
      {email, password},
      (resp) => {
        store.dispatch({
          type: 'NEW_SESSION',
          data: resp.data,
        });
      }
    );
  }
}

export default new Server();
