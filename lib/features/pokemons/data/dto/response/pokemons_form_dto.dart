import 'package:json_annotation/json_annotation.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_list_item.dart';

part 'pokemons_form_dto.g.dart';

@JsonSerializable()
class PokemonsFormDto {
  final int id;
  final String name;
  final Map<String, dynamic> sprites;

  const PokemonsFormDto({
    required this.id,
    required this.name,
    required this.sprites,
  });

  factory PokemonsFormDto.fromJson(Map<String, dynamic> json) => _$PokemonsFormDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonsFormDtoToJson(this);

  String? get imageUrl => sprites['front_default'];//tu już jadę na skróty, ponieważ spora sie ta aplikacja robi, a do końca daleko
}