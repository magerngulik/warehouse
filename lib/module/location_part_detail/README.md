# Halaman Location Part Detail
pada halaman ini ada yang agak berbeda dari sebelumnya, dihalaman ini akan melakukan load melalui stream jadi jadi nya tidak diload melalui variable dan update secara manual, untuk jelas nya sebagai berikut:
```dart
  StreamBuilder(
        //pada steam akan menggunakan stream builder dengan query sebagai berikut, data nya akan di tampilkan dalam snapshot
        stream: WarehouseServices.getStreamById(
            column: "head_location_id",
            tblName: "location",
            id: dataHead['id']),
        builder: (context, snapshot) {
          //jika error
          if (!snapshot.hasError) {
            const Center(
              child: Text("error"),
            );
          }
          //jika data nya ada tapi sedang di load
          if (!snapshot.hasData) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }

          //ketika data nya null
          if (snapshot.data == null) {
            return const Center(
              child: Text(
                "Belum ada data yang tersedia",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            );
          }
          //ini adalah variable untuk didapatkan shapshot.data
          final listHeadLocation = snapshot.data;
        }
  )
```