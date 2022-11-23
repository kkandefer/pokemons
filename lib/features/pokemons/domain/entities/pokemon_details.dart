import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

class PokemonDetails extends Equatable {
  @primaryKey
  final int id;
  final String name;
  final String? imageUrl;
  final String? imageUrlBig;
  final int baseExperience;

  const PokemonDetails({
    required this.id,
    required this.name,
    this.imageUrl,
    this.imageUrlBig,
    required this.baseExperience,
  });

  @override
  List<Object?> get props => [ id, name, imageUrl, imageUrlBig, baseExperience ];
}