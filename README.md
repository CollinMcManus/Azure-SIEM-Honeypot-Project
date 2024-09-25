# Azure-SIEM-Honeypot-Project
## Overview
This honeypot project highlights configuring and use of industry tools such as Azure Sentinel being utilized as an SIEM to log and monitor failed RDP attempts filtered by IP address and geoloation. By configuring a honeypot virtual machine, one can attract malicious actors generating events from brute force attacks that can be logged and analyzed for real-time security insights.
## Objectives
- Create a vulnerable honeypot in an isolated virtual environment
- Utilize Powershell to gather event logs, running them through an api for geo location
- Use geolocation results and feed them into Microsoft Sentinel for a realtime visual output
- Analyze results and cybersecurity insights
## Prerequisites
- Understanding of Azure tools including; Azure Virtual Machines, Microsoft Sentinel, and log analytics workspace
- Basic understanding of Kusto Query Language and Powershell
- Knowlege on firewall settings along with inbound/outbound rules
## Process
1. Create a virtual environment on Azure, a free account comes with $200 in Azure credit. ![image](https://github.com/user-attachments/assets/e71da8b3-a43c-4661-84b8-69b00a501e4d)
2. Replace inbound security rules with a new rule that opens all ports and has the highest priority level. ![image](https://github.com/user-attachments/assets/d45845fb-a4ff-4612-9c83-8c647c0596b6)
3. After you have created your machine, utilize Remote Desktop Protocol to connect to your new virtual host. ![image](https://github.com/user-attachments/assets/ef9dc06e-0b8c-4dcb-9472-f4052033d9f3)
4. Next, Turn off Windows Defender Firewall for all profiles.                  
                                    ![image](https://github.com/user-attachments/assets/afc23c4f-ce67-47af-bd60-fc29c3b9cacc)
6. At this point, the brute force attacks have likely begun. After this I utilized powershell and acquired an API key for ipgeolocation.io to turn event logs for event 4625 into geolocation event data. ![image](https://github.com/user-attachments/assets/f7429a6d-874c-4e25-a5e5-c1c3aa84dd8b)
7. Following that, I set up a custom table for my log file and used sample data to train the table. After my table was made, I used a query that can take my logs and turn it into an easier to analyze format. ![image](https://github.com/user-attachments/assets/a3d9c423-de25-48f2-8e41-e92d15f189e5)
8. Finally, I used Sentinels SIEM to make a workbook and map out the data into a realtime visual format. ![RDPmap](https://github.com/user-attachments/assets/f3438acf-a724-4f13-8792-f2df095c2914)
## Conclusion
This project is a great example of how to efficiently use Azure Sentinely as a SIEM. Utilizing a honeypot is a great way to gather insight into attacks, doing so in an isolated, virtual environment eliminates the risk involved. While this project demonstrates real world attacks, it is important to recognize the risk that comes with turning off all firewalls, especially outside of an isolated environment.





