/**
 * Created by Abdullah on 21/8/24.
 */



abstract class RoutePath{
  static const String start = _RoutePath._start;
  static const String signUp = _RoutePath._signUp;
  static const String login = _RoutePath._login;
  static const String dashboard = _RoutePath._dashboard;
  static const String chatUserList = _RoutePath._chatUserList;
  static const String chat = _RoutePath._chat;
}


class _RoutePath{
  static const String _start = '/start';
  static const String _signUp = '/signUp';
  static const String _login = '/login';
  static const String _dashboard = '/dashboard';
  static const String _chatUserList = '/chatUserList';
  static const String _chat = '/chat';
}