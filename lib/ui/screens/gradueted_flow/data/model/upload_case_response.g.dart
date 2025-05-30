// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_case_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UploadCaseResponseAdapter extends TypeAdapter<UploadCaseResponse> {
  @override
  final int typeId = 1;

  @override
  UploadCaseResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UploadCaseResponse(
      message: fields[0] as String,
      caseRequestId: fields[1] as int,
      prediction: fields[2] as String,
      confidence: fields[3] as double,
      treatment: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UploadCaseResponse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.caseRequestId)
      ..writeByte(2)
      ..write(obj.prediction)
      ..writeByte(3)
      ..write(obj.confidence)
      ..writeByte(4)
      ..write(obj.treatment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UploadCaseResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
