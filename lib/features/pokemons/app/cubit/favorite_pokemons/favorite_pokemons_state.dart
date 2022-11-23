part of 'favorite_pokemons_cubit.dart';

enum FavoritePokemonsStatus { initial, normal, failure }

// Strasznie dużo czasu pochłoneła mi lista, dlatego tu tylko już taki prosty stan
class FavoritePokemonsState extends Equatable {

  final FavoritePokemonsStatus status;
  final List<FavoritePokemon> favorites;

  const FavoritePokemonsState({ required this.status, required this.favorites });

  const FavoritePokemonsState.initial() :
    status = FavoritePokemonsStatus.initial,
    favorites = const [];

  @override
  List<Object?> get props => [ status, favorites ];

  FavoritePokemonsState copyWith({
    FavoritePokemonsStatus? status,
    List<FavoritePokemon>? favorites,
  }) {
    return FavoritePokemonsState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
    );
  }

}

