document.addEventListener("DOMContentLoaded", function () {
  const player = document.getElementById("audio-player");
  const titleDisplay = document.getElementById("now-playing-title");
  const miniPlayer = document.getElementById("mini-audio-player");
  const miniTitleDisplay = document.getElementById("mini-now-playing");

  document.querySelectorAll(".play-button").forEach(button => {
    button.addEventListener("click", function () {
      const src = this.getAttribute("data-src");
      let title;

      // Get title from data attribute (preview) or DOM structure (full page)
      if (this.getAttribute("data-title")) {
        title = this.getAttribute("data-title");
      } else {
        title = this.closest(".music-item-list-item").querySelector("h2").innerText;
      }

      // Use mini player if available (homepage), otherwise use main player
      const activePlayer = miniPlayer || player;
      const activeTitleDisplay = miniTitleDisplay || titleDisplay;

      if (activePlayer && activeTitleDisplay) {
        activePlayer.querySelector("source").src = src;
        activePlayer.load();
        activePlayer.play();
        activeTitleDisplay.innerText = "Now Playing: " + title;
      }
    });
  });
});