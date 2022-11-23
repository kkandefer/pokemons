import 'package:floor/floor.dart';
import 'package:pokemons/features/pokemons/domain/entities/favorite_pokemon.dart';

@dao
abstract class FavoritePokemonDao {

  @Query('SELECT * FROM FavoritePokemon ORDER BY sequence DESC')
  Future<List<FavoritePokemon>> getFavoritePokemons();

  @Query('SELECT * FROM FavoritePokemon WHERE id = :id')
  Future<FavoritePokemon?> findPokemonById(int id);

  @Query('SELECT MAX(sequence) FROM FavoritePokemon')
  Future<int?> getMaxSequence();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFavoritePokemons(List<FavoritePokemon> pokemons);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFavoritePokemon(FavoritePokemon pokemon);

  @update
  Future<void> updateFavoritePokemons(List<FavoritePokemon> pokemons);

  @delete
  Future<void> deleteFavoritePokemon(FavoritePokemon pokemons);

  @Query('DELETE FROM FavoritePokemon')
  Future<void> deleteAllFavoritePokemons();
}
