part of 'image_picker_bloc.dart';

abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

class OnClickImagePicker extends ImagePickerEvent {
  final int refresh;

  const OnClickImagePicker({
    required this.refresh,
  });

  @override
  List<Object> get props => [
        refresh,
      ];
}
