library Utility;

const String databaseName = "AMADatabase.db";
const String customSessionBaseID = "__AMA_Custom_Session_";

const String aboutText = "Hello, and welcome to AMA, an agenda mobile app for the <Programming> 2020 conference, to be held in March 2020, in Porto. Here, you can schedule your activities and appointments so you can organize yourself better, and get the best out of the conference. Enjoy!";

const String noSessionsTitle = "This schedule has no sessions!";

const String noSessionsText = "Tap the ADD button in order to discover all the sessions available to you on this day! \n\nSwipe left on a session and click the green button to add it to the schedule, or click on the session to learn more about it.\n\nAlternatively, you can go to the \"Activity Creator\" menu in order to create your own custom sessions!";

const int scanTimeBLE = 5;
const int numMinutesForSessionBLE = 30;
const int namespaceBLE = 5555;

const int numMinutesForNotif = 10;

String sessionSearchAboutText = "Welcome to our Session Search feature, were you can discover all the exciting sessions around you, with just the tap of a button! Using Bluetooth Low Energy (BLE) beacons, we are able to tell you if there are any activities near you, that will start in under " + numMinutesForSessionBLE.toString() + " mins. Tap the \"scan\" button whenever you're ready!";

const String jsonURL = 'https://2019.programming-conference.org/dataexport/810b23a0-737b-4f74-9170-75d515274859/confero.json';

const urlPattern = r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";

const String BTAvailableText = "Bluetooth is available on this device!";
const String BTNotAvailableText = "Unfortunately, it seems like this device does not suport Bluetooth connection, so this functionality cannot be used. We are sorry.";
const String BTDisabledText = "The Bluetooth functionality of this device is turned off. In order to use the Session Search feature, please turn the Bluetooth on.";
const String BTEnabledText = "Bluetooth is turned on! Tap on the \"scan\" in order to commence Session Search.";

const String noInternetTitle = "No Internet Connection";
const String noInternetText = "Internet connection is needed for the first time you open the app. \n Please try again when you are connected to the internet.";
const String noInternetTextUpdate = "Internet connection is needed for updating the conference's information. \n Please try again when you are connected to the internet.";

const String noLocationsTitle = "No locations available";
const String noLocationsText = "Looks like there are no locations available... how strange!";

const String ademarPhoto = "https://scontent.fopo3-2.fna.fbcdn.net/v/t31.0-8/p960x960/11426751_10153406272449161_4609663974000048493_o.jpg?_nc_cat=107&_nc_ohc=KIJK7Wv7ARQAQn3gdPB6mHSsSXJoKpXgx06ZG6bDX_v7GWsBRL0xo2IDA&_nc_ht=scontent.fopo3-2.fna&oh=5cf02272c85240d3b5ca8495a0efe229&oe=5E856E71";
const String davidPhoto = "https://scontent.fopo3-2.fna.fbcdn.net/v/t1.0-9/p960x960/68643879_2440141056041424_3853270333838589952_o.jpg?_nc_cat=104&_nc_ohc=PlW0vYHOXG4AQmMgeKhpKq2Gbf1FCuf7vTFQ21urvF4NZ595FXWjTWCmg&_nc_ht=scontent.fopo3-2.fna&oh=90f4d8aebc41d1b6ad16c3c078bec219&oe=5E82AAFA";
const String eduPhoto = "https://scontent.fopo3-1.fna.fbcdn.net/v/t1.0-9/71500913_2470546719699845_1106906109760765952_n.jpg?_nc_cat=101&_nc_ohc=cSkydWkkirEAQmBbOiHzDJ5tzWWtEP6fy6FerLkvKjjBwYfydBT6pjbgg&_nc_ht=scontent.fopo3-1.fna&oh=d57bd403d073b173f3713dd256c7de5d&oe=5E4F8D77";
const String zePhoto = "https://scontent.fopo3-2.fna.fbcdn.net/v/t1.0-9/47345742_2261543377212598_5072022262480109568_n.jpg?_nc_cat=100&_nc_ohc=U6ah_n9QdxMAQnMfwaCgZTgFBLPr2x5wc5VWNKMOSSxX3CV3dSkHL6e5g&_nc_ht=scontent.fopo3-2.fna&oh=7f320037609bf7f3d04995eaf230f44c&oe=5E42AC42";
const String luisPhoto = "https://scontent.fopo3-2.fna.fbcdn.net/v/t1.0-9/27658102_1568590759883747_5712690656793015680_n.jpg?_nc_cat=109&_nc_ohc=pQS_2mlbj0cAQkxctpZyQjmE_InUGGWPICGUvle7jBdhxC72fi5EFqkkA&_nc_ht=scontent.fopo3-2.fna&oh=c6bd97d2264988418fd3aa97efaf6d5f&oe=5E4EA063";