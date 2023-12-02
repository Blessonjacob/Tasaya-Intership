class Dashboard_model{
  int count;
  String text;

  Dashboard_model({
    required this.count,
    required this.text
});

  static List < Dashboard_model > getContent() {
    List < Dashboard_model > content = [];

    content.add(
        Dashboard_model(
          count: 10,
          text: "Assign to driver"
        )
    );content.add(
        Dashboard_model(
            count: 7,
            text: "Successfull Delivery"
        )
    );content.add(
        Dashboard_model(
          count: 3,
          text: "Out of Delivery"
        )
    );content.add(
        Dashboard_model(
          count: 26 ,
          text: "Kms Travelled"
        )
    );content.add(
        Dashboard_model(
          count: 15 ,
          text: "Hrs Served"
        )
    );
    return content;}


  }