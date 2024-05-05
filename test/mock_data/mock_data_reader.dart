import 'dart:io';

String mockDataReader(String name) =>
    File('test/mock_data/$name').readAsStringSync();
