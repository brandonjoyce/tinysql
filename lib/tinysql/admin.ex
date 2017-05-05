defmodule Tinysql.Admin do
  def create_database(database) do
    encoding = "UTF8"
		{output, status} = run_with_psql "CREATE DATABASE " <> database <> " ENCODING='#{encoding}'"

    cond do
      status == 0                                -> :ok
      String.contains?(output, "already exists") -> {:error, :already_up}
      true                                       -> {:error, output}
    end
  end

  defp run_with_psql(sql_command) do
    unless System.find_executable("psql") do
      raise "could not find executable `psql` in path, " <>
            "please guarantee it is available before running ecto commands"
    end

    [hostname: host, username: username, password: password] = Tinysql.Util.connection_opts()
    env = [{"PGPASSWORD", password}]
    args = ["-p", "5432", "-U", username]
    args = args ++ ["--quiet", "--host", host, "-d", "template1", "-c", sql_command]
    System.cmd("psql", args, env: env, stderr_to_stdout: true)
  end
end
