// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForecastModelAdapter extends TypeAdapter<ForecastModel> {
  @override
  final int typeId = 0;

  @override
  ForecastModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForecastModel(
      crypto: fields[0] as String,
      forecast: fields[1] as Forecast,
      assumptions: fields[2] as String,
      tips: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ForecastModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.crypto)
      ..writeByte(1)
      ..write(obj.forecast)
      ..writeByte(2)
      ..write(obj.assumptions)
      ..writeByte(3)
      ..write(obj.tips);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ForecastAdapter extends TypeAdapter<Forecast> {
  @override
  final int typeId = 1;

  @override
  Forecast read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Forecast(
      shortTerm: fields[0] as String,
      mediumTerm: fields[1] as String,
      longTerm: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Forecast obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.shortTerm)
      ..writeByte(1)
      ..write(obj.mediumTerm)
      ..writeByte(2)
      ..write(obj.longTerm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
