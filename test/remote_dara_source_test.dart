import 'dart:convert';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:shop_o/core/data/datasources/remote_data_source.dart';
import 'package:shop_o/modules/authentication/models/user_prfile_model.dart';
import 'mock_data/mock_data_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  late RemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: http.Client());
  });

  group("user login ", () { 
    final userData = UserProfileModel.fromMap(
        json.decode(mockDataReader('user_login.json')));
    test("login and get user data", () async {
      final uri =
          Uri.parse('http://127.0.0.1:5500/test/mock_data/user_login.json');
      // arrange
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(mockDataReader('user_login.json'));
      when(() => mockHttpClient.get(uri)).thenAnswer((_) async => response);

      // when(mockHttpClient.get(any())).thenAnswer(
      //     (_) async => http.Response(mockDataReader('user_login.json'), 200));

      final result = await dataSource.signIn({});

      expect(userData, equals(result));
    });
  });
}
