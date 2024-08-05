import 'package:dio/dio.dart';
import 'package:payment_paymob/constants.dart';

class PaymentManager {
  Future<String> getPaymentKey(int amount, String currency) async {
    try{

      String authenticationToken = await _getAuthenticationToken();
      int orderId = await _getOrderId(
          authenticationToken: authenticationToken,
          amount: (amount * 100).toString(),
          currency: currency);
      String paymentKey =await _getPaymentKey(
          currency: currency,
          amount: (amount * 100).toString(),
          orderId: orderId.toString(),
          authenticationToken: authenticationToken
      );
      return paymentKey;
    }catch(error){
      print("Error,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
      print(error.toString());
      throw Exception();
    }
  }

  Future<String> _getAuthenticationToken() async {
    final Response response = await Dio().post(
        "https://accept.paymob.com/api/auth/tokens",
        data: {"api_key": Constants.apiKey});
    return response.data['token'];
  }

  Future<int> _getOrderId(
      {required String authenticationToken,
      required String amount,
      required String currency}) async {
    final Response response = await Dio()
        .post("https://accept.paymob.com/api/ecommerce/orders", data: {
      "auth_token": authenticationToken,
      "amount_cents": amount,
      "currency": currency,
      "delivery_needed": "false",
      "items": []
    });
    return response.data['id'];
  }

  Future<String> _getPaymentKey(
      {required String authenticationToken,
      required String amount,
      required String currency,
      required String  orderId}) async {
    final Response response = await Dio().post(
        "https://accept.paymob.com/api/acceptance/payment_keys",
        data: {
          "auth_token": authenticationToken,
          "amount_cents": amount,
          "expiration": 3600,
          "order_id": orderId,
          "billing_data": {
            "apartment": "NA",
            "email": "claudette09@exa.com",
            "floor": "NA",
            "first_name": "Clifford",
            "street": "NA",
            "building": "NA",
            "phone_number": "+86(8)9135210487",
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "last_name": "Nicolas",
            "state": "NA"
          },
          "currency": currency,
          "integration_id": Constants.cardPaymentMethodIntegrationId
        });
    return response.data['token'];
  }
}
