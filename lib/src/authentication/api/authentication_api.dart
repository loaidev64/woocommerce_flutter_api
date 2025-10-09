import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'authentication_endpoints.dart';

/// Extension providing authentication-related API methods for WooCommerce.
///
/// This extension adds methods for user authentication, registration,
/// password management, and session handling.
extension WooAuthenticationApi on WooCommerce {
  /// Authenticates a user with email and password.
  ///
  /// Upon successful login, the user ID is securely stored in local storage
  /// and can be retrieved using [LocalStorageHelper.getSecurityUserId()].
  ///
  /// ## Parameters
  ///
  /// - [email]: The user's email address.
  /// - [password]: The user's password.
  ///
  /// ## Throws
  ///
  /// Throws an exception if authentication fails or if the API request fails.
  ///
  /// ## Example
  ///
  /// ```dart
  /// try {
  ///   await woocommerce.login('user@example.com', 'password123');
  ///   print('Login successful');
  /// } catch (e) {
  ///   print('Login failed: $e');
  /// }
  /// ```
  Future<void> login(String email, String password) async {
    if (useFaker) {
      return;
    }

    final response = await dio.post(_AuthenticationEndpoints.login, data: {
      'email': email,
      'password': password,
    });

    final userId = (response.data as Map<String, dynamic>)['user_id'] as int;
    await LocalStorageHelper.updateSecurityUserId(userId);
  }

  /// Registers a new customer account.
  ///
  /// Upon successful registration, the user ID is securely stored in local storage
  /// and can be retrieved using [LocalStorageHelper.getSecurityUserId()].
  ///
  /// ## Parameters
  ///
  /// - [customer]: The customer object containing registration details.
  ///
  /// ## Throws
  ///
  /// Throws an exception if registration fails or if the API request fails.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final newCustomer = WooCustomer(
  ///   email: 'newuser@example.com',
  ///   firstName: 'John',
  ///   lastName: 'Doe',
  /// );
  ///
  /// try {
  ///   await woocommerce.register(newCustomer);
  ///   print('Registration successful');
  /// } catch (e) {
  ///   print('Registration failed: $e');
  /// }
  /// ```
  Future<void> register(WooCustomer customer) async {
    if (useFaker) {
      return;
    }
    final response = await dio.post(
      _AuthenticationEndpoints.register,
      data: customer.toJson(),
    );

    final userId = (response.data as Map<String, dynamic>)['user_id'] as int;
    await LocalStorageHelper.updateSecurityUserId(userId);
  }

  /// Changes the password for the currently logged-in user.
  ///
  /// ## Parameters
  ///
  /// - [password]: The new password for the user.
  ///
  /// ## Throws
  ///
  /// Throws an exception if the password change fails or if the API request fails.
  ///
  /// ## Example
  ///
  /// ```dart
  /// try {
  ///   await woocommerce.changePassword('newPassword123');
  ///   print('Password changed successfully');
  /// } catch (e) {
  ///   print('Password change failed: $e');
  /// }
  /// ```
  Future<void> changePassword(String password) async {
    if (useFaker) {
      return;
    }
    final response = await dio.post(
      _AuthenticationEndpoints.changePassword,
      data: {
        'user_id': await LocalStorageHelper.getSecurityUserId(),
        'password': password,
      },
    );

    return (response.data as Map<String, dynamic>)['status'];
  }

  /// Initiates a password reset process for the given email address.
  ///
  /// This method sends a password reset request and returns a user ID and reset code
  /// that can be used to complete the password reset process.
  ///
  /// ## Parameters
  ///
  /// - [email]: The email address of the user requesting password reset.
  ///
  /// ## Returns
  ///
  /// A [Future] that completes with a record containing:
  /// - [userId]: The ID of the user requesting password reset.
  /// - [code]: The reset code for completing the password reset.
  ///
  /// ## Throws
  ///
  /// Throws an exception if the password reset request fails or if the API request fails.
  ///
  /// ## Example
  ///
  /// ```dart
  /// try {
  ///   final result = await woocommerce.forgotPassword('user@example.com');
  ///   print('Reset code: ${result.code} for user: ${result.userId}');
  /// } catch (e) {
  ///   print('Password reset request failed: $e');
  /// }
  /// ```
  Future<({int userId, String code})> forgotPassword(String email) async {
    if (useFaker) {
      return (userId: FakeHelper.integer(), code: FakeHelper.code());
    }
    final response = await dio.post(
      _AuthenticationEndpoints.forgotPassword,
      data: {
        'email': email,
      },
    );

    final data = (response.data as Map<String, dynamic>);
    final userId = int.parse(data['user_id']);
    final code = data['code'] as String;

    return (userId: userId, code: code);
  }

  /// Logs out the currently logged-in user.
  ///
  /// This method clears the stored user ID from local storage,
  /// effectively ending the user's session.
  ///
  /// ## Example
  ///
  /// ```dart
  /// await woocommerce.logout();
  /// print('User logged out successfully');
  /// ```
  Future<void> logout() async {
    await LocalStorageHelper.deleteSecurityUserId();
  }
}
