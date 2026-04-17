// void main(){
//   String text = "Flutter Developer";
//   int count = 0;
//   for(int i = 0; i <= text.length-1; i++){
//     String ch = text[i].toLowerCase();
//     if(ch == " "){
//       continue;
//     }
//     if(ch == "a" || ch == "e" || ch == "i" || ch == "o" || ch == "u"){
//       count++;
//     }
//   }
//   print("Total Vowels:- $count");
// }

// void main(){
//   int num = 121;
//   int original = num;
//   int reverse = 0;
//   while(num > 0){
//     int digit = num % 10;
//     reverse = reverse * 10 + digit;
//     num = num ~/ 10;
//   }
//   if(original == reverse){
//     print("$original is Polindrome Number");
//   }
//   else{
//     print("$original isn't Polindrome Number");
//   }
// }

import 'dart:io';
import 'dart:math';

// void main(){
//   int num = 153;
//   int original = num;
//   int sum = 0;
//   int digits = num.toString().length;
//   while(num > 0){
//     int digit = num % 10;
//     sum = sum + pow(digit, digits).toInt();
//     num ~/= 10;
//   }
//   if(sum == original){
//     print("$original is ArmStrong Number");
//   }
//   else{
//     print("$original isn't ArmStrong Number");
//   }
// }

// void main(){
//   for(int i = 1; i <= 153; i++){
//     int num = i;
//     int original = num;
//     int sum = 0;
//     int digits = num.toString().length;
//     while(num > 0){
//       int digit = num % 10;
//       sum = sum + pow(digit, digits).toInt();
//       num ~/= 10;
//     }
//     if(sum == original){
//       print("$original is ArmStrong Number");
//     }
//     else{
//       print("$original isn't ArmStrong Number");
//     }
//   }
// }

// void main(){
//   List items = ["apple", "banana", "apple", "mango", "apple", "banana"];
//   Map count = {};
//   for(var i in items){
//     count[i] = (count[i] ?? 0) + 1;
//   }
//   var maxItem = "";
//   var maxCount = 0;
//   count.forEach((key, value){
//     if(value > maxCount){
//       maxCount = value;
//       maxItem = key;
//     }
//   });
//   print(maxItem);
// }

// void main(){
//   List items = ["apple", "banana", "apple", "mango", "apple", "banana"];
//   Map count = {};
//   for(var i in items){
//     count[i] = (count[i] ?? 0) + 1;
//   }
//   var maxItem = "";
//   var maxCount = 0;
//   count.forEach((key, value){
//     if(value > maxCount){
//       maxCount = value;
//       maxItem = key;
//     }
//   });
//   print(maxItem);
// }

// void main(){
//   String name = "Vikram Kumar";
//   String reversed = "";
//   for(int i = name.length-1; i >= 0; i--){
//     reversed += name[i];
//   }
//   print(reversed);
// }

// void main(){
//   int num = 5;
//   int factorial = 1;
//   for(int i = 1; i <= num; i++){
//     factorial = factorial * i;
//   }
//   print("Factorial of $num:- $factorial");
// }

// void main(){
//   List<int> numbers = [10,50,10,20,30,10,50,60,70,80];
//   List<int> uniqueNumbers = [];
//   for(int num in numbers){
//     if(!uniqueNumbers.contains(num)){
//       uniqueNumbers.add(num);
//     }
//   }
//   print(uniqueNumbers);
// }

// void main() {
//   List<int> numbers = [10, 50, 10, 20, 30, 10, 50, 60, 70, 80];
//
//   List<int> duplicates = [];
//   List<int> seen = [];
//
//   for (int num in numbers) {
//     if (seen.contains(num)) {
//       if (!duplicates.contains(num)) {
//         duplicates.add(num);
//       }
//     } else {
//       seen.add(num);
//     }
//   }
//
//   print("Duplicate values: $duplicates");
// }

// void main(){
//   List<int> numbers = [10,50,10,80,70,60,50,80];
//   List<int> duplicates = [];
//   List<int> seen = [];
//   for(int num in numbers){
//     if(seen.contains(num)){
//       if(!duplicates.contains(num)){
//         duplicates.add(num);
//       }
//     }
//     else{
//       seen.add(num);
//     }
//   }
//   print("Duplicates Value: $duplicates");
// }

// void main(){
//   List<int> num=[10,20,10,10,20,30,40,50,80,50,60,50,70,80,70];
//   List<int> dupl=[];
//   for(int i in num){
//     if(!dupl.contains(i)){
//       dupl.add(i);
//     }
//   }
//
//   for(int i in dupl){
//     int count=0;
//     for(int j in num){
//       if(i==j){
//         count++;
//       }
//     }
//     print("$i : $count");
//   }
//
// }

// void main(){
//   List<int> numbers = [10,80,70,10,80,70,50,90,100,10,80];
//   List<int> duplicates = [];
//   List<int> seen = [];
//   for(int num in numbers){
//     if(seen.contains(num)){
//       if(!duplicates.contains(num)){
//         duplicates.add(num);
//       }
//     }
//     else{
//       seen.add(num);
//     }
//   }
//   print("Duplicates Value: $duplicates");
// }

// void main(){
//   String course = "Flutter Developer";
//   for(var i = 0; i <= course.length-1; i++){
//     String ch = course[i].toLowerCase();
//     if(ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u'){
//       print("${course[i]}");
//     }
//   }
// }


// void main(){
//   List<int> numbers = [50,80,70,40,50,60,30,20];
//   List<int> uniqueNumbers = [];
//   for(int num in numbers){
//     if(!uniqueNumbers.contains(num)){
//       uniqueNumbers.add(num);
//     }
//   }
//   print(uniqueNumbers);
// }

// void main(){
//   List<int> numbers = [50,80,70,90,60,50,30,20,50];
//   Map<int, bool> uniqueNumbers = {};
//   for(int num in numbers){
//     uniqueNumbers[num] = true;
//   }
//   print(uniqueNumbers.keys.toList());
// }

/// Encapsulation

// class Person{
//   String _name = "";
//   void setName(String name){
//     _name = name;
//   }
//   String getName(){
//     return _name;
//   }
// }
// void main(){
//   Person person = Person();
//   person.setName("Vikram");
//   print(person.getName());
// }

/// Inheritance

// class Animal{
//   void eat(){
//     print("Animal is eating");
//   }
// }
// class Dog extends Animal{
//   void barks(){
//     print("Dog is Barking");
//   }
// }
//
// void main(){
//   Dog dog = Dog();
//   dog.eat();
//   dog.barks();
// }

/// Polymorphism

// class Animal{
//   void sound(){
//     print("Animal Sound");
//   }
// }
// class Dog extends Animal{
//   @override
//   void sound() {
//     print("Dog Barks");
//   }
// }
// class Cat extends Animal{
//   @override
//   void sound() {
//     print("Cat Meows");
//   }
// }
// void main(){
//   Animal a1 = Cat();
//   Animal a2 = Dog();
//   a1.sound();
//   a2.sound();
// }

/// Abstract Class

// abstract class Vehicle{
//   void start();
// }
// class Car extends Vehicle{
//   @override
//   void start(){
//     print("Car starts with key");
//   }
// }
// void main(){
//   Car car = Car();
//   car.start();
// }

// void main() {
//   for (int i = 0; i <= 100; i++) {
//     int count = 0;
//
//     for (int j = 1; j <= i; j++) {
//       if (i % j == 0) {
//         count++;
//       }
//     }
//
//     if (count == 2) {
//       print(i);
//     }
//   }
// }

// void main() {
//   for (int i = 1; i <= 100; i++) {
//     if (i % 2 == 0) {
//       print(i);
//     }
//   }
// }

// void main(){
//   List<int> num = [50,300,70,100,120,200];
//   int max = num[0];
//   int secondMax = num[0];
//   for(int i = 0; i < num.length; i++){
//     if(num[i] > max){
//       secondMax = max;
//       max = num[i];
//     }
//     else if(num[i] > secondMax && num[i] != max){
//       secondMax = num[i];
//     }
//   }
//   print(secondMax);
// }

// void main(){
//   List<int> num = [50,80,150,70,60,10];
//   int max = num[0];
//   for(int i = 0; i < num.length; i++){
//     if(num[i] > max){
//       max = num[i];
//     }
//   }
//   print("Maximum Number is :- $max");
// }

// void main(){
//   List<int> num = [50,80,100,40,90,100,120];
//   int min = num[0];
//   for(int i = 0; i < num.length; i++){
//     if(num[i] < min){
//       min = num[i];
//     }
//   }
//   print("Minimum Number is :- $min");
// }

// void main(){
//   List<int> num = [40,80,50,20,30,100];
//   int secondMin = num[0];
//   int min = num[0];
//   for(int i = 0; i < num.length; i++){
//     if(num[i] < min){
//       secondMin = min;
//       min = num[i];
//     }
//     else if(num[i] < secondMin && num[i] != min){
//       secondMin = num[i];
//     }
//   }
//   print(secondMin);
// }

// void main(){
//   int num = 121;
//   int temp = num;
//   int rev = 0;
//   while(num > 0){
//     int rem = num % 10;
//     rev = rev * 10 + rem;
//     num ~/= 10;
//   }
//   if(temp == rev){
//     print("$num is Palindrome Number");
//   }
//   else{
//     print("$num isn't Palindrome Number");
//   }
// }

// void main(){
//   List<int> numbers = [50,10,30,40,80,20,90];
//   for(int i = 0; i < numbers.length; i++){
//     for(int j = i + 1; j < numbers.length; j++){
//       if(numbers[i] > numbers[j]){
//         int temp = numbers[i];
//         numbers[i] = numbers[j];
//         numbers[j] = temp;
//       }
//     }
//   }
//   print(numbers);
// }