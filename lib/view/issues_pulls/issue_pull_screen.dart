import 'package:dio_hub/app/settings/palette.dart';
import 'package:dio_hub/common/issues/issue_label.dart';
import 'package:dio_hub/common/misc/app_bar.dart';
import 'package:dio_hub/common/misc/deep_link_widget.dart';
import 'package:dio_hub/common/misc/editable_text.dart';
import 'package:dio_hub/common/misc/loading_indicator.dart';
import 'package:dio_hub/common/misc/markdown_body.dart';
import 'package:dio_hub/common/misc/profile_banner.dart';
import 'package:dio_hub/common/wrappers/api_wrapper_widget.dart';
import 'package:dio_hub/common/wrappers/editing_wrapper.dart';
import 'package:dio_hub/controller/deep_linking_handler.dart';
import 'package:dio_hub/graphql/graphql.dart';
import 'package:dio_hub/routes/router.gr.dart';
import 'package:dio_hub/services/issues/issues_service.dart';
import 'package:dio_hub/utils/get_date.dart';
import 'package:dio_hub/utils/rich_text.dart';
import 'package:dio_hub/view/issues_pulls/issue_screen.dart';
import 'package:dio_hub/view/issues_pulls/pull_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

IssuePullScreenRoute issuePullScreenRoute(PathData path) {
  return IssuePullScreenRoute(
      ownerName: path.component(1)!,
      repoName: path.component(2)!,
      number: int.parse(path.component(4)!));
}

class IssuePullScreen extends DeepLinkWidget {
  const IssuePullScreen(
      {required this.number,
      required this.repoName,
      required this.ownerName,
      Key? key,
      this.commentsSince,
      this.initialIndex = 0})
      : super(key: key);
  final String repoName;
  final String ownerName;
  final int number;
  final DateTime? commentsSince;
  final int initialIndex;

  @override
  State<IssuePullScreen> createState() => _IssuePullScreenState();
}

class _IssuePullScreenState extends DeepLinkWidgetState<IssuePullScreen> {
  @override
  void handleDeepLink(PathData deepLinkData) {
    // TODO: implement handleDeepLink
  }

  @override
  Widget build(BuildContext context) {
    return APIWrapper<IssuePullInfo$Query$Repository$IssueOrPullRequest>(
      apiCall: () => IssuesService.getIssuePullInfo(widget.number,
          repo: widget.repoName, user: widget.ownerName),
      loadingBuilder: (context) => Scaffold(
        appBar: AppBar(),
        body: const LoadingIndicator(),
      ),
      responseBuilder: (context, data) {
        if (data is IssueInfoMixin) {
          return IssueScreen(data as IssueInfoMixin);
        } else if (data is PullInfoMixin) {
          return PullScreen(data as PullInfoMixin);
        } else {
          return Container();
        }
      },
    );
  }
}

class IssuePullInfoTemplate extends StatelessWidget {
  const IssuePullInfoTemplate(
      {Key? key,
      required this.number,
      required this.title,
      required this.repoInfo,
      required this.state,
      required this.body,
      required this.labels,
      required this.createdAt,
      required this.createdBy})
      : super(key: key);
  final int number;
  final String title;
  final String body;
  final RepoInfoMixin repoInfo;
  final IssuePullState state;
  final List<LabelMixin?>? labels;
  final DateTime createdAt;
  final ActorMixin createdBy;

  @override
  Widget build(BuildContext context) {
    return EditingWrapper(
      onSave: () {},
      builder: (context) => Scaffold(
        appBar: DHAppBar(
          hasEditableChildren: true,
          title: Row(
            children: [
              Icon(
                state.icon,
                color: state.color,
                size: 16,
              ),
              // const SizedBox(
              //   width: 8,
              // ),
              richText([
                TextSpan(text: ' #$number '),
                TextSpan(
                    text: repoInfo.name,
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: faded3(context))),
              ]),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Card(
                      color: state.color,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              state.icon,
                              size: 16,
                              // color: state.color,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(state.text),
                          ],
                        ),
                      ),
                    ),
                    const Text(' by '),
                    ProfileTile(
                      createdBy.avatarUrl.toString(),
                      userLogin: createdBy.login,
                      showName: true,
                      size: 16,
                    ),
                    Text(', ${getDate(createdAt.toString(), shorten: false)}'),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                EditableTextItem(
                  title,
                  onChange: (value) {},
                ),
                if (labels != null) ...[
                  const SizedBox(
                    height: 4,
                  ),
                  Wrap(
                    children: labels!
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: IssueLabel.gql(e!),
                            ))
                        .toList(),
                  ),
                ],
                const SizedBox(
                  height: 4,
                ),
                Card(
                  child: MarkdownBody(body),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IssuePullState {
  IssuePullState(this.state, {this.isDraft = false})
      : assert(state is PullRequestState || state is IssueState,
            'Not a valid state!');
  final dynamic state;
  final bool isDraft;

  IconData get icon {
    if (state == IssueState.open) {
      return Octicons.issue_opened;
    } else if (state == IssueState.closed) {
      return Octicons.issue_closed;
    } else if (state == PullRequestState.open ||
        state == PullRequestState.closed) {
      return Octicons.git_pull_request;
    } else if (state == PullRequestState.merged) {
      return Octicons.git_merge;
    } else {
      throw UnimplementedError();
    }
  }

  Color get color {
    if (state == IssueState.closed || state == PullRequestState.closed) {
      return Colors.red;
    } else if (isDraft) {
      return Colors.grey;
    } else if (state == IssueState.open || state == PullRequestState.open) {
      return Colors.green;
    } else if (state == PullRequestState.merged) {
      return Colors.deepPurple;
    } else {
      throw UnimplementedError();
    }
  }

  String get text {
    if (state == IssueState.closed || state == PullRequestState.closed) {
      return 'Closed';
    } else if (isDraft) {
      return 'Draft';
    } else if (state == IssueState.open || state == PullRequestState.open) {
      return 'Opened';
    } else if (state == PullRequestState.merged) {
      return 'Merged';
    } else {
      throw UnimplementedError();
    }
  }
}
