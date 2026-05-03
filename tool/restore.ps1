$historyDir = "$env:APPDATA\Code\User\History"

# Delete any stray small files from the new directories
Remove-Item -Force lib/auth/*, lib/home/*, lib/booking/*, lib/kredit/*, lib/core/* -ErrorAction SilentlyContinue

# Move splash_screen.dart (which was tracked and restored by git)
Move-Item lib/splash_screen.dart lib/auth/ -Force -ErrorAction SilentlyContinue

# Map file sizes to their correct destination
$map = @{
    6022  = "lib/core/hondaku_app.dart"
    8825  = "lib/home/aktivitas_page.dart"
    3165  = "lib/home/aktivitas_store.dart"
    7091  = "lib/booking/booking_berhasil_page.dart"
    16323 = "lib/home/catalog_page.dart"
    16782 = "lib/booking/checkout_payment_method_page.dart"
    28409 = "lib/booking/data_pemesan_page.dart"
    26295 = "lib/home/home_page.dart"
    8859  = "lib/kredit/konfirmasi_pengajuan_page.dart"
    13563 = "lib/auth/login_screen.dart"
    12329 = "lib/auth/onboarding_screen.dart"
    21469 = "lib/booking/pembayaran_booking_page.dart"
    17379 = "lib/home/profile.dart"
    12014 = "lib/auth/register_screen.dart"
    21163 = "lib/booking/ringkasan_pembayaran_page.dart"
    13300 = "lib/kredit/simulasi_kredit_page.dart"
    11799 = "lib/kredit/upload_dokumen_kredit_page.dart"
    22031 = "lib/home/product_detail_screen.dart"
}

foreach ($size in $map.Keys) {
    $file = Get-ChildItem -Path $historyDir -Recurse -File | Where-Object { $_.Length -eq $size } | Select-Object -First 1
    if ($file) {
        Copy-Item -Path $file.FullName -Destination $map[$size] -Force
        Write-Output "Restored $($map[$size])"
    } else {
        Write-Output "Failed to find file of size $size"
    }
}

# Remove stray duplicates restored by git at the root of lib/
$rootFiles = @("catalog_page.dart", "home_page.dart", "hondaku_app.dart", "login_screen.dart", "onboarding_screen.dart", "register_screen.dart")
foreach ($rf in $rootFiles) {
    Remove-Item "lib/$rf" -Force -ErrorAction SilentlyContinue
}
