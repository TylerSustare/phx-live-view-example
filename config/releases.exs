# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

database_url =
  "ecto://yfmrqtvxjkzpzc:722a2af4cdb3bf271564c31755fcc03343a5610add9964e83c14ba4e55fa956d@ec2-34-204-121-199.compute-1.amazonaws.com:5432/d1680skf9eink6"

# System.get_env("DATABASE_URL") ||
#   raise """
#   environment variable DATABASE_URL is missing.
#   For example: ecto://USER:PASS@HOST/DATABASE
#   """

config :live_view_studio, LiveViewStudio.Repo,
  ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base = "GZ1+mgSuyGxpKyLOXZdgf6HCKre90HNjtCCaXEDBtUObbebidpv83hLr0IDX1YKq"
# System.get_env("SECRET_KEY_BASE") ||
#   raise """
#   environment variable SECRET_KEY_BASE is missing.
#   You can generate one by calling: mix phx.gen.secret
#   """

config :live_view_studio, LiveViewStudioWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "8080"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
config :live_view_studio, LiveViewStudioWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
