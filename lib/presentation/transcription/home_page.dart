import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/presentation/comparison/result_page.dart';
import 'package:internship_project/presentation/transcription/bloc/transcription_bloc.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AudioRecorder audioRecorder;
  late TextEditingController originalText;
  // late AudioPlayer audioPlayer;
  bool isRecording = false;
  String? recordPath;

  @override
  void initState() {
    audioRecorder = AudioRecorder();
    originalText = TextEditingController();
    // audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    audioRecorder.dispose();
    originalText.dispose();
    // audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: originalText,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      maxLines: 10,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    originalText.text = "";
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
            BlocConsumer<TranscriptionBloc, TranscriptionState>(
              listener: (context, state) {
                switch (state) {
                  case TranscriptionReady():
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(
                          originalText: originalText.text,
                          userText: state.transcript,
                        ),
                      ),
                    );
                  case TranscriptionError():
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  default:
                }
              },
              builder: (context, state) {
                switch (state) {
                  case AudioUploadedSuccessfully():
                    return SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text("Transcribing audio..."),
                        ],
                      ),
                    );
                  case TranscriptionLoading() || AudioUploading():
                    return SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text("Please wait..."),
                        ],
                      ),
                    );
                  case TranscriptionReady():
                    return Center(child: Text("Transcript ready!"));
                  case TranscriptionError():
                    return Center(child: Text(state.message));
                  default:
                    return ElevatedButton.icon(
                      onPressed: audioRecording,
                      label: Text(
                        isRecording ? "Stop recording" : "Start recording",
                      ),
                      icon: Icon(isRecording ? Icons.stop_circle : Icons.mic),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void audioRecording() async {
    if (isRecording) {
      String? filePath = await audioRecorder.stop();
      try {
        if (filePath != null) {
          recordPath = filePath;
          if (context.mounted) {
            context.read<TranscriptionBloc>().add(
              AudioUploaded(file: File(recordPath!)),
            );
          }
          isRecording = false;
        }
      } catch (e, s) {
        print("from stop func");
        print(s);
      }
    } else {
      if (await audioRecorder.hasPermission()) {
        final Directory directory = await getApplicationDocumentsDirectory();
        final String filePath = "${directory.path}/recording.m4a";
        try {
          audioRecorder.start(
            const RecordConfig(),
            path: filePath,
          );
          setState(() {
            isRecording = true;
          });
        } catch (e, s) {
          print("from start record func");
          print(s);
        }
      }
    }
  }
}
