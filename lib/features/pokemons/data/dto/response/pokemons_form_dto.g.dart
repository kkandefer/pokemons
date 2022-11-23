// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemons_form_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonsFormDto _$PokemonsFormDtoFromJson(Map<String, dynamic> json) =>
    PokemonsFormDto(
      id: json['id'] as int,
      name: json['name'] as String,
      sprites: json['sprites'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$PokemonsFormDtoToJson(PokemonsFormDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sprites': instance.sprites,
    };
