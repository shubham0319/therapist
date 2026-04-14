// This is a generated file - do not edit.
//
// Generated from proto/blog.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class BlogStatus extends $pb.ProtobufEnum {
  static const BlogStatus BLOG_STATUS_UNSPECIFIED =
      BlogStatus._(0, _omitEnumNames ? '' : 'BLOG_STATUS_UNSPECIFIED');
  static const BlogStatus BLOG_STATUS_DRAFT =
      BlogStatus._(1, _omitEnumNames ? '' : 'BLOG_STATUS_DRAFT');
  static const BlogStatus BLOG_STATUS_PUBLISHED =
      BlogStatus._(2, _omitEnumNames ? '' : 'BLOG_STATUS_PUBLISHED');

  static const $core.List<BlogStatus> values = <BlogStatus>[
    BLOG_STATUS_UNSPECIFIED,
    BLOG_STATUS_DRAFT,
    BLOG_STATUS_PUBLISHED,
  ];

  static final $core.List<BlogStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static BlogStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BlogStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
