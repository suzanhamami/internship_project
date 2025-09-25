# Arabic Memorization App
A Flutter application that uploads an audio file, transcribes it using AssemblyAI, then formats the transcript (removing filler words, normalizing some Arabic letters that could cause confusion)

## Features
- Upload audio files in Arabic.
- Send audio to AssemblyAI for transcription.
- Remove filler words (specific to Syrian Arabic).
- Normalize Arabic letters that are variations of the same letter.

## Technologies
- Flutter
- Dart
- BLoC for state management
- Dio for HTTP requests
- GetIt for dependency injection
- AssemblyAI API

## Installation
1. Clone the repository:
    ```
    git clone https://github.com/suzanhamami/arabic_memorization_helper.git
    ```
2. Install dependencies:
    ```
    flutter pub get
    ```
3. Add environment variables:
    create an .env file in the root of your project
    add your API key:
    ```
    API_KEY=your_assemblyai_api_key
    ```
4. Run the app:
    ```
    flutter run
    ```

## Usage
- Tap the upload button to select an audio file.
- The app uploads and transcribes it automatically.
- View the formatted transcript on screen.
