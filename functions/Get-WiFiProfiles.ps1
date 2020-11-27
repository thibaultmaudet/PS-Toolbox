function Get-WifiProfiles
{
    [cmdletbinding()]
    [OutputType("Custom Object")]
    param
    (
    )

    begin {
        Write-Verbose "Perform operation '$($MyInvocation.MyCommand)'."
    }

    process
    {
        if ($PSVersionTable.OS -match "Windows" -or $PSVersionTable.PSEdition -like "Desktop") {
            $profiles = ((netsh.exe wlan show profiles) -Match '\s{2,}:\s') -Replace '.*:\s' , ''

            if ($profiles -eq 0) {
                Write-Host "No saved Wi-Fi profiles found."
            }
            else {
                foreach ($profile in $profiles) {
                    [PSCustomObject]@{
                        PSTypeName = "WiFiProfiles"
                        SSID = $profile
                    }
                }
            }
        }
        else {
            Write-Host "This OS is not supported."
        }
    }

    end {
        Write-Verbose "Operation '$($MyInvocation.MyCommand)' complete."
    }
}
