part of 'pagar_bloc.dart';

class PagarState extends Equatable {
  final double montoPagar;
  final String modena;
  final bool tarjetaActiva;
  final TarjetaCredito? tarjeta;

  String get montoPagarString => '${(montoPagar * 100).floor()}';

  const PagarState({
    this.montoPagar = 150.55,
    this.modena = 'USD',
    this.tarjetaActiva = false,
    this.tarjeta,
  });

  PagarState copyWith({
    double? montoPagar,
    String? modena,
    bool? tarjetaActiva,
    TarjetaCredito? tarjeta,
  }) =>
      PagarState(
          montoPagar: montoPagar ?? this.montoPagar,
          modena: modena ?? this.modena,
          tarjetaActiva: tarjetaActiva ?? this.tarjetaActiva,
          tarjeta: tarjeta ?? this.tarjeta);

  @override
  List<Object?> get props => [montoPagar, modena, tarjetaActiva, tarjeta];
}
