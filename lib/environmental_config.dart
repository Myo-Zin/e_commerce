class EnvironmentConfig {
  static const baseUrl = String.fromEnvironment('BASE_URL',
      defaultValue: "https://demo.ktechnologygroup.com");
}