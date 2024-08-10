import 'dart:math';

import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';

abstract class PagingState {
  Paging get paging;
}

const maxPageSize = 7;
const maxPaginationWith = 700.0;
const minPaginationWith = 150.0;
const onePageItemWith = 100.0;

class ActPagination<B extends StateStreamable<S>, S extends PagingState> extends StatelessWidget {
  final Paging paging;

  final _numberPaginatorController = NumberPaginatorController();
  final Function(int page) onPageChange;

  ActPagination({
    super.key,
    required this.paging,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listenWhen: (previous, current) => previous.paging != current.paging,
      listener: (context, state) {
        if (_numberPaginatorController.currentPage != state.paging.page - 1) {
          _numberPaginatorController.currentPage = state.paging.page - 1;
        }
      },
      child: Center(
        child: SizedBox(
          width: getPaginationWidth(),
          child: NumberPaginator(
            key: Key(paging.toString()),
            controller: _numberPaginatorController,
            initialPage: paging.page - 1,
            numberPages: (paging.total / apiLoadSize).ceil(),
            onPageChange: (int index) => onPageChange(index + 1),
            config: const NumberPaginatorUIConfig(
              buttonSelectedBackgroundColor: Colors.transparent,
              buttonUnselectedBackgroundColor: Colors.transparent,
              buttonSelectedForegroundColor: Colors.black,
              buttonUnselectedForegroundColor: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  double getPaginationWidth() {
    final totalPages = paging.totalPage;

    if (totalPages > maxPageSize) {
      return maxPaginationWith;
    }

    return max(totalPages * onePageItemWith, minPaginationWith);
  }
}
