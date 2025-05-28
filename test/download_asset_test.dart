import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:test/test.dart';
import '../bin/download_transformer.dart' as dt;

void main() {
  test(
    'Asset download check via direct main call with output directory, hash verification, and no exception thrown',
    () async {
      final inFile = 'test/sample_input.png';
      final outFile = 'test/sample_output.png';

      await expectLater(
        dt.main(['--input', inFile, '--output', outFile]),
        completes,
      );

      final downloadedAsset = File(outFile);
      final exists = await downloadedAsset.exists();
      expect(
        exists,
        isTrue,
        reason:
            'Asset texture_atlas.png should have been downloaded in the output directory.',
      );

      final bytes = await downloadedAsset.readAsBytes();
      final hash = sha256.convert(bytes).toString();
      const expectedHash =
          'a5e2b7d9ddde8e864b77e13a9303308c9da29479200bdeade06f9b666a3e1026';
      expect(
        hash,
        equals(expectedHash),
        reason: 'Downloaded asset file hash should match the expected hash.',
      );

      await downloadedAsset.delete();
    },
  );
}
