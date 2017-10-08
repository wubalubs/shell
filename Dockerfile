FROM debian:stable-slim
LABEL maintainer "wubalubs wubalubs@gmail.com"

#APPS
RUN apt-get update && apt-get install -y \
	apt-transport-https \
	android-tools-adb \
	git \
	wget \
	nmap \
	zsh \
	nano \
	john \
	qpdf \ 
	ssh \
	hydra \
	ca-certificates \
--no-install-recommends

#ADD USER AND NECESSARY DIRS
RUN mkdir -p /PROJECTS/docker && mkdir -p /PROJECTS/git &&  mkdir -p /SHELL/.oh-my-zsh/themes && mkdir -p /VOL
RUN chown -R root:root /VOL && chown -R root:root /SHELL && chown -R root:root /PROJECTS

#PULL ZSHRC FROM GIT && CP TO HOME
RUN cd /PROJECTS/docker && git clone http://github.com/wubalubs/dotfiles.git
RUN cp /PROJECTS/docker/dotfiles/zsh/.zshrc /root/.zshrc

#DO WE NEED TO RELOAD SHELL HERE?

RUN wget https://raw.githubusercontent.com/wubalubs/dotfiles/master/zsh/amuse.zsh-theme -O /home/wubalubs/.oh-my-zsh/themes/amuse.zsh-theme

##
##ZSH THINGS
##UPDATE SHELL IN ETC/PASSWD
##CMD [ "sed -ie 's@wubalubs:/bin/sh@wubalubs:/bin/zsh@g' /etc/passwd" ]
##
##Getting temp file error when attempting to update this after launching docker container
## " sed: couldn't open temporary file /etc/sedssJncq: Permission denied "
##

USER root
##JUST RUNNING /bin/zsh EXPLICITLY FOR NOW

CMD ["/bin/zsh"]

