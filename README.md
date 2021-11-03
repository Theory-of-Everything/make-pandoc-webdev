# make-pandoc-webdev

This is my static stie generation workflow presented in one of my [youtube videos](https://youtu.be/VKbla_fkWxA)
This is mainly meant to be a template to be used in other projects, fell free to use whereever.

### Usage:
this is a tool meant to be used for you own sites! install it by doing
```bash
# clone repo and cd into it
git clone https://github.com/theory-of-everything/make-pandoc-webdev /path/to/your/site
cd /path/to/your/site

# remove git objects
sudo rm -r .git
```

You can build your markdown source files in `src/` by doing
```bash
make
```
Clean the build directory with
```bash
make clean
```
Test your curret build with
```bash
make test
```
Sync build with remote server (vars changed in makefile) with
```bash
make sync
```
