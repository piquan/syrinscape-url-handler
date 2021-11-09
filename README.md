Syrinscape URI Handler
Copyright 2021 Joel Ray Holveck

This utility will send `syrinscape-fantasy://` and `syrinscape-sci-fi://` URLs as commands to the Syrinscape Sci-Fi Player.  All you should need to do is just install it (using your package manager or `sudo make install`).

This program is not a product of Syrinscape.  It is my own work.  Do not blame them if it doesn’t work.

To test it, you can try `xdg-open syrinscape-sci-fi:///stop-all/`, or point your web browser at that URL.  To see debug messages, try running `/usr/local/libexec/syrinscape-uri-handler/syrinscape-uri-handler syrinscape-sci-fi:///stop-all/`.
