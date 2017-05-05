defmodule Tinysql.Util do
  def connection_opts(opts \\ []) do
    host = Application.get_env(:tinysql, :db_host)
    username = Application.get_env(:tinysql, :db_user)
    password = Application.get_env(:tinysql, :db_password)
    [hostname: host, username: username, password: password] ++ opts
  end
end
