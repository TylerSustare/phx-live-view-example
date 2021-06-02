defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Front Porch Light</h1>

    <div id="light">
      <div class="meter">
        <span style="width: <%= @brightness %>%">
          <%= @brightness %>%
        </span>
      </div>

      <button phx-click="off">
        <img src="images/light-off.svg" alt="">
      </button>

      <button phx-click="down">
        <img src="images/down.svg" alt="">
      </button>

      <button phx-click="up">
        <img src="images/up.svg" alt="">
      </button>

      <button phx-click="on">
        <img src="images/light-on.svg" alt="">
      </button>

      <button phx-click="random">
        ?
      </button>

    </div>
    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    brightness = socket.assigns.brightness + 10
    socket = assign(socket, :brightness, min(brightness, 100))
    {:noreply, socket}
  end

  # the same as "up" just more idomatic elixir
  def handle_event("down", _, socket) do
    # capture syntax for anonymous function &()
    # brightness value is &1
    socket = update(socket, :brightness, &max(&1 - 10, 0))
    {:noreply, socket}
  end

  def handle_event("random", _, socket) do
    socket = assign(socket, :brightness, Enum.random(0..10))
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end
end
