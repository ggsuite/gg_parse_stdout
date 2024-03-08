#!/usr/bin/env dart
// @license
// Copyright (c) 2019 - 2024 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'package:gg_parse_stdout/src/gg_parse_stdout.dart';

void main() {
  print(
    parseDartFilePathes(content)
        .join('\n'), // [lib/src/tools/error_lines.dart:7:14]
  );
}

// .............................................................................
const content = '''
Analyzing gg_check...
info - lib/src/tools/error_lines.dart:7:14 - Missing documentation for a public member. Try adding documentation for the member. - public_member_api_docs
1 issue found.
''';
