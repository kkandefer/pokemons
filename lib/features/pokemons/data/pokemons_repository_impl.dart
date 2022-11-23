import 'package:pokemons/features/pokemons/data/retrofit/api.dart';
import 'package:pokemons/features/pokemons/data/retrofit/api_retrofit.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_details.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_list_item.dart';
import 'package:pokemons/features/pokemons/domain/pokemons_repository.dart';

class PokemonsRepositoryImpl extends PokemonsRepository {

  final ApiRetrofit _apiRetrofit;
  Api get _api => _apiRetrofit.api;

  PokemonsRepositoryImpl(this._apiRetrofit);

  @override
  Future<List<PokemonListItem>> getRemotePokemons({ int offset = 0, int limit = 20}) async {
    var response = await _api.getPokemonsList(offset, limit);
    return response.results.map((e) => e.toEntity()).toList();
  }

  // @override
  // Future<PokemonDetails> getRemotePokemonDetails({ required int id }) {
  //   return Future.value(PokemonsRepositoryMock.mockDetails[id]);
  // }


  Future<String?> getRemotePokemonImage({ required int id }) async {
    var response = await _api.getForm(id);
    return response.imageUrl;
  }

}