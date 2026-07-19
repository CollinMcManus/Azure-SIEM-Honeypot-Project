# Lab Security and Cleanup Guide

This project intentionally exposed a disposable Windows virtual machine to unsolicited internet traffic. Use the controls below before recreating any part of the lab.

## Before deployment

- Use only an Azure subscription and systems you own or are explicitly authorized to test.
- Place the lab in a dedicated resource group with no peering or trust relationship to production networks.
- Do not store personal data, reusable credentials, production secrets, or sensitive files on the virtual machine.
- Set an Azure budget and cost alert before deployment.
- Define a short collection window and a specific teardown time.
- Prefer exposing only the service being observed instead of allowing all inbound traffic.
- Restrict outbound connectivity so a compromised host cannot be used to attack other systems.
- Store API keys in environment variables, Azure Key Vault, or another managed secret store.

## During collection

- Monitor Event ID 4625 for failed logons and Event ID 4624 for successful logons.
- Review Network Security Group flow data and Azure activity logs when available.
- Watch for unexpected processes, persistence, new users, scheduled tasks, and outbound connections.
- Never interact with systems that generated traffic toward the honeypot.
- Treat IP geolocation as approximate context rather than attribution.
- Stop the experiment immediately if the host shows evidence of successful unauthorized access or outbound abuse.

## Validation checklist

- [ ] Windows Security auditing is recording Event ID 4625.
- [ ] Log Analytics is receiving current events from the expected host.
- [ ] Source IP fields exclude loopback and placeholder values.
- [ ] Custom-table timestamps are parsed as datetimes rather than strings.
- [ ] Latitude and longitude fields are parsed as numeric values before mapping.
- [ ] The workbook time range matches the documented observation window.
- [ ] No API keys, passwords, public IP assignments, or session tokens appear in screenshots or repository files.

## Teardown checklist

- [ ] Export only the sanitized evidence needed for documentation.
- [ ] Revoke temporary API keys and credentials.
- [ ] Remove the public IP address and permissive inbound rules.
- [ ] Delete the virtual machine, disks, network interfaces, and snapshots.
- [ ] Delete the dedicated resource group after confirming nothing shared depends on it.
- [ ] Confirm no unexpected resources remain in the subscription.
- [ ] Review final Azure costs and disable temporary budget alerts if appropriate.
- [ ] Retain only sanitized screenshots, queries, and written findings.

