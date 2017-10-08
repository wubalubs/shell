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
	ca-certificates \
	--no-install-recommends

#ADD USER AND NECESSARY DIRS
RUN useradd wubalubs
RUN mkdir -p /home/wubalubs/projects/docker/
RUN mkdir -p /home/wubalubs/.oh-my-zsh/themes && chown /home/wubalubs/.oh-my-zsh
RUN chown -R wubalubs:users /home/wubalubs

#PULL ZSHRC FROM GIT && CP TO HOME
RUN cd /home/wubalubs/projects/docker && git clone http://github.com/wubalubs/dotfiles.git
RUN cp /home/wubalubs/projects/docker/dotfiles/zsh/.zshrc /home/wubalubs/.zshrc

#DO WE NEED TO RELOAD SHELL HERE?

RUN wget https://raw.githubusercontent.com/wubalubs/dotfiles/master/zsh/amuse.zsh-theme -O /home/wubalubs/.oh-my-zsh/themes/amuse.zsh-theme

#ZSH THINGS
#UPDATE SHELL IN ETC/PASSWD
#CMD [ "sed -ie 's@wubalubs:/bin/sh@wubalubs:/bin/zsh@g' /etc/passwd" ]
#
#Getting temp file error when attempting to update this after launching docker container
# " sed: couldn't open temporary file /etc/sedssJncq: Permission denied "
#
#JUST RUNNING /bin/zsh EXPLICITLY FOR NOW

USER wubalubs
#ZSH AND DOTFILES WORKING
#HOW DO WE UPDATE ROOT PW?

CMD ["/bin/zsh"]

