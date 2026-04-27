FROM ubuntu:22.04 AS base

ARG GOCLAW_VERSION=v3.11.2

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists

RUN curl -fsSL \
    "https://github.com/nextlevelbuilder/goclaw/releases/download/${GOCLAW_VERSION}/goclaw-${GOCLAW_VERSION#v}-linux-amd64.tar.gz" \
    | tar xz -C /usr/local/bin goclaw \
    && chmod +x /usr/local/bin/goclaw

RUN useradd -r -s /bin/false -d /opt/goclaw goclaw \
    && mkdir -p /opt/goclaw/data /opt/goclaw/workspace /opt/goclaw/migrations \
    && chown -R goclaw:goclaw /opt/goclaw

WORKDIR /opt/goclaw
USER goclaw

EXPOSE 18790

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:18790/health || exit 1

ENTRYPOINT ["/usr/local/bin/goclaw"]
CMD ["--config", "/opt/goclaw/data/config.json"]
