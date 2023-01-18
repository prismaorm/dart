import 'dart:convert';

/// Prisma Typed parameter
class PrismaTypedParameter {
  /// The parameter type.
  final String type;

  /// The parameter value.
  final String value;

  /// Create a new instance of [PrismaTypedParameter].
  const PrismaTypedParameter(this.type, this.value);

  /// Create a new instance of [PrismaTypedParameter] from a JSON map.
  factory PrismaTypedParameter.fromJson(Map<String, dynamic> json) {
    return PrismaTypedParameter(
      json['prisma__type'] as String,
      json['prisma__value'] as String,
    );
  }

  /// Create from a [BigInt].
  factory PrismaTypedParameter.fromBigInt(BigInt value) {
    return PrismaTypedParameter('bigint', value.toString());
  }

  /// Create from a [DateTime].
  factory PrismaTypedParameter.fromDateTime(DateTime value) {
    return PrismaTypedParameter('date', value.toIso8601String());
  }

  /// Create from a [double].
  factory PrismaTypedParameter.fromDouble(double value) {
    return PrismaTypedParameter('decimal', value.toString());
  }

  /// Convert the parameter to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'prisma__type': type,
      'prisma__value': value,
    };
  }
}

final demo = Utf8Codec;

/// Prisma RAW parameter codec.
class PrismaRawParameterCodec extends Codec<Object?, Object?> {
  /// Create a new instance of [PrismaRawParameterCodec].
  const PrismaRawParameterCodec();

  @override
  Converter<Object?, Object?> get decoder => const PrismaRawParameterDecoder();

  @override
  Converter<Object?, Object?> get encoder => const PrismaRawParameterEncoder();
}

/// Prisma RAW encoder converter.
class PrismaRawParameterEncoder extends Converter<Object?, Object?> {
  /// Create a new instance of [PrismaRawParameterEncoder].
  const PrismaRawParameterEncoder();

  @override
  Object? convert(Object? input) {
    if (input is BigInt) {
      return PrismaTypedParameter.fromBigInt(input);
    } else if (input is DateTime) {
      return PrismaTypedParameter.fromDateTime(input);
    } else if (input is double) {
      return PrismaTypedParameter.fromDouble(input);
    }

    return input;
  }
}

/// Prisma RAW parameter decoder.
class PrismaRawParameterDecoder extends Converter<Object?, Object?> {
  /// Create a new instance of [PrismaRawParameterDecoder].
  const PrismaRawParameterDecoder();

  @override
  Object? convert(Object? input) {
    // TODO: implement convert

    return input;
  }
}

dynamic deserializeRawResult(dynamic result) {
  if (result is Map) {
    return (_decodeParameter(result) as Map).map((key, value) => MapEntry(
          key,
          deserializeRawResult(value),
        ));
  } else if (result is Iterable) {
    return result.map((e) => deserializeRawResult(e));
  }

  return result;
}

/// Decode a JSON compatible value to a parameter.
dynamic _decodeParameter(dynamic parameter) {
  if (parameter is Map) {
    if (parameter.containsKey("prisma__type")) {
      final type = parameter["prisma__type"];
      final value = parameter["prisma__value"];

      if (type == "bigint") {
        return BigInt.parse(value);
      } else if (type == "date" || type == "datetime") {
        return DateTime.parse(value);
      } else if (type == "decimal") {
        return double.parse(value);
      } else if (type == 'int') {
        return int.parse(value);
      }

      return value;
    }
  }

  return parameter;
}
