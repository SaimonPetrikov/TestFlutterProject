import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/apod/data/today_photo/today_photo.dart';
import 'package:flutter_project/features/apod/presentation/components/date_picker.dart';

import '../../../../core/constant.dart';
import '../../../../core/data/api/resource.dart';
import '../../../../core/data/api/service_locator.dart';
import '../bloc/apod_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.builder(
      creator: (_, __) => HomeBloc(sl.get()),
      builder: (context, HomeBloc bloc) {
        return Scaffold(
          backgroundColor: const Color(0xFF0D1B26),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: kPrimaryColor,
            title: const Text('Today Photo from Apod'),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
          ),
          body: Stack(
            children: <Widget>[
              StreamBuilder<Resource<TodayPhoto>>(
                stream: bloc.apod,
                builder: (context, snapshot) {
                  final status = snapshot.data?.status;

                  if (status == Status.LOADING) {
                    return Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  }

                  if (status == Status.ERROR) {
                    return Container(
                      alignment: Alignment.center,
                      child: const Text('Oops, something went wrong!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red)),
                    );
                  }

                  final photo = snapshot.data?.data;

                  return SingleChildScrollView(
                    child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text('${photo?.title}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Image.network('${photo?.url}'),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 200.0),
                            child: DatePicker(dateNow: photo?.date),
                          ),
                        ],
                      ),
                  );
                },
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.15,
                minChildSize: 0.15,
                maxChildSize: 0.8,
                builder: (context, scrollController) => Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    color: Colors.white
                  ),
                  alignment: Alignment.topCenter,
                  child: StreamBuilder<Resource<TodayPhoto>>(
                    stream: bloc.apod,
                    builder: (context, snapshot) {
                      final status = snapshot.data?.status;

                      if (status == Status.LOADING) {
                        return Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      }

                      if (status == Status.ERROR) {
                        return Container(
                          alignment: Alignment.center,
                          child: const Text('Oops, something went wrong!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red)),
                        );
                      }

                      final photo = snapshot.data?.data;
                      return Container(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              controller: scrollController,
                              padding: const EdgeInsets.only(top: 70.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                    child: const Text('Explanation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                                    child: Text('${photo?.explanation}', style: const TextStyle(fontSize: 14)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                                  color: Colors.white
                              ),
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                                controller: scrollController,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: <Widget> [
                                        Image.asset('assets/icon/nasa.svg', width: 40, height: 40),
                                        Text('${photo?.title}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );},
                  ),
                ),
              )
            ]
          ),
        );
      },
    );
  }
}
