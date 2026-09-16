import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class CubitRecorder<S> {
  CubitRecorder(this.cubit) {
    _subscription = cubit.stream.listen(states.add);
  }

  final Cubit<S> cubit;
  final List<S> states = [];
  late final StreamSubscription<S> _subscription;

  void clear() => states.clear();

  Future<void> dispose() async {
    await _subscription.cancel();
    await cubit.close();
  }
}

Future<void> flushMicrotasks([int rounds = 5]) async {
  for (var i = 0; i < rounds; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}
