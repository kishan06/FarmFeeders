class Content {
  String image;
  String title;
  String description;
  String arrow;

  Content(
      {required this.image,
      required this.title,
      required this.description,
      required this.arrow});
}

List<Content> contents = [
  // Content(
  //     image: 'assets/images/Splashslider1.png',
  //     title: 'One Stop Solution \n For All Your Farm \nNeeds',
  //     description:
  //         "Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry.",
  //     arrow: 'assets/images/Splasharrowhalf.svg',
  //         ),
  Content(
    image: 'assets/images/Splashslider2.png',
    title: 'Feed Tracking \nAnd Inventory \nSolutions',
    description:
        "Unlock The Full Potential Of Your Animals With Accurate Feed Estimation!",
    arrow: 'assets/images/Splasharrowmed.svg',
  ),
  Content(
    image: 'assets/images/Splashslider3.png',
    title: 'Track Your Animals \nAnd Feed \nDeliveries',
    description:
        "Get Access To Real-Time Information On All Orders And Deliveries",
    arrow: 'assets/images/Splasharrowfull.svg',
  ),
];
