import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'payment_manager/payment_manager.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paymob Integration"),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: ()async=>_pay(),
              child: Text("pay 10 EGP"))
        ],
      ),

    );
  }
  Future<void>_pay()async{
    print("kkkkkkkkkkkkkkkkkkkk");
    PaymentManager().getPaymentKey(10, "EGP").then((String paymentKey){
      launchUrl(
          Uri.parse("https://accept.paymob.com/api/acceptance/iframes/826605?payment_token=$paymentKey"),

      );
    });

  }
}
