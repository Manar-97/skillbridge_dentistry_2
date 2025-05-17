import 'dart:convert';

/// Parses a JWT token and returns its payload as a Map<String, dynamic>.
/// Throws an Exception if the token is invalid.
Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Invalid token');
  }

  final payload = base64Url.normalize(parts[1]);
  final payloadString = utf8.decode(base64Url.decode(payload));
  return json.decode(payloadString);
}
