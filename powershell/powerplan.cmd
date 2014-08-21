:: A simple cmd redirect that invokes the powershell script from a cmd shell
@powershell -ExecutionPolicy RemoteSigned -File "%~dp0\.\powerplan.ps1" %*