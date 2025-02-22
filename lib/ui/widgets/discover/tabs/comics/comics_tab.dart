import 'package:d_reader_flutter/ui/shared/enums.dart';
import 'package:d_reader_flutter/ui/widgets/discover/common/discover_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:d_reader_flutter/core/providers/comic_provider.dart';

class DiscoverComicsTab extends StatelessWidget {
  const DiscoverComicsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DiscoverScrollView(
      listenableProvider: paginatedComicsProvider,
      scrollListType: ScrollListType.comicList,
    );
  }
}
