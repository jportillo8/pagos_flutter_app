import 'package:flutter/material.dart';
import 'package:pagos_app_flutter/pages/home_page.dart';
import 'package:pagos_app_flutter/pages/pago_completo_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stripe App',
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomePage(),
        'pago_completo': (context) => const PagoCompletoPage(),
      },
      theme: ThemeData.light().copyWith(
          primaryColor: const Color(0xFF284879),
          scaffoldBackgroundColor: const Color(0xFF21232A)),
    );
  }
}
