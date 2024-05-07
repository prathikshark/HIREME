import consumer from "channels/consumer";

consumer.subscriptions.create("Noticed::BookingChannel", {
  connected() {
    console.log("Connected on Booking Channel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("Recied Message Through Action Cable 👇");
    console.log(data);
  },
});
