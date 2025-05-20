import 'package:get/get.dart';
import '../../../constants/image_strings.dart';

/// A GetX controller to manage the user's profile image selection.
class ProfileImageController extends GetxController {
  /// Observable variable to hold the selected profile image path.
  /// Initially set to a default image (tBoy1).
  var selectedImage = tBoy1.obs;

  /// Method to update the selected profile image.
  /// [path] is the new image path to be set.
  void setImage(String path) {
    selectedImage.value = path;
  }
}
