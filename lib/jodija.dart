library users_module;

import 'package:cloud_firestore/cloud_firestore.dart';

/// A Calculator.
class JoDijaTestConnection {
  void  test(){

    FirebaseFirestore.instance.collection("testJoDija").add(({"tested":true}));
  }
}
