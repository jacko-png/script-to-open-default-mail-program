Observations
============
• FOR can be used to process strings
• HKCU\SOFTWARE\Clients\Mail and HKLM\… have information about the default mail client
    • This information can be used to infer the executable of the mail client
• ApplicationIcon may contain the name of the executable

Line-by-line
============
1. Find the name of the program in HKCU first, then HKLM
    • is `IF "[%APP%]"=="[]"` good enough?
2. Use %APP% to infer the Registry key that contains the ApplicationIcon value
3. Process %RPATH% into the likely path of the executable
    • TODO check that the found file is an executable and not, say, a dll or ico.
4. START the executable with the title bar found in the registry

