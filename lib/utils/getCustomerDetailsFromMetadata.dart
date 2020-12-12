import 'dart:convert';

import 'package:http/http.dart';
import '../models/models.dart';

Future<PapercupsCustomer> getCustomerDetailsFromMetadata(
  Props p,
  PapercupsCustomer c,
  Function sc,
) async {
  var res = await get(
    Uri.https(
      p.baseUrl,
      "/api/customers/identify",
      {
        "external_id": p.customer.externalId,
        "account_id": p.accountId,
      },
    ),
  );
  var data = jsonDecode(res.body)["data"];
  c = PapercupsCustomer(
    id: data["customer_id"],
    externalId: c == null ? null : c.externalId,
    email: c == null ? null : c.email,
    createdAt: c == null ? null : c.createdAt,
    firstSeen: c == null ? null : c.firstSeen,
    lastSeen: c == null ? null : c.lastSeen,
    name: c == null ? null : c.name,
    phone: c == null ? null : c.phone,
    updatedAt: c == null ? null : c.updatedAt,
  );
  sc(c);
  return c;
}