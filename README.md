nad_plugins
===========

Community-developed plugins for the Circonus Node Agent Daemon ("nad").  This repository borrows heavily from https://github.com/wanelo-chef/nad/tree/master/templates/default but aims for a broader audience and to be more Unix-y (the repo only handles nad plugins).  In theory, this repo could be included as a sub-module for any other repo that's involved in managing Circonus/NAD bits.

We are following the Chef/nad convention of one directory per platform for platform-specific plugins.  Cross-platform plugins can be placed in the root of this repo.

credits
===========

Credit due to @skingry, @sax, @richardiux, @meatballhat, @hjhart, @ohrite and others for much of the original work contained herein.
