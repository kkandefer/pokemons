import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_feature.dart';

@entity
class PokemonDetails extends Equatable {
  @primaryKey
  final int id;
  final String name;
  final String? imageUrl;
  final List<PokemonFeature> features;

  const PokemonDetails({
    required this.id,
    required this.name,
    this.imageUrl,
    this.features = const [],
  });

  @override
  List<Object?> get props => [ id, name, imageUrl, features ];
}