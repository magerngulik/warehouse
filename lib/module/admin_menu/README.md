# Halaman Admin Menu
pada menu admin ini akan menampilkan akan menampilkan navigasi ke beberapa halaman. 
- [head location](../head_location/README.md)
- [location part](../location_part/README.md)
- [list part](../list_part/README.md)
- [admin list item](../admin_list_items/README.md)
- [admin manage user]() 
- [report](../report/README.md) 
<br>

untuk tampilan halaman ini sebagai berikut
![admin menu](/assets/image/menu_admin/admin_menu.png)

```dart
List<Map<String, dynamic>> halaman = [
    {
      "title": "Input Head Location",
      "ontap": const HeadLocationView(),
      "image": "assets/icons/input head location.png"
    },
    {
      "title": "Input Location",
      "ontap": const LocationPartView(),
      "image": "assets/icons/input location.png"
    },
    {
      "title": "List Part Area",
      "ontap": const ListPartView(),
      "image": "assets/icons/list area part.png"
    },
    {
      "title": "Manage Part Data",
      "ontap": const AdminListItemsView(),
      "image": "assets/icons/manage part data.png"
    },
    {
      "title": "Kelola Akun",
      "ontap": const AdminManageUserView(),
      "image": "assets/icons/kelola akun.png"
    },
    {
      "title": "Report",
      "ontap": const ReportView(),
      "image": "assets/icons/report.png"
    },
  ];

```
dari list di atas akan di tampilkan pada halaman view sebagi berikut:
```dart
GridView.builder(
    padding: const EdgeInsets.all(15.0),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: 1.0,
      crossAxisCount: 2,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
    ),
    itemCount: controller.halaman.length,
    shrinkWrap: true,
    physics: const ScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      //item dari list tadi dimasukan sesuai dengan index
      var item = controller.halaman[index];

      return InkWell(
        onTap: () {
          //di push berdasarkan halaman yang telah di daftarkan di list
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => item['ontap'] as Widget),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //load image variable
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      item["image"],
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      8.0,
                    ),
                  ),
                ),
              ),
              //load title variable
              Text(
                item['title'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      );
    },
  ),
```