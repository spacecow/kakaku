raw_config = File.read(RAILS_ROOT + "/config/admin_authentication_config.yml")
ADMIN_AUTHENTICATION_CONFIG = YAML.load(raw_config)[RAILS_ENV].symbolize_keys
