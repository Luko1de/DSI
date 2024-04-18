import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('MovieBox'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Recomendados'),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: 10,
                  options: CarouselOptions(
                    height: 250,
                    viewportFraction: 0.55,
                    pageSnapping: true,
                  ),
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 300,
                        width: 200,
                        child: Image.asset('assets/homem_aranha.jpeg'),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              Text('Últimos Avaliados'),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: 10,
                  options: CarouselOptions(
                    height: 250,
                    viewportFraction: 0.55,
                    pageSnapping: true,
                  ),
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 300,
                        width: 200,
                        child: Image.asset('assets/homem_aranha.jpeg'),
                      ),
                    );
                  },
                ),
              ),
            ])));
  }
}
