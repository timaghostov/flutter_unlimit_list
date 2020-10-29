



class StackState {
    bool _cardVisible;
    int _index;

    StackState() {
        _cardVisible = false;
        _index = 0;
    }

    void show( int index ) {
        _cardVisible = true;
        this._index = index;
    }

    void hide() {
        _cardVisible = false;
    }

    int get index => this._index;

    bool get isOpen => this._cardVisible;
}