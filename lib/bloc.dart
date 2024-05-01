import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_bloc/event.dart';
import 'package:search_bloc/state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  static List<String> words = ['Flutter', 'Guy', 'Data']; //;

  SearchBloc() : super(LoadedWords(words: words, filteredWords: words)) {
    on<SearchWord>((event, emit) {
      emit(LoadingWords());

      List<String> searchedTitles = [];
      for (var el in words) {
        if(el.toLowerCase().contains(event.word.toLowerCase())) {
          searchedTitles.add(el);
        }
      }

      emit(LoadedWords( words: words, filteredWords: searchedTitles ));
    });
  }
}