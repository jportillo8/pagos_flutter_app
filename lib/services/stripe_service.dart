import 'package:dio/dio.dart';
import 'package:pagos_app_flutter/models/payment_intent_response.dart';
import 'package:pagos_app_flutter/models/stripe_custom_response.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  // Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  final String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  static const String _secretKey =
      'sk_test_51KvwPJDUIuyvCpsu7R2V2pygQrzd1eUOu8yAFZJkLb8b0OpvYqNwbEmZxe3N8bQC4vItehEXFEHoZGHmyJwUdKvP00imONfs2e';
  final String _apiKey =
      'pk_test_51KvwPJDUIuyvCpsuvsQ9J04XA2LTZheqoxejAgimn4ZpZpeJFMp9dG5tBtQSAWQTeZ6NxYRA5VtAYBiAFkCU2idh00kjxeaUhB';

  final headerOptions = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {'Authorization': 'Bearer ${StripeService._secretKey}'});

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

/*Este metodo resuelve y verifica una tarjeta valida*/
  Future<StripeCustomResponse> pagarNuevaTarjeta({
    required String amount,
    required String currency,
  }) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      final stripeRes = await _realizarPago(
          amount: amount, currency: currency, paymentMethod: paymentMethod);

      return stripeRes;
    } catch (e) {
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }

  Future pagarApplePayGooglePay({
    required String amount,
    required String currency,
  }) async {}

/*Este metodo es creado para obtener el intent de el pago*/
  Future<PaymentIntentResponse> _crearPaymentIntent({
    required String amount,
    required String currency,
  }) async {
    try {
      final dio = Dio();
      final data = {
        'amount': amount,
        'currency': currency,
      };
      final resp = await dio.post(
        _paymentApiUrl,
        data: data,
        options: headerOptions,
      );
      print('xxxxxxxx ${resp.realUri}');
      return PaymentIntentResponse.fromMap(resp.data);
    } catch (e) {
      print('Errror en intento: ${e.toString()}');
      return PaymentIntentResponse(status: '400');
    }
  }

  Future<StripeCustomResponse> _realizarPago(
      {required String amount,
      required String currency,
      required PaymentMethod paymentMethod}) async {
    try {
      // Crear el intent
      final paymentIntent =
          await _crearPaymentIntent(amount: amount, currency: currency);
      // Confirmar Cobro
      final paymentResult = await StripePayment.confirmPaymentIntent(
          PaymentIntent(
              clientSecret: paymentIntent.clientSecret,
              paymentMethodId: paymentMethod.id));
      print(paymentResult.status);
      if (paymentResult.status == 'succeeded') {
        return StripeCustomResponse(ok: true);
      } else {
        return StripeCustomResponse(
            ok: false, msg: 'Fallo: ${paymentResult.status}');
      }
    } catch (e) {
      print(e.toString());
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }
}
