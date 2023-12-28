part of 'scroll_bloc.dart';

class ScrollState extends Equatable {
  final bool isVisible;

  const ScrollState({required this.isVisible});

  @override
  List<Object?> get props => [isVisible];
}
