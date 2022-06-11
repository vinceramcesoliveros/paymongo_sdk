import 'package:equatable/equatable.dart';

class CreateLinkAttributes extends Equatable {
  final int amount;
  final String description;
  final String? remarks;
  const CreateLinkAttributes({
    required this.amount,
    required this.description,
    this.remarks,
  });

  CreateLinkAttributes copyWith({
    int? amount,
    String? description,
    String? remarks,
  }) {
    return CreateLinkAttributes(
      amount: amount ?? this.amount,
      description: description ?? this.description,
      remarks: remarks ?? this.remarks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'description': description,
      'remarks': remarks,
    };
  }

  @override
  List<Object?> get props => [amount, description, remarks];
}
