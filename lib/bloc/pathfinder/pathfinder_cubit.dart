import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pf/model/exceptions/solver_exception.dart';
import 'package:pf/model/result/result_payload.dart';
import 'package:pf/pathfinder/solver/bfs_solver_impl.dart';
import 'package:pf/pathfinder/solver/pathfinder.dart';

import '../../model/app_point/app_point.dart';
import '../../model/path/path.dart';
import '../../model/pathfinding_query/pathfinding_request.dart';
import '../../network/api.dart';

part 'pathfinder_state.dart';

class PathfinderCubit extends Cubit<PathfinderState> {
  final PathFinderApi _api;

  PathfinderCubit(this._api) : super(PathfinderInitial());

  void fetchQueries(String url) async {
    emit(QueriesLoadingState());

    final res = await _api.fetchQueries(url);
    if (res.error) {
      emit(QueriesErrorState(error: res.message));
      return;
    }

    emit(QueriesFetchedState(queries: res.data, url: url));
  }

  void findPath() async {
    final currentState = state;
    if (currentState is QueriesFetchedState) {
      final totalTasks = currentState.queries.map((e) => e.tasks).reduce((value, element) => value + element);

      ReceivePort receivePort = ReceivePort();
      var isolate = await Isolate.spawn(_findPaths, receivePort.sendPort);
      isolate.addErrorListener(receivePort.sendPort);

      receivePort.listen((message) {
        if (message is SendPort) {
          message.send(currentState.queries);
        } else if (message is (int, int)) {
          emit(CalculatingPathsState(
            url: currentState.url,
            queries: currentState.queries,
            currentTask: message.$2,
            totalTasks: totalTasks,
            currentQuery: message.$1,
          ));
        } else if (message is List<AppPath>) {
          emit(CalculatedPathsState(
            url: currentState.url,
            queries: currentState.queries,
            appPaths: message,
          ));
          receivePort.close();
        } else if (message is SolverException) {
          emit(ErrorCalculatingState(
            queries: currentState.queries,
            url: currentState.url,
            error: message.message,
          ));
          receivePort.close();
        } else {
          print('unexpected format');
        }
      });
    }
  }

  void sendResults() async {
    final currentState = state;
    if (currentState is CalculatedPathsState) {
      emit(LoadingResultState(
        url: currentState.url,
        queries: currentState.queries,
        appPaths: currentState.appPaths,
      ));

      final List<ResultPayload> payloads = [];
      for (int i = 0; i < currentState.queries.length; i++) {
        payloads.add(ResultPayload(id: currentState.queries[i].id, path: currentState.appPaths[i]));
      }

      final res = await _api.postResults(payloads, currentState.url);

      if (res.error == false) {
        emit(SuccessResultState(
          url: currentState.url,
          queries: currentState.queries,
          appPaths: currentState.appPaths,
        ));
      } else {
        emit(ErrorResultState(
          queries: currentState.queries,
          appPaths: currentState.appPaths,
          url: currentState.url,
          error: res.message,
        ));
      }
    }
  }
}

void _findPaths(SendPort sendPort) {
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  int currentTask = 0;
  receivePort.listen((message) {
    if (message is List<MapData>) {
      final List<AppPath> paths = [];
      for (int i = 0; i < message.length; i++) {
        try {
          final solver = BfsSolver(
            mapData: message[i],
            progressCallback: (count) {
              currentTask = currentTask + count;
              sendPort.send((i, currentTask));
            },
          );
          paths.add(solver.solve());
        } on SolverException catch (e) {
          paths.add(AppPath([]));
          sendPort.send(e);
        }
      }
      sendPort.send(paths);
      receivePort.close();
    }
  });
}
