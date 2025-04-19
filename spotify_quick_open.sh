#!/bin/bash

# === CONFIGURATION ===
PLAYLIST_URI="spotify:playlist:0Rf4qOQR1kwqB"  # Replace with your playlist URI

# === LAUNCH SPOTIFY ===
spotify & disown
echo "Launching Spotify..."

# === WAIT FOR SPOTIFY TO REGISTER WITH DBUS ===
echo "Waiting for Spotify to appear on DBus..."
while ! dbus-send --session --dest=org.freedesktop.DBus \
        --type=method_call --print-reply \
        /org/freedesktop/DBus org.freedesktop.DBus.NameHasOwner \
        string:'org.mpris.MediaPlayer2.spotify' | grep -q "true"; do
    sleep 0.5
done

# === PLAY THE PLAYLIST ===
echo "Spotify is ready. Playing playlist..."
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify \
  /org/mpris/MediaPlayer2 \
  org.mpris.MediaPlayer2.Player.OpenUri \
  string:"$PLAYLIST_URI"

#Minimizes Spotify
sleep 1

xdotool getactivewindow windowminimize


