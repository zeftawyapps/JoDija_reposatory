
const String emailAlreadyInUser = "email-already-in-use";
const String invalidEmail = "invalid-email";
const String userDisabled = "user-disabled";
const String userNotFound = "user-not-found";
const String wrongPassword = "wrong-password";
const String tooManyRequests = "too-many-requests";
const String operationNotAllowed = "operation-not-allowed";
const String loginAgain = "loginAgain";


String handilExcepstons(String  error ) {
  switch (error) {
    case emailAlreadyInUser :
      return "هذا البريد مسجل من قبل";
    case invalidEmail :
      return "هذا البريد غير مسجل ";
    case userDisabled :
      return "";
    case userNotFound :
      return "هذا البريد غير مسجل ";
    case wrongPassword :
      return "كلمة المرور خاطئة";
    case tooManyRequests :
      return "";
    case operationNotAllowed :
      return "";
    case loginAgain :
      return "";
    default :
      return "";
  }}