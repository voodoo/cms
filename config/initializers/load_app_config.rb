raw_config = File.read(Rails.root + "config/app_config.yml")
APP_CONFIG = YAML.safe_load(raw_config, aliases: true)[Rails.env].symbolize_keys
