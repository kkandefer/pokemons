import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemons/common/route_arguments/pokemon_details_arg.dart';
import 'package:pokemons/features/pokemons/app/cubit/favorite_pokemons/favorite_pokemons_cubit.dart';
import 'package:pokemons/features/pokemons/app/cubit/pokemons_list/pokemons_list_cubit.dart';
import 'package:pokemons/features/pokemons/domain/entities/favorite_pokemon.dart';
import 'package:pokemons/ui/pokemon_details_screen.dart';
import 'package:pokemons/ui/widgets/pk_error_widget.dart';
import 'package:pokemons/ui/widgets/search_form.dart';
import 'package:transparent_image/transparent_image.dart';


class FavoritePokemonsListScreen extends StatelessWidget {

  static const routeName = '/favoritePokemonsList';

  FavoritePokemonsListScreen._();
  static withCubit() {
    return BlocProvider<FavoritePokemonsCubit>.value(
      value: GetIt.instance<FavoritePokemonsCubit>()..initFavoriteList(),
      child: FavoritePokemonsListScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onPanDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ulubione'),
        ),
        body: BlocBuilder<FavoritePokemonsCubit, FavoritePokemonsState>(
          //buildWhen celowo odpuszcam, tu i tak wszystko dzieje się w jednym miejscu
          builder: (context, favoritePokemonsState) {
            switch(favoritePokemonsState.status){
              case FavoritePokemonsStatus.initial :
                return Center(child: CircularProgressIndicator());
              case FavoritePokemonsStatus.failure :
                return PkErrorWidget(message: "Wystapił błąd");
              case FavoritePokemonsStatus.normal :
                if(favoritePokemonsState.favorites.length == 0){
                  return PkErrorWidget(message: "Lista ulubionych jest pusta");
                }
                else{
                  return ReorderableListView(
                    children: favoritePokemonsState.favorites.map((item) => _buildItem(context, item)).toList(),
                    onReorder: (int start, int current) {
                      List<FavoritePokemon> pokemonsToSort = favoritePokemonsState.favorites;
                      if (start < current) {
                        int end = current - 1;
                        FavoritePokemon startItem = pokemonsToSort[start];
                        int i = 0;
                        int local = start;
                        do {
                          pokemonsToSort[local] = pokemonsToSort[++local];
                          i++;
                        } while (i < end - start);
                        pokemonsToSort[end] = startItem;
                      }
                      // dragging from bottom to top
                      else if (start > current) {
                        FavoritePokemon startItem = pokemonsToSort[start];
                        for (int i = start; i > current; i--) {
                          pokemonsToSort[i] = pokemonsToSort[i - 1];
                        }
                        pokemonsToSort[current] = startItem;
                      }
                      BlocProvider.of<FavoritePokemonsCubit>(context).updatePokemonsOrder(pokemonsToSort);
                    }
                  );
                }
            }
          },
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, FavoritePokemon pokemon) {
    return ListTile(
      key: Key(pokemon.id.toString()),
      title: Text(pokemon.name),
      leading: FadeInImage.memoryNetwork(
        image: pokemon.imageUrl.toString(),
        placeholder: kTransparentImage,
        imageErrorBuilder: (context, error, stackTrace) => Icon(Icons.image),
      ),
      trailing: Icon(Icons.drag_handle),
      onTap: () => Navigator.of(context).pushNamed(PokemonDetailsScreen.routeName, arguments: PokemonDetailsArg(id: pokemon.id)),
    );
  }
}