/// Endpoint entity containing relevant network call details
class Endpoints {
  /// connection timeout duration
  static const Duration connectionTimeout = Duration(milliseconds: 150000);

  /// receive timeout duration
  static const Duration receiveTimeout = Duration(milliseconds: 150000);

  /// base url
  static const String baseUrl = 'https://reqres.in/';

  /// api endpoint to get users/customers
  static const String customers = '/api/users';
}
