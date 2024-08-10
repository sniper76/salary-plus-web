import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/section_carousel_item.dart';
import 'package:act_cms/presentation/widget/section_list_item.dart';
import 'package:flutter/material.dart';

class SectionCarouselView extends StatelessWidget {
  final List<SectionCarouselItem> carouselItems;

  const SectionCarouselView({super.key, this.carouselItems = const []});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 315,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: carouselItems.length,
            itemBuilder: (context, index) {
              final carouselItem = carouselItems[index];
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Container(
                  width: 280,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => context.openLink(carouselItem.header.link),
                        child: Container(
                          height: 82,
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 16, top: 44),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                carouselItem.header.imageUrl ?? '',
                              ),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.grey.shade900.withOpacity(0.3),
                                BlendMode.srcATop,
                              ),
                            ),
                          ),
                          child: Wrap(
                            spacing: 4,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                carouselItem.header.title,
                                style: context.textTheme.headlineMedium?.copyWith(color: Colors.white),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...carouselItem.listItems.map(
                        (e) => SectionListItem(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          sectionItem: e,
                          visibleViewCount: false,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 8);
            },
          ),
        ),
      ],
    );
  }
}
