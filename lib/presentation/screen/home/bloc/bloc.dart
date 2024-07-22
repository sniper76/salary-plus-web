import 'package:act_web/config/constants.dart';
import 'package:act_web/core/extension/exception_extension.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/domain/usecase/post/get_post_list_previews.dart';
import 'package:act_web/presentation/base/base_state_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';
part 'bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPostListPreviews _getPostListPreviews = GetIt.I<GetPostListPreviews>();

  HomeBloc() : super(HomeState.initial()) {
    on<_OnInit>((event, emit) async {
      emit(state.copyWithNull(
        isLoading: true,
      ));

      Result<DataResponse<List<Post>>, Exception> postRes = await _getPostListPreviews(
        stockCode: AppConfig.globalBoardCode,
        boardGroupType: BoardGroupType.globalboard,
      );

      postRes.when(
        (DataResponse<List<Post>> postsData) {
          if (postsData.data?.isEmpty == true) {
            emit(state.copyWithNull(
              isLoading: false,
              errorToastMessage: '글이 없습니다.',
            ));

            return;
          } else {
            emit(state.copyWithNull(
              isLoading: false,
              globalBoardPosts: postsData.data!,
            ));
          }
        },
        (error) {
          emit(state.copyWithNull(
            isLoading: false,
            errorToastMessage: error.message,
          ));

          return;
        },
      );
    });
  }
}
