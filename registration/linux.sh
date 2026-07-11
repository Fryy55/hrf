#!/bin/bash


echo 'Setting up XDG MIME...'

mkdir -p $HOME/.local/share/mime/packages/

echo '<?xml version="1.0" encoding="utf-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
  <mime-type type="application/x.heart-rate-format-1">
    <comment>Heart Rate Format (HRF) v1 File</comment>
    <glob pattern="*.hrf" />
    <magic priority="80">
      <match type="string" offset="0" value="\x01HRF\x06\x07TR" />
    </magic>
    <icon name="media-floppy" />
    <generic-icon name="application-x-object" />
  </mime-type>
</mime-info>' > $HOME/.local/share/mime/packages/x.heart-rate-format.xml
update-mime-database $HOME/.local/share/mime

echo 'XDG MIME info set up'


if grep -q 'Heart Rate Format (HRF) v1 File' /etc/magic; then
	echo 'Magic number already registered'
else
	echo 'Registering magic number...'

	printf '\n0\tstring\t\\x01HRF\\x06\\x07TR\tHeart Rate Format (HRF) v1 File\n!:mime\tapplication/x.heart-rate-format-1\n' | sudo tee -a /etc/magic > /dev/null

	echo 'Magic number registered'
fi