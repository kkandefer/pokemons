import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:pokemons/features/pokemons/data/dao/favorite_pokemon_dao.dart';
import 'package:pokemons/features/pokemons/domain/entities/favorite_pokemon.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_details.dart';
import 'package:pokemons/features/pokemons/domain/pokemons_repository.dart';

part 'favorite_pokemons_state.dart';

class FavoritePokemonsCubit extends Cubit<FavoritePokemonsState> {

  final log = Logger('FavoritePokemonsCubit');
  final FavoritePokemonDao favoritePokemonDao;

  FavoritePokemonsCubit({ required this.favoritePokemonDao }) : super(FavoritePokemonsState.initial());

  void initFavoriteList() async {

    emit(FavoritePokemonsState.initial());

    try{
      List<FavoritePokemon> favoritePokemons = await favoritePokemonDao.getFavoritePokemons();

      emit(state.copyWith(
        status: FavoritePokemonsStatus.normal,
        favorites: favoritePokemons,
      ));

    }
    catch(e, s) {
      emit(state.copyWith(
        status: FavoritePokemonsStatus.failure,
      ));
      log.severe('Unable to get favorite pokemons from database', e, s);
      //TODO logowanie do crashlytics, ale w tej wersji nie podłaczam bo nie ma konta
    }
  }

  void addToFavorite(PokemonDetails pokemon) async {

    try{
      int? maxSequence = await favoritePokemonDao.getMaxSequence();
      FavoritePokemon favoritePokemon = FavoritePokemon(
        sequence: maxSequence ?? 0 + 1,
        id: pokemon.id,
        name: pokemon.name,
        baseExperience: pokemon.baseExperience,
        imageUrl: pokemon.imageUrl,
        imageUrlBig: pokemon.imageUrlBig,
      );

      await favoritePokemonDao.insertFavoritePokemon(favoritePokemon);
      List<FavoritePokemon> favoritePokemons = await favoritePokemonDao.getFavoritePokemons();

      emit(state.copyWith(
        favorites: favoritePokemons,
      ));
    }
    catch(e, s) {//upraszczam obsługę błędów, z powodu braku czasu
      log.severe('Unable to remove favorite from database', e, s);
      //TODO logowanie do crashlytics, ale w tej wersji nie podłaczam bo nie ma konta
    }
  }

  void removeFromFavorite(FavoritePokemon favoritePokemon) async {

    try{
      await favoritePokemonDao.deleteFavoritePokemon(favoritePokemon);
      List<FavoritePokemon> favoritePokemons = await favoritePokemonDao.getFavoritePokemons();

      emit(state.copyWith(
        favorites: favoritePokemons,
      ));
    }
    catch(e, s) {//upraszczam obsługę błędów, z powodu braku czasu
      log.severe('Unable to remove favorite from database', e, s);
      //TODO logowanie do crashlytics, ale w tej wersji nie podłaczam bo nie ma konta
    }
  }
}
