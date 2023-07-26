import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ithome_reader/models/comment_list_item.dart';
import 'package:ithome_reader/widget/network_image.dart';

class CommentListTile extends StatelessWidget {
  const CommentListTile({
    super.key,
    required this.item,
    this.indentLevel = 0,
  });

  final CommentListItem item;
  final int indentLevel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16 + 8 * indentLevel.toDouble(),
        indentLevel == 0 ? 4 : 8,
        indentLevel == 0 ? 16 : 0,
        0,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 36,
                height: 36,
                child: CustomNetworkAvatar(url: item.userInfo.userAvatar),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item.userInfo.userNick,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.userInfo.level.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          item.floorStr,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Builder(
                        builder: (context) {
                          String commentStr = '';
                          for (CommentElement element in item.elements) {
                            commentStr += element.content;
                          }
                          return Text(commentStr);
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat('yyyy-MM-dd HH:mm:ss')
                              .format(item.postTime.toLocal()),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          item.support.toString(),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.green.shade400,
                                  ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.thumb_up_alt_outlined,
                          size: 16,
                          color: Colors.green.shade400,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.against.toString(),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.red.shade400,
                                  ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.thumb_down_alt_outlined,
                          size: 16,
                          color: Colors.red.shade400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          for (CommentListItem child in item.children)
            CommentListTile(
              item: child,
              indentLevel: indentLevel + 1,
            ),
        ],
      ),
    );
  }
}
