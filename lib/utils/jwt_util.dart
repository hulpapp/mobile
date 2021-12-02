import 'package:jwt_decoder/jwt_decoder.dart';

main() {
  String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ2b2x1bnRlZXJfZGF0YSI6eyJpZCI6MiwibmFtZSI6ImpvYW8gdGVzdGUiLCJlbWFpbCI6ImpvYW8udGVzdGVAaG90bWFpbC5jb20iLCJ0ZWxlcGhvbmUiOiIoMzEpIDkzNTA1LTQ1NDUiLCJjcGYiOiIwMTMuNTExLjQ5Ni05NSIsImlkZW50aXR5IjoiMTUwNDA1MCIsImFkZHJlc3NfaWQiOjIsInVzZXJfaWQiOjIsImNyZWF0ZWRfYXQiOiIyMDIxLTExLTEzVDE5OjMxOjU4LjI0MFoiLCJ1cGRhdGVkX2F0IjoiMjAyMS0xMS0xM1QxOTozMTo1OC4yNDBaIn0sInJvbGVzIjpbXSwiZXhwIjoxNjM3MDEzOTM3fQ.jJouq5pSzVIjMzX_ltOIUG0iW2i4WOS9TwNrfxBfL30";

  /* decode() method will decode your token's payload */
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  // Now you can use your decoded token
  print(decodedToken['user_id']);
}