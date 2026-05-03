import 'dart:async';
import 'dart:io';

/// Generates and syncs an auto-maintained flow section in flow.md.
///
/// Usage:
/// - dart run tool/sync_app_flow.dart
/// - dart run tool/sync_app_flow.dart --watch
void main(List<String> args) {
  final watchMode = args.contains('--watch');

  if (watchMode) {
    _syncOnce();
    _watchAndSync();
    return;
  }

  _syncOnce();
}

void _watchAndSync() {
  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    stderr.writeln('Folder lib tidak ditemukan.');
    exitCode = 1;
    return;
  }

  stdout.writeln('Watch mode aktif. Memantau perubahan di folder lib/...');

  Timer? debounce;
  libDir.watch(recursive: true).listen((event) {
    final path = event.path.replaceAll('\\', '/');
    if (!path.endsWith('.dart')) {
      return;
    }

    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 350), _syncOnce);
  });
}

void _syncOnce() {
  try {
    final edges = _collectEdges();
    final output = _renderAutoSection(edges);
    _writeSection(output);
    stdout.writeln(
      'flow.md berhasil disinkronkan (${DateTime.now().toIso8601String()}).',
    );
  } catch (error, stackTrace) {
    stderr.writeln('Gagal sinkronisasi flow.md: $error');
    stderr.writeln(stackTrace);
    exitCode = 1;
  }
}

class _Edge {
  const _Edge(this.from, this.to, this.via, this.filePath, this.line);

  final String from;
  final String to;
  final String via;
  final String filePath;
  final int line;

  String get key => '$from|$to|$via|$filePath|$line';
}

List<_Edge> _collectEdges() {
  final files =
      Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  final edges = <_Edge>[];

  for (final file in files) {
    final normalized = file.path.replaceAll('\\', '/');
    final sourceText = file.readAsStringSync();

    final sourceWidget =
        _findPrimaryWidgetName(sourceText) ??
        _pascalFromFileName(normalized.split('/').last);

    edges.addAll(
      _extractNavigatorEdges(
        sourceText: sourceText,
        sourceWidget: sourceWidget,
        filePath: normalized,
      ),
    );

    if (normalized.endsWith('/main.dart')) {
      final homeMatch = RegExp(
        r'home\s*:\s*(?:const\s+)?([A-Za-z_][A-Za-z0-9_]*)',
      ).firstMatch(sourceText);
      if (homeMatch != null) {
        final target = homeMatch.group(1)!;
        final line = _lineNumberFor(sourceText, homeMatch.start);
        edges.add(
          _Edge(sourceWidget, target, 'MaterialApp.home', normalized, line),
        );
      }
    }
  }

  final unique = <String, _Edge>{};
  for (final edge in edges) {
    unique[edge.key] = edge;
  }

  final result = unique.values.toList()
    ..sort((a, b) {
      final byFrom = a.from.compareTo(b.from);
      if (byFrom != 0) {
        return byFrom;
      }
      final byTo = a.to.compareTo(b.to);
      if (byTo != 0) {
        return byTo;
      }
      return a.filePath.compareTo(b.filePath);
    });

  return result;
}

List<_Edge> _extractNavigatorEdges({
  required String sourceText,
  required String sourceWidget,
  required String filePath,
}) {
  final edges = <_Edge>[];

  final pattern = RegExp(
    r'Navigator(?:\.of\([^)]*\))?\.(push|pushReplacement|pushAndRemoveUntil)\s*\([\s\S]{0,500}?\b(?:builder|pageBuilder)\s*:\s*\([^)]*\)\s*=>\s*(?:const\s+)?([A-Za-z_][A-Za-z0-9_]*)',
    multiLine: true,
  );

  for (final match in pattern.allMatches(sourceText)) {
    final method = match.group(1)!;
    final target = match.group(2)!;
    final line = _lineNumberFor(sourceText, match.start);
    edges.add(_Edge(sourceWidget, target, method, filePath, line));
  }

  return edges;
}

String? _findPrimaryWidgetName(String sourceText) {
  final classPattern = RegExp(
    r'class\s+([A-Za-z_][A-Za-z0-9_]*)\s+extends\s+(StatelessWidget|StatefulWidget)',
  );

  for (final match in classPattern.allMatches(sourceText)) {
    final name = match.group(1)!;
    if (!name.startsWith('_')) {
      return name;
    }
  }

  return null;
}

int _lineNumberFor(String content, int offset) {
  var line = 1;
  for (var i = 0; i < offset && i < content.length; i++) {
    if (content.codeUnitAt(i) == 10) {
      line++;
    }
  }
  return line;
}

String _pascalFromFileName(String fileName) {
  final base = fileName.replaceAll('.dart', '');
  final parts = base.split('_').where((p) => p.isNotEmpty);
  return parts
      .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
      .join();
}

String _renderAutoSection(List<_Edge> edges) {
  final nodes = <String>{};
  for (final edge in edges) {
    nodes.add(edge.from);
    nodes.add(edge.to);
  }

  final mermaidLines = <String>['flowchart TD'];
  for (final edge in edges) {
    mermaidLines.add('  ${edge.from} -->|${edge.via}| ${edge.to}');
  }

  final bulletLines = edges
      .map(
        (edge) =>
            '- ${edge.from} -> ${edge.to} (${edge.via}) [${edge.filePath}:${edge.line}]',
      )
      .join('\n');

  final generatedAt = DateTime.now().toLocal().toString();

  return [
    '## Auto-Generated Flow Map',
    '',
    '> Bagian ini dihasilkan otomatis oleh `tool/sync_app_flow.dart`.',
    '> Jangan edit manual di antara marker START/END karena akan ditimpa saat sinkronisasi.',
    '',
    '**Generated at:** $generatedAt',
    '**Detected nodes:** ${nodes.length}',
    '**Detected transitions:** ${edges.length}',
    '',
    '```mermaid',
    ...mermaidLines,
    '```',
    '',
    '### Detected Transitions',
    '',
    if (bulletLines.isNotEmpty)
      bulletLines
    else
      '- Tidak ada transisi terdeteksi.',
  ].join('\n');
}

void _writeSection(String renderedSection) {
  final appFlow = File('flow.md');
  if (!appFlow.existsSync()) {
    throw StateError('flow.md tidak ditemukan di root project.');
  }

  final startMarker = '<!-- AUTO_FLOW_START -->';
  final endMarker = '<!-- AUTO_FLOW_END -->';

  final content = appFlow.readAsStringSync();
  final block = '$startMarker\n$renderedSection\n$endMarker';

  if (content.contains(startMarker) && content.contains(endMarker)) {
    final updated = content.replaceFirst(
      RegExp('$startMarker[\\s\\S]*?$endMarker'),
      block,
    );
    appFlow.writeAsStringSync(updated);
    return;
  }

  final withSection = [
    content.trimRight(),
    '',
    '---',
    '',
    block,
    '',
  ].join('\n');

  appFlow.writeAsStringSync(withSection);
}
