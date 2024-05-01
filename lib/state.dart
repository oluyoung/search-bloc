abstract class SearchState {}

class InitialState extends SearchState {}

class LoadingWords extends SearchState {}

class LoadedWords extends SearchState {
  /* Note: words can be inserted here locally
  */
  List<String> loadedWords = [];
  List<String> filteredLoadedWords = [];

  LoadedWords({ words, filteredWords }) {
    loadedWords = words ?? loadedWords;
    filteredLoadedWords = filteredWords ?? loadedWords;
  }
} 
