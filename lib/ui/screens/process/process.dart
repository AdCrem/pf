import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/pathfinder/pathfinder_cubit.dart';
import '../../navigation/navigation.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({super.key});

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      context.read<PathfinderCubit>().findPath();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Process Screen')),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<PathfinderCubit, PathfinderState>(
            listenWhen: (prev, state) => state is SuccessResultState && prev is! SuccessResultState,
            listener: (context, state) {
              if (state is SuccessResultState) {
                Navigator.of(context).pushReplacementNamed(Screens.results);
              }
            },
            builder: (context, state) {
              return const Column(
                children: [
                  Expanded(child: ProcessIndicator()),
                  ProcessButton(),
                ],
              );
            },
          )),
    );
  }
}

class ProcessButton extends StatelessWidget {
  const ProcessButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PathfinderCubit, PathfinderState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (state is CalculatedPathsState)
                  ? () => context.read<PathfinderCubit>().sendResults()
                  : (state is LoadingResultState)
                      ? () {}
                      : null,
              child: state is LoadingResultState ? const CircularProgressIndicator(color: Colors.white) : const Text('Send results to server'),
            ),
          ),
        );
      },
    );
  }
}

class ProcessIndicator extends StatelessWidget {
  const ProcessIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PathfinderCubit, PathfinderState>(
      builder: (context, state) {
        final double progressValue = (state is CalculatingPathsState)
            ? state.currentTask / state.totalTasks
            : (state is CalculatedPathsState)
                ? 1
                : 0;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator.adaptive(
                    value: progressValue,
                    backgroundColor: Colors.grey,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                Text('${(progressValue * 100).toStringAsFixed(0)}%'),
              ],
            ),
            const SizedBox(height: 20),
            if (state is CalculatingPathsState) Text('Calculating query #${state.currentQuery} of ${state.totalQueries}'),
            if (state is CalculatedPathsState)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'All calculations has finished, you can send your results to server',
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
            if (state is ErrorCalculatingState) ...[
              const SizedBox(height: 20),
              Text(state.error),
            ],
            if (state is ErrorResultState) ...[
              const SizedBox(height: 20),
              Text(state.error),
            ],
          ],
        );
      },
    );
  }
}
