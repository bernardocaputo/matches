defmodule Matches.DataFecherSupervisorTest do
  use ExUnit.Case

  alias Matches.DataFecherSupervisor

  test "start_supervised correctly starts the supervisor and children" do
    arg = {:providers, 1}

    {:ok, supervisor_pid} = DataFecherSupervisor.start_link([arg])

    assert [{{:providers, 1}, _pid_worker, :worker, [Matches.DataFecher]}] =
             Supervisor.which_children(DataFecherSupervisor)

    assert Process.alive?(supervisor_pid)
  end
end
