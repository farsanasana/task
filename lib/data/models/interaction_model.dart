class InteractionModel {
  final String clientId;
  final String type; // Call, Message, Meeting
  final String notes;
  final String reply;
  final DateTime followUp;

  InteractionModel({
    required this.clientId,
    required this.type,
    required this.notes,
    required this.reply,
    required this.followUp,
  });
}
