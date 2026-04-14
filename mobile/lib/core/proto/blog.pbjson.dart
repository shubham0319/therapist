// This is a generated file - do not edit.
//
// Generated from proto/blog.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use blogStatusDescriptor instead')
const BlogStatus$json = {
  '1': 'BlogStatus',
  '2': [
    {'1': 'BLOG_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'BLOG_STATUS_DRAFT', '2': 1},
    {'1': 'BLOG_STATUS_PUBLISHED', '2': 2},
  ],
};

/// Descriptor for `BlogStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List blogStatusDescriptor = $convert.base64Decode(
    'CgpCbG9nU3RhdHVzEhsKF0JMT0dfU1RBVFVTX1VOU1BFQ0lGSUVEEAASFQoRQkxPR19TVEFUVV'
    'NfRFJBRlQQARIZChVCTE9HX1NUQVRVU19QVUJMSVNIRUQQAg==');

@$core.Deprecated('Use blogDescriptor instead')
const Blog$json = {
  '1': 'Blog',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'therapist_id', '3': 2, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'slug', '3': 4, '4': 1, '5': 9, '10': 'slug'},
    {'1': 'cover_image_url', '3': 5, '4': 1, '5': 9, '10': 'coverImageUrl'},
    {'1': 'content', '3': 6, '4': 1, '5': 9, '10': 'content'},
    {'1': 'image_urls', '3': 7, '4': 3, '5': 9, '10': 'imageUrls'},
    {
      '1': 'status',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.therapist.BlogStatus',
      '10': 'status'
    },
    {'1': 'views', '3': 9, '4': 1, '5': 3, '10': 'views'},
    {'1': 'likes', '3': 10, '4': 1, '5': 3, '10': 'likes'},
    {'1': 'liked_by_me', '3': 11, '4': 1, '5': 8, '10': 'likedByMe'},
    {'1': 'created_at', '3': 12, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 13, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'published_at', '3': 14, '4': 1, '5': 9, '10': 'publishedAt'},
    {'1': 'tags', '3': 15, '4': 3, '5': 9, '10': 'tags'},
  ],
};

/// Descriptor for `Blog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blogDescriptor = $convert.base64Decode(
    'CgRCbG9nEg4KAmlkGAEgASgJUgJpZBIhCgx0aGVyYXBpc3RfaWQYAiABKAlSC3RoZXJhcGlzdE'
    'lkEhQKBXRpdGxlGAMgASgJUgV0aXRsZRISCgRzbHVnGAQgASgJUgRzbHVnEiYKD2NvdmVyX2lt'
    'YWdlX3VybBgFIAEoCVINY292ZXJJbWFnZVVybBIYCgdjb250ZW50GAYgASgJUgdjb250ZW50Eh'
    '0KCmltYWdlX3VybHMYByADKAlSCWltYWdlVXJscxItCgZzdGF0dXMYCCABKA4yFS50aGVyYXBp'
    'c3QuQmxvZ1N0YXR1c1IGc3RhdHVzEhQKBXZpZXdzGAkgASgDUgV2aWV3cxIUCgVsaWtlcxgKIA'
    'EoA1IFbGlrZXMSHgoLbGlrZWRfYnlfbWUYCyABKAhSCWxpa2VkQnlNZRIdCgpjcmVhdGVkX2F0'
    'GAwgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgNIAEoCVIJdXBkYXRlZEF0EiEKDHB1Ym'
    'xpc2hlZF9hdBgOIAEoCVILcHVibGlzaGVkQXQSEgoEdGFncxgPIAMoCVIEdGFncw==');

@$core.Deprecated('Use createBlogRequestDescriptor instead')
const CreateBlogRequest$json = {
  '1': 'CreateBlogRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'content', '3': 3, '4': 1, '5': 9, '10': 'content'},
    {'1': 'cover_image_url', '3': 4, '4': 1, '5': 9, '10': 'coverImageUrl'},
    {'1': 'image_urls', '3': 5, '4': 3, '5': 9, '10': 'imageUrls'},
    {'1': 'tags', '3': 6, '4': 3, '5': 9, '10': 'tags'},
  ],
};

/// Descriptor for `CreateBlogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createBlogRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVCbG9nUmVxdWVzdBIhCgx0aGVyYXBpc3RfaWQYASABKAlSC3RoZXJhcGlzdElkEh'
    'QKBXRpdGxlGAIgASgJUgV0aXRsZRIYCgdjb250ZW50GAMgASgJUgdjb250ZW50EiYKD2NvdmVy'
    'X2ltYWdlX3VybBgEIAEoCVINY292ZXJJbWFnZVVybBIdCgppbWFnZV91cmxzGAUgAygJUglpbW'
    'FnZVVybHMSEgoEdGFncxgGIAMoCVIEdGFncw==');

@$core.Deprecated('Use createBlogResponseDescriptor instead')
const CreateBlogResponse$json = {
  '1': 'CreateBlogResponse',
  '2': [
    {
      '1': 'blog',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.therapist.Blog',
      '10': 'blog'
    },
  ],
};

/// Descriptor for `CreateBlogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createBlogResponseDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVCbG9nUmVzcG9uc2USIwoEYmxvZxgBIAEoCzIPLnRoZXJhcGlzdC5CbG9nUgRibG'
    '9n');

@$core.Deprecated('Use updateBlogRequestDescriptor instead')
const UpdateBlogRequest$json = {
  '1': 'UpdateBlogRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'blog_id', '3': 2, '4': 1, '5': 9, '10': 'blogId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'content', '3': 4, '4': 1, '5': 9, '10': 'content'},
    {'1': 'cover_image_url', '3': 5, '4': 1, '5': 9, '10': 'coverImageUrl'},
    {'1': 'image_urls', '3': 6, '4': 3, '5': 9, '10': 'imageUrls'},
    {'1': 'tags', '3': 7, '4': 3, '5': 9, '10': 'tags'},
  ],
};

/// Descriptor for `UpdateBlogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBlogRequestDescriptor = $convert.base64Decode(
    'ChFVcGRhdGVCbG9nUmVxdWVzdBIhCgx0aGVyYXBpc3RfaWQYASABKAlSC3RoZXJhcGlzdElkEh'
    'cKB2Jsb2dfaWQYAiABKAlSBmJsb2dJZBIUCgV0aXRsZRgDIAEoCVIFdGl0bGUSGAoHY29udGVu'
    'dBgEIAEoCVIHY29udGVudBImCg9jb3Zlcl9pbWFnZV91cmwYBSABKAlSDWNvdmVySW1hZ2VVcm'
    'wSHQoKaW1hZ2VfdXJscxgGIAMoCVIJaW1hZ2VVcmxzEhIKBHRhZ3MYByADKAlSBHRhZ3M=');

@$core.Deprecated('Use updateBlogResponseDescriptor instead')
const UpdateBlogResponse$json = {
  '1': 'UpdateBlogResponse',
  '2': [
    {
      '1': 'blog',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.therapist.Blog',
      '10': 'blog'
    },
  ],
};

/// Descriptor for `UpdateBlogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateBlogResponseDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVCbG9nUmVzcG9uc2USIwoEYmxvZxgBIAEoCzIPLnRoZXJhcGlzdC5CbG9nUgRibG'
    '9n');

@$core.Deprecated('Use publishBlogRequestDescriptor instead')
const PublishBlogRequest$json = {
  '1': 'PublishBlogRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'blog_id', '3': 2, '4': 1, '5': 9, '10': 'blogId'},
  ],
};

/// Descriptor for `PublishBlogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publishBlogRequestDescriptor = $convert.base64Decode(
    'ChJQdWJsaXNoQmxvZ1JlcXVlc3QSIQoMdGhlcmFwaXN0X2lkGAEgASgJUgt0aGVyYXBpc3RJZB'
    'IXCgdibG9nX2lkGAIgASgJUgZibG9nSWQ=');

@$core.Deprecated('Use publishBlogResponseDescriptor instead')
const PublishBlogResponse$json = {
  '1': 'PublishBlogResponse',
  '2': [
    {
      '1': 'blog',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.therapist.Blog',
      '10': 'blog'
    },
  ],
};

/// Descriptor for `PublishBlogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publishBlogResponseDescriptor = $convert.base64Decode(
    'ChNQdWJsaXNoQmxvZ1Jlc3BvbnNlEiMKBGJsb2cYASABKAsyDy50aGVyYXBpc3QuQmxvZ1IEYm'
    'xvZw==');

@$core.Deprecated('Use deleteBlogRequestDescriptor instead')
const DeleteBlogRequest$json = {
  '1': 'DeleteBlogRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'blog_id', '3': 2, '4': 1, '5': 9, '10': 'blogId'},
  ],
};

/// Descriptor for `DeleteBlogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBlogRequestDescriptor = $convert.base64Decode(
    'ChFEZWxldGVCbG9nUmVxdWVzdBIhCgx0aGVyYXBpc3RfaWQYASABKAlSC3RoZXJhcGlzdElkEh'
    'cKB2Jsb2dfaWQYAiABKAlSBmJsb2dJZA==');

@$core.Deprecated('Use deleteBlogResponseDescriptor instead')
const DeleteBlogResponse$json = {
  '1': 'DeleteBlogResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeleteBlogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBlogResponseDescriptor =
    $convert.base64Decode(
        'ChJEZWxldGVCbG9nUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use getBlogRequestDescriptor instead')
const GetBlogRequest$json = {
  '1': 'GetBlogRequest',
  '2': [
    {'1': 'blog_id', '3': 1, '4': 1, '5': 9, '10': 'blogId'},
    {'1': 'viewer_id', '3': 2, '4': 1, '5': 9, '10': 'viewerId'},
  ],
};

/// Descriptor for `GetBlogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBlogRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRCbG9nUmVxdWVzdBIXCgdibG9nX2lkGAEgASgJUgZibG9nSWQSGwoJdmlld2VyX2lkGA'
    'IgASgJUgh2aWV3ZXJJZA==');

@$core.Deprecated('Use getBlogResponseDescriptor instead')
const GetBlogResponse$json = {
  '1': 'GetBlogResponse',
  '2': [
    {
      '1': 'blog',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.therapist.Blog',
      '10': 'blog'
    },
  ],
};

/// Descriptor for `GetBlogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBlogResponseDescriptor = $convert.base64Decode(
    'Cg9HZXRCbG9nUmVzcG9uc2USIwoEYmxvZxgBIAEoCzIPLnRoZXJhcGlzdC5CbG9nUgRibG9n');

@$core.Deprecated('Use listBlogsRequestDescriptor instead')
const ListBlogsRequest$json = {
  '1': 'ListBlogsRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'viewer_id', '3': 2, '4': 1, '5': 9, '10': 'viewerId'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListBlogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBlogsRequestDescriptor = $convert.base64Decode(
    'ChBMaXN0QmxvZ3NSZXF1ZXN0EiEKDHRoZXJhcGlzdF9pZBgBIAEoCVILdGhlcmFwaXN0SWQSGw'
    'oJdmlld2VyX2lkGAIgASgJUgh2aWV3ZXJJZBISCgRwYWdlGAMgASgFUgRwYWdlEhsKCXBhZ2Vf'
    'c2l6ZRgEIAEoBVIIcGFnZVNpemU=');

@$core.Deprecated('Use listBlogsResponseDescriptor instead')
const ListBlogsResponse$json = {
  '1': 'ListBlogsResponse',
  '2': [
    {
      '1': 'blogs',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.therapist.Blog',
      '10': 'blogs'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ListBlogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBlogsResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0QmxvZ3NSZXNwb25zZRIlCgVibG9ncxgBIAMoCzIPLnRoZXJhcGlzdC5CbG9nUgVibG'
    '9ncxIUCgV0b3RhbBgCIAEoBVIFdG90YWw=');

@$core.Deprecated('Use listMyBlogsRequestDescriptor instead')
const ListMyBlogsRequest$json = {
  '1': 'ListMyBlogsRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
  ],
};

/// Descriptor for `ListMyBlogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMyBlogsRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0TXlCbG9nc1JlcXVlc3QSIQoMdGhlcmFwaXN0X2lkGAEgASgJUgt0aGVyYXBpc3RJZB'
    'ISCgRwYWdlGAIgASgFUgRwYWdlEhsKCXBhZ2Vfc2l6ZRgDIAEoBVIIcGFnZVNpemU=');

@$core.Deprecated('Use listMyBlogsResponseDescriptor instead')
const ListMyBlogsResponse$json = {
  '1': 'ListMyBlogsResponse',
  '2': [
    {
      '1': 'blogs',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.therapist.Blog',
      '10': 'blogs'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ListMyBlogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMyBlogsResponseDescriptor = $convert.base64Decode(
    'ChNMaXN0TXlCbG9nc1Jlc3BvbnNlEiUKBWJsb2dzGAEgAygLMg8udGhlcmFwaXN0LkJsb2dSBW'
    'Jsb2dzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');

@$core.Deprecated('Use toggleLikeBlogRequestDescriptor instead')
const ToggleLikeBlogRequest$json = {
  '1': 'ToggleLikeBlogRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'blog_id', '3': 2, '4': 1, '5': 9, '10': 'blogId'},
  ],
};

/// Descriptor for `ToggleLikeBlogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleLikeBlogRequestDescriptor = $convert.base64Decode(
    'ChVUb2dnbGVMaWtlQmxvZ1JlcXVlc3QSIQoMdGhlcmFwaXN0X2lkGAEgASgJUgt0aGVyYXBpc3'
    'RJZBIXCgdibG9nX2lkGAIgASgJUgZibG9nSWQ=');

@$core.Deprecated('Use toggleLikeBlogResponseDescriptor instead')
const ToggleLikeBlogResponse$json = {
  '1': 'ToggleLikeBlogResponse',
  '2': [
    {'1': 'liked', '3': 1, '4': 1, '5': 8, '10': 'liked'},
    {'1': 'likes', '3': 2, '4': 1, '5': 3, '10': 'likes'},
  ],
};

/// Descriptor for `ToggleLikeBlogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleLikeBlogResponseDescriptor =
    $convert.base64Decode(
        'ChZUb2dnbGVMaWtlQmxvZ1Jlc3BvbnNlEhQKBWxpa2VkGAEgASgIUgVsaWtlZBIUCgVsaWtlcx'
        'gCIAEoA1IFbGlrZXM=');

@$core.Deprecated('Use uploadBlogImageRequestDescriptor instead')
const UploadBlogImageRequest$json = {
  '1': 'UploadBlogImageRequest',
  '2': [
    {'1': 'therapist_id', '3': 1, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
    {'1': 'file_name', '3': 3, '4': 1, '5': 9, '10': 'fileName'},
    {'1': 'content_type', '3': 4, '4': 1, '5': 9, '10': 'contentType'},
  ],
};

/// Descriptor for `UploadBlogImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadBlogImageRequestDescriptor = $convert.base64Decode(
    'ChZVcGxvYWRCbG9nSW1hZ2VSZXF1ZXN0EiEKDHRoZXJhcGlzdF9pZBgBIAEoCVILdGhlcmFwaX'
    'N0SWQSEgoEZGF0YRgCIAEoDFIEZGF0YRIbCglmaWxlX25hbWUYAyABKAlSCGZpbGVOYW1lEiEK'
    'DGNvbnRlbnRfdHlwZRgEIAEoCVILY29udGVudFR5cGU=');

@$core.Deprecated('Use uploadBlogImageResponseDescriptor instead')
const UploadBlogImageResponse$json = {
  '1': 'UploadBlogImageResponse',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `UploadBlogImageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadBlogImageResponseDescriptor =
    $convert.base64Decode(
        'ChdVcGxvYWRCbG9nSW1hZ2VSZXNwb25zZRIQCgN1cmwYASABKAlSA3VybA==');
