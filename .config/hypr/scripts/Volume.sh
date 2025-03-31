#!/bin/bash

iDIR="$HOME/.config/swaync/icons"
sDIR="$HOME/.config/hypr/scripts"

# ID del dispositivo de audio
SINK="@DEFAULT_AUDIO_SINK@"
SOURCE="@DEFAULT_AUDIO_SOURCE@"

# Obtener volumen de salida
get_volume() {
  volume=$(wpctl get-volume "$SINK" | awk '{print int($2 * 100)}')
  muted=$(wpctl get-mute "$SINK" | awk '{print $2}')
  if [[ "$muted" == "yes" ]]; then
    echo "Muted"
  else
    echo "$volume %"
  fi
}

# Obtener icono de volumen
get_icon() {
  current=$(get_volume)
  if [[ "$current" == "Muted" ]]; then
    echo "$iDIR/volume-mute.png"
  elif [[ "${current%\%}" -le 30 ]]; then
    echo "$iDIR/volume-low.png"
  elif [[ "${current%\%}" -le 60 ]]; then
    echo "$iDIR/volume-mid.png"
  else
    echo "$iDIR/volume-high.png"
  fi
}

# Notificación de volumen
notify_user() {
  if [[ "$(get_volume)" == "Muted" ]]; then
    notify-send -e -h string:x-canonical-private-synchronous:volume_notif -u low -i "$(get_icon)" " Volume:" " Muted"
  else
    notify-send -e -h int:value:"$(get_volume | sed 's/%//')" -h string:x-canonical-private-synchronous:volume_notif -u low -i "$(get_icon)" " Volume Level:" " $(get_volume)" &&
      "$sDIR/Sounds.sh" --volume
  fi
}

# Aumentar volumen
inc_volume() {
  wpctl set-volume "$SINK" 5%+
  volume=$(wpctl get-volume "$SINK" | awk '{print $2}')
  if (($(echo "$volume > 1.0" | bc -l))); then
    wpctl set-volume "$SINK" 1.0
  fi
  notify_user
}

# Disminuir volumen
dec_volume() {
  wpctl set-volume "$SINK" 5%- && notify_user
}

# Alternar mute
toggle_mute() {
  wpctl set-mute "$SINK" toggle
  notify_user
}

# Alternar mute del micrófono
toggle_mic() {
  wpctl set-mute "$SOURCE" toggle
  notify_mic_user
}

# Obtener volumen del micrófono
get_mic_volume() {
  volume=$(wpctl get-volume "$SOURCE" | awk '{print int($2 * 100)}')
  muted=$(wpctl get-mute "$SOURCE" | awk '{print $2}')
  if [[ "$muted" == "yes" ]]; then
    echo "Muted"
  else
    echo "$volume %"
  fi
}

# Obtener icono del micrófono
get_mic_icon() {
  muted=$(wpctl get-mute "$SOURCE" | awk '{print $2}')
  if [[ "$muted" == "yes" ]]; then
    echo "$iDIR/microphone-mute.png"
  else
    echo "$iDIR/microphone.png"
  fi
}

# Notificación del micrófono
notify_mic_user() {
  volume=$(get_mic_volume)
  icon=$(get_mic_icon)
  notify-send -e -h int:value:"$volume" -h "string:x-canonical-private-synchronous:volume_notif" -u low -i "$icon" " Mic Level:" " $volume"
}

# Aumentar volumen del micrófono
inc_mic_volume() {
  wpctl set-volume "$SOURCE" 5%+ && notify_mic_user
}

# Disminuir volumen del micrófono
dec_mic_volume() {
  wpctl set-volume "$SOURCE" 5%- && notify_mic_user
}

# Ejecutar función según argumento
case "$1" in
--get) get_volume ;;
--inc) inc_volume ;;
--dec) dec_volume ;;
--toggle) toggle_mute ;;
--toggle-mic) toggle_mic ;;
--get-icon) get_icon ;;
--get-mic-icon) get_mic_icon ;;
--mic-inc) inc_mic_volume ;;
--mic-dec) dec_mic_volume ;;
*) get_volume ;;
esac
