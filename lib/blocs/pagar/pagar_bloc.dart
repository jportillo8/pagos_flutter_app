import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pagos_app_flutter/data/tarjetas.dart';
import 'package:pagos_app_flutter/models/tarjeta_credito_model.dart';

part 'pagar_event.dart';
part 'pagar_state.dart';

class PagarBloc extends Bloc<PagarEvent, PagarState> {
  PagarBloc() : super(const PagarState()) {
    on<OnSeleccionarTarjeta>((event, emit) {
      emit(state.copyWith(tarjetaActiva: true, tarjeta: event.tarjeta));
    });
    on<OnDesactivarTarjeta>(
        (event, emit) => emit(state.copyWith(tarjetaActiva: false)));
  }
}
