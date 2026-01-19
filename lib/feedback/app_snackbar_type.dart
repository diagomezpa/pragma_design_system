/// Defines the types of feedback that can be shown through AppSnackbar.
/// 
/// This enum provides semantic meaning for different types of user feedback,
/// ensuring consistent visual treatment and appropriate color schemes across
/// the application.
/// 
/// Types:
/// - [success]: Positive feedback for successful operations
/// - [error]: Critical feedback for errors or failures  
/// - [info]: Neutral informational messages
enum AppSnackbarType {
  /// Positive feedback for successful operations (e.g., "Data saved successfully")
  /// Uses success colors from the theme's color scheme
  success,
  
  /// Critical feedback for errors or failures (e.g., "Network connection failed")
  /// Uses error colors from the theme's color scheme
  error,
  
  /// Neutral informational messages (e.g., "Loading in progress")
  /// Uses neutral colors from the theme's color scheme
  info,
}
