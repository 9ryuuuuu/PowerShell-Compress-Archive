<#
.SYNOPSIS
パスワード付きzip圧縮を行います。

.DESCRIPTION
成功すると使用したパスワードを表示します。
圧縮対象のファイルの拡張子をzipにしたものが出力ファイル名になります。
出力ファイルがすでに存在する場合上書きします。
環境変数のpathに7zip.exeが登録されている必要があります。

.EXAMPLE
# 対象ファイルを圧縮する。
./Compress-ArchivePassword.ps1 対象ファイルのパス

.EXAMPLE
# パスワードの文字数を指定して対象ファイルを圧縮する。
./Compress-ArchivePassword.ps1 対象ファイルのパス 10

.NOTES

.LINK

#>
param(
    [Parameter(Mandatory = $true)] # 圧縮対象のパスを指定します。
    [string]
    [ValidateScript( {
            if ((Test-Path $_)) {
                return $true
            }
            else {
                throw "`n圧縮対象のパス${_}が存在しません。`n"
            }
        })]
    $TargetPath,
    [Parameter(Mandatory = $false)] # パスワードの文字数を指定します。
    [int]
    [ValidateScript( {
            if ($_ -ge 1) {
                return $true
            }
            else {
                throw "`nPasswordNumberは1以上の整数値を指定してください。`n"
            }
        })]
    $PasswordNumber = 8
)


if (-Not (Get-Command '7z' -errorAction SilentlyContinue)) {
    "本スクリプトを実行するには7zコマンドが使用できる必要があります。"
    exit 1
}
$FileName = Split-Path $TargetPath -LeafBase
$CompressPath = Join-path (Split-Path $TargetPath) "${FileName}.zip"
$Password = -join ( (33..125) | Get-Random -Count $PasswordNumber | ForEach-Object { [char]$_ })
& '7z.exe' 'a' "$CompressPath" "$TargetPath" "-p${Password}" '-tzip' | Out-Null
Write-Host "${Password}"