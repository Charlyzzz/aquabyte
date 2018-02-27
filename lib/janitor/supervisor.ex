defmodule Aquabyte.JanitorSupervisor do
  use Supervisor

  alias Aquabyte.Janitor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      %{
        id: Janitor,
        start: {Janitor, :start_link, []}
      }
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end