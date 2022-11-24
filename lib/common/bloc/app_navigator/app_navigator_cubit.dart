import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_navigator_state.dart';

class AppNavigatorCubit extends Cubit<AppNavigatorState> {

  AppNavigatorCubit() : super(AppNavigatorState.initial());

  void goBackRoute() {
    emit(state.popRoute());
  }

  void goToRoute(AppNavigatorRoute route) {
    if(state.currentRoute != route){
      emit(state.pushRoute(route));
    }
  }
}
