defmodule HyperlogWeb.Helpers.Defaults do
  defmacro __using__(_) do
    quote do
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def title(_view_template, _assigns), do: "Hyperlog"
    end
  end
end
