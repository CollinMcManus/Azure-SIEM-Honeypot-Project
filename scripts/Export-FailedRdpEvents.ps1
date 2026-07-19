[CmdletBinding()]
param(
    [ValidateRange(1, 168)]
    [int]$Hours = 24,

    [string]$OutputPath = (Join-Path $PSScriptRoot "..\output\failed-rdp-events.csv")
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$startTime = (Get-Date).AddHours(-$Hours)

Write-Verbose "Reading Security Event ID 4625 since $startTime"

$events = Get-WinEvent -FilterHashtable @{
    LogName   = "Security"
    Id        = 4625
    StartTime = $startTime
} -ErrorAction SilentlyContinue

$records = @(
    foreach ($eventRecord in $events) {
        [xml]$eventXml = $eventRecord.ToXml()
        $eventData = @{}

        foreach ($item in $eventXml.Event.EventData.Data) {
            $eventData[[string]$item.Name] = [string]$item.'#text'
        }

        [pscustomobject]@{
            TimeCreated    = $eventRecord.TimeCreated.ToUniversalTime().ToString("o")
            EventId        = $eventRecord.Id
            Computer       = $eventRecord.MachineName
            TargetUserName = $eventData["TargetUserName"]
            TargetDomain   = $eventData["TargetDomainName"]
            LogonType      = $eventData["LogonType"]
            SourceIp       = $eventData["IpAddress"]
            SourcePort     = $eventData["IpPort"]
            Workstation    = $eventData["WorkstationName"]
            FailureReason  = $eventData["FailureReason"]
            Status         = $eventData["Status"]
            SubStatus      = $eventData["SubStatus"]
        }
    }
)

$outputDirectory = Split-Path -Parent $OutputPath
if ($outputDirectory -and -not (Test-Path -LiteralPath $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
}

$records | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8

Write-Host "Exported $($records.Count) failed-logon events to $OutputPath"

