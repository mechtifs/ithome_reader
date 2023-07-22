import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ithome_reader/models/news_list_item.dart';
import 'package:ithome_reader/pages/news_detail_page.dart';

class NewsListTile extends StatelessWidget {
  const NewsListTile({
    super.key,
    required this.item,
  });

  final NewsListItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(28),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: SizedBox(
          height: 96,
          child: Row(
            children: [
              SizedBox(
                width: 128,
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    item.image,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                        DateFormat('yyyy-MM-dd HH:mm:ss')
                            .format(item.postdate.toLocal()),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              newsid: item.newsid,
              title: item.title,
              url: item.url,
            ),
          ),
        ),
      },
    );
  }
}
