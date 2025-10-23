import 'package:dio_request_inspector/src/page/dashboard/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:dio_request_inspector/src/common/helpers.dart';
import 'package:dio_request_inspector/src/model/http_activity.dart';
import 'package:dio_request_inspector/src/page/resources/app_color.dart';
import 'package:dio_request_inspector/src/page/dashboard/widget/dot_indicator_widget.dart';

class ItemResponseWidget extends StatelessWidget {
  final HttpActivity data;

  const ItemResponseWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      width: double.infinity,
      child: Card(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildRequestInfo(),
              _buildStatusCode(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestInfo() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  data.method,
                  style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomText(
                    data.endpoint,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            CustomText(
              data.uri,
              style: TextStyle(fontSize: 12, color: AppColor.primary),
            ),
            const Divider(color: Colors.grey, endIndent: 12),
            Row(
              children: [
                CustomText(
                  data.request?.time != null ? _formatTime(data.request!.time) : 'n/a',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Spacer(),
                CustomText(
                  '${Helper.formatBytes(data.request?.size ?? 0)} / '
                  '${Helper.formatBytes(data.response?.size ?? 0)}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Spacer(),
                CustomText(
                  Helper.formatTime(data.duration),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCode() {
    final int statusCode = data.response?.status ?? 0;
    Color statusColor;
    if (statusCode >= 200 && statusCode < 300) {
      statusColor = Colors.green;
    } else if (statusCode >= 300 && statusCode < 400) {
      statusColor = Colors.blue;
    } else if (statusCode >= 400 && statusCode < 500) {
      statusColor = Colors.orange;
    } else if (statusCode >= 500 && statusCode < 600) {
      statusColor = Colors.red;
    } else {
      return const DotIndicatorWidget(
        dotColor: Colors.grey,
        dotSize: 8.0,
        animationDuration: Duration(milliseconds: 1000),
      );
    }

    return CustomText(
      statusCode.toString(),
      style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
    );
  }

  String _formatTime(DateTime time) {
    return '${_formatTimeUnit(time.hour)}:${_formatTimeUnit(time.minute)}:${_formatTimeUnit(time.second)}';
  }

  String _formatTimeUnit(int unit) {
    return unit.toString().padLeft(2, '0');
  }
}
