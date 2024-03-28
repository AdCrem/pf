import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pf/bloc/pathfinder/pathfinder_cubit.dart';
import 'package:pf/model/result/pathfinding_result.dart';

import '../../navigation/navigation.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result list screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<PathfinderCubit, PathfinderState>(
          builder: (context, state) {
            if (state is SuccessResultState) {
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(Screens.preview, arguments: PathfindingResult(state.queries[index], state.appPaths[index]));
                    },
                    child: Center(
                      child: Text(state.appPaths[index].toString()),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: state.appPaths.length,
              );
            } else {
              return const Center(
                child: Text('Unexpected state'),
              );
            }
          },
        ),
      ),
    );
  }
}
