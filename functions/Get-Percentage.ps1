function Get-Percentage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]$FirstNumber,
        [Parameter(Mandatory)]$SecondNumber
    )  

    begin {
        Write-Verbose "Perform operation '$($MyInvocation.MyCommand)'."
    }

    process {
        if ($FirstNumber -eq 0) {
            Write-Warning "Unable to calculate percentage if FirstNumber equals 0"
            return;
        }

        $percentage = (1 - ($SecondNumber / $FirstNumber)) * 100

        return [Math]::Round($percentage, 2, [MidPointRounding]::AwayFromZero)
    }

    end {
        Write-Verbose "Operation '$($MyInvocation.MyCommand)' complete."
    }
}