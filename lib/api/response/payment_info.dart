class PaymentInformation {
  final String bin;
  final String accountNumber;
  final String accountName;
  final int amount;
  final String description;
  final int orderCode;
  final String currency;
  final String paymentLinkId;
  final String status;
  final String? expiredAt;
  final String checkoutUrl;
  final String qrCode;

  PaymentInformation({
    required this.bin,
    required this.accountNumber,
    required this.accountName,
    required this.amount,
    required this.description,
    required this.orderCode,
    required this.currency,
    required this.paymentLinkId,
    required this.status,
    this.expiredAt,
    required this.checkoutUrl,
    required this.qrCode,
  });

  // Factory constructor to create an instance from JSON
  factory PaymentInformation.fromJson(Map<String, dynamic> json) {
    final content = json['content'];
    return PaymentInformation(
      bin: content['bin'],
      accountNumber: content['accountNumber'],
      accountName: content['accountName'],
      amount: content['amount'],
      description: content['description'],
      orderCode: content['orderCode'],
      currency: content['currency'],
      paymentLinkId: content['paymentLinkId'],
      status: content['status'],
      expiredAt: content['expiredAt'],
      checkoutUrl: content['checkoutUrl'],
      qrCode: content['qrCode'],
    );
  }

  // Method to convert object back to JSON if needed
  Map<String, dynamic> toJson() {
    return {
      'content': {
        'bin': bin,
        'accountNumber': accountNumber,
        'accountName': accountName,
        'amount': amount,
        'description': description,
        'orderCode': orderCode,
        'currency': currency,
        'paymentLinkId': paymentLinkId,
        'status': status,
        'expiredAt': expiredAt,
        'checkoutUrl': checkoutUrl,
        'qrCode': qrCode,
      },
      'message': null,
      'details': ['URL payment link'],
      'statusCode': 200,
      'meatadataDTO': null,
    };
  }
}
