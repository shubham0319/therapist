package handler

import (
	"context"
	"therapist/pkg/logger"
	"therapist/pkg/proto/therapistpb"
	"therapist/pkg/service"

	"go.uber.org/zap"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

// Blog RPC handlers — all implemented on TherapistHandler.

func (h *TherapistHandler) CreateBlog(ctx context.Context, req *therapistpb.CreateBlogRequest) (*therapistpb.CreateBlogResponse, error) {
	log := logger.Named("handler.blog")
	log.Debug("CreateBlog called", zap.String("therapist_id", req.TherapistId))

	if req.TherapistId == "" {
		return nil, status.Error(codes.InvalidArgument, "therapist_id is required")
	}
	if req.Title == "" {
		return nil, status.Error(codes.InvalidArgument, "title is required")
	}

	blog, err := h.svc.CreateBlog(ctx, req.TherapistId, req.Title, req.Content, req.CoverImageUrl, req.ImageUrls)
	if err != nil {
		log.Error("CreateBlog failed", zap.Error(err))
		return nil, grpcError(err)
	}

	log.Info("CreateBlog succeeded", zap.String("blog_id", blog.ID))
	return &therapistpb.CreateBlogResponse{Blog: toBlogProto(blog)}, nil
}

func (h *TherapistHandler) UpdateBlog(ctx context.Context, req *therapistpb.UpdateBlogRequest) (*therapistpb.UpdateBlogResponse, error) {
	log := logger.Named("handler.blog")
	log.Debug("UpdateBlog called", zap.String("blog_id", req.BlogId))

	if req.TherapistId == "" || req.BlogId == "" {
		return nil, status.Error(codes.InvalidArgument, "therapist_id and blog_id are required")
	}
	if req.Title == "" {
		return nil, status.Error(codes.InvalidArgument, "title is required")
	}

	blog, err := h.svc.UpdateBlog(ctx, req.TherapistId, req.BlogId, req.Title, req.Content, req.CoverImageUrl, req.ImageUrls)
	if err != nil {
		log.Error("UpdateBlog failed", zap.Error(err))
		return nil, grpcError(err)
	}

	log.Info("UpdateBlog succeeded", zap.String("blog_id", blog.ID))
	return &therapistpb.UpdateBlogResponse{Blog: toBlogProto(blog)}, nil
}

func (h *TherapistHandler) PublishBlog(ctx context.Context, req *therapistpb.PublishBlogRequest) (*therapistpb.PublishBlogResponse, error) {
	log := logger.Named("handler.blog")
	log.Debug("PublishBlog called", zap.String("blog_id", req.BlogId))

	if req.TherapistId == "" || req.BlogId == "" {
		return nil, status.Error(codes.InvalidArgument, "therapist_id and blog_id are required")
	}

	blog, err := h.svc.PublishBlog(ctx, req.TherapistId, req.BlogId)
	if err != nil {
		log.Error("PublishBlog failed", zap.Error(err))
		return nil, grpcError(err)
	}

	log.Info("PublishBlog succeeded", zap.String("blog_id", blog.ID))
	return &therapistpb.PublishBlogResponse{Blog: toBlogProto(blog)}, nil
}

func (h *TherapistHandler) DeleteBlog(ctx context.Context, req *therapistpb.DeleteBlogRequest) (*therapistpb.DeleteBlogResponse, error) {
	log := logger.Named("handler.blog")
	log.Debug("DeleteBlog called", zap.String("blog_id", req.BlogId))

	if req.TherapistId == "" || req.BlogId == "" {
		return nil, status.Error(codes.InvalidArgument, "therapist_id and blog_id are required")
	}

	if err := h.svc.DeleteBlog(ctx, req.TherapistId, req.BlogId); err != nil {
		log.Error("DeleteBlog failed", zap.Error(err))
		return nil, grpcError(err)
	}

	log.Info("DeleteBlog succeeded", zap.String("blog_id", req.BlogId))
	return &therapistpb.DeleteBlogResponse{Success: true}, nil
}

func (h *TherapistHandler) GetBlog(ctx context.Context, req *therapistpb.GetBlogRequest) (*therapistpb.GetBlogResponse, error) {
	log := logger.Named("handler.blog")
	log.Debug("GetBlog called", zap.String("blog_id", req.BlogId))

	if req.BlogId == "" {
		return nil, status.Error(codes.InvalidArgument, "blog_id is required")
	}

	blog, err := h.svc.GetBlog(ctx, req.BlogId, req.ViewerId)
	if err != nil {
		log.Error("GetBlog failed", zap.Error(err))
		return nil, grpcError(err)
	}

	return &therapistpb.GetBlogResponse{Blog: toBlogProto(blog)}, nil
}

func (h *TherapistHandler) ListBlogs(ctx context.Context, req *therapistpb.ListBlogsRequest) (*therapistpb.ListBlogsResponse, error) {
	log := logger.Named("handler.blog")
	log.Debug("ListBlogs called")

	blogs, total, err := h.svc.ListBlogs(ctx, req.TherapistId, req.ViewerId, req.Page, req.PageSize)
	if err != nil {
		log.Error("ListBlogs failed", zap.Error(err))
		return nil, grpcError(err)
	}

	pbBlogs := make([]*therapistpb.Blog, 0, len(blogs))
	for _, b := range blogs {
		pbBlogs = append(pbBlogs, toBlogProto(b))
	}
	return &therapistpb.ListBlogsResponse{Blogs: pbBlogs, Total: int32(total)}, nil
}

func (h *TherapistHandler) ToggleLikeBlog(ctx context.Context, req *therapistpb.ToggleLikeBlogRequest) (*therapistpb.ToggleLikeBlogResponse, error) {
	log := logger.Named("handler.blog")
	log.Debug("ToggleLikeBlog called", zap.String("blog_id", req.BlogId))

	if req.TherapistId == "" || req.BlogId == "" {
		return nil, status.Error(codes.InvalidArgument, "therapist_id and blog_id are required")
	}

	liked, likes, err := h.svc.ToggleLikeBlog(ctx, req.TherapistId, req.BlogId)
	if err != nil {
		log.Error("ToggleLikeBlog failed", zap.Error(err))
		return nil, grpcError(err)
	}

	return &therapistpb.ToggleLikeBlogResponse{Liked: liked, Likes: likes}, nil
}

func (h *TherapistHandler) UploadBlogImage(ctx context.Context, req *therapistpb.UploadBlogImageRequest) (*therapistpb.UploadBlogImageResponse, error) {
	log := logger.Named("handler.blog")
	log.Debug("UploadBlogImage called",
		zap.String("therapist_id", req.TherapistId),
		zap.String("content_type", req.ContentType),
		zap.Int("bytes", len(req.Data)),
	)

	if req.TherapistId == "" {
		return nil, status.Error(codes.InvalidArgument, "therapist_id is required")
	}
	if req.FileName == "" || req.ContentType == "" {
		return nil, status.Error(codes.InvalidArgument, "file_name and content_type are required")
	}
	if len(req.Data) == 0 {
		return nil, status.Error(codes.InvalidArgument, "file data must not be empty")
	}

	url, err := h.svc.UploadBlogImage(ctx, req.TherapistId, req.FileName, req.ContentType, req.Data)
	if err != nil {
		log.Error("UploadBlogImage failed", zap.Error(err))
		return nil, grpcError(err)
	}

	log.Info("UploadBlogImage succeeded", zap.String("url", url))
	return &therapistpb.UploadBlogImageResponse{Url: url}, nil
}

// ─── mapping ──────────────────────────────────────────────────────────────────

func toBlogProto(b *service.BlogResult) *therapistpb.Blog {
	statusMap := map[string]therapistpb.BlogStatus{
		"draft":     therapistpb.BlogStatus_BLOG_STATUS_DRAFT,
		"published": therapistpb.BlogStatus_BLOG_STATUS_PUBLISHED,
	}
	st, ok := statusMap[b.Status]
	if !ok {
		st = therapistpb.BlogStatus_BLOG_STATUS_UNSPECIFIED
	}
	return &therapistpb.Blog{
		Id:            b.ID,
		TherapistId:   b.TherapistID,
		Title:         b.Title,
		Slug:          b.Slug,
		CoverImageUrl: b.CoverImageURL,
		Content:       b.Content,
		ImageUrls:     b.ImageURLs,
		Status:        st,
		Views:         b.Views,
		Likes:         b.Likes,
		LikedByMe:     b.LikedByMe,
		CreatedAt:     b.CreatedAt,
		UpdatedAt:     b.UpdatedAt,
		PublishedAt:   b.PublishedAt,
	}
}
