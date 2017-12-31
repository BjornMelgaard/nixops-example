Nix is not exporting libs, so you should `bundle isntall` in this env `nix-shell -p yajl pkgconfig libxml2`

`yajl` - is libyajl, `pkgconfig libxml - is for nokogiri`

P.S.
  https://github.com/NixOS/nix/issues/726#issuecomment-161215255
