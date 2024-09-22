import 'dart:math';

/**
 * Created by Abdullah on 22/9/24.
 */

class ChatUtils {
  static String getSecuredCallEmojis() {
    int length = 4;
    final List<String> emojis = [
      '🔒', '🔑', '🛡️', '💬', '📞', '✨', '🦄', '🌟', '🔮', '👾',
      // Add more emojis as needed
    ];

    final random = Random();
    final selectedEmojis = <String>{}; // Use a Set to avoid duplicates

    while (selectedEmojis.length < length) {
      final emoji = emojis[random.nextInt(emojis.length)];
      selectedEmojis.add(emoji);
    }

    return selectedEmojis.join(' '); // Join them into a single string
  }
}
