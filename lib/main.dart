import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_bloc/event.dart';
import 'package:search_bloc/state.dart';
import 'package:search_bloc/bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(),
      child: MaterialApp(
        title: 'Search Bloc',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Search Words'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(children: [_searchField(context), _words(context)]),
    );
  }

  Widget _searchField(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search...',
              contentPadding: const EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1))),
          onChanged: (value) {
            context.read<SearchBloc>().add(SearchWord(word: value));
          },
        ));
  }

  Widget _words(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is LoadingWords) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoadedWords) {
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    state.filteredLoadedWords[index],
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 0.2, color: Colors.grey),
              itemCount: state.filteredLoadedWords.length);
        }
        return Container();
      },
    );
  }
}
