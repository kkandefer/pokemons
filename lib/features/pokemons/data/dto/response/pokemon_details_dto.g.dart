// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDetailsDto _$PokemonDetailsDtoFromJson(Map<String, dynamic> json) =>
    PokemonDetailsDto(
      id: json['id'] as int,
      name: json['name'] as String,
      base_experience: json['base_experience'] as int?,
      sprites: json['sprites'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$PokemonDetailsDtoToJson(PokemonDetailsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'base_experience': instance.base_experience,
      'sprites': instance.sprites,
    };
