import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import '../consts/color_manager.dart';

class ImagePickerUtils {
  static final ImagePicker _picker = ImagePicker();

  /// Request permission based on image source
  static Future<bool> _requestPermission(ImageSource source) async {
    debugPrint('Requesting permission for source: $source');

    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();
      debugPrint('Camera permission status: $status');

      if (status.isGranted) {
        return true;
      } else if (status.isPermanentlyDenied) {
        debugPrint('Camera permission permanently denied, opening settings');
        await openAppSettings();
        return false;
      } else {
        debugPrint('Camera permission denied');
        return false;
      }
    } else {
      // For gallery, handle both old and new Android permission models
      if (Platform.isAndroid) {
        // Try photos permission first (Android 13+)
        var status = await Permission.photos.request();
        debugPrint('Photos permission status: $status');

        if (status.isGranted) {
          return true;
        }

        // Fall back to storage permission for older Android
        status = await Permission.storage.request();
        debugPrint('Storage permission status: $status');

        if (status.isGranted) {
          return true;
        } else if (status.isPermanentlyDenied) {
          debugPrint('Storage permission permanently denied, opening settings');
          await openAppSettings();
          return false;
        } else {
          debugPrint('Storage permission denied');
          return false;
        }
      } else {
        // iOS
        final status = await Permission.photos.request();
        debugPrint('Photos permission status: $status');

        if (status.isGranted) {
          return true;
        } else if (status.isPermanentlyDenied) {
          debugPrint('Photos permission permanently denied, opening settings');
          await openAppSettings();
          return false;
        } else {
          debugPrint('Photos permission denied');
          return false;
        }
      }
    }
  }

  /// Pick and crop an image with 1:1 aspect ratio
  /// Returns the cropped image file path or null if cancelled
  static Future<String?> pickAndCropImage({
    required BuildContext context,
    ImageSource source = ImageSource.gallery,
    String title = 'Crop Image',
  }) async {
    try {
      debugPrint('Starting image picker with source: $source');

      // Request permission first
      final hasPermission = await _requestPermission(source);
      if (!hasPermission) {
        debugPrint('Permission not granted');
        return null;
      }

      debugPrint('Permission granted, opening picker');

      // Pick image
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      debugPrint('Picked file: ${pickedFile?.path}');

      if (pickedFile == null) {
        debugPrint('No image selected');
        return null;
      }

      // Crop image with 1:1 aspect ratio
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 85,
        maxWidth: 1024,
        maxHeight: 1024,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: title,
            toolbarColor: ColorManager.primary,
            toolbarWidgetColor: ColorManager.white,
            statusBarColor: ColorManager.primary,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: false,
            showCropGrid: true,
            cropGridRowCount: 3,
            cropGridColumnCount: 3,
            activeControlsWidgetColor: ColorManager.primary,
            backgroundColor: Colors.black,
            dimmedLayerColor: Colors.black.withValues(alpha: 0.65),
            cropFrameColor: ColorManager.white,
            cropGridColor: Colors.white.withValues(alpha: 0.3),
            cropFrameStrokeWidth: 2,
            cropGridStrokeWidth: 1,
          ),
          IOSUiSettings(
            title: title,
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
            aspectRatioPickerButtonHidden: true,
            minimumAspectRatio: 1.0,
            rectX: 1,
            rectY: 1,
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      debugPrint('Cropped file: ${croppedFile?.path}');

      if (croppedFile == null) {
        debugPrint('Cropping cancelled');
        return null;
      }

      debugPrint('Successfully cropped image: ${croppedFile.path}');
      return croppedFile.path;
    } catch (e, stackTrace) {
      debugPrint('Error picking/cropping image: $e');
      debugPrint('Stack trace: $stackTrace');
      return null;
    }
  }

  /// Show image source selection bottom sheet
  static Future<String?> showImageSourceDialog({
    required BuildContext context,
    String title = 'Select Image Source',
  }) async {
    debugPrint('Showing image source dialog');

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _ImageSourceBottomSheet(title: title),
    );

    debugPrint('Selected source: $source');

    if (source == null) {
      debugPrint('No source selected');
      return null;
    }

    debugPrint('About to call pickAndCropImage');

    // Direct call without context check - image_picker handles context internally
    try {
      return await pickAndCropImage(
        context: context,
        source: source,
        title: 'Crop Logo',
      );
    } catch (e) {
      debugPrint('Error in showImageSourceDialog: $e');
      return null;
    }
  }

  /// Validate image file
  static bool isValidImageFile(String? path) {
    if (path == null || path.isEmpty) return false;
    final file = File(path);
    if (!file.existsSync()) return false;

    final extension = path.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'webp'].contains(extension);
  }

  /// Get file size in MB
  static double getFileSizeInMB(String path) {
    final file = File(path);
    if (!file.existsSync()) return 0.0;
    final bytes = file.lengthSync();
    return bytes / (1024 * 1024);
  }
}

class _ImageSourceBottomSheet extends StatelessWidget {
  final String title;

  const _ImageSourceBottomSheet({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ColorManager.grey3,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.photo_library, color: ColorManager.primary),
              title: Text(
                'Choose from Gallery',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.textPrimary,
                ),
              ),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: ColorManager.primary),
              title: Text(
                'Take a Photo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.textPrimary,
                ),
              ),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
