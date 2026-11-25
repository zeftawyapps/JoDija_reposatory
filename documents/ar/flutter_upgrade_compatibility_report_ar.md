# تقرير مراجعة التوافق وتحديث Flutter قبل رفع `jodija_repository` على pub.dev

**تاريخ المراجعة:** 2026-11-25  
**إصدار Flutter المثبّت حالياً على الجهاز:** `Flutter 3.51.0-1.0.pre-49` / `Dart 3.11.1`  
**النطاق:** `JoDija_reposatory` (`jodija_repository`)، `jodija_tamplites`، `shahbandar-v1`، `darElEzz`، `imarati-app-main`  
**نسخة Google Docs:** [فتح التقرير على Google Docs](https://docs.google.com/document/d/1ucGfJWOap5RkHxGbkAFK46ArjA1lO5EuIXb1pDJpoXk/edit)

---

## 1. ملخص حالة المشاريع الأربعة

| المشروع | ملف الإعداد | قيد `sdk` | `.fvmrc` | اعتماده على مكتبات JoDija |
| --- | --- | --- | --- | --- |
| **JoDija Repository** | `tools/JoDija_reposatory/pubspec.yaml` | `>=3.0.6 <4.0.0` | `3.41.4` | الحزمة الأساسية (تم توحيد اسمها إلى `jodija_repository` v1.7.0) |
| **JoDija Tamplites** | `tools/jodija_tamplites/pubspec.yaml` | `>=3.0.6 <4.0.0` | `3.41.4` | تم توحيد اسمها إلى `jodija_tamplites` (v3.1.0) |
| **Shahbandar Core Logic** | `shahbandar-v1/shahbandar_core_logic _front/pubspec.yaml` | `^3.10.0` | `3.41.4` | يعتمد بمسار محلي (`path`) على الاسم القديم `JoDija_reposatory` |
| **Shahbandar Client App** | `shahbandar-v1/shabandar-client-app/pubspec.yaml` | `^3.10.0` | `3.41.4` | يعتمد بمسار محلي (`path`) على الاسم القديم `JoDija_tamplites` |
| **Shahbandar Management App** | `shahbandar-v1/shahbandar-mangement-app/pubspec.yaml` | `^3.10.0` | `3.41.4` | يعتمد بمسار محلي (`path`) على الاسم القديم `JoDija_tamplites` |
| **Dar El Ezz** | `mohammed_towfeeq/darElEzz/pubspec.yaml` | `^3.11.1` | لا يوجد | يعتمد عبر `git` على `JoDija_reposatory` (`v1.7.0`) و`JoDija_tamplites` (`v3.0.3`) |
| **Imarati** | `custmes products/imarati-app-main/pubspec.yaml` | `>=3.6.0 <4.0.0` | لا يوجد | مستقل حالياً، ويستخدم `firebase_core ^3.8.1` و`firebase_messaging ^15.1.6` |

---

## 2. نقاط الخطر والتعارض قبل التحديث

### أولاً: تعارض أسماء الحزم المحلية (يكسر `flutter pub get` في Shahbandar)
- مشروع `shahbandar_core_logic _front` ما زال يطلب الحزمة باسم `JoDija_reposatory` عبر مسار محلي يشير مباشرة إلى مجلد `JoDija_reposatory`. بعد تغيير الاسم إلى `jodija_repository` سيفشل `flutter pub get` حتى يتم تحديث الاسم في `pubspec.yaml` وتحديث الـ imports إلى `package:jodija_repository/`.
- مشروعا `shabandar-client-app` و`shahbandar-mangement-app` ما زالا يطلبان `JoDija_tamplites` (بأحرف كبيرة) عبر مسار محلي، بينما اسم الحزمة الفعلي في `jodija_tamplites/pubspec.yaml` أصبح `jodija_tamplites` (أحرف صغيرة).
- مشروع **Dar El Ezz** لن يتأثر فوراً لأنه مربوط بـ Git tag (`v1.7.0` و`v3.0.3`)، ولكن عند نقله للاعتماد على `pub.dev` سيحتاج تحديث الاسمين والـ imports.

### ثانياً: اعتماديات غير مستخدمة داخل `jodija_repository` تسبب تعارضات بلا داعٍ
بالفحص المباشر لجميع الـ imports في مجلد `lib/` داخل `jodija_repository` تبيّن أن الحزم الخمس التالية **غير مستخدمة إطلاقاً في الكود**:
- `flutter_bloc`: ترقيتها إلى `^9.1.1` ستتعارض مباشرة مع `jodija_tamplites` (`^8.1.1`) ومع `shahbandar` (`flutter_bloc ^8.1.6` و`bloc ^8.1.4`). حذفها من `jodija_repository` يلغي هذا التعارض نهائياً.
- `intl`: غير مستخدمة داخل `lib/`، وحذفها يمنع أي تعارض مع `flutter_localizations` عند ترقية Flutter.
- `dartz`: غير مستخدمة داخل `lib/`.
- `firebase_auth_web` و`firebase_core_web`: لا يتم استيرادهما مباشرة ويجلبهما `firebase_auth` و`firebase_core` تلقائياً؛ تثبيتهما يدوياً يسبب تعارضات عند تحديث Firebase.
- `freezed_annotation`: مستخدمة فقط لجلب `@mustBeOverridden` في `base_user_module.dart`، ويمكن استبدالها بـ `meta` أو إبقائها محدثة.

### ثالثاً: ترقية Firebase و`google_sign_in`
- أحدث إصدار من `google_sign_in` هو `^7.2.0` ويحتوي على **تغيير جذري (Breaking Change)** في الـ API (`GoogleSignIn.instance` بدلاً من `GoogleSignIn()`). ترقيته تتطلب تعديل ملف `lib/source/user/accountLoginLogout/firebase/auth_google_source.dart`.
- ترقية حزم Firebase إلى الجيل الأحدث (`firebase_core ^5.x`، `cloud_firestore ^7.x`، `firebase_auth ^7.x`، `firebase_messaging ^17.x`، `firebase_storage ^14.x`) متوافقة مع Flutter الحديث، ولكن يجب مراعاة أن مشروع **Imarati** يعمل حالياً على `firebase_core ^3.8.1` و`firebase_messaging ^15.1.6`.
- في **Imarati** أيضاً يُنصح باختبار الحزم الأقدم عند الترقية إلى آخر Flutter، خصوصاً: `flutter_localization ^0.2.2`، `month_year_picker ^0.5.0+1`، `google_fonts ^6.2.1`، `file_picker ^8.1.2`.

### رابعاً: توحيد إصدار Flutter وملفات `.fvmrc`
- ملفات `.fvmrc` في `JoDija_reposatory` و`jodija_tamplites` ومشاريع `shahbandar-v1` ما زالت مثبتة على `3.41.4` بينما النسخة النشطة على الجهاز هي `3.51.0-1.0.pre-49` / `Dart 3.11.1`.
- يُفضّل توحيد جميع المشاريع على أحدث إصدار `stable` من Flutter وتحديث `.fvmrc` فيها جميعاً (أو إزالته إن لم يعد مستخدماً).

---

## 3. خطة التنفيذ المقترحة بالترتيب الآمن

1. **✅ [تم التنفيذ] تنظيف وتحديث `jodija_repository` (جاهزة للنشر على pub.dev):**
   - تم حذف الاعتماديات غير المستخدمة (`flutter_bloc`، `intl`، `dartz`، `firebase_auth_web`، `firebase_core_web`، واستبدال `freezed_annotation` بـ `meta`).
   - تم توسيع قيود Firebase (`firebase_core: ">=3.4.1 <6.0.0"` وما يقابلها) لتعمل بسلاسة مع الجيل الحديث على Flutter 3.51 ومع الجيل الأقدم في `imarati` في آنٍ واحد.
   - تم ترقية `google_sign_in` إلى `^7.2.0` وتحديث `auth_google_source.dart` ورفع `flutter_lints` إلى `^6.0.0` وتحديث `.fvmrc` إلى `stable`.
   - تم اجتياز `flutter analyze` و`flutter test` و`flutter pub publish --dry-run` بدون أخطاء.

2. **✅ [تم التنفيذ] مراجعة وتحديث `jodija_tamplites`:**
   - تم التحقق من خلو `jodija_tamplites` (v3.1.0) من أي أخطاء برمجية على Flutter `3.51` وتحديث `.fvmrc` إلى `stable`.

3. **✅ [تم التنفيذ محلياً على فرع `upgrading-tools`] تحديث مشاريع `shahbandar-v1`:**
   - تم إنشاء فرع `upgrading-tools` في المستودعات الستة داخل `shahbandar-v1`.
   - تم تحديث الاعتمادية والـ imports في `shahbandar_core_logic _front` (72 ملفاً) إلى `jodija_repository` واجتياز `flutter analyze` بصفر أخطاء.
   - تم تحديث الاعتمادية والـ imports في `shabandar-client-app` (86 ملفاً) و`shahbandar-mangement-app` (207 ملفات) إلى `jodija_tamplites` وتحديث `.fvmrc` إلى `stable` واجتياز الفحص.

4. **✅ [تم التنفيذ] تحديث `darElEzz`:**
   - تم ترحيل `pubspec.yaml` و20 ملفاً (في `lib` و`test` و`integration_test`) إلى `jodija_repository` و`jodija_tamplites` واجتياز `flutter analyze` بصفر أخطاء.

5. **✅ [تم الفحص والتحقق] مراجعة `imarati-app-main`:**
   - تم تشغيل `flutter pub get` و`flutter analyze` على Flutter `3.51` / Dart `3.11.1` واجتاز الفحص بصفر أخطاء وصفر تحذيرات!
