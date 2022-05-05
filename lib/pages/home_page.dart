import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pagos_app_flutter/blocs/pagar/pagar_bloc.dart';

import 'package:pagos_app_flutter/data/tarjetas.dart';
import 'package:pagos_app_flutter/helpers/helpers.dart';
import 'package:pagos_app_flutter/pages/tarjeta_page.dart';
import 'package:pagos_app_flutter/services/stripe_service.dart';
import 'package:pagos_app_flutter/widgets/total_pay_button.dart';

class HomePage extends StatelessWidget {
  final stripeService = StripeService();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pagarBloc = BlocProvider.of<PagarBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Pagar'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                mostraLoading(context);
                // await Future.delayed(Duration(seconds: 1));
                // mostraAlerta(context, 'hola', 'mundo');
                final amount = pagarBloc.state.montoPagarString;
                final currency = pagarBloc.state.modena;
                final resp = await stripeService.pagarNuevaTarjeta(
                    amount: amount, currency: currency);

                Navigator.pop(context);

                if (resp.ok) {
                  mostraAlerta(context, 'Tarjeta Ok', 'Todo correcto');
                } else {
                  mostraAlerta(context, 'Algo salio mal', resp.msg);
                }
              },
            )
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              width: size.width,
              height: size.height,
              top: 200,
              child: PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  physics: const BouncingScrollPhysics(),
                  itemCount: tarjetas.length,
                  itemBuilder: (_, i) {
                    final tarjeta = tarjetas[i];
                    return GestureDetector(
                      onTap: () {
                        pagarBloc.add(OnSeleccionarTarjeta(tarjeta));
                        Navigator.push(
                            context, navegarFadeIn(context, TarjetaPage()));
                      },
                      child: Hero(
                        tag: tarjeta.cardNumber,
                        child: CreditCardWidget(
                          cardNumber: tarjeta.cardNumberHidden,
                          expiryDate: tarjeta.expiracyDate,
                          cardHolderName: tarjeta.cardHolderName,
                          cvvCode: tarjeta.cvv,
                          showBackView: false,
                          onCreditCardWidgetChange: (CreditCardBrand) {},
                        ),
                      ),
                    );
                  }),
            ),
            const Positioned(bottom: 0, child: TotalPayButton())
          ],
        ));
  }
}
