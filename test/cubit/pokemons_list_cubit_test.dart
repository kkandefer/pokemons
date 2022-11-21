
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemons/features/pokemons/app/cubit/pokemons_list_cubit.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_details.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemons_list_item.dart';
import 'package:pokemons/features/pokemons/domain/pokemons_repository.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const List<PokemonsListItem> mockList = [
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

  group('PokemonsListCubit', () {

    late PokemonsRepository pokemonsRepository;
    late PokemonsListCubit pokemonsCubit;
    int remoteLimit = 40;

    setUp(() async {
      pokemonsRepository = MockPokemonsRepository();
      when(
        () => pokemonsRepository.getRemotePokemons(limit: any(named: 'limit'), offset: any(named: 'offset')),
      ).thenAnswer((_) async => Future.value(List<PokemonsListItem>.generate(remoteLimit, (i) => mockList[i % mockList.length])));
      pokemonsCubit = PokemonsListCubit(pokemonsRepository: pokemonsRepository);

    });

    group('initialize', () {

      test('initial list is empty', () {
        final pokemonsCubit = PokemonsListCubit(pokemonsRepository: pokemonsRepository);
        expect(pokemonsCubit.state.results, const []);
      });

      test('initial status is normal', () {
        final pokemonsCubit = PokemonsListCubit(pokemonsRepository: pokemonsRepository);
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
                () => pokemonsRepository.getRemotePokemons(limit: any(named: 'limit'), offset: any(named: 'offset')),
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

