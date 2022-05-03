import 'package:flutter/material.dart';
import 'package:pagos_app_flutter/pages/home_page.dart';
import 'package:pagos_app_flutter/pages/pago_completo_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stripe App',
      initialRoute: 'home',
      routes: {
        'home': (context) => HomePage(),
        'pago_completp': (context) => PagoCompletoPage(),
      },
      theme: ThemeData.light().copyWith(
          primaryColor: Color(0xFF284879),
          scaffoldBackgroundColor: Color(0xFF21232A)),
    );
  }
}
