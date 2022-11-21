import 'package:pokemons/features/pokemons/data/models/response/pokemons_list_item_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemons_list_dto.g.dart';

@JsonSerializable()
class PokemonsListDto {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonsListItemDto> results;

  const PokemonsListDto({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonsListDto.fromJson(Map<String, dynamic> json) => _$PokemonsListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonsListDtoToJson(this);

}