import 'package:pokemons/features/pokemons/domain/entities/pokemon_details.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemons_list_item.dart';

abstract class PokemonsRepository {

  Future<List<PokemonsListItem>> getRemotePokemons({ int offset, int limit});
  // Future<PokemonDetails> getRemotePokemonDetails({ required int id });
}