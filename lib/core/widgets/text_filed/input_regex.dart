/**
 * Created by Abdullah on 22/8/24.
 */
enum InputRegex {
  NONE(r'', ""),
  EMAIL(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$',
      "Invalid Email"),
  NOT_EMPTY(r'.{1}$', "Field Cannot Be Empty"),
  ;

  final String pattern, message;

  const InputRegex(this.pattern, this.message);
}
