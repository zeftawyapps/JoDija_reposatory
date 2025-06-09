import 'package:cloud_firestore/cloud_firestore.dart';

/// An abstract class that defines the actions for account and profile data.
///
/// This class provides methods to create, update, and retrieve profile data.
/// It also defines methods for handling sub-profile data actions.
abstract class IBaseAccountActions {
  /// Creates profile data for a user.
  ///
  /// \param id The identifier of the user.
  /// \param data A map containing the profile data.
  /// \returns A `Future` that completes when the profile data is created.
  Future createProfileData({required String id, required Map<String, dynamic> data});

  /// Updates profile data for a user.
  ///
  /// \param id The identifier of the user.
  /// \param mapData An optional map containing the updated profile data.
  /// \param file An optional file object associated with the profile data.
  /// \returns A `Future` that completes with a map containing the updated profile data.
  Future<Map<String, dynamic>> updateProfileData({required String id, Map<String, dynamic>? mapData, Object? file});

  /// Retrieves profile data for a user by document ID.
  ///
  /// \param id The identifier of the document.
  /// \returns A `Future` that completes with a map containing the profile data.
  Future<Map<String, dynamic>> getDataByDoc(String id);
}

/// An abstract class that defines the actions for sub-profile data.
///
/// This class provides methods to create, update, delete, and retrieve sub-profile data.
abstract class IProfileSubDataActions {
  /// Creates sub-profile data.
  ///
  /// \param path The path where the sub-profile data is stored.
  /// \param data A map containing the sub-profile data.
  /// \param file An optional file object associated with the sub-profile data.
  /// \returns A `Future` that completes when the sub-profile data is created.
  Future createProfileData({required String path, required Map<String, dynamic> data, Object? file});

  /// Updates sub-profile data.
  ///
  /// \param id The identifier of the sub-profile data.
  /// \param path The path where the sub-profile data is stored.
  /// \param data A map containing the updated sub-profile data.
  /// \returns A `Future` that completes when the sub-profile data is updated.
  Future updateProfileData({required String id, required String path, required Map<String, dynamic> data});

  /// Deletes sub-profile data.
  ///
  /// \param path The path where the sub-profile data is stored.
  /// \returns A `Future` that completes when the sub-profile data is deleted.
  Future deleteProfileData({required String path});

  /// Retrieves a list of sub-profile data.
  ///
  /// \param path The path where the sub-profile data is stored.
  /// \param queryBuilder An optional function to build a query for filtering the data.
  /// \returns A `Future` that completes with a list of maps containing the sub-profile data.
  Future<List<Map<String, dynamic>>> getData({required String path, Query Function(Query query)? queryBuilder});
}