function Test-MandatoryFields {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [PSObject]$InputObject,
        [Switch]$Quiet
    )

    begin {
        $mandatoryFields = @(
            'Username',
            'EmployeeID',
            'Department',
            'FirstName',
            'LastName',
            'State'
        )
        $missingFields = @()
    }

    process {
        foreach ($field in $mandatoryFields) {
            if (-not $InputObject.PSObject.Properties.Name.Contains($field)) {
                $missingFields += $field
            }
        }
    }

    end {
        if ($missingFields.Count -gt 0) {
            $errorMessage = "Missing mandatory field(s): $($missingFields -join ', ')"
            if ($Quiet) {
                return $false
            }
            else {
                throw [System.ArgumentException]::new($errorMessage)
            }
        }
        return $true
    }
}