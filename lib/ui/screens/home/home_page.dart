import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pf/bloc/pathfinder/pathfinder_cubit.dart';
import 'package:pf/ui/resources/validators/app_validators.dart';

import '../../navigation/navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController linkController = TextEditingController();
  GlobalKey<FormState> linkFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<PathfinderCubit, PathfinderState>(
          listenWhen: (prev, current) => (current is QueriesFetchedState && prev is! QueriesFetchedState),
          listener: (context, state) {
            if (state is QueriesFetchedState) {
              Navigator.of(context).pushNamed(Screens.process);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.compare_arrows),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Form(
                        key: linkFormKey,
                        child: TextFormField(
                          controller: linkController,
                          validator: (String? value) {
                            return AppValidators.isValidUrl(value);
                          },
                          decoration: InputDecoration(
                            errorText: state is QueriesErrorState ? state.error : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (state is! QueriesLoadingState) ? () => _actionButton(linkController.text) : () {},
                      child:
                          state is QueriesLoadingState ? const CircularProgressIndicator(color: Colors.white) : const Text('Start counting process'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _actionButton(String url) {
    if (linkFormKey.currentState?.validate() ?? false) {
      context.read<PathfinderCubit>().fetchQueries(url);
    }
  }
}
