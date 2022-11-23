import 'package:floor/floor.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_list_item.dart';

@dao
abstract class PokemonListItemDao {

  @Query('SELECT * FROM PokemonListItem ORDER BY name ASC LIMIT :limit OFFSET :offset')
  Future<List<PokemonListItem>> getPokemonsPart(int offset, int limit);

  @Query('SELECT * FROM PokemonListItem WHERE name LIKE :phrase ORDER BY name ASC LIMIT :limit OFFSET :offset')
  Future<List<PokemonListItem>> findPokemonsPart(String phrase, int offset, int limit);

  @Query('SELECT * FROM PokemonListItem WHERE id = :id')
  Future<PokemonListItem?> findPokemonById(int id);

  @Query('SELECT * FROM PokemonListItem WHERE name = :name')
  Future<PokemonListItem?> findPokemonByName(String name);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertPokemons(List<PokemonListItem> pokemons);

  @update
  Future<void> updatePokemons(List<PokemonListItem> pokemons);

  @Query('DELETE FROM PokemonListItem')
  Future<void> deleteAllPokemons();
}
