use Mix.Config

config :handwrite, api_key: System.fetch_env!("HANDWRITE_API_KEY")
