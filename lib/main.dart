import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:internship_project/core/utils/text_formatting.dart';
import 'package:internship_project/presentation/bloc/transcription_bloc.dart';
import 'package:internship_project/core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  setUpLocator();
  // String sen = "heyyy";
  // sen.substring(1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return // TranscriptionBloc(),
    BlocProvider(
      create: (context) => getIt<TranscriptionBloc>(),
      child: MaterialApp(home: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<TranscriptionBloc, TranscriptionState>(
          builder: (context, state) {
            switch (state) {
              case AudioUploadedSuccessfully():
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Transcribing audio..."),
                  ],
                );
              case AudioUploading():
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Uploading audio..."),
                  ],
                );
              case TranscriptionError():
                return Text("An Error occured");
              case TranscriptionLoading():
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Almost ready..."),
                  ],
                );
              case TranscriptionReady():
                TextFormatting formattedTranscript = TextFormatting(
                );
                return SingleChildScrollView(
                  child: Text(formattedTranscript.formatText(state.transcript.text)),
                );
              default:
                return Text("Click button to upload audio");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();
          if (result != null) {
            File file = File(result.files.single.path!);

            if (context.mounted) {
              context.read<TranscriptionBloc>().add(AudioUploaded(file: file));
            }
          } else {
            // User canceled the picker
          }
        },
      ),
    );
  }
}
