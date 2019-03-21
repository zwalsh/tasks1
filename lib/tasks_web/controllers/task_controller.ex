defmodule TasksWeb.TaskController do
  use TasksWeb, :controller

  alias Tasks.Repo
  alias Tasks.Users
  alias Tasks.Tasks
  alias Tasks.Task

  # def personal_tasks(conn, params) do
  #   IO.inspect params
  #   user = Map.get(params, "user_id")
  #     |> case do
  #         nil -> conn.assigns[:current_user]
  #         id -> Users.get_user(id)
  #       end
  #
  #   if user do
  #     IO.inspect user
  #     tasks = Tasks.list_tasks_for_user(user.id)
  #     conn = conn
  #     |> assign(:for_user, true)
  #     |> assign(:email, user.email)
  #
  #     render(conn, "index.html", tasks: tasks)
  #   else
  #     conn
  #     |> redirect(to: Routes.task_path(conn, :index))
  #   end
  # end

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    conn = assign(conn, :for_user, false)
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    email = task_params["assignee"]
    user = Users.get_user_by_email(email)
    task_params = Map.put(task_params, "assignee_id", user.id)

    with {:ok, task} <- Tasks.create_task(task_params) do
      task = Repo.preload(task, :assignee)
      conn
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task(id)
    if task do
      render(conn, "show.json", task: task)
    else
      conn
      |> render(:error, "Task with id: #{id} does not exist")
    end
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    with {:ok, task} <- Tasks.update_task(task, task_params) do
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> render("show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    with {:ok, _task} <- Tasks.delete_task(task) do
      conn
      |> send_resp(200, "deleted")
    end
  end
end
