param(
    [string]$path,
    [string]$solutionName = "Solution",
    [string]$applicationName = "Solution.App",
    [Parameter(Position = 0)]
    [ValidateSet('console', 'mvc', 'webapp')]
    [string]$applicationType = "console",
    [switch]$sqlFolder
)

if(![string]::IsNullOrWhiteSpace($path)) {
    Set-Location $path
}

mkdir $solutionName

Set-Location $solutionName

git init

dotnet new sln -n $solutionName

mkdir src

if($sqlFolder.IsPresent){
    mkdir sql
}

Set-Location src

dotnet new $applicationType -n $applicationName

Set-Location ..

$csprojFilePath = "src/" + $applicationName + "/" + $applicationName + ".csproj"
dotnet sln add $csprojFilePath

git add .
git commit -m 'create solution'

write-host "`r`npress any key to continue.."
[Console]::ReadKey()

