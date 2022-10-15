import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/datasources/memories_remote_datasource.dart';
import '../../data/models/memory_model.dart';

part 'memories_event.dart';
part 'memories_state.dart';

class MemoriesBloc extends Bloc<MemoriesEvent, MemoriesState> {
  MemoriesBloc() : super(MemoriesInitial()) {
    on<MemoriesEvent>((event, emit) async {
      if (event is GetUserMemories) {
        emit(Loading());
        try {
          final MemoriesRemoteDatasourceImpl mrds =
              MemoriesRemoteDatasourceImpl();
          final memories = await mrds.fetchUserMemories();
          emit(Loaded(memories: memories));
        } catch (e) {
          debugPrint(e.toString());
          emit(Failed());
        }
      }
    });
  }
}
