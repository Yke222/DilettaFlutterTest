class EnvironmentConfig {
  static const String endpointName = String.fromEnvironment(
    'endpointName',
    defaultValue: 'https://65779a0f197926adf62e955d.mockapi.io/',
  );
}