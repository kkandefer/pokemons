import 'package:pokemons/features/pokemons/domain/entities/pokemon_details.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_list_item.dart';

abstract class PokemonsRepository {

  Future<List<PokemonListItem>> getRemotePokemons({ int offset, int limit });
  Future<PokemonDetails> getRemotePokemonDetails({ required int id });
  Future<String?> getRemotePokemonImage({ required int id });
}