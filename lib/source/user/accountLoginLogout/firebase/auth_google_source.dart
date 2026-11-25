import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


import '../../../../interface/user/firebase_acc.dart';
import '../../../../model/user/base_model/base_user_module.dart';
import '../../../../utilis/firebase/firebase_account.dart';


class GoogleAuthSoucre extends IFirebaseAuthentication {
  static bool _isInitialized = false;

  FirebaseAccount? _accountRegist;
  final String? clientId;
  final String? serverClientId;

  GoogleAuthSoucre({this.clientId, this.serverClientId}) {
    _accountRegist = FirebaseAccount();
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await GoogleSignIn.instance.initialize(
        clientId: clientId,
        serverClientId: serverClientId,
      );
      _isInitialized = true;
    }
  }

  @override
  Future<UsersBaseModel> createAccount({Map<String , dynamic >? body  })async{
 var user =await   _signInWithGoogle();
 if (user == null) {
   throw Exception('user is  null ');
 }

 return UsersBaseModel(name: user.user!.displayName, email: user.user!.email, uid: user.user!.uid, token: await  user.user!.getIdToken() ?? "");
  }

  @override
  Future<UsersBaseModel> logIn() async{
    var user =await   _signInWithGoogle();
    if (user == null) {
      throw Exception('user is  null ');
    }
    return  UsersBaseModel(name: user.user!.displayName, email: user.user!.email, uid: user.user!.uid, token: await  user.user!.getIdToken() ?? "") ;
  }

  @override
  Future<void> logOut()async   {
   await  _accountRegist!.logOut();
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential? user;

      await _ensureInitialized();
      final GoogleSignInAccount googleSignInAccount =
          await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleSignInAuthentication =
          googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential;
      return user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
           throw Exception('account-exists-with-different-credential');
          }
          else if (e.code == 'invalid-credential') {
             throw Exception('invalid-credential');
          }
        } catch (e) {
          throw Exception('error');
        }
    return null;
      }
      
        @override
        Future<UsersBaseModel> changePassword(String email, String oldPassword, String newPassword) {
          return _accountRegist!.changePassword(email, oldPassword, newPassword);
        }
    }

