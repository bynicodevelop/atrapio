import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerBloc() : super(const ImagePickerInitialState()) {
    on<OnClickImagePicker>((event, emit) async {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        emit(
          ImagePickerInitialState(
            image: image.path,
            refresh: DateTime.now().millisecondsSinceEpoch,
          ),
        );
      } else {
        emit(
          ImagePickerInitialState(
            image: "",
            refresh: DateTime.now().millisecondsSinceEpoch,
          ),
        );
      }
    });
  }
}
