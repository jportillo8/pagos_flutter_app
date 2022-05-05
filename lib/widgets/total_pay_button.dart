import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pagos_app_flutter/blocs/pagar/pagar_bloc.dart';
import 'package:pagos_app_flutter/helpers/helpers.dart';
import 'package:pagos_app_flutter/services/stripe_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TotalPayButton extends StatelessWidget {
  const TotalPayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final pagarBloc = BlocProvider.of<PagarBloc>(context).state;
    return Container(
      width: width,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('${pagarBloc.montoPagar} ${pagarBloc.modena}',
                style: const TextStyle(fontSize: 20)),
          ],
        ),
        BlocBuilder<PagarBloc, PagarState>(
          builder: (context, state) {
            return _BtnPay(state: state);
          },
        )
      ]),
    );
  }
}

class _BtnPay extends StatelessWidget {
  final PagarState state;
  const _BtnPay({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(state.tarjetaActiva);
    return state.tarjetaActiva
        ? builBotonTarjeta(context)
        : buildAppleAndGooglePay(context);
  }

  Widget builBotonTarjeta(BuildContext context) {
    return MaterialButton(
        height: 45,
        minWidth: 170,
        shape: const StadiumBorder(),
        elevation: 0,
        color: Colors.black,
        child: Row(children: [
          Icon(FontAwesomeIcons.solidCreditCard, color: Colors.white),
          const Text('  PagarT',
              style: TextStyle(color: Colors.white, fontSize: 22)),
        ]),
        onPressed: () async {
          mostraLoading(context);

          final stripeService = StripeService();
          final state = BlocProvider.of<PagarBloc>(context).state;
          final tarjeta = state.tarjeta;
          final mesAnio = tarjeta!.expiracyDate.split('/');

          final resp = await stripeService.pagarConTarjetaExiste(
              amount: state.montoPagarString,
              currency: state.modena,
              card: CreditCard(
                number: tarjeta.cardNumber,
                expMonth: int.parse(mesAnio[0]),
                expYear: int.parse(mesAnio[1]),
              ));

          Navigator.pop(context);

          if (resp.ok) {
            mostraAlerta(context, 'Tarjeta Ok', 'Todo correcto');
          } else {
            mostraAlerta(context, 'Algo salio mal', resp.msg);
          }
        });
  }

  Widget buildAppleAndGooglePay(BuildContext context) {
    return MaterialButton(
        height: 45,
        minWidth: 150,
        shape: const StadiumBorder(),
        elevation: 0,
        color: Colors.black,
        child: Row(children: [
          Icon(
              Platform.isAndroid
                  ? FontAwesomeIcons.google
                  : FontAwesomeIcons.apple,
              color: Colors.white),
          const Text(' PayX',
              style: TextStyle(color: Colors.white, fontSize: 22)),
        ]),
        onPressed: () async {
          final stripeService = StripeService();
          final state = BlocProvider.of<PagarBloc>(context).state;
          final resp = await stripeService.pagarApplePayGooglePay(
              amount: state.montoPagarString, currency: state.modena);
        });
  }
}
