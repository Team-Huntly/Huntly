part of 'memories_bloc.dart';

abstract class MemoriesState extends Equatable {
  const MemoriesState();

  @override
  List<Object> get props => [];
}

class MemoriesInitial extends MemoriesState {}

class Loading extends MemoriesState {}

class Failed extends MemoriesState {}

class Loaded extends MemoriesState {
  final List<dynamic> memories;

  const Loaded({required this.memories});

  @override
  List<Object> get props => [memories];
}
