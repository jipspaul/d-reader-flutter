import 'package:d_reader_flutter/core/models/comic.dart';
import 'package:d_reader_flutter/ui/shared/app_colors.dart';
import 'package:d_reader_flutter/ui/utils/screen_navigation.dart';
import 'package:d_reader_flutter/ui/views/comic_details.dart';
import 'package:d_reader_flutter/ui/widgets/common/cached_image_bg_placeholder.dart';
import 'package:d_reader_flutter/ui/widgets/common/description_text.dart';
import 'package:d_reader_flutter/ui/widgets/common/icons/favourite_icon_count.dart';
import 'package:d_reader_flutter/ui/widgets/common/icons/hot_icon.dart';
import 'package:d_reader_flutter/ui/widgets/genre/genre_tags_default.dart';
import 'package:flutter/material.dart';

class ComicCardLarge extends StatelessWidget {
  final ComicModel comic;
  const ComicCardLarge({
    super.key,
    required this.comic,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final nameCharacterLimit =
        MediaQuery.of(context).size.width > 360 ? 22 : 19;
    return GestureDetector(
      onTap: () {
        nextScreenPush(context, ComicDetails(slug: comic.slug));
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: CachedImageBgPlaceholder(
              imageUrl: comic.cover,
              cacheKey: comic.slug,
              height: 330,
              foregroundDecoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    ColorPalette.boxBackground200,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0, 2],
                ),
                borderRadius: BorderRadius.circular(
                  16,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 28,
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: comic.isCompleted
                                ? const Color(0xFFC6E7C1)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Center(
                            child: Text(
                              '${comic.stats?.issuesCount} EPs${comic.isCompleted ? ' - ENDED' : ''}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const HotIcon(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  comic.name.length > nameCharacterLimit
                                      ? '${comic.name.substring(0, nameCharacterLimit)}...'
                                      : comic.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.titleMedium
                                      ?.copyWith(fontSize: 24),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                comic.isVerified
                                    ? const Icon(
                                        Icons.verified,
                                        color: ColorPalette.dReaderYellow100,
                                        size: 20,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            FavouriteIconCount(
                              favouritesCount:
                                  comic.stats?.favouritesCount ?? 0,
                              isFavourite: comic.myStats?.isFavourite ?? false,
                              slug: comic.slug,
                            )
                          ],
                        ),
                        DescriptionText(
                          text: comic.description,
                          textAlign: TextAlign.start,
                        ),
                        GenreTagsDefault(genres: comic.genres),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
