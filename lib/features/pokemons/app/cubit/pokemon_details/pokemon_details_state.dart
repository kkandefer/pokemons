part of 'pokemon_details_cubit.dart';

enum PokemonDetailsStatus { initial, normal, failure }

// Strasznie dużo czasu pochłoneła mi lista, dlatego tu tylko już taki prosty stan
class PokemonDetailsState extends Equatable {

  final PokemonDetailsStatus status;
  final PokemonDetails? details;

  const PokemonDetailsState({ required this.status, this.details }) :
      assert(status != PokemonDetailsStatus.normal || details != null);

  const PokemonDetailsState.initial() :
    status = PokemonDetailsStatus.initial,
    details = null;

  @override
  List<Object?> get props => [ status, details ];

  PokemonDetailsState copyWith({
    PokemonDetailsStatus? status,
    PokemonDetails? details,
  }) {
    return PokemonDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
    );
  }

}

