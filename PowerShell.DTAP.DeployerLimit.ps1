# PowerShell.DTAP.DeployerLimit.ps1
#
$ErrorActionPreference = "SilentlyContinue"
cls
#
$servers = @("SERVEUR_UNE", "SERVEUR-DEUX")
#
$startTime = get-date
write-host "Started $($startTime)"
#
foreach ($server in $servers) {   
    write-host "Server: $server"
    #
    write-host "Search in: \data\www\tridion\2011  for: cd_deployer_conf.xml"
    $files = get-childitem -path "\\$server\f$\data\www\tridion\2011\" -recurse -force -include "cd_deployer_conf.xml"
    write-host "Files found: $files" -foregroundcolor gray
    foreach ($file in $files) {
        write-host "File: $file" -foregroundcolor yellow
        [xml] $conf = get-content $file
        write-host $conf.deployer.httpsreceiver.name         " " -nonewline
        write-host $conf.deployer.httpsreceiver.maxsize.name " " -nonewline
        write-host $conf.deployer.httpsreceiver.maxsize 
    } 
    #
    write-host "Search in: \data\www\tridion\2011  for: web.config"
    $files = get-childitem -path "\\$server\f$\data\www\tridion\2011\" -recurse -force -include "web.config"
    write-host "Files found: $files" -foregroundcolor gray
    foreach ($file in $files) {
        write-host "File: $file" -foregroundcolor yellow
        [xml] $conf = get-content $file
        write-host $conf.configuration.'system.web'.httpruntime.name                  " " -nonewline
        write-host $conf.configuration.'system.web'.httpruntime.maxrequestlength.name " " -nonewline 
        write-host $conf.configuration.'system.web'.httpruntime.maxrequestlength
        write-host $conf.configuration.'system.webserver'.security.requestfiltering.requestlimits.name                         " " -nonewline
        write-host $conf.configuration.'system.webserver'.security.requestfiltering.requestlimits.maxallowedcontentlength.name " " -nonewline
        write-host $conf.configuration.'system.webserver'.security.requestfiltering.requestlimits.maxallowedcontentlength
    }
}
write-host "Finished $(get-date)"
