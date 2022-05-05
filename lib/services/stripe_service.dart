import 'package:flutter/cupertino.dart';
import 'package:pagos_app_flutter/models/stripe_custom_response.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  // Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  String secretKey =
      'sk_test_51KvwPJDUIuyvCpsu7R2V2pygQrzd1eUOu8yAFZJkLb8b0OpvYqNwbEmZxe3N8bQC4vItehEXFEHoZGHmyJwUdKvP00imONfs2e';
  String _apiKey =
      'pk_test_51KvwPJDUIuyvCpsuvsQ9J04XA2LTZheqoxejAgimn4ZpZpeJFMp9dG5tBtQSAWQTeZ6NxYRA5VtAYBiAFkCU2idh00kjxeaUhB';

  // Inicializacion de el usuario
  void init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: _apiKey, androidPayMode: 'test', merchantId: 'test'));
  }

  Future pagarConTarjetaExiste({
    required String amount,
    required String currency,
    required CreditCard card,
  }) async {}

  Future<StripeCustomResponse> pagarNuevaTarjeta({
    required String amount,
    required String currency,
  }) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      // TODO Crear el intent
      return StripeCustomResponse(ok: true);
    } catch (e) {
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }

  Future pagarApplePayGooglePay({
    required String amount,
    required String currency,
  }) async {}

  Future _crearPaymentIntent({
    required String amount,
    required String currency,
  }) async {}

  Future _realizarPago(
      {required String amount,
      required String currency,
      required PaymentMethod paymentMethod}) async {}
}
