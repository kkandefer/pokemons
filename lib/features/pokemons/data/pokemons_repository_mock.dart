import 'package:pokemons/features/pokemons/domain/entities/pokemon_details.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemons_list_item.dart';
import 'package:pokemons/features/pokemons/domain/pokemons_repository.dart';

class PokemonsRepositoryMock extends PokemonsRepository {

  @override
  Future<List<PokemonsListItem>> getRemotePokemons({ int offset = 0, int limit = 20}) {
    return Future.value(List<PokemonsListItem>.generate(20, (i) => mockList[i % mockList.length]));
  }

  @override
  Future<PokemonDetails> getRemotePokemonDetails({ required int id }) {
    return Future.value(mockDetails[id]);
  }

  static List<PokemonsListItem> mockList = [
    PokemonsListItem(
      id: 1,
      name: 'Testowy pokemon 1',
    ),
    PokemonsListItem(
      id: 2,
      name: 'Testowy pokemon 2',
    ),
    PokemonsListItem(
      id: 3,
      name: 'Testowy pokemon 3',
    ),
    PokemonsListItem(
      id: 3,
      name: 'Testowy pokemon 4',
    ),
  ];

  static Map<int, PokemonDetails> mockDetails = {
    1: PokemonDetails(
      id: 1,
      name: 'Testowy pokemon 1',
    ),
    2: PokemonDetails(
      id: 2,
      name: 'Testowy pokemon 2',
    ),
  };
}