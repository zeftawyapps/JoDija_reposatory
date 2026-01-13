import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


import '../../../../interface/user/firebase_acc.dart';
import '../../../../model/user/base_model/base_user_module.dart';
import '../../../../utilis/firebase/firebase_account.dart';


class GoogleAuthSoucre extends IFirebaseAuthentication {
  FirebaseAccount? _accountRegist;

  GoogleAuthSoucre() {
    _accountRegist = FirebaseAccount();
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

      final GoogleSignIn googleSignIn = GoogleSignIn();

      GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );


          final UserCredential userCredential = await auth.signInWithCredential(
              credential);

          user = userCredential;
        return user;
      }else {
        throw Exception('error');
      }
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
      }
      
        @override
        Future<UsersBaseModel> changePassword(String email, String oldPassword, String newPassword) {
          return _accountRegist!.changePassword(email, oldPassword, newPassword);
        }
    }

