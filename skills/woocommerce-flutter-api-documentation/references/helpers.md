# helpers

## fake_helper

### abstract class FakeHelper

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static int integer({int? min, int? max})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String code()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String word()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String sentence()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String url()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String image()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static DateTime datetime()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static bool boolean()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static double decimal()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static List<int> listOfIntegers()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String firstName()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String lastName()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String email()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String address()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String city()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String country()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String countryCode()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String state()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String company()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String phoneNumber()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String zipCode()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String currencyCode()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## helpers

## local_storage_helper

### abstract class LocalStorageHelper

Helper class for managing secure local storage of user data.

This class provides methods to securely store and retrieve user IDs
using Flutter's secure storage mechanism.

### static Future<void> updateSecurityUserId(int? userId) async

Stores the user ID securely in local storage.

[userId] The user ID to store. Pass null to clear the stored ID.

### static Future<void> deleteSecurityUserId() async

Deletes the stored user ID from secure storage.

### static Future<int?> getSecurityUserId() async

Retrieves the stored user ID from secure storage.

Returns the user ID if found, null otherwise.

