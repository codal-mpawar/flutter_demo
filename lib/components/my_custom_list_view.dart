import 'dart:ffi';

import 'package:flutter/material.dart';
import 'my_custom_loader.dart';
import 'my_post_tile.dart';
import 'my_tile.dart';

class MyCustomListView extends StatefulWidget {
  const MyCustomListView(
      {super.key,
      required this.items,
      this.onEndReached,
      this.onTap,
      this.onPressIconButton,
      this.onRefresh,
      this.isMoreData,
      this.itemExtent});
  final List items;
  final VoidCallback? onEndReached;
  final Function? onTap;
  final Function? onPressIconButton;
  final VoidCallback? onRefresh;
  final bool? isMoreData;
  final double? itemExtent;
  @override
  State<MyCustomListView> createState() => _MyCustomListViewState();
}

class _MyCustomListViewState extends State<MyCustomListView> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _onEndReached();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _onEndReached() {
    widget.onEndReached!();
  }

  Future<void> onRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    widget.onRefresh!();
    return;
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.isMoreData!}');
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemExtent: widget.itemExtent,
        controller: _scrollController,
        itemCount: widget.items.isEmpty
            ? 0
            : widget.isMoreData! == false
                ? widget.items.length
                : widget.items.length + 1,
        itemBuilder: (context, index) {
          if (index == widget.items.length) {
            return const Loader();
          } else {
            final item = widget.items[index];
            if (item['first_name'].runtimeType == String) {
              return MyUserTile(
                onTap: () {
                  widget.onTap!(item);
                },
                onPressIconButton: () {
                  widget.onPressIconButton!(context, item);
                },
                user: item,
                isVisible: true,
              );
            }
            return MyPostTile(post: item);
          }
        },
      ),
    );
  }
}
