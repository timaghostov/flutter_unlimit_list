

import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:unlimit_list/service/constant.dart';
import 'package:unlimit_list/model/error.dart';
import 'package:unlimit_list/model/event/event.dart';
import 'package:unlimit_list/model/event/horizontal_item_builder.dart';
import 'package:unlimit_list/model/event/vertical_item_builder.dart';
import 'package:unlimit_list/model/indicator.dart';
import 'package:unlimit_list/model/state/list_state.dart';
import 'package:unlimit_list/service/util.dart';


class ListPersonBloc extends IsolateBloc<AppEvent, ListState> {

    LoadIndicator _loadIndicator;
    Error _error;

    ListPersonBloc(): super( new ListState() );

    @override
    void onEventReceived(AppEvent event) {
        if ( event.etype == EventType.loadNew ) {
            _hideIndicatorError();
            _showIndicator();
            // print("onEventReceived event is LoadNewPerson");
            loadNewPersons()
                .catchError(( error ) {
                    _hideIndicatorErrorShowError();
                })
                .then((persons) {
                    if ( persons != null ) {
                        _hideIndicatorError();
                        state.addPersonList(persons);
                        emit( state );
                    }
                });
        }
        if ( event.etype == EventType.verticalItemBuild ) {
            int index = ( event as VItemBuilder ).index + 1;
            // print("onEventReceived event is VItemBuilder :: { $index } :: ${state.size()}");
            executeNewRequest(index);
        }
        if ( event.etype == EventType.horizontalItemBuild ) {
            int index = ( event as HItemBuilder ).index + 1;
            // print("onEventReceived event is HItemBuilder :: { $index } :: ${state.size()}");
            executeNewRequest(index);
        }
    }

    void executeNewRequest( int index ) {
        if ( (index % REQUEST_LIMIT == 0) && ( index >= state.size() ) ) {//load more data
            if (_error != null) {
                _hideIndicatorErrorShowError();
            } else {
                _showIndicator();

                loadNewPersons()
                    .catchError(( error ) {
                        _hideIndicatorErrorShowError();
                    })
                    .then((persons) {
                        if ( persons != null ) {
                            _hideIndicatorError();
                            state.addPersonList(persons);
                            emit( state );
                        }
                    });
            }
        }
    }

    void _showIndicator() {
        _loadIndicator = new LoadIndicator();
        state.addLoadIndicator( _loadIndicator );
        emit( state );
    }

    // void _hideIndicator() {
    //     state.removeIndicator();
    //     _loadIndicator = null;
    //     emit( state );
    // }

    // void _showError() {
    //     _error = new Error();
    //     state.addError( _error );
    //     emit( state );
    // }

    // void _hideError() {
    //     state.removeError();
    //     _error = null;
    //     emit( state );
    // }

    void _hideIndicatorError() {
        state.removeIndicator();
        _loadIndicator = null;
        state.removeError();
        _error = null;
        emit( state );
    }

    void _hideIndicatorErrorShowError() {
        state.removeIndicator();
        _loadIndicator = null;
        state.removeError();
        _error = null;
        _error = new Error();
        state.addError( _error );
        emit( state );
    }
}