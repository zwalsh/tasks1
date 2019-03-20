defmodule TasksWeb.TaskView do
  use TasksWeb, :view

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TasksWeb.TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TasksWeb.TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{id: task.id,
      description: task.desc,
      title: task.title,
      assignee: render_one(task.assignee, TasksWeb.UserView, "user.json")}
  end
end
