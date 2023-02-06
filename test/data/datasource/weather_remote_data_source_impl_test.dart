import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

import 'weather_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late final client;
  setUp(() {
    client = MockClient();
  });
}
