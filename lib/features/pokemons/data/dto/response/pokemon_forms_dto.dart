import 'package:json_annotation/json_annotation.dart';

part 'pokemon_forms_dto.g.dart';

@JsonSerializable()
class PokemonFormsDto {
  final int id;
  final String name;
  final Map<String, dynamic> sprites;

  const PokemonFormsDto({
    required this.id,
    required this.name,
    required this.sprites,
  });

  factory PokemonFormsDto.fromJson(Map<String, dynamic> json) => _$PokemonFormsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonFormsDtoToJson(this);

  String? get imageUrl => sprites['front_default'];//tu już jadę na skróty, ponieważ spora sie ta aplikacja robi, a do końca daleko
}