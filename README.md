# 🛡️ linux-security-mini-check
Um mini scanner de segurança para Linux — rápido, simples e útil.  
Ideal para sysadmins, SOC, DevOps e engenheiros Linux que querem verificar o básico em segundos.

---

## 🚀 Features
- Verifica utilizadores com sudo
- Confirma se o SSH está seguro
- Lista portas abertas
- Aponta ficheiros world-writable suspeitos
- Verifica firewall activo (ufw / firewalld)
- Lista updates de segurança pendentes
- Mostra tentativas de login falhadas

---

## 📦 Instalação
```bash
git clone https://github.com/<seu-usuario>/linux-security-mini-check
cd linux-security-mini-check
chmod +x security-scan.sh
