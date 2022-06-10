import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sentimento/utilities/securestorage.dart';

part 'coupan_event.dart';
part 'coupan_state.dart';

class CoupanBloc extends Bloc<CoupanEvent, CoupanState> {
  CoupanBloc(InitialState initialState) : super(InitialState()) {
    on<InitialEvent>(_initialEvent);
  }

  FutureOr<void> _initialEvent(
      InitialEvent initialEvent, Emitter<CoupanState> emit) async {
    emit.call(InitialState());

    //now will take coupans from saved cache
    List<String> savedCoupans = await getStoredCoupans();
    emit.call(CoupansState(
        yKey: savedCoupans[0],
        ck: savedCoupans[1],
        cs: savedCoupans[2],
        at: savedCoupans[3],
        ats: savedCoupans[4]));
  }
}
