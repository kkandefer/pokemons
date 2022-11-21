part of 'pokemons_list_cubit.dart';

enum PokemonsListStatus { searching, normal, failure }

class PokemonsListState extends Equatable {

  final PokemonsListStatus searchStatus;
  final List<PokemonsListItem> results;
  final String? searchPhrase;

  final bool appending;
  final bool hasRatherMax;
  final String? errorMessage;

  const PokemonsListState({
    required this.searchStatus,
    required this.results,
    this.searchPhrase,
    required this.appending,
    required this.hasRatherMax,
    this.errorMessage,
  });

  const PokemonsListState.initial() :
    searchStatus = PokemonsListStatus.normal,
    results = const [],
    searchPhrase = null,
    appending = false,
    hasRatherMax = false,
    errorMessage = null;

  @override
  List<Object?> get props => [ searchStatus, results, searchPhrase, appending, hasRatherMax, errorMessage ];

  PokemonsListState copyWith({
    PokemonsListStatus? searchStatus,
    List<PokemonsListItem>? results,
    String? searchPhrase,
    int? currentOffset,
    bool? appending,
    bool? hasRatherMax,
    String? errorMessage,
  }) {
    return PokemonsListState(
      searchStatus: searchStatus ?? this.searchStatus,
      results: results ?? this.results,
      searchPhrase: searchPhrase ?? this.searchPhrase,
      appending: appending ?? this.appending,
      hasRatherMax: hasRatherMax ?? this.hasRatherMax,
      errorMessage: errorMessage ?? null,
    );
  }

  PokemonsListState copyAndClearSearchPhrase({
    PokemonsListStatus? searchStatus,
    List<PokemonsListItem>? results,
    String? searchPhrase,
    int? currentOffset,
    bool? appending,
    bool? hasRatherMax,
    String? errorMessage,
  }) {
    return PokemonsListState(
      searchStatus: this.searchStatus,
      results: this.results,
      searchPhrase: null,
      appending: this.appending,
      hasRatherMax: this.hasRatherMax,
      errorMessage: null,
    );
  }
}

