// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_datasource.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _ApiDataSource implements ApiDataSource {
  _ApiDataSource(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<DataResponse<List<BaseStock>>> getCommonStocks() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<List<BaseStock>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/commons/stocks',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<List<BaseStock>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<BaseStock>(
                  (i) => BaseStock.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return _value;
  }

  @override
  Future<void> postStockSearchTrend(String stockCode) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'stockCode': stockCode};
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/stock-search-trends',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<DataResponse<UploadImageFile>> uploadImage(
    String contentType,
    FormData file,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Content-Type': contentType};
    _headers.removeWhere((k, v) => v == null);
    final _data = file;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<UploadImageFile>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: contentType,
    )
            .compose(
              _dio.options,
              '/images',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<UploadImageFile>.fromJson(
      _result.data!,
      (json) => UploadImageFile.fromJson(json as Map<String, dynamic>),
    );
    return _value;
  }

  @override
  Future<WebVerification> createWebVerification(
      Map<String, dynamic> data) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<WebVerification>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/auth/web/generate-verification-code',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = WebVerification.fromJson(_result.data!);
    return _value;
  }

  @override
  Future<SucceededWebVerification> verifyWebVerification(
      Map<String, dynamic> data) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SucceededWebVerification>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/auth/web/verify-verification-code',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = SucceededWebVerification.fromJson(_result.data!);
    return _value;
  }

  @override
  Future<DataResponse<User>> fetchUserMe() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DataResponse<User>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/users/me',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<User>.fromJson(
      _result.data!,
      (json) => User.fromJson(json as Map<String, dynamic>),
    );
    return _value;
  }

  @override
  Future<DataResponse<AnonymousWriteCount>> getAnonymousWriteCount() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<AnonymousWriteCount>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/users/anonymousCount',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<AnonymousWriteCount>.fromJson(
      _result.data!,
      (json) => AnonymousWriteCount.fromJson(json as Map<String, dynamic>),
    );
    return _value;
  }

  @override
  Future<void> blockUser(Map<String, dynamic> data) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/users/me/blocked-users',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<DataResponse<List<Post>>> getPostList(
    String stockCode,
    String boardGroup,
    String? boardCategory,
    String? boardCategories,
    int page,
    int size,
    String? sorts,
    bool? isExclusiveToHolders,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'boardCategory': boardCategory,
      r'boardCategories': boardCategories,
      r'page': page,
      r'size': size,
      r'sorts': sorts,
      r'isExclusiveToHolders': isExclusiveToHolders,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<List<Post>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroup}/posts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<List<Post>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<Post>((i) => Post.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return _value;
  }

  @override
  Future<DataResponse<List<Post>>> getPostListPreviews(
    String stockCode,
    String boardGroup,
    String? boardCategory,
    String? boardCategories,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'boardCategory': boardCategory,
      r'boardCategories': boardCategories,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<List<Post>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroup}/posts/previews',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<List<Post>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<Post>((i) => Post.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return _value;
  }

  @override
  Future<DataResponse<Post>> getPostDetail(
    String stockCode,
    String boardGroup,
    int postId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DataResponse<Post>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<Post>.fromJson(
      _result.data!,
      (json) => Post.fromJson(json as Map<String, dynamic>),
    );
    return _value;
  }

  @override
  Future<DataResponse<Post>> createPost(
    String stockCode,
    String boardGroup,
    Map<String, dynamic> data,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DataResponse<Post>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroup}/posts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<Post>.fromJson(
      _result.data!,
      (json) => Post.fromJson(json as Map<String, dynamic>),
    );
    return _value;
  }

  @override
  Future<DataResponse<Post>> updatePost(
    String stockCode,
    String boardGroup,
    int postId,
    Map<String, dynamic> data,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DataResponse<Post>>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<Post>.fromJson(
      _result.data!,
      (json) => Post.fromJson(json as Map<String, dynamic>),
    );
    return _value;
  }

  @override
  Future<void> deletePost(
    String stockCode,
    String boardGroup,
    int postId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<void> reportPost(
    String stockCode,
    String boardGroup,
    int postId,
    Map<String, dynamic> data,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/reports',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<DataResponse<Post>> likePost(
    String stockCode,
    String boardGroup,
    int postId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DataResponse<Post>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/likes',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<Post>.fromJson(
      _result.data!,
      (json) => Post.fromJson(json as Map<String, dynamic>),
    );
    return _value;
  }

  @override
  Future<DataResponse<Post>> unlikePost(
    String stockCode,
    String boardGroup,
    int postId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DataResponse<Post>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/likes',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<Post>.fromJson(
      _result.data!,
      (json) => Post.fromJson(json as Map<String, dynamic>),
    );
    return _value;
  }

  @override
  Future<void> createAnswerOnPostPoll(
    String stockCode,
    String boardGroup,
    int postId,
    int pollId,
    Map<String, dynamic> data,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/polls/${pollId}/answers',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<void> updateAnswerOnPostPoll(
    String stockCode,
    String boardGroup,
    int postId,
    int pollId,
    Map<String, dynamic> data,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/polls/${pollId}/answers',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<DataResponse<List<Comment>>> getCommentList(
    String stockCode,
    String boardGroup,
    int postId,
    int page,
    int size,
    String? sorts,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'size': size,
      r'sorts': sorts,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<List<Comment>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/comments',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<List<Comment>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<Comment>((i) => Comment.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return _value;
  }

  @override
  Future<DataResponse<Comment>> createComment(
    String stockCode,
    String boardGroup,
    int postId,
    Map<String, dynamic> data,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<Comment>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/comments',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<Comment>.fromJson(
      _result.data!,
      (json) => Comment.fromJson(json as Map<String, dynamic>),
    );
    return _value;
  }

  @override
  Future<DataResponse<Comment>> updateComment(
    String stockCode,
    String boardGroup,
    int postId,
    int commentId,
    Map<String, dynamic> data,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<Comment>>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/comments/${commentId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<Comment>.fromJson(
      _result.data!,
      (json) => Comment.fromJson(json as Map<String, dynamic>),
    );
    return _value;
  }

  @override
  Future<void> deleteComment(
    String stockCode,
    String boardGroup,
    int postId,
    int commentId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/comments/${commentId}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<void> likeComment(
    String stockCode,
    String boardGroup,
    int postId,
    int commentId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/comments/${commentId}/likes',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<void> reportComment(
    String stockCode,
    String boardGroup,
    int postId,
    int commentId,
    Map<String, dynamic> data,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/comments/${commentId}/reports',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<void> unlikeComment(
    String stockCode,
    String boardGroup,
    int postId,
    int commentId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/comments/${commentId}/likes',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<DataResponse<List<Comment>>> getReplyList(
    String stockCode,
    String boardGroup,
    int postId,
    int commentId,
    int page,
    int size,
    String? sorts,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'size': size,
      r'sorts': sorts,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<List<Comment>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/comments/${commentId}/replies',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<List<Comment>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<Comment>((i) => Comment.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return _value;
  }

  @override
  Future<DataResponse<Comment>> createReply(
    String stockCode,
    String boardGroup,
    int postId,
    int commentId,
    Map<String, dynamic> data,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<Comment>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/comments/${commentId}/replies',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<Comment>.fromJson(
      _result.data!,
      (json) => Comment.fromJson(json as Map<String, dynamic>),
    );
    return _value;
  }

  @override
  Future<DigitalProxyUrl> getPostDigitalProxyEmbeddedUrl(
    String stockCode,
    String boardGroup,
    int postId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DigitalProxyUrl>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroup}/posts/${postId}/digital-proxy',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DigitalProxyUrl.fromJson(_result.data!);
    return _value;
  }

  @override
  Future<DataResponse<Post>> saveHolderListReadAndCopyPost(
    String stockCode,
    String boardGroupName,
    String? createPostRequest,
    File signImage,
    List<File>? idCardImage,
    List<File>? bankAccountImages,
    List<File>? hectoEncryptedBankAccountPdf,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (createPostRequest != null) {
      _data.fields.add(MapEntry(
        'createPostRequest',
        createPostRequest,
      ));
    }
    _data.files.add(MapEntry(
      'signImage',
      MultipartFile.fromFileSync(
        signImage.path,
        filename: 'user_sign.jpg',
        contentType: MediaType.parse('image/jpeg'),
      ),
    ));
    if (idCardImage != null) {
      _data.files.addAll(idCardImage.map((i) => MapEntry(
          'idCardImage',
          MultipartFile.fromFileSync(
            i.path,
            filename: i.path.split(Platform.pathSeparator).last,
            contentType: MediaType.parse('image/jpeg'),
          ))));
    }
    if (bankAccountImages != null) {
      _data.files.addAll(bankAccountImages.map((i) => MapEntry(
          'bankAccountImages',
          MultipartFile.fromFileSync(
            i.path,
            filename: i.path.split(Platform.pathSeparator).last,
            contentType: MediaType.parse('image/jpeg'),
          ))));
    }
    if (hectoEncryptedBankAccountPdf != null) {
      _data.files.addAll(hectoEncryptedBankAccountPdf.map((i) => MapEntry(
          'hectoEncryptedBankAccountPdf',
          MultipartFile.fromFileSync(
            i.path,
            filename: i.path.split(Platform.pathSeparator).last,
            contentType: MediaType.parse('text/plain'),
          ))));
    }
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DataResponse<Post>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroupName}/posts/holder-list-read-and-copy',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<Post>.fromJson(
      _result.data!,
      (json) => Post.fromJson(json as Map<String, dynamic>),
    );
    return _value;
  }

  @override
  Future<DataResponse<List<BoardGroupCategory>>> getBoardGroupCategories(
    String stockCode,
    String boardGroup,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<List<BoardGroupCategory>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/board-groups/${boardGroup}/categories',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<List<BoardGroupCategory>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<BoardGroupCategory>(
                  (i) => BoardGroupCategory.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return _value;
  }

  @override
  Future<DataResponse<List<RankingStock>>> getRankingStockList(
    String sorts,
    int size,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sorts': sorts,
      r'size': size,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<List<RankingStock>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stock-rankings',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<List<RankingStock>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<RankingStock>(
                  (i) => RankingStock.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return _value;
  }

  @override
  Future<DataResponse<List<SearchRanking>>> getSearchRankingList() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<List<SearchRanking>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/search-recommendations',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<List<SearchRanking>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<SearchRanking>(
                  (i) => SearchRanking.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return _value;
  }

  @override
  Future<StockHome> getStockHome(String stockCode) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<StockHome>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stocks/${stockCode}/home',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = StockHome.fromJson(_result.data!);
    return _value;
  }

  @override
  Future<void> updateSolidarityLeaderMessage(
    String stockCode,
    int solidarityId,
    Map<String, dynamic> data,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/stocks/${stockCode}/solidarity/${solidarityId}/leader/message',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<DataResponse<List<Solidarity>>> getPagedMySolidarityList(
    int page,
    int size,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'size': size,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<List<Solidarity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/home/my-solidarity',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<List<Solidarity>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<Solidarity>(
                  (i) => Solidarity.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return _value;
  }

  @override
  Future<DataResponse<List<Solidarity>>> getWholeMySolidarityList(
      int page) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<List<Solidarity>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/home/my-solidarity',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<List<Solidarity>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<Solidarity>(
                  (i) => Solidarity.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return _value;
  }

  @override
  Future<DataResponse<List<Solidarity>>> updateMySolidarityDisplayOrder(
      Map<String, dynamic> data) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DataResponse<List<Solidarity>>>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/home/my-solidarity',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DataResponse<List<Solidarity>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<Solidarity>(
                  (i) => Solidarity.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
