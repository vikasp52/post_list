import 'package:benshi/repository/model/user.dart';
import 'package:benshi/screens/post_details/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthodData extends StatelessWidget {
  final User user;
  const AuthodData({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Author Details',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            UserCard(
              lable: user.name!,
              icon: Icons.person_pin,
            ),
            UserCard(
              lable: user.email!,
              icon: Icons.email,
              onTap: () async {
                final Uri _email = Uri(
                  scheme: 'mailto',
                  path: user.email,
                  query: 'Mail to benshi.ai',
                );

                if (await launchUrl(_email)) {
                  throw 'Could not launch $_email';
                }
              },
            ),
            UserCard(
              lable: user.website!,
              icon: Icons.web,
              onTap: () async {
                final Uri _website = Uri.parse(user.website!);
                if (await canLaunchUrl(_website)) {
                  throw 'Could not launch $_website';
                }
              },
            ),
            UserCard(
              lable: user.phone!,
              icon: Icons.phone,
              onTap: () async {
                final _phone = 'tel:${user.phone}';
                if (await launchUrl(Uri.parse(_phone))) {
                  throw 'Could not launch $_phone';
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              child: MapView(
                lat: user.address!.geo.lat ?? '',
                lng: user.address!.geo.lat ?? '',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
