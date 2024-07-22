import 'dart:math';

import 'package:act_web/data/response/paging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';

mixin PagingState {
  Paging get paging;
}

class ActPagination<B extends StateStreamable<S>, S extends PagingState> extends StatelessWidget {
  final Paging paging;

  final NumberPaginatorController _numberPaginatorController = NumberPaginatorController();
  final Function(int page) onChangePage;

  final int maxPageSize = 5;
  final double maxPaginationWith = 400.0;
  final double minPaginationWith = 200.0;
  final double onePageItemWith = 80.0;

  ActPagination({
    super.key,
    required this.paging,
    required this.onChangePage,
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
            numberPages: paging.totalPage,
            onPageChange: (int index) => onChangePage(index + 1),
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
    final int totalPage = paging.totalPage;

    if (totalPage > maxPageSize) {
      return maxPaginationWith;
    }

    return max(totalPage * onePageItemWith, minPaginationWith);
  }
}
