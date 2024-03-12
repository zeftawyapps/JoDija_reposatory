 import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utilis/models/remote_base_model.dart';

  part 'base_state.freezed.dart';

@immutable
@freezed
class CommerceModuleBaseState<T> with _$BaseState<T>{
  const factory CommerceModuleBaseState.init() = _Init;
  const factory CommerceModuleBaseState.loading() = _Loading;
  const factory CommerceModuleBaseState.success([T? model]) = _Success<T>;
  const factory CommerceModuleBaseState.failure(RemoteBaseModel error, VoidCallback callback) = _Failure;
}