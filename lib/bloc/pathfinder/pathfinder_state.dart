part of 'pathfinder_cubit.dart';

abstract class PathfinderState extends Equatable {
  const PathfinderState();
}

class PathfinderInitial extends PathfinderState {
  @override
  List<Object> get props => [];
}

class QueriesLoadingState extends PathfinderState {
  @override
  List<Object> get props => [];
}

class QueriesErrorState extends PathfinderState {
  final String error;

  const QueriesErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class QueriesFetchedState extends PathfinderState {
  final List<MapData> queries;
  final String url;

  const QueriesFetchedState({required this.queries, required this.url});

  int get totalQueries => queries.length;

  @override
  List<Object> get props => [queries, url];
}

class ErrorCalculatingState extends QueriesFetchedState{
  final String error;

  const ErrorCalculatingState({required super.queries, required super.url, required this.error});
}

class CalculatingPathsState extends QueriesFetchedState {
  final int currentTask;
  final int totalTasks;
  final int currentQuery;

  double get progress => currentTask / totalTasks;

  const CalculatingPathsState({
    required super.queries,
    required this.currentTask,
    required this.totalTasks,
    required this.currentQuery,
    required super.url,
  });

  @override
  List<Object> get props => [queries, currentTask, currentQuery];
}

class CalculatedPathsState extends QueriesFetchedState {
  final List<AppPath> appPaths;

  const CalculatedPathsState({required super.queries, required this.appPaths, required super.url});
}

class LoadingResultState extends CalculatedPathsState {
  const LoadingResultState({required super.queries, required super.appPaths, required super.url});
}

class SuccessResultState extends CalculatedPathsState {
  const SuccessResultState({required super.queries, required super.appPaths, required super.url});
}

class ErrorResultState extends CalculatedPathsState {
  final String error;
  const ErrorResultState({required super.queries, required super.appPaths, required super.url,required this.error});
}
