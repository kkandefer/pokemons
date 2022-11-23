import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemons/common/route_arguments/pokemon_details_arg.dart';
import 'package:pokemons/features/pokemons/app/cubit/favorite_pokemons/favorite_pokemons_cubit.dart';
import 'package:pokemons/features/pokemons/app/cubit/pokemon_details/pokemon_details_cubit.dart';
import 'package:pokemons/features/pokemons/app/cubit/pokemons_list/pokemons_list_cubit.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_details.dart';
import 'package:pokemons/ui/widgets/pk_error_widget.dart';
import 'package:pokemons/ui/widgets/search_form.dart';

class PokemonDetailsScreen extends StatelessWidget {

  static const routeName = '/pokemonDetails';

  PokemonDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context)!.settings.arguments;
    if(arguments is! PokemonDetailsArg){
      //TODO logowanie do crashlytics, ale w tej wersji nie podłaczam bo nie ma konta
      return PkErrorWidget(message: 'Błędne Id');
    }

    return BlocProvider<PokemonDetailsCubit>.value(
      value: GetIt.instance<PokemonDetailsCubit>()..initPokemonById(arguments.id),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: _AppBarTitle(),
              actions: [
                _AppBarIcon(),
              ],
            ),
            body: BlocBuilder<PokemonDetailsCubit, PokemonDetailsState>(
              builder: (context, pokemonDetailsState) {
                switch(pokemonDetailsState.status){
                  case PokemonDetailsStatus.initial :
                    return Center(child: CircularProgressIndicator());
                  case PokemonDetailsStatus.failure :
                    return Center(child: PkErrorWidget(message: "Błąd",));
                  case PokemonDetailsStatus.normal :
                    print(pokemonDetailsState.details?.imageUrl);
                    return Column(
                      children: [
                        Row(
                          children: [
                            Flexible(flex: 1, child: Text('Nazwa: ')),
                            Flexible(flex: 2, child: Text(pokemonDetailsState.details!.name)),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(flex: 1, child: Text('Doswiadczenie: ')),
                            Flexible(flex: 2, child: Text(pokemonDetailsState.details!.baseExperience.toString())),
                          ],
                        ),
                        if(pokemonDetailsState.details!.imageUrl != null)
                          Expanded(child: Image.network(pokemonDetailsState.details!.imageUrl!))
                      ],
                    );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

//ten widget to taka celowa pokazówka, szybsza alternaywa dla BlocBuildera
class _AppBarTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    PokemonDetails? details = context.select((PokemonDetailsCubit c) => c.state.details);
    return Text(details?.name ?? '');
  }
}

class _AppBarIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    PokemonDetails? details = context.select((PokemonDetailsCubit c) => c.state.details);
    return BlocBuilder<FavoritePokemonsCubit, FavoritePokemonsState>(
      bloc: GetIt.instance<FavoritePokemonsCubit>(),
      builder: (context, favoritePokemonsState){
        if(favoritePokemonsState.status == FavoritePokemonsStatus.normal
            && details != null
            && favoritePokemonsState.favorites.indexWhere((f) => f.id == details.id) != -1
        ){
          return IconButton(
            onPressed: (){
              GetIt.instance<FavoritePokemonsCubit>().removeFromFavorite(favoritePokemonsState.favorites.firstWhere((f) => f.id == details.id));
            },
            icon: Icon(Icons.star_outlined),
          );
        }
        else if(favoritePokemonsState.status == FavoritePokemonsStatus.normal
            && details != null
            && favoritePokemonsState.favorites.indexWhere((f) => f.id == details.id) == -1
        ){
          return IconButton(
            onPressed: (){
              GetIt.instance<FavoritePokemonsCubit>().addToFavorite(details);
            },
            icon: Icon(Icons.star_outline),
          );
        }
        else{
          return SizedBox();
        }
      }
    );
  }
}
