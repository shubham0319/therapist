import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:therapist/core/di/injection.dart';
import 'package:therapist/features/auth/bloc/auth_bloc.dart';
import 'package:therapist/features/blog/bloc/blog_bloc.dart';
import 'package:therapist/features/blog/data/blog_repository.dart';

// Max inline images allowed by the server.
const _maxImages = 2;
// Max blog image size: 2 MB.
const _maxImageBytes = 2 * 1024 * 1024;

class CreateBlogPage extends StatefulWidget {
  const CreateBlogPage({super.key, this.existingBlog});

  /// When non-null, we are in "edit" mode.
  final BlogModel? existingBlog;

  @override
  State<CreateBlogPage> createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends State<CreateBlogPage> {
  late final BlogBloc _bloc;
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _coverImageUrl = '';
  final List<String> _imageUrls = [];

  // Tracks upload-in-progress state per slot.
  bool _uploadingCover = false;
  final List<bool> _uploadingImages = [];

  bool get _isEdit => widget.existingBlog != null;

  /// Read the therapistId synchronously from the app-level AuthBloc.
  String get _therapistId {
    final s = context.read<AuthBloc>().state;
    return s is AuthAuthenticated ? s.therapistId : '';
  }

  @override
  void initState() {
    super.initState();
    _bloc = BlogBloc();
    if (_isEdit) {
      _titleCtrl.text = widget.existingBlog!.title;
      _contentCtrl.text = widget.existingBlog!.content;
      _coverImageUrl = widget.existingBlog!.coverImageUrl;
      _imageUrls.addAll(widget.existingBlog!.imageUrls);
    }
  }

  @override
  void dispose() {
    _bloc.close();
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  // ── Image upload helpers ─────────────────────────────────────────────────

  Future<void> _pickCoverImage() async {
    final picked = await _pickImage();
    if (picked == null || !mounted) return;
    setState(() => _uploadingCover = true);

    final result = await sl<BlogRepository>().uploadBlogImage(
      therapistId: _therapistId,
      fileName: picked.name,
      contentType: _mimeFromName(picked.name),
      data: picked.bytes!,
    );

    if (!mounted) return;
    result.fold(
      (f) {
        setState(() => _uploadingCover = false);
        _showError(f.message);
      },
      (url) => setState(() {
        _coverImageUrl = url;
        _uploadingCover = false;
      }),
    );
  }

  Future<void> _pickInlineImage() async {
    if (_imageUrls.length >= _maxImages) {
      _showError('Maximum $_maxImages inline images allowed.');
      return;
    }
    final picked = await _pickImage();
    if (picked == null || !mounted) return;

    final idx = _imageUrls.length;
    setState(() => _uploadingImages.add(true));

    final result = await sl<BlogRepository>().uploadBlogImage(
      therapistId: _therapistId,
      fileName: picked.name,
      contentType: _mimeFromName(picked.name),
      data: picked.bytes!,
    );

    if (!mounted) return;
    result.fold(
      (f) {
        setState(() => _uploadingImages[idx] = false);
        _showError(f.message);
      },
      (url) => setState(() {
        if (idx < _imageUrls.length) {
          _imageUrls[idx] = url;
        } else {
          _imageUrls.add(url);
        }
        _uploadingImages[idx] = false;
      }),
    );
  }

  Future<PlatformFile?> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return null;
    final file = result.files.first;
    if (file.bytes == null) return null;
    if (file.bytes!.length > _maxImageBytes) {
      _showError('Image must be ≤ 2 MB. Selected file is too large.');
      return null;
    }
    return file;
  }

  String _mimeFromName(String name) {
    final ext = name.split('.').last.toLowerCase();
    return switch (ext) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'webp' => 'image/webp',
      _ => 'image/jpeg',
    };
  }

  // ── Save / submit ─────────────────────────────────────────────────────────

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _bloc.add(BlogSubmitted(
      therapistId: _therapistId,
      title: _titleCtrl.text.trim(),
      content: _contentCtrl.text.trim(),
      coverImageUrl: _coverImageUrl,
      imageUrls: List.from(_imageUrls),
      blogId: widget.existingBlog?.id,
    ));
  }

  void _showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<BlogBloc, BlogState>(
        listener: (ctx, state) {
          if (state is BlogSaved) {
            ScaffoldMessenger.of(ctx)
                .showSnackBar(const SnackBar(content: Text('Blog saved as draft')));
            ctx.pop(state.blog);
          }
          if (state is BlogError) {
            _showError(state.message);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(_isEdit ? 'Edit Blog' : 'Write a Blog'),
            actions: [
              BlocBuilder<BlogBloc, BlogState>(
                builder: (ctx, state) => state is BlogLoading
                    ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : TextButton(
                        onPressed: _therapistId.isEmpty ? null : _submit,
                        child: const Text('Save'),
                      ),
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Cover image ─────────────────────────────────────────
                  Text('Cover Image', style: theme.textTheme.labelLarge),
                  const SizedBox(height: 8),
                  _CoverImagePicker(
                    url: _coverImageUrl,
                    uploading: _uploadingCover,
                    onPick: _pickCoverImage,
                    onRemove: () => setState(() => _coverImageUrl = ''),
                  ),
                  const SizedBox(height: 24),

                  // ── Title ───────────────────────────────────────────────
                  TextFormField(
                    controller: _titleCtrl,
                    maxLength: 300,
                    decoration: const InputDecoration(
                      labelText: 'Title *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final s = v?.trim() ?? '';
                      if (s.isEmpty) return 'Title is required';
                      if (s.length < 3) return 'Title is too short';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // ── Content ─────────────────────────────────────────────
                  TextFormField(
                    controller: _contentCtrl,
                    maxLines: 18,
                    maxLength: 50000,
                    decoration: const InputDecoration(
                      labelText: 'Content',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Inline images ───────────────────────────────────────
                  Row(
                    children: [
                      Text('Inline Images', style: theme.textTheme.labelLarge),
                      const SizedBox(width: 8),
                      Text(
                        '(max $_maxImages, 2 MB each)',
                        style: theme.textTheme.labelSmall?.copyWith(color: cs.outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ..._imageUrls.asMap().entries.map(
                    (e) => _InlineImageRow(
                      url: e.value,
                      onRemove: () => setState(() => _imageUrls.removeAt(e.key)),
                    ),
                  ),
                  if (_imageUrls.length < _maxImages)
                    OutlinedButton.icon(
                      onPressed: _uploadingImages.contains(true) ? null : _pickInlineImage,
                      icon: _uploadingImages.contains(true)
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.add_photo_alternate_outlined),
                      label: const Text('Add image'),
                    ),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Cover image picker widget
// ─────────────────────────────────────────────────────────────────────────────

class _CoverImagePicker extends StatelessWidget {
  const _CoverImagePicker({
    required this.url,
    required this.uploading,
    required this.onPick,
    required this.onRemove,
  });
  final String url;
  final bool uploading;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (uploading) {
      return Container(
        height: 160,
        decoration: BoxDecoration(
          border: Border.all(color: cs.outlineVariant),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (url.isNotEmpty) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(url, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: CircleAvatar(
              backgroundColor: cs.errorContainer,
              child: IconButton(
                icon: Icon(Icons.close, color: cs.onErrorContainer),
                onPressed: onRemove,
              ),
            ),
          ),
        ],
      );
    }

    return InkWell(
      onTap: onPick,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(color: cs.outlineVariant, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(12),
          color: cs.surfaceContainerLowest,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_photo_alternate_outlined, size: 36, color: cs.outline),
            const SizedBox(height: 8),
            Text('Tap to add cover image', style: TextStyle(color: cs.outline)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Inline image row
// ─────────────────────────────────────────────────────────────────────────────

class _InlineImageRow extends StatelessWidget {
  const _InlineImageRow({required this.url, required this.onRemove});
  final String url;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(url, width: 80, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              url.split('/').last,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: cs.error),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
