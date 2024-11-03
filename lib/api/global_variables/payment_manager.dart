class PaymentManager {
  static final PaymentManager _instance = PaymentManager._internal();
  String orderCode = '';

  factory PaymentManager() {
    return _instance;
  }

  PaymentManager._internal();
}
