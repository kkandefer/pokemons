import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_details.dart';

@entity
class FavoritePokemon extends PokemonDetails {
  final int sequence;

  const FavoritePokemon({
    required this.sequence,
    required int id,
    required String name,
    String? imageUrl,
    String? imageUrlBig,
    required int baseExperience,
  }) : super(
    id: id,
    name: name,
    imageUrl: imageUrl,
    imageUrlBig: imageUrlBig,
    baseExperience: baseExperience,
  );

  @override
  List<Object?> get props => [ sequence, id, name, imageUrl, imageUrlBig, baseExperience ];

  FavoritePokemon copyWith({
    int? sequence,
  }) {
    return FavoritePokemon(
      sequence: sequence ?? this.sequence,
      id: id,
      name: name,
      imageUrl: imageUrl,
      imageUrlBig: imageUrlBig,
      baseExperience: baseExperience,
    );
  }
}