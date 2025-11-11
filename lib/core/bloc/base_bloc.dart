import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_state.dart';

abstract class BaseBloc<Event, Model> extends Bloc<Event, BaseState<Model>> {
  BaseBloc() : super(BaseState<Model>.initial());

  Future<void> handleRequest(Future<Model> Function() request) async {
    emit(BaseState<Model>.loading());
    try {
      final response = await request();
      emit(BaseState<Model>.success(response));
    } catch (e) {
      emit(BaseState<Model>.error(e.toString()));
    }
  }
}
