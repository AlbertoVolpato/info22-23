import 'package:flutter/material.dart';
import 'package:client/common/utils.dart';

class AddPostGallery extends StatefulWidget {
  const AddPostGallery({super.key});
  @override
  _AddPostGallery createState() => _AddPostGallery();
}

class _AddPostGallery extends State<AddPostGallery> {
  final ScrollController _gridScrollController = ScrollController();
  final ScrollController _singleChildController = ScrollController();

  void _gridListener() {
    if (_gridScrollController.offset <
        _gridScrollController.position.minScrollExtent - 50) {
      _singleChildController.animateTo(_gridScrollController.offset,
          duration: Duration(milliseconds: 100), curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    _gridScrollController.addListener(_gridListener);
    _singleChildController.addListener(_gridListener);
    Size _screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: _screen.height,
        width: _screen.width,
        color: Color(0xFFEDF0F6),
        child: SingleChildScrollView(
          controller: _singleChildController,
          child: Column(
            children: <Widget>[
              Container(
                height: 410,
                color: Colors.green,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image(
                        image: NetworkImage(Utils.listOfImageUrl.elementAt(5)),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _circularStackButton(icon: Icons.expand, text: ''),
                            Container(
                              width: _screen.width / 1.6,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  _circularStackButton(
                                      icon: Icons.loop, text: ''),
                                  _circularStackButton(
                                      icon: Icons.auto_awesome_mosaic_outlined,
                                      text: ''),
                                  _circularStackButton(
                                      icon: Icons
                                          .check_box_outline_blank_outlined,
                                      text: 'SELECT MULTIPLE'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: _screen.height - 90,
                child: GridView.count(
                  controller: _gridScrollController,
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  children: List<Widget>.generate(
                      80,
                      (index) => Container(
                            height: 200,
                            width: 200,
                            child: Image(
                              image: NetworkImage(
                                  Utils.listOfImageUrl.elementAt(index)),
                              fit: BoxFit.cover,
                            ),
                          )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circularStackButton({
    required IconData icon,
    required String text,
  }) {
    if (text == null) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: Color.fromRGBO(81, 84, 86, 0.8),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(left: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 36,
      decoration: BoxDecoration(
        color: Color.fromRGBO(81, 84, 86, 0.8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
