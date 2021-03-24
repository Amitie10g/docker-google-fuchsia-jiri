FROM ubuntu:latest

# Install the required packages
RUN apt-get update && \
    apt-get -y --no-install-recommends install \
        curl \
        git \
        ca-certificates \
        unzip \
        ccache \
        binutils \
		openssh-client \
        eject \
        python3 \
        sudo && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    bash -o pipefail -c "curl -s 'https://fuchsia.googlesource.com/jiri/+/HEAD/scripts/bootstrap_jiri?format=TEXT' | base64 --decode | bash -s /tmp" && \
    mv /tmp/.jiri_root/bin/* /usr/local/bin && \
    rm -fr /tmp/.jiri_root && \
	addgroup --system --gid 1000 fuchsia && \
	adduser --system --home /fuchsia --no-create-home --uid 1000 --gid 1000 --disabled-password --disabled-login fuchsia

# Set default environment variables
ENV PRODUCT="workstation" \
    BOARD="x64" \
    BUNDLE="//bundles:tools" \
    FUCHSIA_ROOT="/fuchsia" \
    DEBUG="false"

# Copy the entrypoint script
COPY entrypoint /usr/local/bin/entrypoint

# Default command line: interactive shell
WORKDIR /fuchsia
ENTRYPOINT ["entrypoint"]
CMD ["shell"]