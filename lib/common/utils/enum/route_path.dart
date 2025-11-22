enum RoutePaths {
  splash('/'),
  login('/login'),
  signUp('/signUp'),
  Audio('/audio'),
  audioHistory('/AudioHistory'),
  Document('/document'),
  documentHistory('/documentHistory'),
  Image('/Image'),
  imageHistory('/imageHistory'),
  Profile('/Profile');

  const RoutePaths(this.path);
  final String path;
}
