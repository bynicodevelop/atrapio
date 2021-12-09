import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/responsive.dart';
import 'package:atrap_io/services/add_link/add_link_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LinkFormComponent extends StatelessWidget {
  final TextEditingController srcController = TextEditingController();
  final TextEditingController utmSourceController = TextEditingController();
  final TextEditingController utmMediumController = TextEditingController();
  final TextEditingController utmCampaignController = TextEditingController();
  final TextEditingController utmIdController = TextEditingController();
  final TextEditingController utmTermController = TextEditingController();
  final TextEditingController utmContentController = TextEditingController();
  final TextEditingController paramsController = TextEditingController();

  LinkFormComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddLinkBloc, AddLinkState>(
      listener: (context, state) {
        if (state is AddLinkSuccess) {
          FocusScope.of(context).requestFocus(FocusNode());

          srcController.clear();
          utmSourceController.clear();
          utmMediumController.clear();
          utmCampaignController.clear();
          utmIdController.clear();
          utmTermController.clear();
          utmContentController.clear();
          paramsController.clear();

          if (Responsive.isMobile(context)) {
            Navigator.pop(context);
          }
        }

        if (state is AddLinkFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                t(context)!.linkFormCreatorUnexpectedErrorMessage,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: srcController,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  labelText: t(context)!.linkFormCreatorLink,
                  helperText: t(context)!.linkFormCreatorLinkHelper,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: utmSourceController,
                decoration: InputDecoration(
                  labelText: t(context)!.linkFormCreatorUtmSource,
                  helperText: t(context)!.linkFormCreatorUtmSourceHelper,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: utmMediumController,
                decoration: InputDecoration(
                  labelText: t(context)!.linkFormCreatorUtmMedium,
                  helperText: t(context)!.linkFormCreatorUtmMediumHelper,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: utmCampaignController,
                decoration: InputDecoration(
                  labelText: t(context)!.linkFormCreatorUtmCampaign,
                  helperText: t(context)!.linkFormCreatorUtmCampaignHelper,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: utmIdController,
                decoration: InputDecoration(
                  labelText: t(context)!.linkFormCreatorUtmId,
                  helperText: t(context)!.linkFormCreatorUtmIdHelper,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: utmTermController,
                decoration: InputDecoration(
                  labelText: t(context)!.linkFormCreatorUtmTerm,
                  helperText: t(context)!.linkFormCreatorUtmTermHelper,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: utmContentController,
                decoration: InputDecoration(
                  labelText: t(context)!.linkFormCreatorUtmContent,
                  helperText: t(context)!.linkFormCreatorUtmContentHelper,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: TextField(
                textInputAction: TextInputAction.done,
                controller: paramsController,
                decoration: InputDecoration(
                  labelText: t(context)!.linkFormCreatorParams,
                  helperText: t(context)!.linkFormCreatorParamsHelper,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (Responsive.isMobile(context))
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        t(context)!.linkFormCreatorCancelButton.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  TextButton(
                    onPressed: context.watch<AddLinkBloc>().state
                            is AddLinkLoading
                        ? null
                        : () {
                            if (srcController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    t(context)!
                                        .linkFormCreatorErrorMessageEmptySrc,
                                  ),
                                ),
                              );

                              return;
                            }

                            context.read<AddLinkBloc>().add(
                                  OnCreateLinkEvent(
                                    params: {
                                      "src": srcController.text,
                                      "utm_source": utmSourceController.text,
                                      "utm_medium": utmMediumController.text,
                                      "utm_campaign":
                                          utmCampaignController.text,
                                      "utm_id": utmIdController.text,
                                      "utm_term": utmTermController.text,
                                      "utm_content": utmContentController.text,
                                      "params": paramsController.text,
                                    },
                                  ),
                                );
                          },
                    child: Text(
                      t(context)!.linkFormCreatorCreateButton.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: context.watch<AddLinkBloc>().state
                                    is AddLinkLoading
                                ? Colors.grey
                                : Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
