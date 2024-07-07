class SplashScreenContent {
  String image;
  String title;
  String discription;

  SplashScreenContent({ required this.image, required this.title, required this.discription});
}

List<SplashScreenContent> contents = [
  SplashScreenContent(
      title: '100% Safe and Secured',
      image: 'assets/images/safe.svg',
      discription: "Surf the web without fear! Our VPN provides robust encryption to guarantee your online presence. Protect your data against snoopers and hackers. Experience absolute online freedom in a secure environment"
  ),
  SplashScreenContent(
      title: 'Upto 3 Times Faster',
      image: 'assets/images/fastloading.svg',
      discription: "Download, stream, and surf with breakneck speed! Our VPN accelerates your connection, resulting in fluid online experiences. Enjoy hassle-free, speedier browsing, smoother streaming, and faster downloads "
  ),
  SplashScreenContent(
      title: 'High Speed Server',
      image: 'assets/images/speed.svg',
      discription: "Unleash the power of high-speed servers! Access content worldwide with minimal buffering. Our vast server network ensures swift connections, offering you a seamless browsing experience wherever you go. Stay speedy, stay connected."
  ),
];