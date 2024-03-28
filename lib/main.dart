import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pf/bloc/pathfinder/pathfinder_cubit.dart';
import 'package:pf/model/app_point/app_point.dart';
import 'package:pf/model/pathfinding_query/pathfinding_request.dart';
import 'package:pf/network/api.dart';
import 'package:pf/network/dio_client/dio_client.dart';
import 'package:pf/pathfinder/solver/bfs_solver_impl.dart';
import 'package:pf/pathfinder/solver/solver.dart';
import 'package:pf/ui/navigation/navigation.dart';
import 'package:pf/ui/theme/theme_data.dart';

void main() {
  runApp(const PathfinderApp());
}

class PathfinderApp extends StatelessWidget {
  const PathfinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mainNavigation = MainNavigation();
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => PathfinderCubit(PathFinderApi(DioClient(Dio()))),
      child: MaterialApp(
        showPerformanceOverlay: false,
        debugShowCheckedModeBanner: false,
        routes: mainNavigation.routes,
        initialRoute: Screens.home,
        onGenerateRoute: mainNavigation.onGenerateRoute,
        theme: themeData,
      ),
    );
  }
}
