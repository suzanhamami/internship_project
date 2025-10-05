// ignore_for_file: public_member_api_docs, sort_constructors_first
class TextFormatting {
  final Set<String> arabicFillerWords = {
    "يعني",
    "إيه",
    "إيه والله",
    "هيك",
    "شو اسمه",
    "فهمت علي",
    "طيب",
    "مزبوط",
    "تمام",
    "والله",
    "عنجد",
    "إيه لك",
    "خلص",
    "ماشي",
    "يعني هيك",
    "و بس",
    "بس هيك",
    "اممم",
    "آآآ",
    "مممم",
    "إييي",
    "بصراحة",
    "في الحقيقة",
    "أيوه",
    "ثواني",
    "طبعًا",
    "كده",
    "خلينا نقول",
    "آآ",
    "ااا",
    "على فكرة",
    "لحظة",
    "خليني أقول",
  };

  String formatText(String text) {
    text = removeZeroWidth(text);
    text = removeLigatures(text);
    text = removePunctuation(text);
    text = fixLetters(text);
    text = fixSpaces(text);
    text = removeFillerWords(text);
    return text;
  }

  String removeZeroWidth(String text) {
    return text.replaceAll(RegExp(r'[\u200C\u200D]'), '');
  }

  String removeLigatures(String text) {
    return text.replaceAll('\uFEFB', 'لا');
  }

  String removePunctuation(String text) {
    text = text.replaceAll(RegExp(r'[^\w\s\u0600-\u06FF]'), '');
    return text;
  }

  String fixLetters(String text) {
    text = text.replaceAll("آ", "ا");
    text = text.replaceAll(RegExp('[أإآ]'), 'ا');
    text = text.replaceAll("أ", "ا");
    text = text.replaceAll("إ", "ا");
    text = text.replaceAll("ة", "ه");
    return text;
  }

  String fixSpaces(String text) {
    text = text.trim();
    text = text.replaceAll(RegExp(r'\s+'), ' ');
    return text;
  }

  String removeFillerWords(String text) {
    List<String> words = text.split(' ');
    words = words.where((word) => !arabicFillerWords.contains(word)).toList();
    return words.join(' ');
  }
}

// Set<String> fillerWords = {
  //   // Hesitation sounds / simple fillers
  //   "uh",
  //   "um",
  //   "ah",
  //   "er",
  //   "hm",
  //   "hmm",
  //   "mhm",
  //   "mm",
  //   "huh",

  //   // Verbal crutches / hesitation phrases
  //   "you know",
  //   "i mean",
  //   "like",
  //   "sort of",
  //   "kind of",
  //   "actually",
  //   "basically",
  //   "literally",
  //   "right",
  //   "okay",
  //   "okay so",
  //   "okay then",

  //   // Repeated discourse markers
  //   "so",
  //   "well",
  //   "now",
  //   "anyway",
  //   "alright",
  //   "oh",
  //   "oh well",
  //   "uh-huh",
  //   "yeah",
  //   "yes",
  //   "no",

  //   // Thinking / filler interjections
  //   "err",
  //   "hmm-m",

  //   // // Self-corrections / stutters
  //   // "i-i",
  //   // "th-this",
  //   // "s-so",
  //   // "w-what",
  //   // "c-could",
  //   // "t-take",
  //   // "m-maybe",

  //   // // Overused conversational intensifiers
  //   // "seriously",
  //   // "totally",
  //   // "completely",
  //   // "really",
  //   // "very",

  //   // // Polite backchannels / listener cues
  //   // "mm-hmm",
  //   // "uh-huh",
  //   // "got it",
  //   // "sure",
  // };
