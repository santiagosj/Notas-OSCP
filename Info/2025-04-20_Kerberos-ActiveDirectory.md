## 🧠 Kerberos Authentication Cheatsheet en Active Directory

---

### 🏩 Componentes Clave

| Componente      | Rol                                                       |
|-----------------|------------------------------------------------------------|
| **Client**      | Usuario/equipo que solicita acceso                         |
| **KDC**         | Key Distribution Center = DC que ejecuta el servicio Kerberos |
| **AS**          | Authentication Service (parte del KDC)                     |
| **TGS**         | Ticket Granting Service (parte del KDC)                    |
| **TGT**         | Ticket Granting Ticket, permite solicitar otros tickets    |
| **ST (Service Ticket)** | Ticket de acceso a un servicio específico               |
| **SPN**         | Service Principal Name, identifica un servicio en la red   |

---

### 🔐 Fase 1: Autenticación Inicial (AS-REQ / AS-REP)

**📍 Objetivo:** El cliente se autentica contra el KDC y obtiene un **TGT**.

1. 🔑 **AS-REQ** → Cliente envía:
   - Nombre del usuario
   - Marca temporal cifrada con la **clave derivada de la contraseña del usuario**

2. 🏰 **AS-REP** ← KDC responde con:
   - **TGT** (cifrado con la clave secreta del TGS)
   - **Session Key** (cifrada con la clave del usuario)

> ⚠️ **Vulnerabilidad:** Si el atacante captura un AS-REP sin preauth, puede realizar **Kerberoasting** (AS-REP Roasting).

---

### 🗒️ Fase 2: Solicitud de Servicio (TGS-REQ / TGS-REP)

**📍 Objetivo:** Obtener un **Service Ticket (ST)** para un servicio específico.

3. 📩 **TGS-REQ** → Cliente envía al KDC:
   - **TGT**
   - Nombre del servicio destino (SPN)
   - Authenticator (cifrado con la Session Key del AS)

4. 📬 **TGS-REP** ← KDC responde con:
   - **Service Ticket (ST)** (cifrado con la clave del servicio SPN)
   - Nueva **Session Key** (para cliente y servicio)

> ⚠️ **Kerberoasting**: Si el atacante tiene acceso al ST, puede crackearlo offline para recuperar la contraseña del servicio SPN.

---

### 🔓 Fase 3: Acceso al Servicio (AP-REQ / AP-REP)

**📍 Objetivo:** Usar el ST para acceder al recurso.

5. 📨 **AP-REQ** → Cliente envía al servidor de destino:
   - **ST**
   - Authenticator (cifrado con la nueva Session Key)

6. 👤 **AP-REP (opcional)** ← Servicio responde si requiere autenticación mutua.

> ✅ El cliente ya puede usar el servicio si todo es válido.

---

### ⟳ Resumen Visual del Flujo

```plaintext
Cliente → (AS-REQ) → KDC[AS]
      ← (AS-REP) ←

Cliente → (TGS-REQ con TGT) → KDC[TGS]
      ← (TGS-REP con ST) ←

Cliente → (AP-REQ con ST) → Servicio
      ← (AP-REP) ←
```

---

### 🧰 Tips para Pentesting

| Técnica              | Descripción                                         |
|----------------------|-----------------------------------------------------|
| **AS-REP Roasting**  | Usuarios sin pre-auth activada                      |
| **Kerberoasting**    | SPNs con STs que pueden ser crackeados offline      |
| **Pass-the-Ticket**  | Reutilizar TGTs o STs robados                       |
| **Overpass-the-Hash**| Generar TGT con hash NTLM usando mimikatz           |

---

### 🛠️ Herramientas útiles

- `Rubeus` (C#): Enumeración, solicitud de tickets, roasting, pass-the-ticket
- `Impacket` (Python): `GetUserSPNs.py`, `ticket_converter.py`
- `Mimikatz`: Exportar tickets (`sekurlsa::tickets`), injectarlos (`kerberos::ptt`)
- `BloodHound`: Identificación de SPNs, relaciones, rutas de ataque

