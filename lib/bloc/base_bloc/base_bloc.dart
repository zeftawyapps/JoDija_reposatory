import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 import '../../utilis/models/remote_base_model.dart';
import 'base_state.dart';

class CommerceModuleBaseBloc<T> extends Cubit<CommerceModuleBaseState<T>> {
  CommerceModuleBaseBloc([T? data]) : super(data != null? CommerceModuleBaseState.success(data): const CommerceModuleBaseState.init());
  T? _data;

  T? get data => _data;

  set data(T? value){
    _data = value;
  }

  void loadingState(){
    emit(const CommerceModuleBaseState.loading());
  }

  void successState([T? data]){
    if(_data != data){
      _data = data;
    }
    emit(CommerceModuleBaseState.success(data));

  }

  void failedState(RemoteBaseModel error, VoidCallback callback){
    emit(CommerceModuleBaseState.failure(error, callback));
  }

}