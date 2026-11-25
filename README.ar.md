![JoDija Logo](https://raw.githubusercontent.com/zeftawyapps/JoDija_reposatory/master/assets/jodija_logo.png)

# مستودع بيانات جوديجا (`jodija_repository`)

[![pub package](https://img.shields.io/pub/v/jodija_repository.svg)](https://pub.dev/packages/jodija_repository)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/zeftawyapps/JoDija_reposatory/blob/master/LICENSE)

إطار عمل موحّد لإدارة **مستودعات البيانات (Repositories)، طلبات الشبكة عبر Dio، وخدمات Firebase** لتطبيقات Flutter على جميع المنصات (**Android, iOS, Web, macOS, Windows, Linux**).

🌐 **English Version:** [🇬🇧 Read in English (README.md)](https://github.com/zeftawyapps/JoDija_reposatory/blob/master/README.md) • [📚 بوابة التوثيق الكاملة](https://github.com/zeftawyapps/JoDija_reposatory/blob/master/documents/ar/README.md)

---

## ماذا تقدم لك مكتبة `jodija_repository`؟

سواء كنت تبني **تطبيقاً مستقلاً واحداً** أو **منظومة متعددة التطبيقات** (تطبيق عميل + تطبيق تاجر + لوحة تحكم تشترك في حزمة منطق أعمال واحدة)، توفر لك المكتبة طبقة بيانات جاهزة وموحّدة دون تكرار أكواد `Dio` أو التوكن أو معالجة الأخطاء:

* **إدارة البيئات (`DataSourceConfigration`):** التبديل الفوري بين بيئات `local` و`remote_dev` و`remote_prod` لروابط الـ API وروابط الصور.
* **عميل شبكة متكامل (`HttpClient`):** يدعم `GET`, `POST`, `PUT`, `PATCH`, `DELETE` ورفع الملفات `MultipartFile` وحقن التوكن (`Authorization: Bearer`) واللغة (`x-lang`) تلقائياً.
* **معالجة أخطاء ونتائج آمنة (`Result` و`BaseError`):** تغليف جميع العمليات داخل `Result<RemoteBaseModel, Data>` بدلاً من الـ Exceptions العشوائية.
* **موصلات Firebase جاهزة:** عمليات CRUD على Firestore (`DataSourceFirebaseSource`)، البث اللحظي (`StreamFirebaseDataSource`)، رفع الملفات (`StorageActions`)، وتسجيل الدخول عبر البريد أو Google (`BaseAuthRepo`).

---

## البدء السريع (خطوة بخطوة)

### 1. التثبيت

```bash
flutter pub add jodija_repository
```

أو في ملف `pubspec.yaml`:

```yaml
dependencies:
  jodija_repository: ^1.7.2
```

---

### 2. تهيئة الروابط والترويسات عند بدء التطبيق

```dart
import 'package:flutter/material.dart';
import 'package:jodija_repository/jodija_repository.dart';

class AppConfig extends DataSourceConfigration {}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig()
    ..envType = EnvType.dev
    ..backendState = BackendState.remote_dev
    ..appType = AppType.App;

  config.setToHttpUrlsEnveiroment(
    baseUrl: 'https://api.example.com/api/v1',
    imageBaseUrl: 'https://cdn.example.com/',
  );

  // ضبط لغة الطلبات الافتراضية (يرسل ترويسة x-lang: ar تلقائياً)
  HttpHeader().setLangHeader(lang: 'ar');

  runApp(const MyApp());
}
```

---

### 3. إنشاء نموذج البيانات (`BaseEntityDataModel`)

```dart
import 'package:jodija_repository/jodija_repository.dart';

class ProductModel extends BaseEntityDataModel {
  final String title;
  final double price;

  ProductModel({
    super.id,
    required this.title,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String? docId) {
    return ProductModel(
      id: docId ?? json['id']?.toString(),
      title: json['title'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
      };
}
```

---

### 4. جلب وإضافة البيانات عبر REST API (`DataSourceRepo`)

```dart
// جلب قائمة المنتجات (GET /products)
final source = DataSourceDataActionsHttpSources<ProductModel>(
  url: 'products',
  dataBuilder: (json, id) => ProductModel.fromJson(json, id),
);
final repo = DataSourceRepo<ProductModel>(inputSource: source);

final result = await repo.getListData();
if (result.hasDataOnly) {
  final products = result.data?.data ?? [];
  JDRepoConsole.success('تم جلب ${products.length} منتج');
} else {
  JDRepoConsole.error('حدث خطأ: ${result.error?.message}');
}
```

---

### 5. المصادقة وتسجيل الدخول (`BaseAuthRepo`)

```dart
// تسجيل الدخول عبر REST API
final authRepo = BaseAuthRepo(
  AuthHttpSource(email: 'user@example.com', pass: 'secret123'),
);
final loginResult = await authRepo.logIn();

if (loginResult.hasDataOnly) {
  HttpHeader().setAuthHeader(loginResult.data!.token ?? '');
}
```

---

## فهرس التوثيق التفصيلي

* [مقدمة الفلسفة المعمارية (عربي)](https://github.com/zeftawyapps/JoDija_reposatory/blob/master/documents/ar/introduction_ar.md)
* [دليل التكامل للمشاريع متعددة التطبيقات (عربي)](https://github.com/zeftawyapps/JoDija_reposatory/blob/master/documents/ar/integration_matger_guide_ar.md)
* [شرح DataSourceConfiguration](https://github.com/zeftawyapps/JoDija_reposatory/blob/master/documents/en/classes/configration.md)
* [شرح HttpClient و HttpHeader](https://github.com/zeftawyapps/JoDija_reposatory/blob/master/documents/en/classes/utils/JodijaHttpClient.md)
* [الفهرس المرجعي الكامل للكلاسات](https://github.com/zeftawyapps/JoDija_reposatory/blob/master/documents/en/classes/class_summary.md)
