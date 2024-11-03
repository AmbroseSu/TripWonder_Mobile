class OrderCode {
  static final OrderCode _instance = OrderCode._internal();

  int? _orderCode;

  factory OrderCode() {
    return _instance;
  }

  OrderCode._internal();

  // Getter and Setter for ID
  int? get orderCode => _orderCode;

  set orderCode(int? orderCode) {
    _orderCode = orderCode;
  }


}