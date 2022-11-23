
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemons/di/dependency_register.dart';
import 'package:pokemons/features/pokemons/app/cubit/pokemons_list_cubit.dart';
import 'package:pokemons/features/pokemons/data/dao/pokemon_list_item_dao.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_details.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_list_item.dart';
import 'package:pokemons/features/pokemons/domain/pokemons_repository.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}
class MockPokemonListItemDao extends Mock implements PokemonListItemDao {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const List<PokemonListItem> mockList = [
    PokemonListItem(
      id: 1,
      name: 'Testowy pokemon 1',
    ),
    PokemonListItem(
      id: 2,
      name: 'Testowy pokemon 2',
    ),
    PokemonListItem(
      id: 3,
      name: 'Testowy pokemon 3',
    ),
    PokemonListItem(
      id: 4,
      name: 'Testowy pokemon 4',
    ),
  ];

  const Map<int, PokemonDetails> mockDetails = {
    1: PokemonDetails(
      id: 1,
      name: 'Testowy pokemon 1',
    ),
    2: PokemonDetails(
      id: 2,
      name: 'Testowy pokemon 2',
    ),
  };

  // setUpAll(() async {
  //   await DependencyRegister.register();
  // });

  group('PokemonsListCubit', () {

    late PokemonsRepository pokemonsRepository;
    late MockPokemonListItemDao pokemonListItemDao;
    late PokemonsListCubit pokemonsCubit;
    int remoteLimit = 4;

    setUp(() async {
      pokemonsRepository = MockPokemonsRepository();
      pokemonListItemDao = MockPokemonListItemDao();

      when(
        () => pokemonsRepository.getRemotePokemons(limit: any(named: 'limit'), offset: any(named: 'offset')),
      ).thenAnswer((_) async => Future.value(List<PokemonListItem>.generate(remoteLimit, (i) => mockList[i % mockList.length])));

      when(
        () => pokemonListItemDao.getPokemonsPart(any(), any()),
      ).thenAnswer((_) async => Future.value(List<PokemonListItem>.generate(remoteLimit, (i) => mockList[i % mockList.length])));
      when(
        () => pokemonListItemDao.deleteAllPokemons(),
      ).thenAnswer((_) async {});
      when(
        () => pokemonListItemDao.insertPokemons(any()),
      ).thenAnswer((_) async {});


      pokemonsCubit = PokemonsListCubit(
        pokemonsRepository: pokemonsRepository,
        pokemonListItemDao: pokemonListItemDao,
      );

    });

    group('initialize', () {

      test('initial list is empty', () {
        final pokemonsCubit = PokemonsListCubit(pokemonsRepository: pokemonsRepository, pokemonListItemDao: pokemonListItemDao,);
        expect(pokemonsCubit.state.results, const []);
      });

      test('initial status is normal', () {
        final pokemonsCubit = PokemonsListCubit(pokemonsRepository: pokemonsRepository, pokemonListItemDao: pokemonListItemDao,);
        expect(pokemonsCubit.state.searchStatus, PokemonsListStatus.normal);
      });

    });

    group('fetchRemotePokemons', () {
      blocTest<PokemonsListCubit, PokemonsListState>(
        'emits correct initialize state',
        build: () => pokemonsCubit,
        act: (cubit) => cubit.initList(),
        expect: () => <dynamic>[
          isA<PokemonsListState>().having((w) => w.searchStatus, 'searchStatus', PokemonsListStatus.searching),
          isA<PokemonsListState>()
            .having((w) => w.searchStatus, 'searchStatus', PokemonsListStatus.normal)
            .having((w) => w.errorMessage, 'errorMessage', null)
            .having((w) => w.results.length, 'resultLength', remoteLimit),
        ],
      );

      blocTest<PokemonsListCubit, PokemonsListState>(
        'handle API error for initialize',
        setUp: () {
          when(
            () => pokemonsRepository.getRemotePokemons(limit: any(named: 'limit'), offset: any(named: 'offset')),
          ).thenThrow(Exception('_'));
        },
        build: () => pokemonsCubit,
        act: (cubit) => cubit.initList(),
        expect: () => <dynamic>[
          isA<PokemonsListState>().having((w) => w.searchStatus, 'searchStatus', PokemonsListStatus.searching),
          isA<PokemonsListState>()
              .having((w) => w.searchStatus, 'searchStatus', PokemonsListStatus.failure),
        ],
      );

      blocTest<PokemonsListCubit, PokemonsListState>(
        'emits correct appending state',
        build: () => pokemonsCubit,
        act: (cubit) => cubit.append(limit: remoteLimit),
        expect: () => <dynamic>[
          isA<PokemonsListState>()
              .having((w) => w.searchStatus, 'searchStatus', PokemonsListStatus.normal)
              .having((w) => w.appending, 'appending', true),
          isA<PokemonsListState>()
              .having((w) => w.searchStatus, 'searchStatus', PokemonsListStatus.normal)
              .having((w) => w.appending, 'appending', false)
              .having((w) => w.errorMessage, 'errorMessage', null)
              .having((w) => w.results.length, 'resultLength', remoteLimit),
        ],
      );

      blocTest<PokemonsListCubit, PokemonsListState>(
        'handle API error for appending',
        setUp: () {
          when(
              () => pokemonListItemDao.getPokemonsPart(any(), any()),
          ).thenThrow(Exception('_'));
        },
        build: () => pokemonsCubit,
        act: (cubit) => cubit.append(limit: remoteLimit),
        expect: () => <dynamic>[
          isA<PokemonsListState>()
              .having((w) => w.searchStatus, 'searchStatus', PokemonsListStatus.normal)
              .having((w) => w.appending, 'appending', true),
          isA<PokemonsListState>()
              .having((w) => w.searchStatus, 'searchStatus', PokemonsListStatus.normal)
              .having((w) => w.appending, 'appending', false)
              .having((w) => w.errorMessage, 'errorMessage', isNotNull),
        ],
      );

    });
  });
}

