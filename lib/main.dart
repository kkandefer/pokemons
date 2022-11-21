import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:pokemons/di/dependency_register.dart';
import 'package:pokemons/ui/pokemons_list_screen.dart';

void main() {
  DependencyRegister.register();

  // Logger.root.level = Level.ALL;
  // Logger.root.onRecord.where((record) => record.level >= Level.WARNING).listen((record) {
  //   print('${record.level.name}: ${record.time}: ${record.message}');
  //   print('${record.error}, ${record.stackTrace}');
  // });

  Logger.root.onRecord.where((record) => record.loggerName == 'ApiRetrofit').listen((record) {
    print('${record.message}');
  });

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Browser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokemonsListScreen.withCubit(),
    );
  }
}
