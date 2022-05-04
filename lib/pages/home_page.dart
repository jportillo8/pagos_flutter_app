import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:pagos_app_flutter/data/tarjetas.dart';
import 'package:pagos_app_flutter/helpers/helpers.dart';
import 'package:pagos_app_flutter/pages/tarjeta_page.dart';
import 'package:pagos_app_flutter/widgets/total_pay_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Pagar'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                // mostraLoading(context);
                // await Future.delayed(Duration(seconds: 1));
                // Navigator.pop(context);
                mostraAlerta(context, 'hola', 'mundo');
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
