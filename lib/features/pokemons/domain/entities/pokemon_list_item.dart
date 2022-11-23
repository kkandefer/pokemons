import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class PokemonListItem extends Equatable {
  @primaryKey
  final int id;
  final String name;
  final String? imageUrl;

  const PokemonListItem({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [ id, name, imageUrl ];
}