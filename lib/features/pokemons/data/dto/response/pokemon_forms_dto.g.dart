// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_forms_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonFormsDto _$PokemonFormsDtoFromJson(Map<String, dynamic> json) =>
    PokemonFormsDto(
      id: json['id'] as int,
      name: json['name'] as String,
      sprites: json['sprites'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$PokemonFormsDtoToJson(PokemonFormsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sprites': instance.sprites,
    };
