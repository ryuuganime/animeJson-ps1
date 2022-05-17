#culture="en-US"
ConvertFrom-StringData @'
  General_Answer                      = Jawaban
  General_Query                       = Kueri

  InitLocale_General_echo             = Sistem secara otomatis mengubah bahasa tampilan skrip ke
  InitLocale_General_prompt           = Apakah kamu ingin mengubah ke bahasa lainnya?
  InitLocale_List_echo                = Daftar bahasa yag tersedia sekarang:
  InitLocale_Replace_prompt           = Tuliskan kode bahasa. Tekan tombol enter/return/kembali untuk tetap menggunakan bahasa sistem
  InitLocale_Replace_success          = Bahasa tampilan skrip berhasil diubah ke

  InitScript_echo                     = Apakah kamu ingin menginisialisasi skrip (Windows memerlukan izin jalan sebagai admin)? (y/n)
  InitScript_success                  = Skrip telah sukses diinisialisaikan. Silakan jalankan kembali skrip (tanpa dijalankan sebagai admin)

  GetOS_IsWindows_echo                = Kamu sedang menggunakan Windows
  GetOS_IsLinux_echo                  = Kamu sedang menggunakan Linux
  GetOS_IsMac_echo                    = Kamu sedang menggunakan macOS
  GetOS_Unknown_e2                    = Kamu sedang menggunakan sistem operasi yang tidak diketahui. Silakan gunakan SO yang didukung: Windows, Linux, atau macOS

  GetAdmin_IsWindows_success          = Skrip sedang dijalankan sebagai administrator
  GetAdmin_IsWindows_e1               = Skrip sedang dijalankan bukan sebagai administrator, silakan pastikan skrip dijalankan sebagai administrator

  GetNotRoot_General_success          = Skrip sedang dijalankan bukan sebagai root
  GetNotRoot_General_e1               = Skrip sedang dijalankan sebagai root, silakan pastikan skrip dijalankan sebagai non-root

  GetAdminNegate_IsWindows_e1         = Skrip sedang dijalankan sebagai administrator, silakan pastikan skrip dijalankan bukan sebagai administrator
  GetAdminNegate_IsWindows_success    = Skrip sedang dijalankan bukan sebagai administrator

  CheckInternet_General_echo          = Memeriksa jika internet terhubung
  CheckInternet_General_success       = Internet tersedia
  CheckInternet_General_e6            = Internet tidak tersedia

  GetModule_General_echo              = Memeriksa jika modul skrip terpasang...
  GetModule_Module_Installed_success  = sudah terpasang
  GetModule_Module_Installed_e3       = belum terpasang, memasangkan...
  GetModule_Module_Choco_echo         = Memeriksa jika Chocolatey terpasang...
  GetModule_Module_Choco_Installed_e3 = Apakah kamu ingin memasankan npm melalui Chocolater? (y/n)
  GetModule_Module_Npm_Installed_e3   = npm belum terpasang, silakan pasang secara manual
  GetModule_Module_Npm_Installed_echo = Kunjungi https://nodejs.org/en/download/ untuk informasi lebih lanjut
  GetModule_Module_Choco_Npm_echo     = Memasangkan npm melalui Chocolatey...
  GetModule_Npm_Packages_echo         = Mengunduh dependensi npm...
  GetModule_Npm_Packages_success      = Dependensi npm sukses terpasang semua
  GetModule_Npm_Packages_e3           = Dependensi npm gagal terpasang

  OutFile_General_echo                = Membuat berkas init_success
  OutFile_General_success             = Berkas init_success tersedia

  GetEnv_Check_echo                   = Memeriksa jika berkas .env tersedia...
  GetEnv_Check_Exist_success          = Berkas .env tersedia
  GetEnv_Check_Exist_e5               = Berkas .env tidak tersedia, sedang membuat...
  GetEnv_Prompt_e4                    = Mohon untuk menyunting/mengedit .env melalui aplikasi editor teks utama kamu dan jalankan kembali skrip

  Greetings_General_echo              = Selamat datang kembali,
  Greetings_Init_echo                 = Mulailah mengetik judul metadata yang ingin dibuat. Tekan enter/return untuk mencari atau tekan Ctrl+C untuk keluar.
  Greetings_Search_echo               = Mencari di

  Query_GrabID_prompt                 = Ketik nomor ID entri untuk melanjuti ke langkah selanjutnya
'@
