# Dokumentasi Alur Kerja Aplikasi

- [Figma Alur Kerja Aplikasi](https://www.figma.com/file/NmZVajMTx1O8DIIBnRQva3/Alur-Kerja-Aplikasi?type=design&node-id=0%3A1&mode=design&t=utOoaTlSZjpGGQQ9-1)

# Struktur Folder 
sebelum melanjutkan ke koding dan logika yang ada anda perlu dulu memahami struktur folder yang ada dan kegunaan nya, berikut ini merupakan fungsi dan kegunaan nya:
- module
    - add_head_location
        - controller
        - view
        - widget
    - add_location_part
        - controller
        - view
        - widget
     - admin_detail_item
        - controller
        - view
        - widget
    - admin_detail_user
        - controller
        - view
        - widget
    - admin_list_items
        - controller
        - view
        - widget
    - admin_manage_user
        - controller
        - view
        - widget
    - dashbord
        - controller
        - view
        - widget
    - detail_item
        - controller
        - view
        - widget
    - head_location
        - controller
        - view
        - widget
    - input_parts
        - controller
        - view
        - widget
    - input_scans
        - controller
        - view
        - widget 
     - list_items
        - controller
        - view
        - widget 
    - list_part
        - controller
        - view
        - widget
    - location_part
        - controller
        - view
        - widget
    - location_part_detail
        - controller
        - view
        - widget
    - login
        - controller
        - view
        - widget
    - rak_location
        - controller
        - view
        - widget
    - register_user
        - controller
        - view
        - widget
    - report
        - controller
        - view
        - widget
    - report_menu
        - controller
        - view
        - widget
    - search_part
        - controller
        - view
        - widget
    - search_sertting
        - controller
        - view
        - widget
    - update_scans
        - controller
        - view
        - widget               
- shared
    - color
    - service
    - widget
- core.dart
- main.dart
#### Module 
berfungsi untuk menyimpan screen dari aplikasi, daldam screen ini terdiri atas 3 folder utama yaitu view, controller widget, view berfungsi untuk menampilkan screen yang ada, controller merupakan bagian untuk mengatur state dan logika, dan widget yang berfungsi untuk menyimpan reusable widget dalam screen ini.

#### Shared
berfungsi untuk menyimpan semua service, utili, reusable widget dan sebagainya

#### Core
fungsi dari core adalah untuk menyimpan alamat dari file dan mengexport nya

#### Main
main merupakan file utama yang akan di akses oleh program untuk pertama kali di jalankan

