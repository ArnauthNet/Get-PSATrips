Function Get-DateFromEpoch {
	param (
		[Parameter(Mandatory=$true)]
		$unixTime
	)
	$epoch = New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0
	Write-output $epoch.AddSeconds($unixTime)
}

$trips = Get-Content ".\my_psa.trips" | ConvertFrom-Json

$myTrips = New-Object System.Collections.Generic.List[System.Object]


foreach ($trip in $trips.trips) {
    $currentTrip = [pscustomobject]@{
        tripDate = Get-DateFromEpoch -unixTime $trip.dte
        tripDuration = $trip.tme
        tripGasConsumption = $trip.vol
        tripDistante = $trip.dst/1000
        tripGasAverage = ($trip.vol*100) / ($trip.dst/1000)
    }
    $myTrips.Add($currentTrip)
}

$myTrips | select -last 1