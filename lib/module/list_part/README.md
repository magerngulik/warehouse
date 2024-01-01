# Halaman List Part
pada halaman ini akan melakukan load pada tabel head_location sebagai parameter untuk halaman selanjutnya
![list_part](/assets/image/menu_admin/list_part.png)

```dart
//ini list akan di tampilkan pada view
var menu = [].obs;
//ini merupakan bagian untuk get data dari tabel head_location
getHeadTable() async {
    try {
      var data = await supabase
          .from("head_location")
          .select("*")
          .order('created_at', ascending: true);
      // debugPrint("data: $data");
      menu = RxList<Map<String, dynamic>>.from(data);
      // debugPrint("menu: $menu");
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

//kemudian panggil fungsi ini pada oninit
  @override
  void onInit() {
    super.onInit();
    getHeadTable();
  }

  selanjutnya list yang sudah di load akan di panggil pada bagian view

  List.generate(controller.menu.length, (index) {
    //ini item akan di looping berdasarkan index
    var item = controller.menu[index];
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: () {
          //pada bagian ini akan di push ke halaman lain dengan membagwa data dari list yang di pilih
          Get.to(RakLocationView(
            data: item,
          ));
          debugPrint("data from rak list data: $item");
        },
        child: Card(
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              //ini merupakan data item yang di maping bernama location_name
              "${item['location_name']}",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }),

```
