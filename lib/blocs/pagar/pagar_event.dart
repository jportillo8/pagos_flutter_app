part of 'pagar_bloc.dart';

abstract class PagarEvent extends Equatable {
  const PagarEvent();

  @override
  List<Object> get props => [];
}

class OnSeleccionarTarjeta extends PagarEvent {
  final TarjetaCredito tarjeta;

  const OnSeleccionarTarjeta(this.tarjeta);
}

class OnDesactivarTarjeta extends PagarEvent {}
