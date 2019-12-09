defmodule HyperlogWeb.SendDiscordToken do
  def send_token(token) do
    {:ok, connection} = AMQP.Connection.open
    {:ok, channel} = AMQP.Channel.open(connection)

    AMQP.Queue.declare(channel, "discord_tokens")
    AMQP.Basic.publish(channel, "", "discord_tokens", token)
    AMQP.Connection.close(connection)
  end
end
