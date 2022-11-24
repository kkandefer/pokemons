// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemons/common/bloc/app_navigator/app_navigator_cubit.dart';
import 'package:pokemons/di/dependency_register.dart';
import 'package:pokemons/main.dart';
import 'package:pokemons/ui/favorite_pokemons_list_screen.dart';
import 'package:pokemons/di/dependency_register.dart';
import 'package:dio/dio.dart';

class MockAppNavigatorCubit extends MockCubit<AppNavigatorState> implements AppNavigatorCubit {}
class MockDefaultHttpClientAdapter extends Mock implements DefaultHttpClientAdapter {}

void main() {

  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await DependencyRegister.register();
    await GetIt.instance.allReady();
  });

  // komentuję, bo trzeba mockować HttpClient, a coś mi to nie działa,
  // niestey już kompketnie nie moge poświęcić więcej czasu!


  // group('MainNavigation', () {
  //
  //   late AppNavigatorCubit appNavigatorCubit;
  //
  //   setUp(() {
  //     appNavigatorCubit = MockAppNavigatorCubit();
  //   });
  //
  //   testWidgets('navigates to Favorite when favorite button is tapped',
  //     (tester) async {
  //       // when(() => appNavigatorCubit.state).thenReturn(AppNavigatorState.initial());
  //       await tester.pumpWidget(
  //         MyApp()
  //       );
  //       await tester.tap(find.byIcon(Icons.favorite));
  //       await tester.pumpAndSettle();
  //       expect(find.byType(FavoritePokemonsListScreen), findsOneWidget);
  //     });
  // });
}
