import { ajax } from "discourse/lib/ajax";

export default {
  actions: {
    clickButton() {
      return ajax(`/discourse-meeting-invite/oauth2callback`, {
        type: "GET"
      })
        .then(result => {
          console.log(result);
        })
    }
  }
};
