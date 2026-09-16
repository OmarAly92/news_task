class MockHttpException implements Exception {
  const MockHttpException(this.statusCode, this.body);

  final int statusCode;
  final Map<String, dynamic> body;

  factory MockHttpException.notFound(String what) => MockHttpException(404, {
    'status': 'error',
    'code': 'NOT_FOUND',
    'message': '$what was not found.',
  });

  factory MockHttpException.temporaryFailure([String? message]) =>
      MockHttpException(503, {
        'status': 'error',
        'code': 'TEMPORARY_FAILURE',
        'message': message ?? 'Something went wrong. Please retry.',
      });

  factory MockHttpException.badRequest(String message) => MockHttpException(
    400,
    {'status': 'error', 'code': 'BAD_REQUEST', 'message': message},
  );
}
