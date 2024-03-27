import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'scroll_event.dart';
part 'scroll_state.dart';

class ScrollBloc extends Bloc<ScrollEvent, ScrollState> {
  ScrollBloc()
      : super(
          const ScrollState(
            isVisible: true,
          ),
        ) {
    on<ToggleVisibilityEvent>(_onToggleVisibility);
  }

  void _onToggleVisibility(
      ToggleVisibilityEvent event, Emitter<ScrollState> emit) {
    if (state.isVisible == event.isVisible) return;
    emit(ScrollState(isVisible: event.isVisible));
  }
}
