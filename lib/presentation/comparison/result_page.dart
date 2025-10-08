// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/domain/entity/transcript_entity.dart';

import 'package:internship_project/presentation/comparison/bloc/comparison_bloc.dart';

class ResultPage extends StatelessWidget {
  final TranscriptEntity originalText;
  final TranscriptEntity userText;
  const ResultPage({
    Key? key,
    required this.originalText,
    required this.userText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<ComparisonBloc, ComparisonState>(
          builder: (context, state) {
            switch (state) {
              case ComparisonLoading():
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Comparing texts..."),
                  ],
                );
              case ComparisonError():
                return Center(child: Text(state.message));
              case ComparisonSuccess():
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.score, style: TextStyle(fontSize: 28)),
                    Text(
                      "Words you got wrong: ${state.wrongWords.toString()}",
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                );
              default:
                return ElevatedButton.icon(
                  onPressed: () {
                    context.read<ComparisonBloc>().add(
                      ComparisonRequested(
                        originalText: originalText,
                        userText: userText,
                      ),
                    );
                  },
                  label: Text("Start comparing"),
                );
            }
          },
        ),
      ),
    );
  }
}
