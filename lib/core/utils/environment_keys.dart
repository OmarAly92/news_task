sealed class EnvironmentKeys {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://news-feed.mock',
  );

  static const bool useMockApi = bool.fromEnvironment(
    'USE_MOCK_API',
    defaultValue: true,
  );
}
