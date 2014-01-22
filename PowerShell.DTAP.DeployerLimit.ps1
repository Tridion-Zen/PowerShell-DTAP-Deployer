# PowerShell.DTAP.DeployerLimit.ps1
#
$ErrorActionPreference = "SilentlyContinue"
cls
#
$servers = @("SERVEUR_UN", "SERVEUR-DEUX")
#
$startTime = get-date
write-host "Started $($startTime)"
#
foreach ($server in $servers) {   
    write-host "Server $server"
    #
    write-host "Searching in \ABC for cd_deployer_conf.xml"
    $files = get-childitem -path "\\$server\c$\ABC\" -recurse -force -include "cd_deployer_conf.xml"
    write-host "Files $files" -foregroundcolor gray
    foreach ($file in $files) {
        write-host "File $file" -foregroundcolor yellow
        [xml] $conf = get-content $file
        $conf.deployer.httpsreceiver
    } 
    #
    write-host "Searching in \DEF for web.config"
    $files = get-childitem -path "\\$server\c$\DEF\" -recurse -force -include "web.config"
    write-host "Files $files" -foregroundcolor gray
    foreach ($file in $files) {
        write-host "File $file" -foregroundcolor yellow
        [xml] $conf = get-content $file
        $conf.configuration.'system.web'.httpruntime
        $conf.configuration.'system.webserver'.security.requestfiltering.requestlimits
    }
}
write-host "Finished $(get-date)"
