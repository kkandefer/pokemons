import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemons/features/pokemons/app/cubit/pokemons_list_cubit.dart';

class PokemonsListScreen extends StatelessWidget {

  PokemonsListScreen._();

  static withCubit() {
    return BlocProvider<PokemonsListCubit>.value(
      value: GetIt.instance<PokemonsListCubit>()..initList(),
      child: PokemonsListScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
