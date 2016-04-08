function Start-Linux {
  $linuxVmName = "ubuntu-vm"
  if ((Get-VM $linuxVmName | Select-Object -ExpandProperty State) -eq "Running") {
    Write-Warning "Linux VM is already started"
  }
  else {
    while ((Get-VM $linuxVmName | Select-Object -ExpandProperty State) -ne "Running")
    {
      try {
        Start-Vm $linuxVmName -ErrorAction Stop
      }
      catch {
        Write-Warning "Failed to start VM, retrying in 2 seconds"
        Start-Sleep -Seconds 2
      }
    }
  }
  
  vmconnect localhost $linuxVmName
}

Set-Alias linux Start-Linux

Export-ModuleMember -Function * -Alias *