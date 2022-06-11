# minecraft

Scripts for managing minecraft servers


## Usage

Use the makefile targets to set up the server.


Setting up the server.
```bash
make
```
    
Uninstalling the server.
```bash
make uninstall
```


## Notes

### Port forwarding

Set up on my router.

```
public:25565 --> mc-server:25565 (minecraft server)
public:25569 --> mc-server:8123  (dynmap)
```

### Domain settings

These are set in [Google Domains](https://domains.google.com/registrar/).

```
mc.domain.name --> SRV record: 50 5 25565 [public IP].
map.domain.name --> SRV record: 50 5 25569 [public IP].
```
