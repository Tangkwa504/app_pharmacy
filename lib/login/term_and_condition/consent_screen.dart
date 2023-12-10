import 'package:app_pharmacy/core/style/app_style.dart';
import 'package:app_pharmacy/first_page.dart';
import 'package:app_pharmacy/widgets/base_button.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import '../singup_pharmacy.dart';

class ConsentScreen extends StatefulWidget {
  static const routeName = 'ConsentScreen';

  const ConsentScreen({super.key});

  @override
  _ConsentScreenState createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  String consentFirst = "ไม่ยินยอม";
  String consentSecond = "ไม่ยินยอม";

  final _status = ["ไม่ยินยอม", "ยินยอม"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black87),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "การยินยอมให้ใช้ข้อมูล",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '''
คำยินยอมฝั่งยูสเซอร์

ข้อตกลงและเงื่อนไขการใช้บริการ Application ร้านยากรุงเทพ (BDS)

ข้อตกลงและเงื่อนไขการใช้บริการ APPLICATION ร้านยากรุงเทพ BDS (“ข้อตกลงฯ”) ฉบับนี้ใช้บังคับระหว่าง บริษัท กรุงเทพดรักสโตร์ จำกัด (ผู้ให้บริการ) กับผู้ใช้บริการซึ่งได้รับการอนุมัติจากบริษัท กรุงเทพดรักสโตร์ จำกัด ให้ใช้บริการประเภทใดประเภทหนึ่งกับบริษัท กรุงเทพดรักสโตร์ จำกัด (“ผู้ใช้บริการ”)

1. ช่องทางการสมัครใช้บริการ หรือเปลี่ยนแปลงรายละเอียดการรับข้อมูลผ่าน SMS ที่เคยให้ข้อมูลไว้กับผู้ให้บริการ: สาขาของผู้ให้บริการหรือ เจ้าหน้าที่หรือตัวแทนของผู้ให้บริการ ช่องทางการยกเลิกการใช้บริการ : สาขาของผู้ให้บริการ หรือ หรือช่องทางอื่นๆ ที่ผู้ให้บริการจะเปิด ให้บริการต่อไปในอนาคต โดยผู้ให้บริการจะดำเนินการตามความประสงค์ของผู้ใช้บริการโดยเร็ว และการสมัครใช้บริการ การยกเลิกการใช้บริการ และการเปลี่ยนแปลงข้อมูลที่ผู้ใช้บริการได้ลงทะเบียนไว้กับผู้ให้บริการจะมีผลสมบูรณ์ เมื่อ ผู้ใช้บริการได้ลงทะเบียน ยืนยันตัวตน และรับข้อความ SMS ยืนยันผู้ให้บริการแล้วเท่านั้น
            ''',
                style: AppStyle.txtBody2,
              ),
              const SizedBox(height: 4),
              RadioGroup<String>.builder(
                groupValue: consentFirst,
                onChanged: (value) => setState(() {
                  consentFirst = value ?? 'ไม่ยินยอม';
                }),
                items: _status,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '''
1. ช่องทางการสมัครใช้บริการ หรือเปลี่ยนแปลงรายละเอียดการรับข้อมูลผ่าน SMS ที่เคยให้ข้อมูลไว้กับผู้ให้บริการ: สาขาของผู้ให้บริการหรือ เจ้าหน้าที่หรือตัวแทนของผู้ให้บริการ ช่องทางการยกเลิกการใช้บริการ : สาขาของผู้ให้บริการ หรือ หรือช่องทางอื่นๆ ที่ผู้ให้บริการจะเปิด ให้บริการต่อไปในอนาคต โดยผู้ให้บริการจะดำเนินการตามความประสงค์ของผู้ใช้บริการโดยเร็ว และการสมัครใช้บริการ การยกเลิกการใช้บริการ และการเปลี่ยนแปลงข้อมูลที่ผู้ใช้บริการได้ลงทะเบียนไว้กับผู้ให้บริการจะมีผลสมบูรณ์ เมื่อ ผู้ใช้บริการได้ลงทะเบียน ยืนยันตัวตน และรับข้อความ SMS ยืนยันผู้ให้บริการแล้วเท่านั้น
            ''',
                style: AppStyle.txtBody2,
              ),
              const SizedBox(height: 4),
              RadioGroup<String>.builder(
                groupValue: consentSecond,
                onChanged: (value) => setState(() {
                  consentSecond = value ?? 'ไม่ยินยอม';
                }),
                items: _status,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
              const SizedBox(height: 12),
              BaseButton(
                isEnabled:
                    consentFirst == "ยินยอม" && consentSecond == "ยินยอม",
                width: MediaQuery.of(context).size.width,
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    singupmixpharmacy.routeName,
                    (route) => route.settings.name == FirstPage.routeName,
                  );
                },
                label: 'ยืนยัน',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
