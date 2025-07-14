import 'package:cloud_firestore/cloud_firestore.dart';

import '../../interface/user/base/actions.dart';
import '../../model/user/base_model/base_user_module.dart';
import '../../utilis/firebase/fireBase_exception_consts.dart';
import '../../utilis/models/remote_base_model.dart';
import '../../utilis/models/staus_model.dart';
import '../../utilis/result/result.dart';


/// A repository class for managing user profiles.
///
/// This class provides methods to retrieve and edit user profiles using
/// the provided account actions interface.
class BaseProfilRebo {

  late IBaseAccountActions _accountActions;

  /// Constructs a `BaseProfilRebo` instance.
  ///
  /// \param accountActions The account actions interface.
  BaseProfilRebo(IBaseAccountActions accountActions) {
    _accountActions = accountActions;
  }

  /// Retrieves the user profile for the given UID.
  ///
  /// \param uid The user ID.
  /// \returns A `Result` containing either a `RemoteBaseModel` or a `UsersBaseModel`.
  Future<Result<RemoteBaseModel, UsersBaseModel>> getProfile(String uid) async {
    try {
      var profileMapData = await _accountActions.getDataByDoc(uid);
      UsersBaseModel usersModel = UsersBaseModel.formJson(profileMapData);
      return Result.data(usersModel);
    } on FirebaseException catch (e) {
      return Result.error(
          RemoteBaseModel(message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }

  /// Edits the user profile.
  ///
  /// \param data The user model containing profile data.
  /// \param id The user ID.
  /// \param file An optional file to be uploaded.
  /// \returns A `Result` containing either a `RemoteBaseModel` or a `UsersBaseModel`.
  Future<Result<RemoteBaseModel, UsersBaseModel>> editProfile(
      {UsersBaseModel? data, String? id, Object? file}) async {
    try {
      var result = await _accountActions.updateProfileData(id: id!, mapData: data!.uMap, file: file);
      UsersBaseModel usersModel = UsersBaseModel.formJson(result);
      return Result.data(usersModel);
    } on FirebaseException catch (e) {
      return Result.error(
          RemoteBaseModel(message: handilExcepstons(e.code), status: StatusModel.error));
    }
  }
}