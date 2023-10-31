# vim: set ft=make :

# Rebase to the Bluefin Developer Experience image
devmode-on:
  #!/usr/bin/env bash
  CURRENT_IMAGE=$(rpm-ostree status -b --json | jq -r '.deployments[0]."container-image-reference"')

  if grep -q "/var/ublue-os/image" <<< $CURRENT_IMAGE
  then
      echo ""
      echo "Before we can switch to the Bluefin Developer Experience"
      echo "the current system needs an update. Please run 'just update'"
      echo "and reboot your system when the update is finished."
      exit
  fi

  if grep -q "bluefin-dx" <<< $CURRENT_IMAGE
  then
      echo "You are already on a developer image"
  else
      echo "Rebasing to a developer image"
      NEW_IMAGE=$(echo $CURRENT_IMAGE | sed "s/bazzite-gnome/bluefin-dx/")
      rpm-ostree rebase $NEW_IMAGE
  fi
