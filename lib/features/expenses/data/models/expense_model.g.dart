// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseModelAdapter extends TypeAdapter<ExpenseModel> {
  @override
  final int typeId = 1;

  @override
  ExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseModel(
      id: fields[0] as String,
      category: fields[1] as String,
      categoryIconCode: fields[2] as int,
      categoryColorValue: fields[3] as int,
      isManual: fields[4] as bool,
      isExpense: fields[5] as bool,
      amount: fields[6] as double,
      currency: fields[7] as String,
      convertedAmount: fields[8] as double,
      date: fields[9] as DateTime,
      receiptImagePath: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.categoryIconCode)
      ..writeByte(3)
      ..write(obj.categoryColorValue)
      ..writeByte(4)
      ..write(obj.isManual)
      ..writeByte(5)
      ..write(obj.isExpense)
      ..writeByte(6)
      ..write(obj.amount)
      ..writeByte(7)
      ..write(obj.currency)
      ..writeByte(8)
      ..write(obj.convertedAmount)
      ..writeByte(9)
      ..write(obj.date)
      ..writeByte(10)
      ..write(obj.receiptImagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
