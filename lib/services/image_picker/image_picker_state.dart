part of 'image_picker_bloc.dart';

abstract class ImagePickerState extends Equatable {
  const ImagePickerState();

  @override
  List<Object> get props => [];
}

class ImagePickerInitialState extends ImagePickerState {
  final String image;
  final int refresh;

  const ImagePickerInitialState({
    this.image = "",
    this.refresh = 0,
  });

  @override
  List<Object> get props => [
        image,
        refresh,
      ];
}
