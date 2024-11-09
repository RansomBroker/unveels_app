import 'package:flutter/material.dart';
import 'utils.dart';
import 'package:mime/mime.dart';

extension ListEX<T> on List<T> {
  List<T> replace(T old, T newItem, [int? forceIndex]) {
    int index = indexOf(old);
    if (forceIndex != null) {
      this
        ..removeAt(index)
        ..insert(forceIndex, newItem);
    } else if (index != -1) {
      this
        ..removeAt(index)
        ..insert(index, newItem);
    } else {
      this
        ..removeAt(index)
        ..insert(0, newItem);
    }
    return this;
  }

  List<T> replaceWhere(bool Function(T element) where, T newItem) {
    for (int i = 0; i < length; i++) {
      if (where(this[i])) {
        this
          ..removeAt(i)
          ..insert(i, newItem);
      }
    }
    return this;
  }

  /// T? get firstOrNull {
  ///   if (isEmpty) return null;
  ///   return first;
  /// }

  /// T? get lastOrNull {
  ///   if (isEmpty) return null;
  ///   return last;
  /// }

  List<T> replaceFirst(bool Function(T element) where, T newItem) {
    for (int i = 0; i < length; i++) {
      if (where(this[i])) {
        this
          ..removeAt(i)
          ..insert(i, newItem);
        break;
      }
    }
    return this;
  }



  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension EXSized on num {
  Widget get h => SizedBox(height: toDouble());
  Widget get w => SizedBox(width: toDouble());
}

extension EXTextStyle on TextStyle {
  /// Returns a TextStyle with  Scaled [fontSize]
  /// Scale between 0.0 and 2.0
  TextStyle S(double s) {
    final scale = (fontSize ?? 10) * s;
    return copyWith(fontSize: scale > 8 ? scale : 8);
  }

  /// Make a TextStyle [Bold]

  TextStyle get B => copyWith(fontWeight: FontWeight.bold);
}

extension Nullable on Object? {
  bool get isNull => this == null;
}

extension StringEX on String {
  String get capitalized => StringEx.capitalize(this);
  bool get isImage => StringEx.isImage(this);
}

extension DurationX on Duration {
  String get toStrTime {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(inMinutes.remainder(60))}:${twoDigits(inSeconds.remainder(60))}";
  }
}

class StringEx {
  static String capitalize(String value) {
    if (isNull(value)) return '';
    if (isBlank(value)!) return value;
    return value.split(' ').map(capitalizeFirst).join(' ');
  }

  static String? capitalizeFirst(String s) {
    if (isNull(s)) return null;
    if (isBlank(s)!) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  static bool isImage(String path) {
    final mimeType = lookupMimeType(path);
    return mimeType?.startsWith('image/') ?? false;
  }

  static bool isNull(dynamic value) => value == null;
  static bool? isBlank(dynamic value) => _isEmpty(value);

  static bool? _isEmpty(dynamic value) {
    if (value is String) {
      return value.toString().trim().isEmpty;
    }
    if (value is Iterable || value is Map) {
      return value.isEmpty as bool?;
    }
    return false;
  }
}

executionTimeCalculator(Future Function() fun) async {
  final stopwatch = Stopwatch()..start();
  await fun.call();
  debugPrint(
    '************* Execution Time Calculator ****************\n'
    'Function ${fun.toString()}  executed in  >>>>   ${stopwatch.elapsed}\n'
    '************* Execution Time Calculator ****************',
  );
  stopwatch.stop();
}









//
//
// extension GetStringUtils on String {
//   bool get isNum => AppUtils.isNum(this);
//
//   bool get isNumericOnly => AppUtils.isNumericOnly(this);
//
//   bool get isAlphabetOnly => AppUtils.isAlphabetOnly(this);
//
//   bool get isBool => AppUtils.isBool(this);
//
//   bool get isVectorFileName => AppUtils.isVector(this);
//
//   bool get isImageFileName => AppUtils.isImage(this);
//
//   bool get isAudioFileName => AppUtils.isAudio(this);
//
//   bool get isVideoFileName => AppUtils.isVideo(this);
//
//   bool get isTxtFileName => AppUtils.isTxt(this);
//
//   bool get isDocumentFileName => AppUtils.isWord(this);
//
//   bool get isExcelFileName => AppUtils.isExcel(this);
//
//   bool get isPPTFileName => AppUtils.isPPT(this);
//
//   bool get isAPKFileName => AppUtils.isAPK(this);
//
//   bool get isPDFFileName => AppUtils.isPDF(this);
//
//   bool get isHTMLFileName => AppUtils.isHTML(this);
//
//   bool get isURL => AppUtils.isURL(this);
//
//   bool get isEmail => AppUtils.isEmail(this);
//
//   bool get isPhoneNumber => AppUtils.isPhoneNumber(this);
//
//   bool get isDateTime => AppUtils.isDateTime(this);
//
//   bool get isMD5 => AppUtils.isMD5(this);
//
//   bool get isSHA1 => AppUtils.isSHA1(this);
//
//   bool get isSHA256 => AppUtils.isSHA256(this);
//
//   bool get isBinary => AppUtils.isBinary(this);
//
//   bool get isIPv4 => AppUtils.isIPv4(this);
//
//   bool get isIPv6 => AppUtils.isIPv6(this);
//
//   bool get isHexadecimal => AppUtils.isHexadecimal(this);
//
//   bool get isPalindrom => AppUtils.isPalindrom(this);
//
//   bool get isPassport => AppUtils.isPassport(this);
//
//   bool get isCurrency => AppUtils.isCurrency(this);
//
//   bool get isCpf => AppUtils.isCpf(this);
//
//   bool get isCnpj => AppUtils.isCnpj(this);
//
//   bool isCaseInsensitiveContains(String b) => AppUtils.isCaseInsensitiveContains(this, b);
//
//   bool isCaseInsensitiveContainsAny(String b) => AppUtils.isCaseInsensitiveContainsAny(this, b);
//
//   String? get capitalize => AppUtils.capitalize(this);
//
//   String? get capitalizeFirst => AppUtils.capitalizeFirst(this);
//
//   String get removeAllWhitespace => AppUtils.removeAllWhitespace(this);
//
//   String? get camelCase => AppUtils.camelCase(this);
//
//   String? get paramCase => AppUtils.paramCase(this);
//
//   String numericOnly({bool firstWordOnly = false}) => AppUtils.numericOnly(this, firstWordOnly: firstWordOnly);
//
//   String createPath([Iterable? segments]) {
//     final path = startsWith('/') ? this : '/$this';
//     return AppUtils.createPath(path, segments);
//   }
// }
