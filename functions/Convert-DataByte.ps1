function Convert-DataByte {
    [cmdletbinding()]
    param(
        [validateset("Bytes", "KB", "MB", "GB", "TB")]
        [string]$From = "Bytes",
        [validateset("Bytes", "KB", "MB", "GB", "TB")]
        [string]$To = "Bytes",
        [Parameter(Mandatory=$true, ValueFromPipeline = $true)]
        [double]$Value
    )

    begin {
        Write-Verbose "Perform operation '$($MyInvocation.MyCommand)'."
    }

    process {
        switch ($From) {
            "Bytes" { $value = $Value }
            "KB" { $value *= 1KB }
            "MB" { $value *= 1MB }
            "GB" { $value *= 1GB }
            "TB" { $value *= 1TB }
        }

        switch ($To) {
            "Bytes" { return $value }
            "KB" { $Value /= 1KB }
            "MB" { $Value /= 1MB }
            "GB" { $Value /= 1GB }
            "TB" { $Value /= 1TB }
        }

        return [Math]::Round($value, 2, [MidPointRounding]::AwayFromZero)
    }

    end {
        Write-Verbose "Operation '$($MyInvocation.MyCommand)' complete."
    }
}