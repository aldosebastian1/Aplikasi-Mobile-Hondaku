import 'dart:convert';
import 'dart:io';
import 'mock_data/master_motorcycle_data.dart';

void main() async {
  // Path menuju hondaku-api/prisma/data
  final file = File('../hondaku-api/prisma/data/motorcycles.json');
  await file.create(recursive: true);
  
  // Convert list of objects to list of maps
  final List<Map<String, dynamic>> jsonData = motorcycleDatabase.map((m) => m.toJson()).toList();
  
  // Save as JSON string
  final jsonString = jsonEncode(jsonData);
  await file.writeAsString(jsonString);
  
  print('✅ Berhasil mengekspor ${jsonData.length} data motor ke ${file.path}');
}
