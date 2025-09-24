class TextFormatting {
  Set<String> fillerWords = {
    // Hesitation sounds / simple fillers
    "uh",
    "um",
    "ah",
    "er",
    "hm",
    "hmm",
    "mhm",
    "mm",
    "huh",

    // Verbal crutches / hesitation phrases
    "you know",
    "i mean",
    "like",
    "sort of",
    "kind of",
    "actually",
    "basically",
    "literally",
    "right",
    "okay",
    "okay so",
    "okay then",

    // Repeated discourse markers
    "so",
    "well",
    "now",
    "anyway",
    "alright",
    "oh",
    "oh well",
    "uh-huh",
    "yeah",
    "yes",
    "no",

    // Thinking / filler interjections
    "err",
    "hmm-m",

    // // Self-corrections / stutters
    // "i-i",
    // "th-this",
    // "s-so",
    // "w-what",
    // "c-could",
    // "t-take",
    // "m-maybe",

    // // Overused conversational intensifiers
    // "seriously",
    // "totally",
    // "completely",
    // "really",
    // "very",

    // // Polite backchannels / listener cues
    // "mm-hmm",
    // "uh-huh",
    // "got it",
    // "sure",
  };
  String removeFillerWords(String transcript) {
    List<String> words = transcript.split(' ');
    words = words
        .where((word) => !fillerWords.contains(word.toLowerCase()))
        .toList();
    return words.join(' ');
  }
}
