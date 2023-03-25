class EnvironmentConfig {
  static const baseUrl = String.fromEnvironment('BASE_URL',
      defaultValue: "https://demo.ktechnologygroup.com/wp-json/wc/v3");
}