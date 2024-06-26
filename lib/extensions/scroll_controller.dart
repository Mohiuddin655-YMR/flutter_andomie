import 'package:flutter/material.dart';

typedef OnPagingListener = Function(dynamic value);

extension ScrollControllerExtension on ScrollController {
  ScrollController paging({
    required OnPagingListener onListen,
  }) {
    addListener(() {
      if (position.atEdge) {
        if (position.pixels != 0) {
          onListen.call(position.pixels);
        }
      }
    });
    return this;
  }
}
