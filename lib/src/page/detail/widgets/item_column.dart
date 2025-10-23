import 'package:dio_request_inspector/src/common/extensions.dart';
import 'package:dio_request_inspector/src/common/helpers.dart';
import 'package:dio_request_inspector/src/page/dashboard/widget/custom_text.dart';
import 'package:flutter/material.dart';

class ItemColumn extends StatelessWidget {
  final String? name;
  final String? value;
  final Widget? child;
  final bool showCopyButton;
  final bool isImage;

  const ItemColumn({
    Key? key,
    this.name,
    this.value,
    this.showCopyButton = true,
    this.isImage = false,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return const SizedBox();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(name!, style: const TextStyle(fontWeight: FontWeight.bold)),
            Visibility(
              visible: showCopyButton,
              child: IconButton(
                icon: const Icon(
                  Icons.copy,
                  size: 16,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Helper.copyToClipboard(
                      text: value!.isJson ? value!.prettify : value!,
                      context: context);
                },
              ),
            ),
          ],
        ),
        if (isImage)
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Placeholder(),
            ),
          ),

        if (!isImage)
          if (child != null) child!,

          Visibility(
            visible: child == null,
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 0,
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    value!.isJson ? value!.prettify : value!,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
