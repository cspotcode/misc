param (
  [parameter(Position = 0,
             Mandatory = $False,
             HelpMessage = "The name of a power mode to switch to.")]
  [string]
  $PowerModeName
)

Add-Type -Language CSharp @"
public class PowerMode {
  public string name;
  public string guid;
  public bool isActive;
}
"@

# Get a list of power profiles, with names and GUIDs
$powerPlans = powercfg /L | % {
  if ($_ -match ": (\S+)  \(([^\)]+)\)\s*(\*?)") {
    $ret = New-Object PowerMode
    $ret.name = $matches[2]
    $ret.guid = $matches[1]
    $ret.isActive = $matches[3] -eq "*"
    return $ret
  } else {
    return $Null
  }
} | Where { $_ -ne $Null }

if($PowerModeName -eq "") {
  return $powerPlans
} else {
  # Find the power plan that the user specified using wildcard matching.
  # This allows the user to enter only part of the plan's name
  $matchingPowerPlans = @( $powerPlans | Where { $_.name -Like ("*" + $PowerModeName + "*") } )
  # If no matching plans were found, that's a problem
  if($matchingPowerPlans.Length -eq 0) {
    Write-Error ("No such power plan: " + $PowerModeName)
    return
  # If multiple plans match, that's also a problem
  } elseif($matchingPowerPlans.Length -gt 1) {
    $matchingNames = $matchingPowerPlans | % { """" + $_.name + """" }
    $matchingNames = $matchingNames -join ", "
    Write-Error ("Multiple power plans match name """ + $PowerModeName + """: " + $matchingNames)
    return
  } else {
    # Found exactly one matching plan.  Enable it
    $powerPlan = $matchingPowerPlans[0]
    #return $matchingPowerPlans
    powercfg /S $($powerPlan.guid)
  }
}