// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemons_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonsListDto _$PokemonsListDtoFromJson(Map<String, dynamic> json) =>
    PokemonsListDto(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => PokemonsListItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonsListDtoToJson(PokemonsListDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
