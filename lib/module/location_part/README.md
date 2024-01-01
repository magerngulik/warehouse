# Halaman Location Part
ini merupakan halaman setelah dari menu admin untuk tampilan dari menu ini seperti ini:
![menu_admin](/assets/image/menu_admin/location_part.png)

pada halaman ini akan menggunakan stream yang diatur pada controller seperti berikut ini:
```dart
//fungsi di bawah ini akan melakukan stream ke tabel head_location
Stream<List<Map<String, dynamic>>> getHeadLocation() {
    return supabase
        .from('head_location')
        .stream(primaryKey: ['id']).order('created_at', ascending: true);
  }
```
dalam view akan diload kedalam stream seperti berikut ini:
```dart
StreamBuilder(
            stream: controller.getHeadLocation(),
            builder: (context, snapshot) {
              if (!snapshot.hasError) {
                const Center(
                  child: Text("erro"),
                );
              }

              if (!snapshot.hasData) {
                const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data == null) return Container();
              final listHeadLocation = snapshot.data;
              return ListView.builder(
                itemCount: listHeadLocation!.length,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var item = listHeadLocation[index];
                  return InkWell(
                    onTap: () {
                      Get.to(LocationPartDetailView(
                        dataHead: item,
                      ));
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "${item['location_name']}",
                          //data di consume pad a bagian ini
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
```