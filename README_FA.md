# 🚀 Easy DNSTT Tunnel

**اسکریپت نصب و راه‌اندازی خودکار DNSTT Tunnel به همراه پنل 3x-ui**

> نصب خودکار • تونل DNS • تنظیم فایروال • SSL • systemd • پنل مدیریت

---

## 📌 معرفی

**Easy DNSTT Tunnel** یک اسکریپت Bash حرفه‌ای برای ساده‌سازی نصب و راه‌اندازی **DNSTT Tunnel Server** به همراه **3x-ui Panel** روی سرورهای Linux است.

این پروژه بسیاری از مراحل نصب و پیکربندی را به‌صورت خودکار انجام می‌دهد؛ از جمله:

- نصب پیش‌نیازهای سیستم
- تنظیم فایروال
- دانلود و نصب DNSTT Server
- ساخت کلیدهای DNSTT
- ایجاد سرویس `systemd`
- فعال‌سازی اجرای خودکار سرویس
- نصب پنل 3x-ui
- نصب و دریافت گواهی SSL با Certbot
- نمایش اطلاعات و وضعیت سرویس
- ارائه راهنمای تنظیم DNS

به‌جای انجام دستی تمام این مراحل، اسکریپت یک محیط تعاملی در ترمینال ارائه می‌کند و فرآیند نصب را مرحله‌به‌مرحله انجام می‌دهد.

### 🔗 Repository

`hosseinit1988/easy-dnstt-tunnel`

### 📄 اسکریپت اصلی

`DNSTT-Tunnel.sh`

---

# ✨ امکانات

| قابلیت | توضیحات |
|---|---|
| 🚀 نصب خودکار | نصب و پیکربندی اجزای اصلی به‌صورت تعاملی |
| 🌐 DNSTT Server | دانلود و راه‌اندازی DNSTT Server |
| 🔐 تولید کلید | تولید خودکار Key Pair برای DNSTT |
| ⚙️ systemd | ایجاد سرویس اختصاصی `dnstt.service` |
| 🛡️ UFW Firewall | باز کردن پورت‌های موردنیاز |
| 🎛️ 3x-ui | نصب پنل مدیریت 3x-ui |
| 🔒 SSL | دریافت گواهی SSL با Certbot |
| 🧰 نصب پیش‌نیازها | نصب خودکار ابزارهای موردنیاز |
| 🖥️ رابط تعاملی | رابط رنگی و مرحله‌ای در ترمینال |
| 📋 خلاصه تنظیمات | نمایش دامنه، دامنه تونل، IP و ایمیل SSL |
| 🔎 بررسی سرویس | نمایش وضعیت سرویس DNSTT |
| 📖 راهنمای DNS | ارائه راهنمای تعاملی برای تنظیم DNS |

---

# 🧠 DNSTT چگونه کار می‌کند؟

در یک نگاه، ساختار ارتباط به شکل زیر است:

```text
                    ┌──────────────────────┐
                    │       Client         │
                    │   DNS / Tunnel       │
                    └──────────┬───────────┘
                               │
                               │ DNS Queries
                               ▼
                    ┌──────────────────────┐
                    │ Recursive Resolver   │
                    └──────────┬───────────┘
                               │
                               │ DNS Delegation
                               ▼
                    ┌──────────────────────┐
                    │    DNSTT Server      │
                    │      UDP/TCP 53      │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │      Server OS       │
                    │   Ubuntu / Debian    │
                    └──────────────────────┘
```

DNSTT یک تونل در لایه Application است که از DNS به‌عنوان بستر انتقال استفاده می‌کند.

پروتکل DNSTT از فناوری‌هایی مانند **KCP / smux** و **Noise Encryption** استفاده می‌کند و بسته به نوع Client می‌تواند از DNS معمولی و همچنین روش‌هایی مانند DoH / DoT استفاده کند.

---

# 🧩 اجزای پروژه

## 🌐 DNSTT

اسکریپت نسخه زیر از DNSTT Server را دریافت و نصب می‌کند:

```text
dnstt-server v1.5.1
```

محل نصب:

```text
/opt/dnstt/
```

در هنگام نصب، یک Key Pair برای دامنه تونل ایجاد می‌شود.

---

## 🎛️ 3x-ui

اسکریپت نصب رسمی 3x-ui را اجرا می‌کند:

```bash
bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
```

پورت پیش‌فرض مورد استفاده پروژه برای پنل:

```text
2053
```

> ⚠️ پنل 3x-ui یک پروژه مستقل است و توسط این Repository توسعه داده نمی‌شود.

پس از نصب، اطلاعات ورود و آدرس پنل در خروجی نصب نمایش داده می‌شود.

---

## ⚙️ systemd

سرویس DNSTT با نام زیر ایجاد می‌شود:

```text
dnstt.service
```

این سرویس برای اجرای خودکار پس از Boot سیستم و Restart شدن در صورت توقف Process پیکربندی می‌شود.

---

# 🛠️ پیش‌نیازها

## سیستم‌عامل‌های پشتیبانی‌شده

اسکریپت در حال حاضر سیستم‌عامل‌های زیر را بررسی می‌کند:

- Ubuntu
- Debian

اسکریپت برای اجرا به دسترسی **Root** نیاز دارد.

### محیط پیشنهادی

```text
Linux VPS
Public IPv4 Address
Root / Sudo Access
Registered Domain
DNS Management Access
```

توصیه می‌شود نصب را روی یک **سرور تمیز (Clean VPS)** انجام دهید.

---

# 🌐 تنظیم Domain و DNS

قبل از اجرای اسکریپت، ابتدا DNS دامنه خود را آماده کنید.

برای مثال:

```text
Main Domain:  example.com
DNS Tunnel:   dns.example.com
Server IP:    203.0.113.10
```

ساختار DNS مورد استفاده پروژه به شکل زیر است.

---

## 1️⃣ ساخت A Record

یک رکورد A برای `ns` ایجاد کنید:

```text
Type:    A
Name:    ns
Value:   YOUR_SERVER_IP
Proxy:   DNS Only
```

مثال:

```text
ns.example.com → 203.0.113.10
```

---

## 2️⃣ ساخت NS Record

سپس رکورد NS مربوط به دامنه تونل را ایجاد کنید:

```text
Type:    NS
Name:    dns
Value:   ns.example.com
```

در نتیجه:

```text
dns.example.com → ns.example.com
```

---

# ☁️ تنظیمات Cloudflare

اگر از Cloudflare استفاده می‌کنید، رکوردهای مورد استفاده برای تونل باید روی:

```text
DNS Only
```

قرار داشته باشند.

یعنی **Proxy / Orange Cloud نباید برای Endpoint مربوط به DNS authoritative تونل فعال باشد.**

### صحیح:

```text
DNS Only
```

### نادرست:

```text
Proxied
```

> ⚠️ فعال بودن Proxy کلادفلر برای Endpoint مورد استفاده تونل می‌تواند باعث اختلال در عملکرد DNS Tunnel شود.

همچنین توجه داشته باشید که انتشار رکوردهای DNS ممکن است بسته به DNS Provider و Cache Resolverها زمان ببرد.

---

# 🚀 نصب

ابتدا Repository را Clone کنید:

```bash
git clone https://github.com/hosseinit1988/easy-dnstt-tunnel.git
cd easy-dnstt-tunnel
```

سپس دسترسی اجرای اسکریپت را فعال کنید:

```bash
chmod +x DNSTT-Tunnel.sh
```

اسکریپت را با دسترسی Root اجرا کنید:

```bash
sudo ./DNSTT-Tunnel.sh
```

یا:

```bash
sudo bash DNSTT-Tunnel.sh
```

اگر از قبل با کاربر Root وارد شده‌اید:

```bash
bash DNSTT-Tunnel.sh
```

---

# ⚡ نصب سریع

اگر Repository را Clone کرده‌اید:

```bash
git clone https://github.com/hosseinit1988/easy-dnstt-tunnel.git && cd easy-dnstt-tunnel && chmod +x DNSTT-Tunnel.sh && sudo ./DNSTT-Tunnel.sh
```

---

# 🧭 مراحل نصب

فرآیند کلی نصب به شکل زیر است:

```text
┌────────────────────────────────────┐
│        Easy DNSTT Tunnel           │
└──────────────────┬─────────────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ دریافت تنظیمات      │
        │ Domain / Subdomain  │
        │ Server IP / Email   │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ تنظیم DNS           │
        │ راهنمای تعاملی      │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ پیش‌نیازهای سیستم   │
        │ apt / packages      │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ UFW Firewall        │
        │ پورت‌های موردنیاز   │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ DNSTT Server        │
        │ Download + Keys     │
        │ systemd service     │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ نصب 3x-ui           │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ SSL / Certbot       │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ خلاصه نصب           │
        └─────────────────────┘
```

---

# 📦 پکیج‌های نصب‌شده

اسکریپت پکیج‌های موردنیاز را از طریق APT نصب می‌کند:

```text
curl
wget
git
ufw
jq
uuid-runtime
openssl
net-tools
```

همچنین در مرحله SSL، ابزارهای زیر نصب می‌شوند:

```text
certbot
python3-certbot-nginx
```

---

# 🔥 پورت‌های Firewall

اسکریپت UFW را برای پورت‌های زیر پیکربندی می‌کند:

| Port | Protocol | کاربرد |
|---:|---|---|
| `22` | TCP | SSH |
| `53` | UDP | انتقال DNS برای DNSTT |
| `80` | TCP | HTTP / اعتبارسنجی SSL |
| `443` | TCP | HTTPS / اتصالات امن |
| `2053` | TCP | پنل 3x-ui |

برای مشاهده وضعیت Firewall:

```bash
ufw status
```

یا:

```bash
ufw status verbose
```

> ⚠️ قبل از اعمال تغییرات Firewall روی سرور Production، مطمئن شوید دسترسی SSH شما قطع نمی‌شود.

---

# 🔐 کلیدهای DNSTT

در زمان نصب، اسکریپت یک Key Pair برای DNSTT تولید می‌کند.

برای مشاهده فایل‌های DNSTT:

```bash
cd /opt/dnstt
```

اطلاعات کلید در فایل زیر ذخیره می‌شود:

```text
/opt/dnstt/dnstt-keys.txt
```

کلید عمومی نیز در خلاصه نصب نمایش داده می‌شود.

---

## ⚠️ حفاظت از Private Key

**Private Key بسیار حساس است.**

هرگز Private Key را در موارد زیر منتشر نکنید:

- GitHub
- Screenshot
- کانال‌های عمومی Telegram
- گزارش‌های Bug
- Logهای عمومی
- فایل‌های Configuration عمومی

اگر Private Key افشا شد، یک Key Pair جدید ایجاد کرده و Configuration سرور را به‌روزرسانی کنید.

---

# ⚙️ مدیریت سرویس DNSTT

فایل سرویس در مسیر زیر ایجاد می‌شود:

```text
/etc/systemd/system/dnstt.service
```

## بررسی وضعیت

```bash
systemctl status dnstt
```

## Start

```bash
systemctl start dnstt
```

## Stop

```bash
systemctl stop dnstt
```

## Restart

```bash
systemctl restart dnstt
```

## اجرای خودکار هنگام Boot

```bash
systemctl enable dnstt
```

## مشاهده Log به‌صورت زنده

```bash
journalctl -u dnstt -f
```

## مشاهده 100 Log اخیر

```bash
journalctl -u dnstt --no-pager -n 100
```

---

# 🔒 گواهی SSL

اسکریپت Certbot را نصب کرده و تلاش می‌کند برای دامنه اصلی و دامنه DNS گواهی SSL دریافت کند.

برای مثال:

```text
yourdomain.com
dns.yourdomain.com
```

مسیر مورد انتظار Certificate:

```text
/etc/letsencrypt/live/YOUR_DOMAIN/
```

فایل‌های معمول:

```text
fullchain.pem
privkey.pem
```

---

## ❌ اگر دریافت SSL با خطا مواجه شد

موارد زیر را بررسی کنید:

```text
DNS Resolution
Port 80
Port 443
Domain Ownership
Port 80 Conflicts
Firewall Rules
```

بررسی Port 80:

```bash
ss -lntup | grep ':80'
```

بررسی DNS:

```bash
dig A example.com
```

دامنه باید به Public IP صحیح سرور اشاره کند.

---

# 🎛️ پنل 3x-ui

در مرحله نصب، اسکریپت نصب رسمی 3x-ui را اجرا می‌کند و تلاش می‌کند اطلاعات ورود تولیدشده توسط پنل را دریافت کند.

پورت پیش‌فرض پروژه:

```text
2053
```

پس از پایان نصب، آدرس پنل و اطلاعات Login در خروجی نمایش داده می‌شود.

### 🔐 توصیه امنیتی

پس از اولین ورود:

1. Username را تغییر دهید.
2. Password را تغییر دهید.
3. از رمز عبور قوی استفاده کنید.
4. در صورت امکان دسترسی به پورت مدیریت را محدود کنید.
5. پنل مدیریت را بدون نیاز در معرض اینترنت عمومی قرار ندهید.

---

# 🧪 بررسی صحت نصب

پس از نصب، ابتدا وضعیت سرویس DNSTT را بررسی کنید:

```bash
systemctl is-active dnstt
```

خروجی مورد انتظار:

```text
active
```

---

## بررسی پورت‌های در حال Listen

```bash
ss -lntup | grep -E ':53|:2053|:80|:443'
```

---

## بررسی DNS

رکورد A:

```bash
dig A ns.example.com
```

رکورد NS:

```bash
dig NS dns.example.com
```

همچنین می‌توانید Delegation مربوط به DNS را از یک سیستم خارجی بررسی کنید.

---

# 🐛 خطایابی

## ❌ سرویس DNSTT اجرا نمی‌شود

ابتدا:

```bash
systemctl status dnstt
```

سپس:

```bash
journalctl -u dnstt --no-pager -n 100
```

به دنبال خطاهایی مانند موارد زیر باشید:

```text
address already in use
permission denied
invalid key
invalid domain
DNS configuration errors
```

---

# ❌ پورت 53 قبلاً استفاده شده است

ابتدا بررسی کنید چه سرویس یا Process روی پورت 53 فعال است:

```bash
ss -lntup | grep ':53'
```

سپس:

```bash
lsof -i :53
```

ممکن است سرویس‌هایی مانند موارد زیر از پورت 53 استفاده کنند:

```text
systemd-resolved
dnsmasq
Other DNS Services
```

> ⚠️ سرویس DNS موجود را بدون بررسی روی یک سرور Production غیرفعال نکنید.

---

# ❌ دریافت SSL با خطا مواجه می‌شود

ابتدا بررسی کنید Port 80 در حال استفاده است یا خیر:

```bash
ss -lntup | grep ':80'
```

سپس DNS دامنه را بررسی کنید:

```bash
dig A example.com
```

مطمئن شوید دامنه به Public IP صحیح سرور اشاره می‌کند.

همچنین موارد زیر را بررسی کنید:

- DNS صحیح باشد.
- Port 80 باز باشد.
- Port 443 باز باشد.
- Firewall مانع اتصال نباشد.
- سرویس دیگری Port 80 را اشغال نکرده باشد.
- دامنه به IP صحیح سرور اشاره کند.

---

# ❌ مشکلات نصب 3x-ui

وضعیت سرویس پنل را بررسی کنید:

```bash
systemctl status x-ui
```

Logهای پنل:

```bash
journalctl -u x-ui --no-pager -n 100
```

> ⚠️ نصب‌کننده 3x-ui خارج از این Repository نگهداری می‌شود؛ بنابراین رفتار نصب آن ممکن است مستقل از این پروژه تغییر کند.

---

# 📁 ساختار پروژه

ساختار فعلی Repository عمداً ساده نگه داشته شده است:

```text
easy-dnstt-tunnel/
│
├── DNSTT-Tunnel.sh
├── README.md
└── LICENSE
```

فایل اصلی نصب:

```text
DNSTT-Tunnel.sh
```

تمام Workflow اصلی Deployment در همین اسکریپت قرار دارد.

---

# ⚠️ نکات مهم درباره وضعیت فعلی پروژه

این README وضعیت فعلی پیاده‌سازی `DNSTT-Tunnel.sh` را مستند می‌کند.

نسخه فعلی اسکریپت در رابط کاربری خود یک Workflow پیشرفته 9 مرحله‌ای را نمایش می‌دهد، اما implementation موجود در Repository در حال حاضر مراحل اصلی نصب را تا مرحله SSL اجرا کرده و سپس خلاصه نصب را نمایش می‌دهد.

همچنین برخی مسیرها و متغیرهایی که در Completion Summary نمایش داده می‌شوند، در implementation فعلی به‌صورت Placeholder هستند و ممکن است در نسخه‌های آینده توسعه داده شوند.

از جمله:

```text
/opt/dnstt/client-config.txt
/opt/dnstt/manage.sh
INBOUND_ID
```

بنابراین خروجی Completion Summary را صرفاً به‌عنوان اطلاعات نصب در نظر بگیرید و **Configuration واقعی و سرویس‌های ایجادشده روی سرور را بررسی کنید.**

---

# 🔐 ملاحظات امنیتی

این پروژه عملیات مدیریتی سطح بالایی روی سیستم‌عامل انجام می‌دهد.

قبل از اجرای آن روی Production Server توصیه می‌شود:

- اسکریپت را قبل از اجرا بررسی کنید.
- در صورت امکان از یک Clean VPS استفاده کنید.
- سیستم‌عامل را به‌روز نگه دارید.
- Private Key مربوط به DNSTT را محافظت کنید.
- Username و Password پنل را تغییر دهید.
- پورت‌های مدیریتی را در صورت امکان محدود کنید.
- Firewall را بعد از نصب بررسی کنید.
- Logهای systemd را مانیتور کنید.
- اطلاعات حساس Configuration را منتشر نکنید.
- از این فناوری فقط در محیط‌ها و شبکه‌هایی استفاده کنید که مجوز استفاده از آن را دارید.

> ⚠️ اجرای Shell Script با دسترسی `root` به اسکریپت کنترل کامل سیستم‌عامل را می‌دهد. همیشه قبل از اجرای اسکریپت‌های Third-Party، کد آن‌ها را بررسی کنید.

---

# 🧰 دستورات کاربردی

## مشاهده Public IPv4 سرور

```bash
curl -4 ifconfig.me
```

---

## بررسی DNS

```bash
dig A example.com
```

```bash
dig NS dns.example.com
```

---

## مشاهده تمام سرویس‌ها و پورت‌های Listening

```bash
ss -lntup
```

---

## بررسی Firewall

```bash
ufw status verbose
```

---

## بررسی DNSTT

```bash
systemctl status dnstt
```

---

## مشاهده Logهای DNSTT

```bash
journalctl -u dnstt -f
```

---

## Restart سرویس DNSTT

```bash
systemctl restart dnstt
```

---

# 🧑‍💻 توسعه

اگر قصد توسعه یا آزمایش تغییرات را دارید، ابتدا Repository را Clone کنید:

```bash
git clone https://github.com/hosseinit1988/easy-dnstt-tunnel.git
cd easy-dnstt-tunnel
```

سپس:

```bash
chmod +x DNSTT-Tunnel.sh
```

توصیه می‌شود تغییرات را ابتدا روی یک **VPS آزمایشی و قابل حذف (Disposable VPS)** تست کنید و پس از اطمینان، روی Production Deploy کنید.

---

# 🤝 مشارکت در پروژه

اگر Bug پیدا کردید یا پیشنهادی برای بهبود پروژه دارید:

1. Repository را Fork کنید.
2. یک Feature Branch ایجاد کنید.
3. تغییرات را تست کنید.
4. Commit ایجاد کنید.
5. یک Pull Request ارسال کنید.

---

## 🐛 گزارش Bug

هنگام گزارش مشکل، اطلاعات زیر می‌تواند مفید باشد:

```text
Operating System
Architecture
Relevant Command Output
DNSTT Service Status
Relevant journalctl Output
Steps to Reproduce
```

### ⚠️ اطلاعات حساس را ارسال نکنید

هرگز موارد زیر را داخل Issue یا Pull Request قرار ندهید:

```text
Private Keys
Passwords
Tokens
API Keys
Sensitive Server Information
```

---

# 📜 License

این پروژه تحت مجوز **GPL-3.0** منتشر شده است.

برای جزئیات کامل مجوز، فایل زیر را در Repository بررسی کنید:

```text
LICENSE
```

همچنین اجزای Third-Party مورد استفاده پروژه ممکن است License و Terms جداگانه خود را داشته باشند.

---

# 🙏 Credits

این پروژه بر پایه تلاش‌های جامعه Open Source و پروژه‌های متن‌باز شبکه ساخته شده است.

تشکر ویژه از:

- DNSTT و توسعه‌دهندگان آن
- 3x-ui و Maintainerهای آن
- جامعه Linux
- جامعه Open Source

برای جزئیات فنی بیشتر درباره DNSTT، مستندات و Source Code پروژه اصلی را بررسی کنید.

---

# ⭐ حمایت از پروژه

اگر این پروژه برای شما مفید بود:

- ⭐ به Repository Star بدهید.
- 🐛 Bugها را گزارش کنید.
- 💡 پیشنهادهای خود را ارسال کنید.
- 🔧 Pull Request ارسال کنید.
- 📢 پروژه را با دیگر توسعه‌دهندگان به اشتراک بگذارید.

بازخورد شما به بهبود پروژه کمک می‌کند.

---

# 🔗 Project

**Easy DNSTT Tunnel**

> اجرای بخش‌های تکراری نصب را خودکار کنید و Deployment را یکپارچه نگه دارید.

ساخته‌شده با ❤️ توسط **Hossein Shourgashti**

---

## 📌 Repository

```text
https://github.com/hosseinit1988/easy-dnstt-tunnel
```

## 📄 Main Script

```text
DNSTT-Tunnel.sh
```

## 📚 README انگلیسی

```text
https://github.com/hosseinit1988/easy-dnstt-tunnel/blob/main/README.md
```

---

**Easy DNSTT Tunnel — DNSTT Tunnel + 3x-ui Automated Installer**