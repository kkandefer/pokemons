import 'package:json_annotation/json_annotation.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_list_item.dart';

part 'pokemons_list_item_dto.g.dart';

@JsonSerializable()
class PokemonsListItemDto {
  final String name;
  final String url;

  const PokemonsListItemDto({
    required this.name,
    required this.url,
  });

  factory PokemonsListItemDto.fromJson(Map<String, dynamic> json) => _$PokemonsListItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonsListItemDtoToJson(this);

  PokemonListItem toEntity() {
    RegExp regExp = RegExp(r"\/(\d+)\/");
    var idMatch = regExp.firstMatch(url);
    return PokemonListItem(
      id: int.tryParse(idMatch?.group(1) ?? '') ?? 0,
      name: name,
    );
  }
}