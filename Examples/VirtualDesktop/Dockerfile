FROM ubuntu:14.04
MAINTAINER Stefano Alberto Russo <stefano.russo@gmail.com>

# Update
RUN apt-get update

# Utilities
RUN apt-get install -y nano telnet unzip wget supervisor openssh-server

# Devel
RUN apt-get install -y build-essential python-dev git-core

# Java
RUN apt-get install -y openjdk-7-jre

# Generate missing US locale
RUN locale-gen en_US en_US.UTF-8

# No pass sudo
COPY sudoers /etc/sudoers

# Create base ubuntu user.
RUN useradd ubuntu -m -s /bin/bash # UID=1000

# Add user ubuntu to sudo
RUN adduser ubuntu sudo


# Install xvfb that triggers minimal install of X base packages and xterm as sample application
RUN apt-get install xvfb xterm  -y

# Install base packages for VNC server and headless desktop (2)
RUN cd /opt && wget https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.8.0.x86_64.tar.gz -O tigervnc-1.8.0.x86_64.tar.gz \
            && tar -zxvf tigervnc-1.8.0.x86_64.tar.gz \
            && mv tigervnc-1.8.0.x86_64 tigervnc

# Install Xfce (Forcing avoids problems like "10" owners/error: "shared/packages-wordlist doesn't exist")
RUN apt-get install --force-yes --no-install-recommends xfce4 xfce4-terminal mousepad ristretto tumbler gnome-icon-theme-full tango-icon-theme firefox -y

# Web VNC (noVNC) v0.6.1, thanks to Doro Wu (https://github.com/fcwu/docker-ubuntu-vnc-desktop/)
# TODO: this is a custom version from Doro Wu. Check differences and maybe move to 0.6.2
COPY noVNC.tar.gz /usr/lib/
RUN cd /usr/lib/ && tar -zxvf noVNC.tar.gz
COPY index.html /usr/lib/noVNC

# Supervisord configuration
COPY supervisord_vnc.conf /etc/supervisor/conf.d/
COPY run_vnc.sh /etc/supervisor/conf.d/
RUN chmod 755 /etc/supervisor/conf.d/run_vnc.sh

# X startup
COPY xstartup /opt/tigervnc/
RUN chmod 755 /opt/tigervnc/xstartup

# Remove xterm as it only create confusion in the menus..
RUN apt-get remove xterm -y

# Replace X startup with version that uses Xfce as Window Manager
COPY xstartup /opt/tigervnc/
RUN chmod 755 /opt/tigervnc/xstartup

# Default conf (mostly eyecandy)
COPY home_ubuntu_.config /home/ubuntu/.config
RUN chown -R ubuntu:ubuntu /home/ubuntu/.config

# Supervisord conf
COPY supervisord.conf /etc/supervisor/
COPY supervisord_webvnc.conf /etc/supervisor/conf.d/

# Expose VNC and Web VNC port
EXPOSE 5900 8590

# Set entrypoint
ENTRYPOINT ["/usr/bin/supervisord"]

