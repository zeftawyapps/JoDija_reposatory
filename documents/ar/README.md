# بوابة التوثيق باللغة العربية - مستودع جوديجا

[English Version](../en/README.md) | **العربية**

مرحباً بك في بوابة التوثيق الرسمية لمكتبة **مستودع جوديجا (JoDija Repository)** باللغة العربية.

---

## 📚 الأقسام والأدلة المتاحة

### 🚀 الفلسفة المعمارية والبدء
- **[مقدمة في مستودع جوديجا](introduction_ar.md)**: شرح الفلسفة المعمارية والفرق بين التطبيقات أحادية الحلول ومتعددة الحلول.
- **[دليل التكامل مع متجر](integration_matger_guide_ar.md)**: الدليل العملي لربط مكتبة البيانات مع حزمة منطق الأعمال `matger front logic` وخادم `matger express`.

---

### ⚙️ التهيئة والأدوات المساعدة
- **[فئات التهيئة (DataSourceConfiguration)](../en/classes/configration.md)**: إدارة بيئات العمل (`localDev`, `dev`, `prod`) ومسارات الصور والـ Firebase.
- **[إدارة الترويسات (HttpHeader)](../en/classes/utils/HttpHeader.md)**: إدارة توكن المصادقة وترويسات اللغة `x-lang`.
- **[عميل الـ HTTP المتقدم (HttpClient)](../en/classes/utils/JodijaHttpClient.md)**: دعم الـ 5 طرق (GET, POST, PUT, DELETE, PATCH).
- **[نظام التسجيل والكونسول (JDRepoConsole)](../en/classes/utils/JDRepoConsole.md)**: السجلات الملونة وقياس الأداء والتنسيق.
- **[هرمية معالجة الأخطاء (HttpErrors)](../en/classes/utils/HttpErrors.md)**: معالجة أخطاء الشبكة والـ 13 كلاس خطأ المشتقة من `BaseError`.
- **[خدمة إشعارات السحابة (FCMService)](../en/classes/utils/FCMService.md)**: إعداد إشعارات Firebase Cloud Messaging.

---

### 📦 المستودعات ومصادر البيانات
- **[مستودع البيانات العام (DataSourceRepo)](../en/classes/implementations/DataSourceRepo.md)**: عمليات الـ CRUD للبيانات.
- **[مستودع تحميل القوائم (LoadDataRepo)](../en/classes/implementations/LoadDataRepo.md)**: جلب وعرض القوائم والمجموعات.
- **[مستودع المصادقة (BaseAuthRepo)](../en/classes/implementations/BaseAuthRepo.md)**: تسجيل الدخول وإنشاء الحسابات.
- **[مستودع المستخدمين (BaseUsersRepo)](../en/classes/implementations/UsersRepo.md)**: إدارة المستخدمين وحساباتهم.
- **[مستودع الملف الشخصي (BaseProfilRebo)](../en/classes/implementations/BaseProfilRebo.md)**: إدارة بيانات الملف الشخصي.
- **[موصل الـ REST API](file:///Users/moaz/Desktop/delta/tools/JoDija_reposatory/documents/en/classes/implementations/DataSourceDataActionsHttpSources.md)**: التواصل مع خوادم الـ REST.
- **[موصل الـ Firebase Firestore](file:///Users/moaz/Desktop/delta/tools/JoDija_reposatory/documents/en/classes/implementations/DataSourceFirebaseSource.md)**: التواصل مع قواعد بيانات Firestore.
- **[موصل البث المباشر (StreamFirebaseDataSource)](../en/classes/implementations/StreamFirebaseDataSource.md)**: البث اللحظي للبيانات.

---

### 📑 النماذج والنتائج
- **[النموذج الأساسي للبيانات (BaseEntityDataModel)](../en/classes/base_model/base_data_model.md)**: الكلاس الأب لجميع الكيانات.
- **[نموذج استجابات الخادم (RemoteBaseModel)](../en/classes/base_model/remote_base_model.md)**: النموذج القياسي لاستجابات الـ API.
- **[حاوية النتائج (Result)](../en/classes/results/result.md)**: تغليف النتائج والأخطاء.
- **[نماذج الجداول والخلايا (Cell Models)](../en/classes/base_model/cell_models.md)**: جداول البيانات وشاشات الإدارة.

---

### 🔍 الفهرس المرجعي
- **[الفهرس التفصيلي لجميع الفئات](../en/classes/class_summary.md)**
- **[العناوين الرئيسية](../en/the%20head%20lines%20.md)**
