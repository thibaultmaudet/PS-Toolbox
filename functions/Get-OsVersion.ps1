function Get-OsVersion {
    [cmdletbinding()]
    [OutputType("Custom Object")]
    param (
    )

    begin {
        Write-Verbose "Perform operation '$($MyInvocation.MyCommand)'."
    }
    
    process {
        if ($PSVersionTable.OS -match "Windows" -or $PSVersionTable.PSEdition -like "Desktop") {
            $result = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' | Select-Object -Property ProductName, EditionId, ReleaseId, CurrentBuild, RegisteredOrganization, RegisteredOwner
            
            [PSCustomObject]@{
                PSTypeName = "WindowsVersion"
                ProductName = $result.ProductName
                EditionId = $result.EditionId
                ReleaseId = $result.ReleaseId
                Build = $result.CurrentBuild
                InstallDate = (Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object InstallDate).InstallDate
                RegisteredOrganization = $result.RegisteredOrganization
                RegisteredOwner = $result.RegisteredOwner
            }
        } else {
            Write-Host "This function is not supported by this platform."
        }
    }

    end {
        Write-Verbose "Operation '$($MyInvocation.MyCommand)' complete."
    }
}