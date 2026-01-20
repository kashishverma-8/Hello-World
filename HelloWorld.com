function sendSOS() {
  const status = document.getElementById("status");
  status.innerText = "Fetching location...";

  navigator.geolocation.getCurrentPosition(
    (position) => {
      const lat = position.coords.latitude;
      const lng = position.coords.longitude;

      const mapLink = `https://maps.google.com/?q=${lat},${lng}`;
      const message = `🚨 SOS ALERT 🚨\nI am in danger. Please help!\nMy location: ${mapLink}`;

      // WhatsApp redirect
      window.open(
        `https://wa.me/?text=${encodeURIComponent(message)}`,
        "_blank"
      );

      // Play alert sound
      const audio = new Audio(
        "https://actions.google.com/sounds/v1/alarms/alarm_clock.ogg"
      );
      audio.play();

      status.innerText = "SOS sent successfully!";
    },
    () => {
      status.innerText = "Location access denied!";
    }
  );
}
