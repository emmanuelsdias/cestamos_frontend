import 'dart:core';
import 'dart:math';
import '../../models/invitation.dart';

// import './base_urls_example.dart';
import './base_urls.dart';
import './request_factory.dart';
import '../../models/my_tuples.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvitationHttpRequestHelper {
  static const String baseBackEndInvitationUrl =
      "${BaseUrls.baseBackEndUrl}/invitation";

  static Future<Pair<List<Invitation>, bool>> getInvitations() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndInvitationUrl/?token=$token";
    var response = await RequestFactory.get(url);
    var invitationsData = response.listedContent;
    List<Invitation> invitation;
    if (response.success) {
      invitation = invitationsData.map((i) => Invitation.fromJson(i)).toList();
    } else {
      invitation = [];
    }
    return Pair(invitation, response.success);
  }

  static Future<Pair<Invitation, bool>> createInvitation(
    int userId,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndInvitationUrl/?token=$token";
    final body = {
      "user_id": userId,
    };
    var response = await RequestFactory.post(url, body);
    var invitationData = response.content;
    Invitation invitation;
    if (response.success) {
      invitation = Invitation.fromJson(invitationData);
    } else {
      invitation = Invitation();
    }
    return Pair(invitation, response.success);
  }

  static Future<Pair<Invitation, bool>> answerInvitation(
    int invitationId,
    bool accepted,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url =
        "$baseBackEndInvitationUrl/$invitationId?token=$token&accepted=$accepted";
    var response = await RequestFactory.delete(url, {});
    var invitationData = response.content;
    Invitation invitation;
    if (response.success) {
      invitation = Invitation.fromJson(invitationData);
    } else {
      invitation = Invitation();
    }
    return Pair(invitation, response.success);
  }
}
