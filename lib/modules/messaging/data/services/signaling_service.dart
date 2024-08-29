/**
 * Created by Abdullah on 29/8/24.
 */
import 'package:supabase_flutter/supabase_flutter.dart';

class SignalingService {
  final _supabase = Supabase.instance.client;

  Future<void> sendSignal(String senderId, String receiverId,
      Map<String, dynamic> signalData) async {
    await _supabase.from('signaling').insert({
      'sender_id': senderId,
      'receiver_id': receiverId,
      'signal_data': signalData,
    });
  }

  Stream<List<Map<String, dynamic>>> onSignalReceived(String receiverId) {
    return _supabase
        .from('signaling')
        .stream(primaryKey: ['id'])
        .eq('receiver_id', receiverId)
        .map((maps) {
          return maps
              .map((map) => map['signal_data'] as Map<String, dynamic>)
              .toList();
        });
  }
}
