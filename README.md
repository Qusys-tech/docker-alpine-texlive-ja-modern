# Qusys/alpine-texlive-ja-modern

[![](https://images.microbadger.com/badges/image/qusys/alpine-texlive-ja-modern.svg)](https://microbadger.com/images/qusys/alpine-texlive-ja-modern "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/qusys/alpine-texlive-ja-modern.svg)](https://microbadger.com/images/qusys/alpine-texlive-ja-modern "Get your own version badge on microbadger.com")

> Modern TeX Live image for Japanese 
Forked from [paperist/alpine-texlive-ja](https://github.com/Paperist/docker-alpine-texlive-ja) \(under the MIT License\).


## Table of Contents

- [Qusys/alpine-texlive-ja-modern](#qusysalpine-texlive-ja-modern)
  - [Table of Contents](#table-of-contents)
  - [Install](#install)
  - [Usage](#usage)
  - [Contribute](#contribute)
  - [License](#license)

## Install

```bash
qusys/alpine-texlive-ja-modern
```

## Usage

You can use latexmk. This is a example which uses LuaLateX, BibTeX and index.
```bash
docker run --rm -it -v $PWD:/workdir qusys/alpine-texlive-ja-modern
latexmk \
-e '$latex=q/lualatex %O -synctex=1 -interaction=nonstopmode -file-line-error %S/' \
-e '$bibtex=q/upbibtex %O %B/' \
-e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' \
-e '$makeindex=q/upmendex %O -o %D %S/' \
-jobname=ci_output -norc -gg -pdfdvi paper.tex
```

## Contribute

PRs accepted.

## License

MIT © Qusys



