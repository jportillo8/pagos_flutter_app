part of 'pagar_bloc.dart';

class PagarState extends Equatable {
  final double montoPagar;
  final String modena;
  final bool tarjetaActiva;
  final TarjetaCredito? tarjeta;

  const PagarState({
    this.montoPagar = 375.55,
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
