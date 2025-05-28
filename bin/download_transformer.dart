import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart' as http;

const inputOptionName = 'input';
const outputOptionName = 'output';

Future<int> main(List<String> arguments) async {
  // The flutter tool will invoke this program with two arguments, one for
  // the `--input` option and one for the `--output` option.
  // `--input` is the original asset file that this program should transform.
  // `--output` is where flutter expects the transformation output to be written to.
  final parser =
      ArgParser()
        ..addOption(inputOptionName, mandatory: true, abbr: 'i')
        ..addOption(outputOptionName, mandatory: true, abbr: 'o');

  ArgResults argResults = parser.parse(arguments);
  final String inputFilePath = argResults[inputOptionName];
  final String outputFilePath = argResults[outputOptionName];

  try {
    final inputFile = File(inputFilePath);
    if (!inputFile.existsSync()) {
      stderr.writeln('Input file does not exist: $inputFilePath');
      return 1;
    }
    final lines = inputFile.readAsLinesSync();

    for (final line in lines) {
      final parts = line.split(RegExp(r'\s+|,'));
      if (parts.length != 1) {
        stderr.writeln('Expected format: <asset_link>');
        return 1;
      }

      final assetLink = parts[0];
      final response = await http.get(Uri.parse(assetLink));
      if (response.statusCode == 200) {
        final assetFile = File(outputFilePath);
        await assetFile.writeAsBytes(response.bodyBytes);
        print('Downloaded $assetLink to $outputFilePath\n');
      } else {
        stderr.writeln(
          'Failed to download $assetLink (HTTP ${response.statusCode})',
        );
        stderr.writeln('Reason: ${response.reasonPhrase}');
        return 1;
      }
    }
    return 0;
  } catch (e) {
    stderr.writeln(
      'Unexpected exception when downloading an image.\n'
      'Details: $e',
    );
    return 1;
  }
}
