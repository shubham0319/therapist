package handler

import (
	"errors"
	"therapist/pkg/service"

	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func grpcError(err error) error {
	switch {
	case errors.Is(err, service.ErrBadInput),
		errors.Is(err, service.ErrImportantFieldMissing),
		errors.Is(err, service.ErrInvalidFormat),
		errors.Is(err, service.ErrMissingField),
		errors.Is(err, service.ErrValidationFailed):
		return status.Error(codes.InvalidArgument, "invalid or missing arguments")

	case errors.Is(err, service.ErrNoData),
		errors.Is(err, service.ErrDBRecordNotFound),
		errors.Is(err, service.ErrFileNotFound):
		return status.Error(codes.NotFound, "resource not found")

	case errors.Is(err, service.ErrDuplicateData):
		return status.Error(codes.AlreadyExists, "resource already exists")

	case errors.Is(err, service.ErrUnauthorized):
		return status.Error(codes.Unauthenticated, "unauthorized access")

	case errors.Is(err, service.ErrForbidden),
		errors.Is(err, service.ErrPermissionDenied):
		return status.Error(codes.PermissionDenied, "access forbidden or permission denied")

	case errors.Is(err, service.ErrTokenExpired),
		errors.Is(err, service.ErrInvalidToken):
		return status.Error(codes.Unauthenticated, "invalid or expired token")

	case errors.Is(err, service.ErrDBConnection),
		errors.Is(err, service.ErrDBQuery),
		errors.Is(err, service.ErrDBTransaction),
		errors.Is(err, service.ErrRedisConnection),
		errors.Is(err, service.ErrRedisGet),
		errors.Is(err, service.ErrRedisSet),
		errors.Is(err, service.ErrRedisDelete),
		errors.Is(err, service.ErrFileRead),
		errors.Is(err, service.ErrFileWrite):
		return status.Error(codes.Internal, "internal server error")

	case errors.Is(err, service.ErrExternalAPI),
		errors.Is(err, service.ErrBadGateway):
		return status.Error(codes.Unavailable, "external service error")

	case errors.Is(err, service.ErrServiceTimeout),
		errors.Is(err, service.ErrTimeout):
		return status.Error(codes.DeadlineExceeded, "operation timed out")

	case errors.Is(err, service.ErrRateLimitExceeded):
		return status.Error(codes.ResourceExhausted, "rate limit exceeded")

	case errors.Is(err, service.ErrStreamError):
		return status.Error(codes.Internal, "error in data stream")

	case errors.Is(err, service.ErrUnexpected),
		errors.Is(err, service.ErrOriginError):
		return status.Error(codes.Unknown, "unexpected internal error")
	}

	// default fallback
	return status.Error(codes.Unknown, err.Error())
}
