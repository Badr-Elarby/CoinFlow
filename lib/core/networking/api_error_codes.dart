/// HTTP and custom error codes used throughout the application
enum ApiErrorCode {
  // ========== Network Errors ==========

  /// Request was cancelled by the user or system
  requestCancelled(499, 'Request was cancelled'),

  /// Request timeout - server didn't respond in time
  timeout(408, 'Request timeout'),

  /// SSL/TLS certificate verification failed
  badCertificate(495, 'SSL certificate error'),

  /// Connection to server failed
  connectionError(503, 'Connection failed'),

  // ========== HTTP Standard Errors ==========

  /// Bad request - invalid request format
  badRequest(400, 'Invalid request'),

  /// Unauthorized - authentication failed
  unauthorized(401, 'Unauthorized - invalid credentials'),

  /// Forbidden - access denied
  forbidden(403, 'Access forbidden'),

  /// Too many requests - rate limit exceeded
  rateLimitExceeded(429, 'Too many requests - rate limit reached'),

  /// Internal server error
  serverError(500, 'Internal server error'),

  /// Service is temporarily unavailable
  serviceUnavailable(503, 'Service unavailable'),

  // ========== CoinGecko Specific Errors ==========

  /// Cloudflare access denied
  cloudflareBlocked(1020, 'Access denied by firewall'),

  /// Missing API key
  missingApiKey(10002, 'API Key is missing'),

  /// No access to endpoint (Pro subscription required)
  noAccessToEndpoint(10005, 'Pro subscription required for this endpoint'),

  /// Invalid Pro API key
  invalidApiKeyPro(10010, 'Invalid Pro API key or wrong base URL'),

  /// Invalid Demo API key
  invalidApiKeyDemo(10011, 'Invalid Demo API key or wrong base URL');

  const ApiErrorCode(this.code, this.description);

  /// The numeric HTTP status code
  final int code;

  /// A brief description of the error
  final String description;

  /// Check if this is a client error (4xx)
  bool get isClientError => code >= 400 && code < 500;

  /// Check if this is a server error (5xx)
  bool get isServerError => code >= 500 && code < 600;
}

const Map<int, String> errorMessages = {
  // CoinGecko API specific errors
  10002: "API Key is missing. Please add your CoinGecko API key.",
  10005: "This endpoint requires a Pro API subscription.",
  10010: "Invalid Pro API key. Make sure you're using pro-api.coingecko.com",
  10011: "Invalid Demo API key. Make sure you're using api.coingecko.com",
  1020: "Access denied by Cloudflare firewall.",

  // Common HTTP status codes
  400: "Bad request. Please check your input.",
  401: "Unauthorized. Please check your API key credentials.",
  403: "Access forbidden. Your request may be blocked by the server.",
  404: "Resource not found.",
  429: "Rate limit exceeded. Please slow down your requests.",
  500: "Server error occurred. Please try again later.",
};
