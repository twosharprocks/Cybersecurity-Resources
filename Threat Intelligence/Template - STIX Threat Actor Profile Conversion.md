
## 1. Source Document Metadata (Not part of STIX, just for tracking)

| Field              | Value                     |
|-------------------|---------------------------|
| Original Filename | `APT28_Profile.docx`      |
| Last Updated      | `2025-04-09`              |
| Converted By      | `Your Name`               |
| Confidence Level  | `High`                    |

---

## 2. `threat-actor` Object

```json
{
  "type": "threat-actor",
  "id": "threat-actor--[UUID]",
  "created": "[ISO 8601 timestamp]",
  "modified": "[ISO 8601 timestamp]",
  "name": "[Primary Threat Actor Name]",
  "aliases": ["[Alias1]", "[Alias2]"],
  "description": "[Brief summary of the actor's background and focus]",
  "roles": ["spy", "saboteur"],
  "goals": ["[espionage, financial gain, disruption]"],
  "sophistication": "advanced",
  "resource_level": "nation-state",
  "primary_motivation": "ideology",
  "secondary_motivations": ["[revenge]", "[organizational gain]"]
}
```

---

## 3. `identity` Object (for attribution)

```json
{
  "type": "identity",
  "id": "identity--[UUID]",
  "created": "[timestamp]",
  "modified": "[timestamp]",
  "name": "[E.g., Russian Federation or PLA Unit 61398]",
  "identity_class": "organization",
  "sectors": ["government", "military"],
  "contact_information": "[optional]",
  "labels": ["state-sponsor"]
}
```

---

## 4. `intrusion-set` or `campaign` Objects

```json
{
  "type": "intrusion-set",
  "id": "intrusion-set--[UUID]",
  "created": "[timestamp]",
  "modified": "[timestamp]",
  "name": "[E.g., Operation Pawn Storm]",
  "description": "[Operation details, years active, goals]",
  "first_seen": "[date]",
  "last_seen": "[date]",
  "goals": ["credential theft", "influence"],
  "resource_level": "nation-state",
  "primary_motivation": "espionage"
}
```

---

## 5. `malware` and `tool` Objects

```json
{
  "type": "malware",
  "id": "malware--[UUID]",
  "created": "[timestamp]",
  "modified": "[timestamp]",
  "name": "X-Agent",
  "labels": ["remote-access-trojan"],
  "description": "Custom RAT used by APT28 to steal data and maintain persistence."
}
```

```json
{
  "type": "tool",
  "id": "tool--[UUID]",
  "created": "[timestamp]",
  "modified": "[timestamp]",
  "name": "Mimikatz",
  "labels": ["credential-dumping"],
  "description": "Common credential harvesting tool used in post-exploitation."
}
```

---

## 6. `attack-pattern` Objects (TTPs)

```json
{
  "type": "attack-pattern",
  "id": "attack-pattern--[UUID]",
  "created": "[timestamp]",
  "modified": "[timestamp]",
  "name": "Spearphishing Attachment",
  "external_references": [
    {
      "source_name": "mitre-attack",
      "external_id": "T1566.001",
      "url": "https://attack.mitre.org/techniques/T1566/001/"
    }
  ],
  "description": "Sends spearphishing emails with malicious attachments to gain initial access."
}
```

---

## 7. `indicator` Objects (IoCs)

```json
{
  "type": "indicator",
  "id": "indicator--[UUID]",
  "created": "[timestamp]",
  "modified": "[timestamp]",
  "name": "APT28 Command and Control IP",
  "description": "Known C2 IP used by APT28 in 2024 campaigns",
  "pattern": "[ipv4-addr:value = '192.168.1.1']",
  "pattern_type": "stix",
  "valid_from": "[timestamp]"
}
```

---

## 8. `relationship` Objects

```json
{
  "type": "relationship",
  "id": "relationship--[UUID]",
  "created": "[timestamp]",
  "modified": "[timestamp]",
  "relationship_type": "uses",
  "source_ref": "threat-actor--[UUID]",
  "target_ref": "malware--[UUID]",
  "description": "APT28 uses X-Agent malware."
}
```

Other relationship types include:
- `attributed-to`
- `targets`
- `uses`
- `compromises`

---
## Optional Tools

- **MITRE ATT&CK Navigator**
- **stix2 Python library**
- **OpenCTI / MISP**
- **OCR/NLP (e.g., spaCy, GPT)**