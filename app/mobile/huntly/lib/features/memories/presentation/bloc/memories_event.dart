part of 'memories_bloc.dart';

abstract class MemoriesEvent extends Equatable {
  const MemoriesEvent();

  @override
  List<Object> get props => [];
}

class GetUserMemories extends MemoriesEvent {}
