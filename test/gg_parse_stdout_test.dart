// @license
// Copyright (c) 2019 - 2024 Dr. Gabriel xyz. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'package:gg_parse_stdout/gg_parse_stdout.dart';
import 'package:test/test.dart';

void main() {
  group('errorLines(message)', () {
    group('should return', () {
      group('an empty array', () {
        test('when message is null', () {
          final result = parseDartFilePathes(null);
          expect(result, isEmpty);
        });
      });

      group('a list of vscode compatible error lines,', () {
        test('for dart analyze output', () {
          final result = parseDartFilePathes(dartAnalyzeOutput);
          expect(result, ['lib/src/tools/error_lines.dart:7:14']);
        });

        test('for dart format output', () {
          final result = parseDartFilePathes(dartFormatOutput);
          expect(result, ['sub/test1.dart', 'test.dart']);
        });

        test('for dart test output', () {
          final result = parseDartFilePathes(dartTestOutput);
          expect(result[0], 'test/bin/gg_parse_stdout_test.dart');
          expect(result[1], 'test/bin/gg_parse_stdout_test.dart');
          expect(result[2], 'test/bin/gg_parse_stdout_test.dart:14:8');
          expect(result[3], 'bin/gg_parse_stdout.dart');
          expect(result[4], '/bin/gg_parse_stdout.dart');
          expect(result[5], 'test/bin/gg_parse_stdout_test.dart:49:15');
          expect(result[6], 'test/bin/gg_parse_stdout_test.dart');
          expect(result[7], 'test/bin/gg_parse_stdout_test.dart');
          expect(result[8], 'test/gg_parse_stdout_test.dart');
          expect(result[9], 'test/gg_parse_stdout_test.dart:24:11');
          expect(result[10], 'test/gg_parse_stdout_test.dart');
          expect(result[11], 'test/vscode/launch_json_test.dart');
          expect(result[12], 'test/vscode/launch_json_test.dart:64:11');
          expect(result[13], 'test/vscode/launch_json_test.dart');
        });
      });
    });
  });
}

// .............................................................................
const dartAnalyzeOutput = '''
Analyzing gg_check...

   info - lib/src/tools/error_lines.dart:7:14 - Missing documentation for a public member. Try adding documentation for the member. - public_member_api_docs

1 issue found.
''';

// .............................................................................
const dartFormatOutput = '''
Formatted sub/test1.dart
Formatted test.dart
Formatted 2 files (2 changed) in 0.06 seconds.
''';

// .............................................................................
const dartTestOutput = '''
00:00 +0 -1: loading test/bin/gg_parse_stdout_test.dart [E]
  Failed to load "test/bin/gg_parse_stdout_test.dart":
  test/bin/gg_parse_stdout_test.dart:14:8: Error: Error when reading 'bin/gg_parse_stdout.dart': No such file or directory
  import '../../bin/gg_parse_stdout.dart';
         ^
  test/bin/gg_parse_stdout_test.dart:49:15: Error: Method not found: 'run'.
          await run(args: ['my-command', '--input', '5'], log: messages.add);
                ^^^

To run this test again: /Users/xyz/dev/flutter/bin/cache/dart-sdk/bin/dart test test/bin/gg_parse_stdout_test.dart -p vm --plain-name 'loading test/bin/gg_parse_stdout_test.dart'
00:00 +1 -3: test/gg_parse_stdout_test.dart: errorLines(message) should return a list of vscode compatible error lines, for dart analyze output [E]
  Expected: <false>
    Actual: <true>

  package:matcher                       expect
  test/gg_parse_stdout_test.dart 24:11  main.<fn>.<fn>.<fn>.<fn>


To run this test again: /Users/xyz/dev/flutter/bin/cache/dart-sdk/bin/dart test test/gg_parse_stdout_test.dart -p vm --plain-name 'errorLines(message) should return a list of vscode compatible error lines, for dart analyze output'
00:00 +2 -3: test/vscode/launch_json_test.dart: .vscode/launch.json pathes in launch.json [E]
  Expected: true
    Actual: <false>

  package:matcher                          expect
  test/vscode/launch_json_test.dart 64:11  main.<fn>.<fn>


To run this test again: /Users/xyz/dev/flutter/bin/cache/dart-sdk/bin/dart test test/vscode/launch_json_test.dart -p vm --plain-name '.vscode/launch.json pathes in launch.json'
00:00 +2 -3: Some tests failed.
''';
