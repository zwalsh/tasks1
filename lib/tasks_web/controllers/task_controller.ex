defmodule TasksWeb.TaskController do
  use TasksWeb, :controller

  alias Tasks.Users
  alias Tasks.Tasks
  alias Tasks.Task

  def personal_tasks(conn, params) do
    IO.inspect params
    user = Map.get(params, "user_id")
      |> case do
          nil -> conn.assigns[:current_user]
          id -> Users.get_user(id)
        end

    if user do
      IO.inspect user
      tasks = Tasks.list_tasks_for_user(user.id)
      conn = conn
      |> assign(:for_user, true)
      |> assign(:email, user.email)

      render(conn, "index.html", tasks: tasks)
    else
      conn
      |> redirect(to: Routes.task_path(conn, :index))
    end
  end

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    conn = assign(conn, :for_user, false)
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    current_user = conn.assigns[:current_user]

    changeset = Tasks.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task(id)
    if task do
      render(conn, "show.html", task: task)
    else
      conn
      |> put_flash(:error, "Task with id: #{id} does not exist")
      |> redirect(to: Routes.task_path(conn, :index))
    end
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task(id)
    if task do
      changeset = Tasks.change_task(task)
      render(conn, "edit.html", task: task, changeset: changeset)
    else
      conn
      |> put_flash(:error, "Task with id: #{id} does not exist")
      |> redirect(to: Routes.task_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
