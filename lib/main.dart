import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagos_app_flutter/blocs/pagar/pagar_bloc.dart';
import 'package:pagos_app_flutter/pages/home_page.dart';
import 'package:pagos_app_flutter/pages/pago_completo_page.dart';
import 'package:pagos_app_flutter/services/stripe_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Inicializamos Stripe Service
    final stripeService = StripeService();
    stripeService.init();
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => PagarBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stripe App',
        initialRoute: 'home',
        routes: {
          'home': (context) => HomePage(),
          'pago_completo': (context) => const PagoCompletoPage(),
        },
        theme: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF284879),
            scaffoldBackgroundColor: const Color(0xFF21232A)),
      ),
    );
  }
}
