# certbot-dns-dnsmanager

ISPsystem DNS API support for Certbot's `--manual-auth-hook` and `--manual-cleanup-hook`.

Use this to install and renew Let's Encrypt wildcard SSL certificates (e.g. for `*.example.com`) via DNS validation using ISPmanager's DNS API.

---

### ✅ Features

- Fully automatic DNS-01 challenge handling for Let's Encrypt
- Works with ISPmanager / DNSmanager API (`dnsmgr`)
- Simple configuration with bash scripts
- Supports wildcard certificates (e.g. `*.yourdomain.com`)

---

### 📦 Files

- `auth-hook.sh` — script to add the required TXT record for domain validation
- `cleanup-hook.sh` — script to remove the TXT record after validation
- `config.sh` — your personal API credentials and DNS panel config

---

### 🚀 Setup instructions

#### 1) Clone this repository and enter the folder

```bash
git clone https://github.com/Dunamis4tw/certbot-dns-dnsmanager.git
cd ./certbot-dns-dnsmanager
```

#### 2) Configure access credentials

Edit `config.sh` with your ISPmanager/DNSmanager API access:

```bash
nano ./config.sh
```

Example:

```bash
# Get your username and password from BILLmanager.
API_USERNAME=admin
API_PASSWORD=yourpassword
API_HOST=example.com
```

#### 3) Install Certbot

If Certbot is not installed yet:

```bash
sudo apt update && sudo apt install certbot
```

Or you can use `letsencrypt-auto` from source (optional).

#### 4) Issue a wildcard certificate

```bash
sudo certbot certonly \
  --manual \
  --manual-public-ip-logging-ok \
  --agree-tos \
  --email you@example.com \
  --renew-by-default \
  -d example.com \
  -d '*.example.com' \
  --manual-auth-hook "$PWD/auth-hook.sh" \
  --manual-cleanup-hook "$PWD/cleanup-hook.sh" \
  --preferred-challenges dns-01 \
  --server https://acme-v02.api.letsencrypt.org/directory
```

#### 5) Force renew manually

```bash
cd /path/to/certbot-dns-dnsmanager
sudo certbot renew \
  --force-renew \
  --manual \
  --manual-auth-hook "$PWD/auth-hook.sh" \
  --manual-cleanup-hook "$PWD/cleanup-hook.sh" \
  --preferred-challenges dns-01 \
  --server https://acme-v02.api.letsencrypt.org/directory
```

---

### 📄 License

This project is a fork of [gordienko/certbot-dns-dnsmanager](https://github.com/gordienko/certbot-dns-dnsmanager)\
MIT License.
