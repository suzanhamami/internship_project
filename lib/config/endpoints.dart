class Endpoints {
  static const String baseUrl = "https://api.assemblyai.com";
  static const String uploadAudioEndPoint = "$baseUrl/v2/upload";
  static const String transcribeAudioEndPoint = "$baseUrl/v2/transcript";
  static String getTranscriptEndPoint(String transcriptId) {
    return "$baseUrl/v2/transcript/$transcriptId";
  }
}
