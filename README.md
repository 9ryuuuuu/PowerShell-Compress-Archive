# Zip compression PowerShell script with password

## Description

This is a PowerShell Script enabling compress file or directory with password.

## Requirnment

* PowerShell6
* 7z.exe must be installed on your machine. And 7z command can be used.
  * To install 7z.exe, go to [7-zip](https://www.7-zip.org/).

## DESCRIPTION
* Displays the password if compression successed.
* The output file name is the target name with a zip extension.
* If the output file already exists, it will be overwritten.

## Motivation
In some business habits, When sending an email with a file attached, it is necessary to compress the file with a different password each time.

It ’s hard to think of a different password every time.

This script compresses the file and sets a different password each time.

## Example

* Compress the target.
  ```PowerShell
    Compress-ArchiveWithPassword.ps1 target_path
  ```

* Compress the target by specifying the password length 10.
  ```PowerShell
    Compress-ArchiveWithPassword.ps1 target_path 10
  ```