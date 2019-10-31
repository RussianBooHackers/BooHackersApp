part of api;

class BarApi {
  static Future<List<Bar>> all() async {
    List<Bar> items = [];
    await Api.dio.get("/bars").then((res) {
      items.addAll(
          List.from(res.data["bars"].map((item) => serializers.deserializeWith(Bar.serializer, item)).toList()));
    }, onError: (e) {});
    return items;
  }
}
