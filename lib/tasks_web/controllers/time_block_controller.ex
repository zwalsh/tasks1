defmodule TasksWeb.TimeBlockController do
  use TasksWeb, :controller

  alias Tasks.TimeBlocks
  alias Tasks.TimeBlocks.TimeBlock

  action_fallback TasksWeb.FallbackController

  def index(conn, _params) do
    time_blocks = TimeBlocks.list_time_blocks()
    render(conn, "index.json", time_blocks: time_blocks)
  end

  def new(conn, %{"task_id" => task_id}) do
    now = DateTime.utc_now()
    params = %{"time_block" => %{start: now, task_id: task_id}}
    create(conn, params)
  end

  def create(conn, %{"time_block" => time_block_params}) do
    with {:ok, %TimeBlock{} = time_block} <- TimeBlocks.create_time_block(time_block_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.time_block_path(conn, :show, time_block))
      |> render("show.json", time_block: time_block)
    end
  end

  def show(conn, %{"id" => id}) do
    time_block = TimeBlocks.get_time_block!(id)
    render(conn, "show.json", time_block: time_block)
  end

  def end_block(conn, %{"id" => id}) do
    params = %{
        end: DateTime.utc_now()
    }
    update(conn, %{"id" => id, "time_block" => params})
  end

  def update(conn, %{"id" => id, "time_block" => time_block_params}) do
    time_block = TimeBlocks.get_time_block!(id)

    with {:ok, %TimeBlock{} = time_block} <- TimeBlocks.update_time_block(time_block, time_block_params) do
      render(conn, "show.json", time_block: time_block)
    end
  end

  def delete(conn, %{"id" => id}) do
    time_block = TimeBlocks.get_time_block!(id)

    with {:ok, %TimeBlock{}} <- TimeBlocks.delete_time_block(time_block) do
      send_resp(conn, :no_content, "")
    end
  end
end
