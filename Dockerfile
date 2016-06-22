FROM scratch
COPY simple-proxy /
ENTRYPOINT ["/simple-proxy"]
