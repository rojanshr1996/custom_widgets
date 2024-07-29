part of '../../custom_widgets.dart';

class CustomAlphabetScrollIndex extends StatefulWidget {
  /// items list of [AlphaModel] type in order to get the alphabets index list
  final List<AlphaModel> items;

  /// Creates a scrollable, linear array of widgets that are created on demand.
  ///
  /// This constructor is appropriate for list views with a large (or infinite)
  /// number of children because the builder is called only for those children
  /// that are actually visible.
  ///
  /// Providing a non-null `itemCount` improves the ability of the [ListView] to
  /// estimate the maximum scroll extent.
  ///
  /// The `itemBuilder` callback will be called only with indices greater than
  /// or equal to zero and less than `itemCount`.
  final IndexedWidgetBuilder itemBuilder;

  /// If non-null, forces the children to have the given extent in the scroll
  /// direction.
  ///
  /// Specifying an [itemHeight] is more efficient than letting the children
  /// determine their own extent because the scrolling machinery can make use of
  /// the foreknowledge of the children's extent to save work, for example when
  /// the scroll position changes drastically.
  final double itemHeight;

  /// Specifies the color of the alphabet which has been selected
  final Color selectedCharColor;

  /// The color to fill in the background of the box.
  final Color backgroundColor;

  /// The color to use when painting the text.
  final Color charColor;
  final ScrollController? scrollController;

  const CustomAlphabetScrollIndex(
      {super.key,
      required this.items,
      required this.itemHeight,
      required this.itemBuilder,
      required this.selectedCharColor,
      required this.backgroundColor,
      required this.charColor,
      this.scrollController});

  @override
  _CustomAlphabetScrollIndexState createState() =>
      _CustomAlphabetScrollIndexState();
}

class _CustomAlphabetScrollIndexState extends State<CustomAlphabetScrollIndex> {
  ScrollController _scrollController = ScrollController();
  final GlobalKey alphabetContainerKey = GlobalKey();
  String currentChar = "";
  String selectedChar = "";
  bool _visible = false;
  bool alphabetColorChange = false;

  @override
  void initState() {
    if (widget.scrollController == null) {
      _scrollController = widget.scrollController!;
    } else {
      _scrollController = ScrollController();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> getAlphabetsFromStringList(List<String> alphabeticOrder) {
    List<String> alphabets = [];
    alphabets = alphabeticOrder.map((data) => data[0]).toSet().toList();
    return alphabets;
  }

  Widget _getAlphabetItem(String alphabet) {
    return Expanded(
      child: Container(
        width: 35,
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: alphabet == "A" ? 4.0 : 0,
                bottom: alphabet == "Z" ? 4 : 0),
            child: Text(
              alphabet,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: selectedChar == alphabet
                    ? alphabetColorChange
                        ? widget.selectedCharColor
                        : widget.charColor
                    : widget.charColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _getAlphabetIndexFromDy(double dy, List<String> alphabets) {
    final alphabetContainer =
        alphabetContainerKey.currentContext?.findRenderObject() as RenderBox;
    final alphabetContainerHeight = alphabetContainer.size.height;
    final oneItemHeight = alphabetContainerHeight / alphabets.length;
    final index = (dy / oneItemHeight).floor();
    return index;
  }

  Map<String, int> _getAlphabetDyPositions(List items) {
    Map<String, int> alphabetDyPositions = {};
    for (var i = 0; i < items.length; i++) {
      final firstChar = items[i].toString()[0];
      if (!alphabetDyPositions.containsKey(firstChar)) {
        alphabetDyPositions[firstChar] = i;
      }
    }
    return alphabetDyPositions;
  }

  void _scrollToItems(String char, Map<String, int> alphabetDyPositions) {
    int indexToGo = 0;
    if (alphabetDyPositions.containsKey(char)) {
      indexToGo = alphabetDyPositions[char]!;
    }

    try {
      double dyToGo = double.parse(indexToGo.toString()) * widget.itemHeight;
      if (dyToGo >= _scrollController.position.maxScrollExtent) {
        dyToGo = _scrollController.position.maxScrollExtent;
      }
      setState(() {
        currentChar = char;
        alphabetColorChange = true;
        _visible = true;
      });

      _scrollController.animateTo(dyToGo,
          duration: const Duration(milliseconds: 400), curve: Curves.linear);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onVerticalDragStart(DragStartDetails details, List<String> alphabets,
      Map<String, int> alphabetDyPositions) {
    final index = _getAlphabetIndexFromDy(details.localPosition.dy, alphabets);
    final alphabet = alphabets[index];
    _scrollToItems(alphabet, alphabetDyPositions);
  }

  void _onVerticalDragUpdate(DragUpdateDetails details, List<String> alphabets,
      Map<String, int> alphabetDyPositions) {
    final index = _getAlphabetIndexFromDy(details.localPosition.dy, alphabets);
    final alphabet = alphabets[index];
    selectedChar = currentChar;
    _scrollToItems(alphabet, alphabetDyPositions);
    alphabetColorChange = true;
  }

  void _onTapDown(TapDownDetails details, List<String> alphabets,
      Map<String, int> alphabetDyPositions) {
    final index = _getAlphabetIndexFromDy(details.localPosition.dy, alphabets);
    final alphabet = alphabets[index];
    setState(() {
      selectedChar = currentChar;
    });
    _scrollToItems(alphabet, alphabetDyPositions);

    setState(() {
      _visible = true;
      alphabetColorChange = true;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        currentChar = "";
        alphabetColorChange = false;
        _visible = false;
      });
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        currentChar = "";
        alphabetColorChange = false;
        _visible = false;
      });
    });
  }

  Widget _itemsList(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 1, bottom: 16),
              controller: _scrollController,
              itemCount: widget.items.isEmpty ? 15 : widget.items.length,
              itemExtent: widget.itemHeight,
              itemBuilder: widget.itemBuilder),
        ),
        _alphabeticalIndex(context, widget.items)
      ],
    );
  }

  Widget _alphabeticalIndex(BuildContext context, List items) {
    items.map((e) {}).toList();
    List<String> alphabets = getAlphabetsFromStringList(items
        .map((item) =>
            item.key == "" ? "Unknown" : item.key.toString().toUpperCase())
        .toList());

    //get the list of names from the list of maps
    items = items
        .map((item) =>
            item.key == "" ? "Unknown" : item.key.toString().toUpperCase())
        .toList();
    alphabets = [
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "W",
      "X",
      "Y",
      "Z"
    ];
    Map<String, int> alphabetDyPositions = {};
    alphabetDyPositions = _getAlphabetDyPositions(items);

    return LayoutBuilder(
      builder: (context, constraint) {
        if (constraint.maxHeight < 350.0)
          return Container(); // alphabet list does not fit, might as well hide it
        return Padding(
          padding: Platform.isIOS
              ? const EdgeInsets.only(top: 16, bottom: 32)
              : const EdgeInsets.only(top: 16, bottom: 32),
          child: SizedBox(
            width: 25.0,
            key: alphabetContainerKey,
            child: GestureDetector(
              onVerticalDragUpdate: (DragUpdateDetails dragUpdateDetails) =>
                  _onVerticalDragUpdate(
                      dragUpdateDetails, alphabets, alphabetDyPositions),
              onVerticalDragStart: (DragStartDetails dragStartDetails) =>
                  _onVerticalDragStart(
                      dragStartDetails, alphabets, alphabetDyPositions),
              onVerticalDragEnd: _onVerticalDragEnd,
              onTapDown: (TapDownDetails dragStartDetails) => {
                _onTapDown(dragStartDetails, alphabets, alphabetDyPositions),
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ...List.generate(alphabets.length, (index) {
                    return _getAlphabetItem(alphabets[index]);
                  })
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _currentCharIndex(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Align(
        alignment: Alignment.center,
        child: currentChar == ""
            ? Container()
            : Container(
                height: 85,
                width: 85,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CustomColor.cPurple.withAlpha(170),
                ),
                child: Center(
                  child: Text(
                    currentChar,
                    style: const TextStyle(color: Colors.white, fontSize: 35.0),
                  ),
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _itemsList(context),
        _currentCharIndex(context),
      ],
    );
  }
}

class AlphaModel {
  final String key;
  final String? secondaryKey;
  AlphaModel(this.key, {this.secondaryKey});
}
