import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FILE DOWNLOADING"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Download file from internet',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: downloadfile,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void downloadfile()async {
    var status=await Permission.storage.request();
    if(status==PermissionStatus.granted){

String paths="https://s3bits.com/ERconnectUpdated/content/815383465.pdf";
      String extension = path.extension(paths);
print(extension);
      FileDownloader.downloadFile(
          url: paths,
          name: "filename${extension}",
          onProgress: (String? filename,double process){
            print("FILE $filename HAS PROGRESS $process") ;
          },
          onDownloadCompleted: (String path){
            SnackBar(
              content:  Text('File saved to Gallery'),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
          },
          onDownloadError: (String error){
            SnackBar(
              content:  Text('Failed To Download file'),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
          }
      );
    }else{
      print("Permission is not granted");
    }
  }
}
