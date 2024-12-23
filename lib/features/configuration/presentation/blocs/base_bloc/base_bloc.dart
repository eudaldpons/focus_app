import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";

part "base_event.dart";
part "base_state.dart";

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc() : super(const PageChangeSuccess(3)) {
    on<BaseEvent>(_baseEvent);
    on<PageIndexChanged>(_pageIndexChanged);
  }

  void _baseEvent(BaseEvent event, Emitter<BaseState> emit) {}

  void _pageIndexChanged(PageIndexChanged event, Emitter<BaseState> emit) {
    emit(PageChangeSuccess(event.index));
  }
}
