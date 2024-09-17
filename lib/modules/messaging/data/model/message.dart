import 'package:shield/modules/messaging/enums/message_type.dart';

/**
 * Created by Abdullah on 1/9/24.
 */

class Message {
  String? message;
  String? senderId;
  bool? isOwn;
  MessageType? messageType;
  String? sent;
  String? read;

  Message({
    this.message,
    this.senderId,
    this.isOwn,
    this.messageType,
    this.sent,
    this.read,
  });
}
