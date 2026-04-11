// Package storage is a stub S3 client.
// TODO: replace with real AWS SDK (github.com/aws/aws-sdk-go-v2) once
// credentials and bucket are configured.
package storage

import (
	"context"
	"crypto/rand"
	"encoding/hex"
	"errors"
	"fmt"

	"go.uber.org/zap"
)

const MaxFileSize = 3 * 1024 * 1024 // 3 MB

// MaxBlogImageSize is the per-image limit for blog inline images.
const MaxBlogImageSize = 2 * 1024 * 1024 // 2 MB

var ErrFileTooLarge = errors.New("file exceeds size limit")

// AllowedFileTypes maps the logical file type to its human label.
var AllowedFileTypes = map[string]bool{
	"profile_photo":      true,
	"degree_certificate": true,
	"government_id":      true,
	"blog_image":         true,
}

// AllowedBlogImageContentTypes is the allow-list for blog image MIME types.
var AllowedBlogImageContentTypes = map[string]bool{
	"image/jpeg": true,
	"image/png":  true,
	"image/webp": true,
}

// Client is the storage abstraction.
type Client struct {
	log *zap.Logger
}

func New(log *zap.Logger) *Client {
	return &Client{log: log}
}

// Upload accepts raw file bytes, validates size, and returns a stub URL.
// In production this will put the object into an S3 bucket and return the
// pre-signed or public URL.
func (c *Client) Upload(_ context.Context, fileName, fileType string, data []byte) (string, error) {
	if !AllowedFileTypes[fileType] {
		return "", fmt.Errorf("unknown file type %q", fileType)
	}
	if len(data) == 0 {
		return "", errors.New("empty file")
	}
	if len(data) > MaxFileSize {
		return "", ErrFileTooLarge
	}

	b := make([]byte, 16)
	if _, err := rand.Read(b); err != nil {
		return "", fmt.Errorf("generate stub key: %w", err)
	}

	url := fmt.Sprintf(
		"https://stub-bucket.s3.ap-south-1.amazonaws.com/%s/%s-%s",
		fileType, hex.EncodeToString(b), fileName,
	)

	c.log.Debug("stub upload complete",
		zap.String("file_type", fileType),
		zap.String("file_name", fileName),
		zap.Int("bytes", len(data)),
		zap.String("url", url),
	)
	return url, nil
}
