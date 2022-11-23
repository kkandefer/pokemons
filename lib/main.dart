import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:pokemons/di/dependency_register.dart';
import 'package:pokemons/ui/pokemon_details_screen.dart';
import 'package:pokemons/ui/pokemons_list_screen.dart';
import 'package:pokemons/features/pokemons/app/cubit/favorite_pokemons/favorite_pokemons_cubit.dart';

void main() {
  DependencyRegister.register();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.where((record) => record.level >= Level.WARNING).listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
    print('${record.error}, ${record.stackTrace}');
  });

  // Logger.root.onRecord.where((record) => record.loggerName == 'ApiRetrofit').listen((record) {
  //   print('${record.message}');
  // });

  runApp(FutureBuilder(
      future: GetIt.instance.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return MyApp();
        } else {
          return Material(
              child: Center(
                child: CircularProgressIndicator(),
              )
          );
        }
      }
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    GetIt.instance<FavoritePokemonsCubit>().initFavoriteList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pokemon Browser',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // flutter 2.x dostarcza deklaratywny Navigator, ale celowo robię na v1,
        // na dobrze zrobiony Navigator 2.0 potrzebowałbym więcej czasu
        // po za tym tu używam lokalnej bazy więc zakładam, ze to typowa aplikacja,
        // do której nie bedzie wersji web
        initialRoute: PokemonsListScreen.routeName,
        routes: {
          PokemonsListScreen.routeName: (context) => PokemonsListScreen.withCubit(),
          PokemonDetailsScreen.routeName: (context) => PokemonDetailsScreen(),
        }
    );
  }
}
