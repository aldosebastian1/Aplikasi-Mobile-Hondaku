import 'dart:io';

void main() {
  final libDir = Directory('lib');
  final files = libDir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart')).toList();
  
  // Map of filename to its new path relative to lib/
  final Map<String, String> nameToPath = {};
  for (final file in files) {
    final relPath = file.path.replaceAll('\\', '/').replaceFirst('lib/', '');
    final name = relPath.split('/').last;
    nameToPath[name] = relPath;
  }
  
  for (final file in files) {
    String content = file.readAsStringSync();
    final fileRelPath = file.path.replaceAll('\\', '/').replaceFirst('lib/', '');
    
    // Replace all import '...';
    content = content.replaceAllMapped(RegExp(r"import\s+'([^']+)\.dart';"), (match) {
      final oldImport = match.group(1)! + '.dart';
      if (oldImport.startsWith('package:')) return match.group(0)!;
      
      final importedName = oldImport.split('/').last;
      
      if (nameToPath.containsKey(importedName)) {
        final targetRelPath = nameToPath[importedName]!;
        // compute relative path from fileRelPath to targetRelPath
        final fromParts = fileRelPath.split('/')..removeLast();
        final toParts = targetRelPath.split('/');
        
        int commonPrefix = 0;
        while (commonPrefix < fromParts.length && commonPrefix < toParts.length && fromParts[commonPrefix] == toParts[commonPrefix]) {
          commonPrefix++;
        }
        
        final up = fromParts.length - commonPrefix;
        final upStr = List.filled(up, '..').join('/');
        final downStr = toParts.sublist(commonPrefix).join('/');
        
        String newImport = '';
        if (upStr.isEmpty) {
          newImport = downStr;
        } else {
          newImport = '$upStr/$downStr';
        }
        
        return "import '$newImport';";
      }
      
      return match.group(0)!;
    });
    
    file.writeAsStringSync(content);
  }
  
  print('Imports fixed successfully!');
}
