vcl 4.1;

# Define a backend (Caddy)
backend default {
    .host = "caddy";  
    .port = "80";     
}

sub vcl_recv {
    # Remove TODOS os cookies para garantir que a página seja cacheada
    unset req.http.Cookie;
}

sub vcl_backend_response {
    forca o varnish a guardar a cache durante 5 min
    set beresp.ttl = 5m;
}

sub vcl_deliver {
    # Verifica se a cache esta a funcionar
    if (obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
    } else {
        set resp.http.X-Cache = "MISS";
    }
}