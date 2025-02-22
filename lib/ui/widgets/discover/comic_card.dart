import 'package:d_reader_flutter/core/models/comic.dart';
import 'package:d_reader_flutter/ui/shared/app_colors.dart';
import 'package:d_reader_flutter/ui/utils/screen_navigation.dart';
import 'package:d_reader_flutter/ui/views/comic_details.dart';
import 'package:d_reader_flutter/ui/widgets/common/author_verified.dart';
import 'package:d_reader_flutter/ui/widgets/common/cached_image_bg_placeholder.dart';
import 'package:d_reader_flutter/ui/widgets/common/figures/episode_circle.dart';
import 'package:d_reader_flutter/ui/widgets/common/figures/mature_audience.dart';
import 'package:d_reader_flutter/ui/widgets/common/icons/favourite_icon_count.dart';
import 'package:d_reader_flutter/ui/widgets/common/icons/rating_icon.dart';
import 'package:d_reader_flutter/ui/widgets/common/icons/viewed_icon_count.dart';
import 'package:d_reader_flutter/ui/widgets/genre/genre_tags.dart';
import 'package:flutter/material.dart';

class DiscoverComicCard extends StatelessWidget {
  final ComicModel comic;
  const DiscoverComicCard({
    Key? key,
    required this.comic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        nextScreenPush(context, ComicDetails(slug: comic.slug));
      },
      child: Container(
        height: 150,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: CachedImageBgPlaceholder(
                imageUrl: comic.cover,
                cacheKey: comic.slug,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EpisodeCircle(
                      text: '${comic.stats?.issuesCount} EPs',
                      color: comic.isCompleted
                          ? ColorPalette.dReaderGreen
                          : Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comic.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      AuthorVerified(
                        authorName: comic.creator.name,
                        isVerified: comic.creator.isVerified,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingIcon(
                            initialRating: comic.stats?.averageRating ?? 0,
                            comicSlug: comic.slug,
                            isRatedByMe: comic.myStats?.rating != null,
                          ),
                          FavouriteIconCount(
                            favouritesCount: comic.stats?.favouritesCount ?? 0,
                            isFavourite: comic.myStats?.isFavourite ?? false,
                            slug: comic.slug,
                          ),
                          ViewedIconCount(
                            viewedCount: comic.stats?.viewersCount ?? 0,
                            isViewed: comic.myStats?.viewedAt != null,
                          ),
                          comic.audienceType == AudienceType.Mature.name
                              ? const MatureAudience()
                              : const SizedBox(
                                  width: 22,
                                  height: 16,
                                ),
                        ],
                      ),
                      const Divider(
                        height: 2,
                        color: ColorPalette.boxBackground300,
                      ),
                    ],
                  ),
                  GenreTags(
                    genres: comic.genres,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
