import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemons/features/pokemons/app/cubit/pokemons_list/pokemons_list_cubit.dart';

class SearchForm extends StatefulWidget {
  SearchForm({Key? key}) : super(key: key);

  @override
  _SearchFormState createState() {
    return _SearchFormState();
  }
}

class _SearchFormState extends State<SearchForm> {

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        autovalidateMode: AutovalidateMode.always,
        onFieldSubmitted: (value) {
          BlocProvider.of<PokemonsListCubit>(context).search(value);
        },
        onChanged: (value) {
          if (_debounce?.isActive ?? false){
            _debounce!.cancel();
          }
          _debounce = Timer(const Duration(milliseconds: 500), () {
            BlocProvider.of<PokemonsListCubit>(context).search(value);
          });
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          hintText: 'Szukaj...',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
