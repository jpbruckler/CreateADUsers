
Describe 'Test-MandatoryFields' {
    BeforeAll {
        $parentPath     = Split-Path $PSScriptRoot
        $scriptFiles    = Get-ChildItem -Path $parentPath -Filter *.ps1
        $scriptFiles | ForEach-Object { 
            . $_.FullName 
        }
    }
    It 'should return true if all mandatory fields are present' {
        $inputObject = [PSCustomObject]@{
            Username = 'user1'
            EmployeeID = '123'
            Department = 'IT'
            FirstName = 'John'
            LastName = 'Doe'
            State = 'CA'
        }
        $result = $inputObject | Test-MandatoryFields
        $result | Should -BeTrue
    }

    It 'should throw an exception if a mandatory field is missing and Quiet is not specified' {
        $inputObject = [PSCustomObject]@{
            Username = 'user2'
            EmployeeID = '456'
            FirstName = 'Jane'
            LastName = 'Doe'
            State = 'NY'
        }
        { $inputObject | Test-MandatoryFields } | Should -Throw "Missing mandatory field(s): Department"
    }

    It 'should return false if a mandatory field is missing and Quiet is specified' {
        $inputObject = [PSCustomObject]@{
            Username = 'user2'
            EmployeeID = '456'
            FirstName = 'Jane'
            LastName = 'Doe'
            State = 'NY'
        }
        $result = $inputObject | Test-MandatoryFields -Quiet
        $result | Should -BeFalse
    }
}
