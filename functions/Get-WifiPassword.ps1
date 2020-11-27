function Get-WifiPassword {
    [cmdletbinding()]
    [OutputType("Custom Object")]
    param (
        
    )

    DynamicParam
    {
        $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        $profiles = @()

        if ($PSVersionTable.OS -match "Windows" -or $PSVersionTable.PSEdition -like "Desktop") {
            Get-WifiProfiles | ForEach-Object {
                $profiles += $_.SSID
            }
        }
        
        if ($profiles.Length -gt 0) {
            $ParamName_ListAvailable = 'ListAvailable'
            $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
            $ParameterAttribute.Mandatory = $false
            $ParameterAttribute.Position = 0
            $AttributeCollection.Add($ParameterAttribute)
            $ValidationValues = $profiles
            $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($ValidationValues)
            $AttributeCollection.Add($ValidateSetAttribute)
            $RuntimeParameter_SpecificPerson = New-Object System.Management.Automation.RuntimeDefinedParameter($ParamName_ListAvailable, [string[]], $AttributeCollection)
            $RuntimeParameterDictionary.Add($ParamName_ListAvailable, $RuntimeParameter_SpecificPerson)
        }
        
        return $RuntimeParameterDictionary
    }

    begin {
        Write-Verbose "Perform operation '$($MyInvocation.MyCommand)'."
    }

    process {
        if ($PSVersionTable.OS -match "Windows" -or $PSVersionTable.PSEdition -like "Desktop") {
            $profiles = @()

            if (-not $PSBoundParameters.Keys.Contains('ListAvailable')) {
                Get-WifiProfiles | ForEach-Object {
                    $profiles += $_.SSID
                }
            }
            else {
                $profiles = $PSBoundParameters.ListAvailable
            }

            if ($profiles.Length -eq 0) {
                Write-Host "No saved Wi-Fi found."
            } else {
                $profiles | ForEach-Object -Process {
                    $ssid = $_.Trim()
                    $passwordDetection = $(netsh wlan show profile name = $ssid key=clear) | Where-Object -FilterScript {($_ -like '*contenu de la cl*') -or ($_ -like '*key content*')}

                    try {
                        $password = $passwordDetection.Split(':')[-1].Trim()
                    }
                    catch {
                        $password = "Unknown"
                    }

                    [PSCustomObject]@{
                        PSTypeName = "WifiPasswords"
                        SSID = $ssid
                        Pasword = $password
                    }
                }
            }    
        } else {
            Write-Host "This OS is not supported."
        }
    }

    end {
        Write-Verbose "Operation '$($MyInvocation.MyCommand)' complete."
    }
}