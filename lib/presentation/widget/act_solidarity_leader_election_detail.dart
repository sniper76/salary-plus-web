import 'package:act_cms/core/extension/color_extension.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/solidarity_election_result.dart';
import 'package:act_cms/domain/model/solidarity_leader_election_applicant.dart';
import 'package:act_cms/domain/model/solidarity_leader_election_candidate.dart';
import 'package:act_cms/domain/model/user_profile.dart';
import 'package:act_cms/presentation/widget/act_round_based_widget.dart';
import 'package:act_cms/presentation/widget/post_profile.dart';
import 'package:act_cms/presentation/widget/stock_count_label.dart';
import 'package:act_cms/presentation/widget/user_profile_image.dart';
import 'package:flutter/material.dart';

class ActDetailSolidarityLeaderElection extends StatefulWidget {
  final String boardGroupCategoryName;
  final String stockName;
  final String stockCode;
  final PostStatusType? status;
  final String postTitle;
  final UserProfile userProfile;
  final int userId;
  final DateTime postCreatedAt;
  final int postViewCount;
  final SolidarityElectionResult election;
  final Function(int) onShowSolidarityApplication;

  const ActDetailSolidarityLeaderElection({
    super.key,
    required this.boardGroupCategoryName,
    required this.stockName,
    required this.stockCode,
    this.status,
    required this.postTitle,
    required this.userProfile,
    required this.userId,
    required this.postCreatedAt,
    required this.postViewCount,
    required this.election,
    required this.onShowSolidarityApplication,
  });

  @override
  State<ActDetailSolidarityLeaderElection> createState() => _ActDetailPostState();
}

class _ActDetailPostState extends State<ActDetailSolidarityLeaderElection> {
  @override
  Widget build(BuildContext context) {
    return ActRoundBasedWidget(child: buildSolidarityLeaderElection(context));
  }

  Widget buildSolidarityLeaderElection(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            spacing: 8,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '[${widget.boardGroupCategoryName}]',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
              Text(
                widget.stockName,
                style: context.textTheme.headlineSmall,
              ),
              Text(
                widget.stockCode,
                style: context.textTheme.titleLarge?.copyWith(color: Colors.grey.shade300),
              ),
              if (widget.status != PostStatusType.active)
                Text(
                  '[${widget.status!.title}]',
                  style: context.textTheme.titleLarge?.copyWith(color: Colors.grey.shade500),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
          child: Text(widget.postTitle, style: context.textTheme.displaySmall),
        ),
        PostProfile(
          userProfile: widget.userProfile,
          stockCode: widget.stockCode,
          userId: widget.userId,
          dateTime: widget.postCreatedAt,
          viewCount: widget.postViewCount,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        Container(
          height: 1,
          color: context.colorScheme.outline,
        ),
        if (widget.election.winner?.nickname != null) ...[
          const SizedBox(height: 12.0),
          Text('주주대표 선출자: ${widget.election.winner!.nickname}',
              style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 8.0,
          )
        ],
        Text('주주대표 후보자 리스트', style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12.0),
        widget.election.applicants.isNotEmpty
            ? Column(
                children: widget.election.applicants
                    .map(
                      (SolidarityLeaderElectionCandidate candidate) => Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                UserProfileImage(
                                  url: candidate.profileImageUrl ?? '',
                                  size: 50.0,
                                ),
                                const SizedBox(width: 6.0),
                                Text(candidate.nickname),
                                const SizedBox(width: 6.0),
                                StockCountLabel(text: candidate.individualStockCountLabel),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                widget.onShowSolidarityApplication(candidate.solidarityApplicantId);
                              },
                              child: const Text('공약 보기'),
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
              )
            : const Text('지원한 후보자가 없습니다'),
        const SizedBox(height: 24.0),
        Text('주주대표 선출 투표', style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12.0),
        widget.election.electionDetail.pollApplicants.isNotEmpty
            ? Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '주주대표 선출',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${widget.election.electionDetail.totalVoterCount.toNumberFormat}명 참여',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    ...List.generate(
                      widget.election.electionDetail.pollApplicants.length,
                      (int applicantIndex) => _SolidarityElectionApplicantWidget(
                        applicant: widget.election.electionDetail.pollApplicants[applicantIndex],
                      ),
                    ),
                  ],
                ),
              )
            : const Text('진행중인 투표가 없습니다'),
      ],
    );
  }
}

class _SolidarityElectionApplicantWidget extends StatelessWidget {
  final SolidarityLeaderElectionApplicant applicant;

  const _SolidarityElectionApplicantWidget({
    required this.applicant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            applicant.nickname,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          ...List.generate(applicant.pollItemGroups.length, (int index) {
            final SolidarityLeaderElectionPollItem pollItem = applicant.pollItemGroups[index];
            final double votePercent =
                applicant.totalVoteStockQuantity == 0 ? 0 : pollItem.stockQuantity / applicant.totalVoteStockQuantity;

            return Container(
              margin: index != applicant.pollItemGroups.length - 1 ? null : const EdgeInsets.only(top: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pollItem.title,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${pollItem.stockQuantity.toNumberFormat}주(${(votePercent * 10000).floor() / 100}%)',
                              style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(4.0),
                          minHeight: 4,
                          value: votePercent,
                          color: context.colorScheme.primary,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '총 투표수 ${applicant.totalVoteStockQuantity.toNumberFormat}주',
                style: const TextStyle(fontSize: 12.0),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        applicant.resolutionCondition.label,
                        style: context.textTheme.labelMedium
                            ?.copyWith(color: HexColor.fromHex(applicant.resolutionCondition.color)),
                      ),
                      Text(
                        applicant.finishedEarlyCondition.label,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: HexColor.fromHex(applicant.finishedEarlyCondition.color),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 3.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${applicant.resolutionCondition.stockQuantity.toNumberFormat}${applicant.resolutionCondition.unit}',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: HexColor.fromHex(applicant.resolutionCondition.color),
                        ),
                      ),
                      Text(
                        '${applicant.finishedEarlyCondition.stockQuantity.toNumberFormat}${applicant.finishedEarlyCondition.unit}',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: HexColor.fromHex(applicant.finishedEarlyCondition.color),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
