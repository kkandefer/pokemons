import 'package:equatable/equatable.dart';

class PokemonFeature extends Equatable {
  final int id;
  final String name;

  const PokemonFeature({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [ id, name ];
}