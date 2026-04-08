package auth

import (
	"errors"
	"fmt"

	"github.com/golang-jwt/jwt/v5"
)

// SupabaseClaims holds the claims embedded in a Supabase-issued JWT.
// The "sub" field is the Supabase user UUID and is always present.
// Email and Phone are populated depending on which auth method was used.
type SupabaseClaims struct {
	Sub   string `json:"sub"`
	Email string `json:"email,omitempty"`
	Phone string `json:"phone,omitempty"`
	jwt.RegisteredClaims
}

// VerifySupabaseToken validates a Supabase JWT using the project JWT secret
// (Settings → API → JWT Secret in the Supabase dashboard).
// Returns the parsed claims on success, or a typed error on failure.
func VerifySupabaseToken(tokenStr, secret string) (*SupabaseClaims, error) {
	if tokenStr == "" {
		return nil, errors.New("token is empty")
	}

	token, err := jwt.ParseWithClaims(tokenStr, &SupabaseClaims{}, func(t *jwt.Token) (interface{}, error) {
		if _, ok := t.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method: %v", t.Header["alg"])
		}
		return []byte(secret), nil
	})
	if err != nil {
		return nil, err
	}

	claims, ok := token.Claims.(*SupabaseClaims)
	if !ok || !token.Valid {
		return nil, errors.New("invalid token claims")
	}
	if claims.Sub == "" {
		return nil, errors.New("token missing sub claim")
	}

	return claims, nil
}
