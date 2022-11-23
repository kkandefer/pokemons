
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:pokemons/features/pokemons/data/dao/favorite_pokemon_dao.dart';
import 'package:pokemons/features/pokemons/domain/entities/favorite_pokemon.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:pokemons/features/pokemons/data/dao/pokemon_list_item_dao.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_list_item.dart';

part 'pokemons_database.g.dart';

@Database(version: 1, entities: [PokemonListItem, FavoritePokemon])
abstract class PokemonsDatabase extends FloorDatabase {
  PokemonListItemDao get pokemonListItemDao;
  FavoritePokemonDao get favoritePokemonDao;
}
