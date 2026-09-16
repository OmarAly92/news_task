class MockServerConfig {
  MockServerConfig({
    this.latency = const Duration(milliseconds: 450),
    this.failureRate = 0,
    this.failNextRequest = false,
    Set<String>? alwaysFailPaths,
  }) : alwaysFailPaths = alwaysFailPaths ?? <String>{};

  Duration latency;
  double failureRate;
  bool failNextRequest;
  final Set<String> alwaysFailPaths;
}
