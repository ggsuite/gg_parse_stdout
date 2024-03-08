// @license
// Copyright (c) 2019 - 2024 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

/// Returns all Vscode formatted error lines from the given error string.
List<String> parseDartFilePathes(String? stdout) {
  if (stdout == null || stdout.isEmpty) {
    return <String>[];
  }

  final pathes = _parsePathes(stdout);
  return makePathesVscodeCompatible(pathes);
}

// .............................................................................
/// Replaces error lines in the given message with vscode compatible ones.
List<String> makePathesVscodeCompatible(List<String> pathes) {
  var result = List<String>.empty(growable: true);

  for (var path in pathes) {
    var compatiblePath = _makePathesVscodeCompatible(path);
    result.add(path.replaceAll(path, compatiblePath));
  }

  return result;
}

// .............................................................................
List<String> _parsePathes(String message) {
  // Regular expression to match file paths and line numbers
  // RegExp exp = RegExp(r'[\/\w]+\.dart[\s:]*\d+:\d+');
  final exp = RegExp(r'[\/\w]+\.dart(?:[\s:]*\d+:\d+)?');
  final matches = exp.allMatches(message);
  final result = <String>[];

  if (matches.isEmpty) {
    return result;
  }

  for (final match in matches) {
    var matchedString = match.group(0) ?? '';
    result.add(matchedString);
  }

  return result;
}

// .............................................................................
String _makePathesVscodeCompatible(String pathes) {
  pathes = pathes.replaceAll(':', ' ');
  var parts = pathes.split(' ');
  if (parts.length != 3) {
    return pathes;
  }

  var filePath = parts[0];
  var lineNumber = parts[1];
  var columnNumber = parts[2];

  return '$filePath:$lineNumber:$columnNumber';
}
