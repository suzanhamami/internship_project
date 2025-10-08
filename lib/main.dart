import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:internship_project/presentation/comparison/bloc/comparison_bloc.dart';
import 'package:internship_project/presentation/transcription/bloc/transcription_bloc.dart';
import 'package:internship_project/core/service_locator.dart';
import 'package:internship_project/presentation/transcription/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  await setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<TranscriptionBloc>()),
        BlocProvider(create: (context) => getIt<ComparisonBloc>()),
      ],
      child: MaterialApp(home: HomePage()),
    );
  }
}
