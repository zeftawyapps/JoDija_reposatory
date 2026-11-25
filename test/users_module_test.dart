import 'package:flutter_test/flutter_test.dart';
import 'package:jodija_repository/jodija_repository.dart';

void main() {
  group('Result & UserResult', () {
    test('Result.data exposes data without error', () {
      final result = Result<RemoteBaseModel, String>.data('ok');

      expect(result.hasDataOnly, isTrue);
      expect(result.hasErrorOnly, isFalse);
      expect(result.data, equals('ok'));
      expect(result.error, isNull);
    });

    test('Result.error exposes error without data', () {
      final errorModel = RemoteBaseModel(
        message: 'Not found',
        status: StatusModel.error,
      );
      final result = Result<RemoteBaseModel, String>.error(errorModel);

      expect(result.hasErrorOnly, isTrue);
      expect(result.hasDataOnly, isFalse);
      expect(result.error?.message, equals('Not found'));
      expect(result.data, isNull);
    });

    test('UserResult.data exposes user payload', () {
      final user = UsersBaseModel(
        uid: 'u1',
        name: 'Moaz',
        email: 'moaz@example.com',
      );
      final result = UserResult<RemoteBaseModel, UsersBaseModel>.data(user);

      expect(result.hasDataOnly, isTrue);
      expect(result.data?.uid, equals('u1'));
    });
  });

  group('Models', () {
    test('UsersBaseModel serializes and deserializes JSON', () {
      final model = UsersBaseModel(
        uid: '123',
        name: 'Alice',
        email: 'alice@example.com',
        token: 'tok',
      );
      final json = model.toJson();
      final restored = UsersBaseModel.formJson(json);

      expect(restored.uid, equals('123'));
      expect(restored.name, equals('Alice'));
      expect(restored.email, equals('alice@example.com'));
      expect(restored.token, equals('tok'));
    });

    test('ShardUserModel includes password in toJson', () {
      final model = ShardUserModel(
        uid: 'u2',
        email: 'bob@example.com',
        pass: 'secret',
      );
      final json = model.toJson();

      expect(json[ShardUserModel.passKey], equals('secret'));
      expect(json[UsersBaseModel.idKey], equals('u2'));
    });

    test('BaseEntityDataModel preserves metadata fields', () {
      final now = DateTime.utc(2026, 1, 1);
      final entity = BaseEntityDataModel(
        id: 'e1',
        isArchived: false,
        createdAt: now,
        updatedAt: now,
      );

      expect(entity.id, equals('e1'));
      expect(entity.isArchived, isFalse);
      expect(entity.createdAt, equals(now));
    });
  });

  group('HTTP Headers & Environment', () {
    test('HttpHeader sets language and bearer authorization headers', () {
      HttpHeader().setLangHeader(lang: 'ar');
      HttpHeader().setAuthHeader('jwt123');

      expect(HttpHeader().langKey, equals('x-lang'));
      expect(HttpHeader().langValue, equals('ar'));
      expect(HttpHeader().tokenKey, equals('Authorization'));
      expect(HttpHeader().usertoken, equals('Bearerjwt123'));
    });

    test('HttpUrlsEnveiroment updates base URLs', () {
      final env = HttpUrlsEnveiroment(
        baseUrl: 'https://api.example.com',
        imageBaseUrl: 'https://cdn.example.com',
      );

      expect(env.baseUrl, equals('https://api.example.com'));
      expect(env.imageBaseUrl, equals('https://cdn.example.com'));
    });
  });

  group('HTTP Error Hierarchy', () {
    test('Error subclasses extend BaseError', () {
      expect(BadRequestError(), isA<BaseError>());
      expect(UnauthorizedError(), isA<BaseError>());
      expect(ForbiddenError(), isA<BaseError>());
      expect(NotFoundError(), isA<BaseError>());
      expect(TimeoutError(), isA<BaseError>());
      expect(ConnectionError(), isA<BaseError>());
    });
  });
}
