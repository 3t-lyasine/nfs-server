FROM ubuntu:bionic
MAINTAINER Yasine L <lyasine@3t-solutions.us>

SHELL ["/bin/bash", "-xo", "pipefail", "-c"]

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG C.UTF-8

RUN apt-get update \
    && apt-get install -y nfs-kernel-server

RUN mkdir -p /mnt/nfs_share
RUN chown -R nobody:nogroup /mnt/nfs_share/
RUN chmod 777 /mnt/nfs_share/
RUN echo '/mnt/nfs_share  *(rw,sync,no_subtree_check)' >> /etc/exports
RUN exportfs -a
RUN /etc/init.d/nfs-kernel-server restart