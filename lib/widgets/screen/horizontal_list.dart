

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:unlimit_list/bloc/data_list_bloc.dart';
import 'package:unlimit_list/bloc/head_index_bloc.dart';
import 'package:unlimit_list/bloc/stack_bloc.dart';
import 'package:unlimit_list/model/event/hide_person.dart';
import 'package:unlimit_list/model/event/horizontal_item_builder.dart';
import 'package:unlimit_list/model/event/update_current_index.dart';
import 'package:unlimit_list/model/state/head_index_state.dart';
import 'package:unlimit_list/model/state/list_state.dart';
import 'package:unlimit_list/model/state/stack_state.dart';
import 'package:unlimit_list/service/constant.dart';
import 'package:unlimit_list/widgets/head_index.dart';
import 'package:unlimit_list/widgets/horizontal_list_item.dart';


class HorizontalListPersonScreen extends StatefulWidget {

    final int index;

    _HorizontalListPersonScreenState _state;

    HorizontalListPersonScreen( this.index, {Key key} ) : super(key: key);

    _HorizontalListPersonScreenState get state => _state;

    @override
    _HorizontalListPersonScreenState createState() {
        _state = _HorizontalListPersonScreenState();
        return _state;
    }

}

class _HorizontalListPersonScreenState extends State<HorizontalListPersonScreen> {

    double _width;
    int _itemCount = 0;
    int _lastPosition = -1;
    ScrollController _controller;

    @override
    void initState() {
        super.initState();
        _controller = ScrollController();
        // _controller.addListener(_scrollListener);
    }

    void dispose(){
        _controller.dispose();
        super.dispose();
    }

    // _scrollListener() {

    // }

    jumpTo( int index ) {
        if ( _lastPosition != index ) {
            // print("HorizontalListPersonScreen jump to :: $index");
            if ( (_itemCount - index) < 2 ) {
                return;
            }
            _lastPosition = index;
            double cardWidth = _width * ( 1 + 3 * CARD_COEF_WIDTH ) * 0.25;
            double jumpPosition = index * cardWidth;
            // print("_jumpTo 1 :: $_width :: ${ ( _width * CARD_COEF_WIDTH ) }");
            // print("_jumpTo 2 :: $cardWidth");
            // print("_jumpTo 3 :: $index :: $_itemCount :: $jumpPosition");
            _controller.jumpTo( jumpPosition );
        }
    }

    _onScrollUpdate( double position, BuildContext context ) {
        double cardWidth = _width * ( 1 + 3 * CARD_COEF_WIDTH ) * 0.25;
        int index = (position / cardWidth).round();
        // print('_onScrollUpdate :: $position :: $index');
        SchedulerBinding.instance.addPostFrameCallback((_) {
            IsolateBlocProvider.of<HeadIndexStateBloc, HeadIndexState>(context)
                .add( UpdateCurrentIndex(index) );
        });
    }

    _onScrollEnd( double position, BuildContext context ) {
        double cardWidth = _width * ( 1 + 3 * CARD_COEF_WIDTH ) * 0.25;
        int index = (position / cardWidth).round();
        // print('_onScrollEnd :: $position :: $index');
        jumpTo(index);
        SchedulerBinding.instance.addPostFrameCallback((_) {
            IsolateBlocProvider.of<HeadIndexStateBloc, HeadIndexState>(context)
                .add( UpdateCurrentIndex(index) );
        });
    }

    @override
    Widget build(BuildContext context) {
        _width = MediaQuery.of(context).size.width;        
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: IsolateBlocBuilder<ListPersonBloc, ListState>(builder: (_, state) {
                _itemCount = state.size();
                double cardWidth = _width * ( 1 + 3 * CARD_COEF_WIDTH ) * 0.25;
                var cacheExtent = cardWidth * ( widget.index - 3 );
                cacheExtent = cacheExtent < 0 ? null : cacheExtent;
                // print("HorizontalListPersonScreen itemCount :: $_itemCount :: $cacheExtent");
                return Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                        title: HeadIndex(_itemCount),
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                        actions: [
                            Padding(
                                padding: EdgeInsets.only(right: 50.0),
                                child: InkWell(
                                    onTap: () {
                                        IsolateBlocProvider.of<StackBloc, StackState>(context)
                                            .add( HidePerson() );
                                    },
                                    child: Icon(
                                        Icons.close
                                    ),
                                ),
                            )
                        ],
                    ),
                    body: Container(
                        color: Colors.grey[600].withOpacity(0.5),
                        child: SizedBox(
                            child: NotificationListener(
                                onNotification: (notification) {
                                    if ( notification is ScrollEndNotification ) {
                                        _onScrollEnd(notification.metrics.pixels, context);
                                    }
                                    if ( notification is ScrollUpdateNotification ) {
                                        _onScrollUpdate(notification.metrics.pixels, context);
                                    }
                                },
                                child: ListView.builder(                                
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    controller: _controller,
                                    itemCount: _itemCount,
                                    // cacheExtent: cacheExtent,
                                    itemExtent: _width * ( 6 * CARD_COEF_WIDTH + 2 ) / 8,
                                    padding: EdgeInsets.only(
                                        left: 60,
                                        right: 60
                                    ),
                                    itemBuilder: (_, index) {
                                        return HorizontalItem (
                                            _width,
                                            onCreate: () {
                                                // print("HorizontalListPersonScreen onCreate :: $index");
                                                IsolateBlocProvider.of<ListPersonBloc, ListState>(context)
                                                    .add( HItemBuilder(index) );
                                            },
                                            index: index,
                                            itemData: state.item(index)
                                        );
                                    },
                                ),
                            ),
                        ),
                    ),
                );  
            })
        );
    }

}