enum AuthProviderEnum {
  google('google'),
  email('email');

  const AuthProviderEnum(this.value);
  final String value;
}
