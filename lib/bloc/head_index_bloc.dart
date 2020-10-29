

import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:unlimit_list/model/event/event.dart';
import 'package:unlimit_list/model/event/update_current_index.dart';
import 'package:unlimit_list/model/state/current_index.dart';
import 'package:unlimit_list/model/state/head_index_state.dart';


class HeadIndexStateBloc extends IsolateBloc<AppEvent, HeadIndexState> {

    HeadIndexStateBloc(): super( new HeadIndexState() );

    @override
    void onEventReceived(AppEvent event) {
        if ( event.etype == EventType.updateCurrentIndex ) {
            int index = ( event as UpdateCurrentIndex ).index;
            // print("onEventReceived event is UpdateCurrentIndex { $index }");
            state.setCurrentIndex( new CurrentIndex(index) );
            emit( state );
        }
    }

}