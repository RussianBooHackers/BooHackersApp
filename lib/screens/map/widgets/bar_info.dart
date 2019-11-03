import 'package:auto_size_text/auto_size_text.dart';
import 'package:boohack/blocs/blocs.dart';
import 'package:boohack/models/models.dart';
import 'package:boohack/res/res.dart';
import 'package:boohack/res/text_style.dart';
import 'package:boohack/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class BarInfo extends StatelessWidget {
  const BarInfo({Key key, this.bar}) : super(key: key);
  final Bar bar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width - 8,
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * .8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  '${bar.name}',
                  maxFontSize: 16,
                  minFontSize: 14,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: ITTextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SmoothStarRating(
                    allowHalfRating: false,
                    starCount: 5,
                    rating: bar.marks.length == 0 ? 0 : bar.marks.reduce((a, b) => a + b) / bar.marks.length ?? 0,
                    size: 25.0,
                    color: ITColors.primary,
                    borderColor: ITColors.primary,
                    spacing: 5.0),
                GestureDetector(
                  onTap: () => DialogBloc.getInstance().dispatch(OpenDialogEvent(text: "оценить", confirm: () {})),
                  child: Text("Оценить", style: ITTextStyle(color: ITColors.secondaryText)),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bar.address, style: ITTextStyle(color: ITColors.secondaryText)),
              Text(calculateDistance(), style: ITTextStyle(color: ITColors.secondaryText)),
            ],
          ),
          Text('${bar.boohacksCount.toString()} бухаков было здесь', style: ITTextStyle(color: ITColors.secondaryText)),
        ],
      ),
    );
  }

  String calculateDistance() {
    double distance = Utils.calculateDistance(
        SelfBloc.getInstance()?.currentState?.position, LatLng(bar.location.latitude, bar.location.longitude));
    if (distance < 1)
      return '${(distance * 1000).floor().toString()} м от вас';
    else
      return '${distance.toStringAsFixed(2)} км от вас';
  }
}
