import 'dart:io';

import 'package:atrap_io/services/image_picker/image_picker_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImagePickerComponent extends StatelessWidget {
  const ImagePickerComponent({
    Key? key,
  }) : super(key: key);

  Widget _wrapper(
    Widget child,
  ) =>
      SizedBox(
        width: 80,
        height: 80,
        child: child,
      );

  Widget _uploadButton(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const FaIcon(
            FontAwesomeIcons.image,
            size: 40,
          ),
          Text(
            "Import image",
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 10,
                ),
          ),
        ],
      );

  Widget _imageRender(String path) => kIsWeb
      ? Image.network(
          path,
          fit: BoxFit.cover,
        )
      : Image.file(
          File(path),
          fit: BoxFit.cover,
        );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerBloc, ImagePickerState>(
      builder: (context, state) => Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: _wrapper(
              InkWell(
                onTap: () => context.read<ImagePickerBloc>().add(
                      OnClickImagePicker(
                        refresh: DateTime.now().millisecondsSinceEpoch,
                      ),
                    ),
                child: (state as ImagePickerInitialState).image.isNotEmpty
                    ? _imageRender(state.image)
                    : _uploadButton(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
