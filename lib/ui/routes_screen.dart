import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemons/common/bloc/app_navigator/app_navigator_cubit.dart';
import 'package:pokemons/common/route_arguments/pokemon_details_arg.dart';
import 'package:pokemons/features/pokemons/app/cubit/favorite_pokemons/favorite_pokemons_cubit.dart';
import 'package:pokemons/features/pokemons/app/cubit/pokemons_list/pokemons_list_cubit.dart';
import 'package:pokemons/features/pokemons/domain/entities/favorite_pokemon.dart';
import 'package:pokemons/ui/favorite_pokemons_list_screen.dart';
import 'package:pokemons/ui/pokemon_details_screen.dart';
import 'package:pokemons/ui/pokemons_list_screen.dart';
import 'package:pokemons/ui/widgets/pk_error_widget.dart';
import 'package:pokemons/ui/widgets/search_form.dart';
import 'package:transparent_image/transparent_image.dart';


class RoutesScreen extends StatelessWidget {

  static const routeName = '/routes';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppNavigatorCubit, AppNavigatorState>(
      builder: (context, appNavigatorState) {
        AppNavigatorRoute cuttentRoute = appNavigatorState.currentRoute;
        // W pełnej palikacji zrobiłbym na Navigatorze 2.0
        // i troche inaczej wyglądałby ten RoutesScreen (nie byłoby WillPopScope),
        // ale tu skracam z braku czasu
        return WillPopScope(
            onWillPop: () {
              if (appNavigatorState.canPop) {
                BlocProvider.of<AppNavigatorCubit>(context).goBackRoute();
                return Future.value(false);
              } else {
                return Future.value(true);
              }
            },
            child: Scaffold(
              body: _showRoute(context, appNavigatorState.currentRoute),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cuttentRoute.index,
                items: AppNavigatorRoute.values.map((AppNavigatorRoute location) {
                  switch(location){
                    case AppNavigatorRoute.list :
                      return const BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Lista',
                      );
                    case AppNavigatorRoute.favorite :
                      return const BottomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                        label: 'Ulubione',
                      );
                  }
                }).toList(),
                onTap: (int index) {
                  if(index != cuttentRoute.index){
                    BlocProvider.of<AppNavigatorCubit>(context).goToRoute(AppNavigatorRoute.values[index]);
                  }
                  // BlocProvider.of<BottomNavigatorCubit>(context).setBottomNavigatorLocationByIndex(index);
                },
              ),
            )
        );
      }
    );
  }

  _showRoute(BuildContext context, AppNavigatorRoute currentRoute) {
    switch (currentRoute) {
      case AppNavigatorRoute.list:
        return PokemonsListScreen.withCubit();
      case AppNavigatorRoute.favorite:
        return FavoritePokemonsListScreen.withCubit();
    }
  }
}