import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hunts_create_event.dart';
part 'hunts_create_state.dart';

class HuntsCreateBloc extends Bloc<HuntsCreateEvent, HuntsCreateState> {
  HuntsCreateBloc() : super(HuntsCreateInitial()) {
    on<HuntsCreateEvent>((event, emit) {});
  }
}
