# vim: set ft=make :

fedora_version := `rpm -E %fedora`

# Create an Alpine boxkit container
distrobox-boxkit:
  echo 'Creating Boxkit distrobox ...'
  distrobox-create --nvidia --image ghcr.io/ashylily/boxkit:latest -n boxkit -Y

# Create a Fedora container
distrobox-fedora:
  echo 'Creating Fedora distrobox ...'
  distrobox-create --nvidia --image ghcr.io/ashylily/fedora-distrobox:{{fedora_version}} -n fedora -Y