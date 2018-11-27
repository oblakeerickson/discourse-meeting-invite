import { acceptance } from "helpers/qunit-helpers";

acceptance("DiscourseMeetingInvite", { loggedIn: true });

test("DiscourseMeetingInvite works", async assert => {
  await visit("/admin/plugins/discourse-meeting-invite");

  assert.ok(false, "it shows the DiscourseMeetingInvite button");
});
