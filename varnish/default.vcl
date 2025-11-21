vcl 4.1;

# Define the backend (Caddy)
backend default {
    .host = "caddy";  # This matches the service name in compose.yml
    .port = "80";     # Caddy listens on port 80 inside the container
}

sub vcl_recv {
    # Happens when a request is received
    # Setup logic here (e.g., bypass cache for specific URLs)
}

sub vcl_backend_response {
    # Happens after we get a response from Caddy, before caching it
    # You can set the Time To Live (TTL) here
    set beresp.ttl = 5m;
}

sub vcl_deliver {
    # Happens when sending the response to the client
    # We add a header to see if it was a Cache HIT or MISS
    if (obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
    } else {
        set resp.http.X-Cache = "MISS";
    }
}