defmodule HyperlogWeb.MessagingQueue do
  def send_discord_token(token, user_id) do
    {:ok, connection} = AMQP.Connection.open
    {:ok, channel} = AMQP.Channel.open(connection)

    {:ok, send_data} = Poison.encode(%{access_token: token, user_id: user_id})

    AMQP.Queue.declare(channel, "discord_tokens")
    AMQP.Basic.publish(channel, "", "discord_tokens", send_data, [content_type: "application/json"])
    AMQP.Connection.close(connection)
  end

  def send_role_data(user_id, roles, action) do
    {:ok, connection} = AMQP.Connection.open
    {:ok, channel} = AMQP.Channel.open(connection)

    {:ok, send_data} = Poison.encode(%{user_id: user_id, roles: roles, action: action})

    AMQP.Queue.declare(channel, "discord_roles")
    AMQP.Basic.publish(channel, "", "discord_roles", send_data, [content_type: "application/json"])
    AMQP.Connection.close(connection)
  end
end
