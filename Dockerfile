FROM ubuntu:latest

RUN apt-get update \
       && apt-get install -y --no-install-recommends \
       emacs-nox \
       texlive texlive-generic-recommended texlive-latex-extra texlive-science texlive-extra-utils \
       latexdiff latexmk ruby git

RUN git clone https://github.com/jagot/org-diff /org-diff
RUN cd /org-diff && gem build org-diff.gemspec && gem install org-diff

RUN useradd -m latexdiff

ADD .emacs.d/ /home/latexdiff/.emacs.d/
RUN chown -R latexdiff /home/latexdiff

USER latexdiff

RUN emacs --batch -l /home/latexdiff/.emacs.d/init.el
