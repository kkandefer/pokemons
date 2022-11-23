import 'package:json_annotation/json_annotation.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_details.dart';

part 'pokemon_details_dto.g.dart';

@JsonSerializable()
class PokemonDetailsDto {
  final int id;
  final String name;
  final int? base_experience;//na wszleki wypadek nullable (nie sprawdziłem dokładnie)
  final Map<String, dynamic> sprites;// ojoj, dopiero teraz widzę, że tu tez jest prites, nie potrzebnie robiłem repo do form

  const PokemonDetailsDto({
    required this.id,
    required this.name,
    this.base_experience,
    required this.sprites,
  });

  factory PokemonDetailsDto.fromJson(Map<String, dynamic> json) => _$PokemonDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDetailsDtoToJson(this);

  String? get imageUrl => sprites['front_default'];
  String? get imageUrlBig => sprites['other']?['official-artwork']?['front_default'];

  PokemonDetails toEntity() {
    return PokemonDetails(
      id: id,
      name: name,
      imageUrl: imageUrl,
      imageUrlBig: imageUrlBig,
      baseExperience: base_experience ?? 0,
    );
  }
}