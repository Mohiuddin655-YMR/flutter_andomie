import 'dart:math';
import 'dart:typed_data';

import '../extensions/int.dart';
import 'random_provider.dart';
import 'replacement.dart';

enum KeyFormats {
  hex("0123456789ABCDEF"),
  numbers("0123456789"),
  capitalChars("QWERTYUIOPASDFGHJKLZXCVBNM"),
  smallChars("qwertyuiopasdfghjklzxcvbn"),
  specialChars("!@%^&*()_+~`-={}|';:?.,<>"),
  alphabets(
    "QWERTYUIOPASDFGHJKLZXCVBNM"
    "qwertyuiopasdfghjklzxcvbn",
  ),
  alphabetsAndNumbers(
    "QWERTYUIOPASDFGHJKLZXCVBNM"
    "qwertyuiopasdfghjklzxcvbn"
    "0123456789",
  ),
  chars(
    "QWERTYUIOPASDFGHJKLZXCVBNM"
    "qwertyuiopasdfghjklzxcvbn"
    "!@%^&*()_+~`-={}|';:?.,<>",
  ),
  capitalCharsAndNumbers(
    "QWERTYUIOPASDFGHJKLZXCVBNM"
    "0123456789",
  ),
  smallCharsAndNumbers(
    "qwertyuiopasdfghjklzxcvbn"
    "0123456789",
  ),
  all(
    "QWERTYUIOPASDFGHJKLZXCVBNM"
    "qwertyuiopasdfghjklzxcvbn"
    "!@%^&*()_+~`-={}|';:?.,<>"
    "0123456789",
  );

  final String value;

  const KeyFormats(this.value);
}

class KeyGenerator {
  const KeyGenerator._();

  static String get uniqueKey => generateKey();

  /// Generates a unique image key based on the current date and time.
  ///
  /// Example:
  /// ```dart
  /// String imageKey = KeyGenerator.dateKey;
  /// print(imageKey); // Output: Current date and time formatted as 'yyyyMMddHHmmss'.
  /// ```
  static String get dateKey {
    final a = DateTime.now();
    return "${a.year.x4D}${a.month.x2D}${a.day.x2D}${a.hour.x2D}${a.minute.x2D}${a.second.x2D}";
  }

  static List<int> _bytes(KeyByteType type) {
    final secure = Random.secure();
    final bytes = Uint8List(type.value);
    for (var i = 0; i < bytes.length; i++) {
      bytes[i] = secure.nextInt(256);
    }
    return bytes;
  }

  /// Generates a key based on the provided name or the current timestamp.
  ///
  /// Parameters:
  /// - [name]: The name to generate a key from. If provided, the key is generated by converting the name to lowercase.
  /// - [timeMills]: The timestamp to generate a key from. If not provided, the current timestamp is used.
  /// - [extraKeySize]: The size of the extra key to append. Default is 5.
  ///
  /// Example:
  /// ```dart
  /// String key = KeyGenerator.generateKey(name: 'MyImage');
  /// print(key); // Output: 'myimage'
  ///
  /// String timestampKey = KeyGenerator.generateKey(timeMills: 1644613725000);
  /// print(timestampKey); // Output: '1644613725000xxxxx' (xxxxx is a random string of 5 characters)
  /// ```
  static String generateKey({
    String? name,
    int? timeMills,
    int extraKeySize = 5,
    KeyFormats format = KeyFormats.numbers,
  }) {
    if (name != null) {
      return Replacement.auto(name).toLowerCase();
    } else {
      final ms = timeMills ?? DateTime.timestamp().millisecondsSinceEpoch;
      final extra = RandomProvider.getString(
        data: format.value,
        max: extraKeySize,
      );
      final key = "$ms$extra";
      return key;
    }
  }

  static String haxKey(List<int> bytes) {
    var buffer = StringBuffer();
    var hexChars = "0123456789ABCDEF";
    for (var byte in bytes) {
      buffer.write(hexChars[(byte & 0xF0) >> 4]);
      buffer.write(hexChars[byte & 0x0F]);
    }
    return "$buffer";
  }

  static String secretKey(KeyByteType type) => haxKey(_bytes(type));
}

enum KeyByteType {
  x2(2),
  x4(4),
  x8(8),
  x16(16),
  x32(32),
  x64(64),
  x128(128);

  final int value;

  const KeyByteType(this.value);
}
