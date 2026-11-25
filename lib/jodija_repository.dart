/// A Flutter data repository and networking framework for single and
/// multi-solution architectures with Dio HTTP client, Firebase integration,
/// and strongly-typed error handling.
library;

// Configuration & Entry
export 'jodija.dart';
export 'jodija_configration.dart';

// Constants
export 'constes/api_urls.dart';
export 'constes/collections.dart';

// HTTP URLs & Headers
export 'https/http_urls.dart';
export 'https/i_http_urls.dart';
export 'https/proudecBaseUrls.dart';

// Interfaces
export 'interface/repo/crud_repo.dart';
export 'interface/sources/i_base_source.dart';
export 'interface/sources/i_base_stream.dart';
export 'interface/sources/i_json_base_source.dart';
export 'interface/sources/i_load_source.dart';
export 'interface/user/base/account.dart';
export 'interface/user/base/actions.dart';
export 'interface/user/firebase_acc.dart';
export 'interface/user/http_acc.dart';

// Models
export 'model/user/base_model/base_user_module.dart';
export 'model/user/base_model/inhertid_models/shardUserModel.dart';
export 'model/user/base_model/inhertid_models/user_model.dart';
export 'model/user/base_model/interface_userModel.dart';

// Repositories
export 'reposetory/load_data_reposatory.dart';
export 'reposetory/reposatory_stream.dart';
export 'reposetory/repsatory.dart';
export 'reposetory/user/auth_repo.dart';
export 'reposetory/user/profile_repo.dart';
export 'reposetory/user/users_repo.dart';

// Data Sources
export 'source/firebase/crud_firebase_source.dart';
export 'source/firebase/stream_firebase.dart';
export 'source/http/crud_http_sources.dart';
export 'source/http/load_http_sources.dart';
export 'source/user/accountLoginLogout/firebase/auth_email_source.dart';
export 'source/user/accountLoginLogout/firebase/auth_google_source.dart';
export 'source/user/accountLoginLogout/firebase/proflle_actions.dart';
export 'source/user/accountLoginLogout/firebase/users_sourse.dart';
export 'source/user/accountLoginLogout/http/auth_http_acc.dart';

// Errors
export 'utilis/errors/http_errors/bass_errors.dart';
export 'utilis/errors/http_errors/errors/bad_request_error.dart';
export 'utilis/errors/http_errors/errors/cancel_error.dart';
export 'utilis/errors/http_errors/errors/conflict_error.dart';
export 'utilis/errors/http_errors/errors/connection_error.dart';
export 'utilis/errors/http_errors/errors/custom_error.dart';
export 'utilis/errors/http_errors/errors/forbidden_error.dart';
export 'utilis/errors/http_errors/errors/format_error.dart';
export 'utilis/errors/http_errors/errors/internal_server_error.dart';
export 'utilis/errors/http_errors/errors/not_found_error.dart';
export 'utilis/errors/http_errors/errors/socket_error.dart';
export 'utilis/errors/http_errors/errors/timeout_error.dart';
export 'utilis/errors/http_errors/errors/unauthorized_error.dart';
export 'utilis/errors/http_errors/errors/unknown_error.dart';

// Firebase Utilities
export 'utilis/firebase/FCM.dart';
export 'utilis/firebase/fireBase_exception_consts.dart';
export 'utilis/firebase/firebase.dart';
export 'utilis/firebase/firebase_account.dart';
export 'utilis/firebase/firebase_and_storage_action.dart';
export 'utilis/firebase/firestore_inputs.dart';
export 'utilis/firebase/fuctions.dart';
export 'utilis/firebase/storage.dart';

// Functions & Logging
export 'utilis/functions/functions.dart';
export 'utilis/functions/jd_repo_console.dart';

// HTTP Client
export 'utilis/http_remotes/http_client.dart';
export 'utilis/http_remotes/http_methos_enum.dart';

// JSON Reader
export 'utilis/json_reader/json_asset_reader.dart';

// Utility Models
export 'utilis/models/base_data_model.dart';
export 'utilis/models/cell_models/cell.dart';
export 'utilis/models/cell_models/data-operations.dart';
export 'utilis/models/cell_models/modulscreateor.dart';
export 'utilis/models/cell_models/row_cells.dart';
export 'utilis/models/remote_base_model.dart';
export 'utilis/models/staus_model.dart';

// Results
export 'utilis/result/result.dart';
export 'utilis/result/result_data_indecator.dart';
export 'utilis/result/user_result.dart';
