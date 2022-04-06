import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_clean_arch/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
        elevation: 0,
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Column(
        children: [
          const SizedBox(height: 10),
          //Top half
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: const Placeholder(),
          ),
          const SizedBox(height: 20),
          // Bottom half
          Column(
            children: [
              const Placeholder(
                fallbackHeight: 40,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  Expanded(
                    child: Placeholder(
                      fallbackHeight: 30,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Placeholder(
                      fallbackHeight: 30,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
