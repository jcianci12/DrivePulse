# Drive Pulse - Powershell network drive benchmarker and diagnostic.

We were having some issues with writing to a network drive at work.

The issues were intermittent, so we needed a way to prove they were happening.

This little powershell script will try to write a 4mb file to a location of your choice and then remove it every 5 seconds.

Adjust the script as neccessary or feel free to create a pull request to extend its use 😎