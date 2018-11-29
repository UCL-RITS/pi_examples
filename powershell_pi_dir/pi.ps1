# PowerShell Pi example.
# Tested on PowerShell Core 6.1.0 on Ubuntu.

$n = 10000000

if ($args.length -gt 0) {
  $n = $args[0]
}

Write-Host "Calculating PI using:"
Write-Host "  " $n "slices"
Write-Host "   1 process"

$timer = New-Object System.Diagnostics.Stopwatch
$timer.Start()

$s = 0.0
$step = 1.0/$n

for ($i=1; $i -le $n; $i++) {
	$x = ($i - 0.5) * $step
	$s = $s + (4.0/(1.0+($x*$x)))
}

$p = $s * $step

$timer.Stop()
$elapsed = $timer.ElapsedMilliseconds/1000
Write-Host "Obtained value of PI:" $p 
Write-Host "Time taken:" $elapsed "seconds"
