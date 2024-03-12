import '../../../utilis/models/remote_base_model.dart';
import '../../../utilis/result/result.dart';

abstract class IEductionalHttpSource{
  Future<Result<RemoteBaseModel , Map<String ,dynamic>>>  addSortDepartmant(String depId , int sort)  ;
  Future<Result<RemoteBaseModel , Map<String ,dynamic>>>  createDepartmant(String depName  )  ;
  Future<Result<RemoteBaseModel , Map<String ,dynamic>>>  addDepartmantMony(String depId , int mony)  ;
  Future< Result<RemoteBaseModel , Map<String ,dynamic>>>   publishDepartmant(String depId , bool ispublish)  ;
  Future< Result<RemoteBaseModel ,  Map<String , dynamic>>>    getQuiz(String depId  )  ;
  Future< Result<RemoteBaseModel ,  Map<String , dynamic>>>     setGameResultToUserProfile(String depId , int score ,
     int currectAnswer ) ;

  }