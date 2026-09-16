enum AuthErrorStatus { actionRequired }

extension AppEnumExtension on AuthErrorStatus {
  String get value {
    switch (this) {
      case AuthErrorStatus.actionRequired:
        return 'action_required';
    }
  }
}

enum ReservationPaymentType { full, partial }

extension PaymentEnumExtension on ReservationPaymentType {
  String get value {
    switch (this) {
      case ReservationPaymentType.full:
        return 'full';
      case ReservationPaymentType.partial:
        return 'partial';
    }
  }
}
