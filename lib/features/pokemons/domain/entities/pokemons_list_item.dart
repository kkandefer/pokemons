import 'package:equatable/equatable.dart';

class PokemonsListItem extends Equatable {

  final int id;
  final String name;
  final String? imageUrl;

  const PokemonsListItem({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [ id, name, imageUrl ];
}