/// Extracts doc comments from the package source and assembles the
/// per-module reference markdown files used by the
/// `woocommerce-flutter-api-documentation` AI skill.
///
/// Usage: `dart run tool/extract_docs.dart`
///
/// For every directory under `lib/src/` it writes one markdown file to
/// `skills/woocommerce-flutter-api-documentation/references/<module>.md`
/// containing the doc comments of every public class, enum, extension,
/// constructor, field and method.
library;

import 'dart:io';

const libSrc = 'lib/src';
const outDir = 'skills/woocommerce-flutter-api-documentation/references';

const barrelFiles = {'models.dart', 'enums.dart', 'api.dart'};
const endpointSuffix = '_endpoints.dart';

/// A documented declaration: its doc comment plus a short signature.
class Doc {
  Doc(this.kind, this.declaration, this.comment);

  final String
      kind; // class | enum | extension | factory | getter | field | method | type
  final String declaration;
  final List<String> comment;
}

List<Doc> parseFile(String path) {
  final lines = File(path).readAsLinesSync();
  final docs = <Doc>[];
  var i = 0;
  while (i < lines.length) {
    final line = lines[i];
    if (!line.trimLeft().startsWith('///')) {
      i++;
      continue;
    }
    final comment = <String>[];
    var j = i;
    while (j < lines.length && lines[j].trimLeft().startsWith('///')) {
      final raw = lines[j].trimLeft();
      comment.add(raw.length >= 3 ? raw.substring(3) : '');
      j++;
    }
    // strip the common source indentation so markdown renders headings
    // and lists correctly while preserving relative indentation.
    final nonEmpty = comment
        .where((l) => l.trim().isNotEmpty)
        .map((l) => l.length - l.trimLeft().length)
        .toList();
    final minIndent =
        nonEmpty.isEmpty ? 0 : nonEmpty.reduce((a, b) => a < b ? a : b);
    for (var n = 0; n < comment.length; n++) {
      comment[n] = comment[n].length >= minIndent
          ? comment[n].substring(minIndent)
          : comment[n];
    }
    if (comment.isNotEmpty && comment.first.startsWith('!')) {
      // library doc — skip
      i = j;
      continue;
    }
    // find the declaration: skip blank/annotation lines
    var k = j;
    while (k < lines.length) {
      final decl = lines[k].trim();
      if (decl.isEmpty) {
        k++;
        continue;
      }
      if (decl.startsWith('@')) {
        k++;
        continue;
      }
      break;
    }
    if (k >= lines.length) {
      i = j;
      continue;
    }
    final decl = lines[k].trim();
    var sig = _stripBody(decl);
    // multi-line declarations: consume continuation lines until balanced
    var depth = _balance(sig);
    var m = k + 1;
    while (depth > 0 && m < lines.length) {
      sig += ' ${lines[m].trim()}';
      depth = _balance(sig);
      m++;
    }
    sig = sig.trim();
    sig = _truncateSig(sig);
    final kind = _classify(decl);
    if (kind != null) {
      docs.add(Doc(kind, sig, comment));
    }
    i = m;
  }
  return docs;
}

/// Cuts a collected signature at the body boundary (top-level `{`, `=>`
/// or `;`), keeping only the declaration itself.
String _truncateSig(String sig) {
  var depth = 0;
  for (var i = 0; i < sig.length; i++) {
    final ch = sig[i];
    if (ch == '(' || ch == '[') depth++;
    if (ch == ')' || ch == ']') depth--;
    if (depth == 0 && (ch == '{' || ch == ';')) {
      return sig.substring(0, i).trim();
    }
    if (depth == 0 && ch == '=' && i + 1 < sig.length && sig[i + 1] == '>') {
      return sig.substring(0, i).trim();
    }
  }
  return sig;
}

int _balance(String s) {
  var depth = 0;
  for (final ch in s.split('')) {
    if (ch == '(' || ch == '[' || ch == '{') depth++;
    if (ch == ')' || ch == ']' || ch == '}') depth--;
  }
  return depth;
}

String _stripBody(String decl) {
  for (final suffix in [' {', ';', '(', '=>']) {
    if (decl.endsWith(suffix)) {
      return decl.substring(0, decl.length - suffix.length).trim();
    }
  }
  return decl;
}

String? _classify(String decl) {
  if (RegExp(r'^(abstract\s+|final\s+|sealed\s+|base\s+|interface\s+)*class ')
          .hasMatch(decl) ||
      decl.startsWith('class ') ||
      decl.startsWith('abstract final class ')) {
    return 'class';
  }
  if (decl.startsWith('enum ')) return 'enum';
  if (decl.startsWith('extension ')) return 'extension';
  if (decl.startsWith('factory ') || decl.startsWith('const factory ')) {
    return 'factory';
  }
  if (decl.startsWith('const ')) return 'constructor';
  if (decl.startsWith('static ')) return 'static';
  if (decl.startsWith('Map<String, dynamic> toJson') ||
      decl.startsWith('void toJson')) {
    return 'method';
  }
  if (RegExp(
          r'^(Future<|Stream<|List<|Map<|Set<|void |int |String |bool |double |DateTime |dynamic |Woo\w+<|Woo\w+ |T )')
      .hasMatch(decl)) {
    return 'method';
  }
  if (RegExp(r'^(final|var|late) ').hasMatch(decl) ||
      RegExp(r'^[A-Za-z_][\w.<>?]*\?+ [a-z]').hasMatch(decl)) {
    return 'field';
  }
  if (decl.startsWith('@override')) return null;
  if (decl.startsWith('bool operator')) return 'operator';
  if (decl.startsWith('int get hashCode')) return 'getter';
  if (decl.startsWith('operator')) return 'operator';
  if (decl.startsWith('String toString')) return 'method';
  if (decl.startsWith('int get ') || decl.startsWith('String get ')) {
    return 'getter';
  }
  if (decl.startsWith('type ')) return 'type';
  return 'member';
}

String moduleName(String dir) => dir.split('/').last;

void main() {
  final outputs = <String, String>{};
  final dirs = Directory(libSrc)
      .listSync()
      .whereType<Directory>()
      .map((d) => d.path)
      .toList()
    ..sort();
  final out = Directory(outDir);
  out.createSync(recursive: true);

  var totalDocs = 0;
  for (final dir in dirs) {
    final name = moduleName(dir);
    final files = Directory(dir)
        .listSync(recursive: true)
        .whereType<File>()
        .map((f) => f.path)
        .toList()
      ..sort();
    final buf = StringBuffer();
    buf.writeln('# $name\n');

    for (final file in files) {
      final base = file.split('/').last;
      if (barrelFiles.contains(base)) continue;
      if (base.endsWith(endpointSuffix)) continue;
      final docs = parseFile(file);
      if (docs.isEmpty) continue;
      buf.writeln('## ${base.replaceAll('.dart', '')}\n');
      for (final doc in docs) {
        if (doc.comment.isEmpty) continue;
        buf.writeln('### ${doc.declaration}\n');
        buf.writeln(doc.comment.join('\n').trim());
        buf.writeln();
        totalDocs++;
      }
    }

    final text = buf.toString();
    if (text.trim().isEmpty) continue;
    outputs[name] = text;
  }
  if (totalDocs == 0) {
    stdout.writeln('WARNING: no doc comments found in lib/src. The source is '
        'deliberately comment-free; references are maintained by hand. '
        'Nothing was written.');
    return;
  }
  for (final entry in outputs.entries) {
    File('${out.path}/${entry.key}.md').writeAsStringSync(entry.value);
    stdout.writeln('wrote ${entry.key}.md (${entry.value.length} chars)');
  }
  stdout.writeln('TOTAL: ${outputs.length} reference files');
}
