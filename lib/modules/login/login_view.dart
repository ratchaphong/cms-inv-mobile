import 'package:cms_inv_mobile/shared/widgets/bstore_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<LoginViewModel>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BStoreLogo(size: LogoSize.base),
                    const SizedBox(height: 32),
                    Text(
                      vm.isRegisterMode.value
                          ? "ลงทะเบียนเพื่อใช้งานระบบ"
                          : "เข้าสู่ระบบเพื่อใช้งานระบบจัดการสินค้า",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // 🧑‍💼 Name (Register only)
                    if (vm.isRegisterMode.value) ...[
                      TextField(
                        onChanged: (v) => vm.name.value = v,
                        decoration: InputDecoration(
                          labelText: "ชื่อ - นามสกุล",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    TextField(
                      onChanged: (v) => vm.email.value = v,
                      decoration: InputDecoration(
                        labelText: "อีเมล",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      onChanged: (v) => vm.password.value = v,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "รหัสผ่าน",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: vm.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: vm.loginOrRegister,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFCC00),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                vm.isRegisterMode.value
                                    ? "ลงทะเบียน"
                                    : "เข้าสู่ระบบ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),

                    // 🔁 Toggle text
                    GestureDetector(
                      onTap: vm.toggleMode,
                      child: Text(
                        vm.isRegisterMode.value
                            ? "มีบัญชีแล้ว? เข้าสู่ระบบ"
                            : "ยังไม่มีบัญชี? ลงทะเบียน",
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary, // อิงจากธีมแอป
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
