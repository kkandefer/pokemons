part of 'app_navigator_cubit.dart';

enum AppNavigatorRoute { list, favorite }

class AppNavigatorState extends Equatable {

  final List<AppNavigatorRoute> _stack;

  AppNavigatorRoute get currentRoute => _stack.last;
  bool get canPop => _stack.length > 1;

  AppNavigatorState(this._stack);
  AppNavigatorState.initial():
    this._stack = [AppNavigatorRoute.list];

  AppNavigatorState pushRoute(AppNavigatorRoute route){
    return AppNavigatorState(
      List.from(_stack)..add(route),
    );
  }

  AppNavigatorState replaceRoute(AppNavigatorRoute route){
    return AppNavigatorState(
      List.from(_stack)..removeLast()..add(route),
    );
  }

  AppNavigatorState popRoute(){
    List<AppNavigatorRoute> newStack = List.from(_stack);
    if(newStack.length > 1){
      newStack.removeLast();
    }
    return AppNavigatorState(
      newStack,
    );
  }

  @override
  List<Object?> get props => [ _stack ];
}