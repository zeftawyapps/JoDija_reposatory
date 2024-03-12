
import '../bass_errors.dart';

class CustomError extends BaseError {
  final String message;

  const CustomError({required this.message});
}