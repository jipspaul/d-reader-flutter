import 'package:d_reader_flutter/ui/shared/app_colors.dart';
import 'package:d_reader_flutter/ui/widgets/common/figures/episode_circle.dart';
import 'package:d_reader_flutter/ui/widgets/common/solana_price.dart';
import 'package:flutter/material.dart';

class ComicIssueCard extends StatelessWidget {
  final String comicTitle;
  final String issueTitle;
  final String episode;
  final String cover;
  final String creatorName;
  final double? price;
  const ComicIssueCard({
    Key? key,
    required this.comicTitle,
    required this.issueTitle,
    required this.episode,
    required this.cover,
    required this.creatorName,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      width: 175,
      decoration: BoxDecoration(
        color: dReaderDarkGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 130,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                        // cover
                        'https://images.unsplash.com/photo-1539651044670-315229da9d2f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHN0cmVldHxlbnwwfHwwfHw%3D&w=1000&q=80'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(width: 1),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(
                      16,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 16,
                child: EpisodeCircle(text: 'EP $episode'),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(right: 4, left: 8, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comicTitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: dReaderYellow,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  issueTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      creatorName,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.verified,
                      color: dReaderYellow,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SolanaPrice(
                  price: price,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
