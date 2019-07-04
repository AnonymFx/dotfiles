# Disable compression for makepkg (3x file size!)
In `/etc/makepkg.conf` change `PKGEXT='pkg.tar.xz` to `PKGEXT='pkg.tar'`

# Use faster gzip: pigz (parallel implementation of gzip)
- Install pigz via pacman
- In `/etc/makepkg.conf` change `PKGEXT` to `'pkg.tar.gz` and `COMPRESSGZ` to `(pigz -c -f -n)`
