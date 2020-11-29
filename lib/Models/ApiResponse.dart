class ApiResponse {
  final int code;
  final String msg;
  final Object object;

  ApiResponse({this.code = -1, this.msg = 'NetWork Error !', this.object});
}
