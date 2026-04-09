package service

import "errors"

var (
	// Generic
	ErrUnexpected            = errors.New("unexpected error")
	ErrNoData                = errors.New("no data found")
	ErrBadInput              = errors.New("invalid data found")
	ErrImportantFieldMissing = errors.New("important data field missing")
	ErrDuplicateData         = errors.New("duplicate data")
	ErrTimeout               = errors.New("timeout error")
	ErrOriginError           = errors.New("error from origin")
	ErrStreamError           = errors.New("error in data stream")

	// Database-related
	ErrDBConnection     = errors.New("error connecting to database")
	ErrDBQuery          = errors.New("error executing database query")
	ErrDBTransaction    = errors.New("error during database transaction")
	ErrDBRecordNotFound = errors.New("record not found in database")

	// Redis / Cache-related
	ErrRedisConnection = errors.New("error connecting to redis")
	ErrRedisGet        = errors.New("error getting value from redis")
	ErrRedisSet        = errors.New("error setting value in redis")
	ErrRedisDelete     = errors.New("error deleting key from redis")

	// Auth / Security
	ErrUnauthorized     = errors.New("unauthorized access")
	ErrForbidden        = errors.New("forbidden access")
	ErrInvalidToken     = errors.New("invalid token")
	ErrTokenExpired     = errors.New("token expired")
	ErrPermissionDenied = errors.New("permission denied")

	// Validation / Input
	ErrValidationFailed = errors.New("validation failed")
	ErrInvalidFormat    = errors.New("invalid input format")
	ErrMissingField     = errors.New("missing required field")

	// External Services
	ErrExternalAPI    = errors.New("error from external API")
	ErrServiceTimeout = errors.New("external service timed out")
	ErrBadGateway     = errors.New("bad gateway or upstream error")

	// File / IO
	ErrFileNotFound  = errors.New("file not found")
	ErrFileRead      = errors.New("error reading file")
	ErrFileWrite     = errors.New("error writing file")
	ErrFileTooLarge  = errors.New("file exceeds 3 MB limit")
	ErrFileTypeInvalid = errors.New("unsupported file type")

	// Rate limiting / Throttling
	ErrRateLimitExceeded = errors.New("rate limit exceeded")
	ErrInvalidOtp=errors.New("invalid OTP")
	ErrOtpExpired=errors.New("OTP expired")
)
