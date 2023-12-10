import 'package:app_pharmacy/core/style/app_style.dart';
import 'package:app_pharmacy/login/term_and_condition/consent_screen.dart';
import 'package:app_pharmacy/widgets/base_button.dart';
import 'package:flutter/material.dart';

class TermAndConditionScreen extends StatelessWidget {
  static const routeName = 'TermAndConditionScreen';

  const TermAndConditionScreen({super.key});

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
                "ข้อตกลงและเงื่อนไข",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '''
นโยบายคุ้มครองข้อมูลส่วนบุคคล

บริษัท กรุงเทพดรักสโตร์ จำกัด (“บริษัท”) ตระหนักถึงความสำคัญในการรักษาความเป็นส่วนตัวและความปลอดภัยของข้อมูลส่วนบุคคลของท่าน (“ท่าน”) ซึ่งเป็นผู้ใช้งานแอปพลิเคชัน “ร้านยากรุงเทพ” และเว็บไซต์ bangkokdrugstore.co.th, mobile.bangkokdrugstore.co.th รวมถึงเว็บไซต์ ฟีเจอร์ เทคโนโลยี เนื้อหา และผลิตภัณฑ์ต่าง ๆ ที่เกี่ยวข้อง (ซึ่งต่อไปนี้จะเรียกรวมกันว่า “แพลตฟอร์ม”) ดังนั้น บริษัทจึงได้ประกาศนโยบายคุ้มครองข้อมูลส่วนบุคคลฉบับนี้ขึ้นเพื่อให้ท่านได้รับทราบถึงวิธีการที่บริษัทเก็บรวบรวม ใช้ หรือเปิดเผยข้อมูลส่วนบุคคลของท่านตลอดจนสิทธิตามกฎหมายของท่านที่เกี่ยวข้องกับข้อมูลส่วนบุคคล ซึ่งเป็นไปตามพระราชบัญญัติคุ้มครองข้อมูลส่วนบุคคล พ.ศ.2562 ตลอดจนกฎหมาย และกฎเกณฑ์ที่เกี่ยวข้องทั้งที่บังคับใช้อยู่ในปัจจุบันและที่ได้มีการแก้ไข/เพิ่มเติม (หากมี)

การใช้บริการแพลตฟอร์มของบริษัท และ/หรือสมัครสมาชิกบนแพลตฟอร์มของบริษัท ท่าน และ/หรือบิดามารดา ผู้ปกครอง หรือ ผู้แทนโดยชอบธรรมของท่าน (ในกรณีที่ท่านมีอายุต่ำกว่า 20 ปี) ต้องรับทราบถึงแนวทางปฏิบัติและวิธีการซึ่งระบุไว้ในนโยบายความเป็นส่วนตัวฉบับนี้

แพลตฟอร์มของบริษัทอาจมีลิงค์ที่เชื่อมต่อไปยังหรือเชื่อมต่อมาจากเว็บไซต์ต่างๆของบุคคลภายนอก หากท่านกดตามลิงค์ไปยังเว็บไซต์ของบุคคลภายนอกดังกล่าว บริษัทขอแจ้งให้ท่านทราบว่าการประมวลผลข้อมูลส่วนบุคคลของท่านจะเป็นไปตามนโยบายความเป็นส่วนตัวของบุคคลภายนอกนั้นทั้งสิ้น ด้วยเหตุนี้ บริษัทขอแนะนำให้ท่านอ่านและทำความเข้าใจนโยบายความเป็นส่วนตัวของบุคคลภายนอกนั้นเมื่อท่านเข้าใช้แพลตฟอร์มนั้นๆ
            ''',
                style: AppStyle.txtBody2,
              ),
              const SizedBox(height: 12),
              BaseButton(
                width: MediaQuery.of(context).size.width,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ConsentScreen.routeName,
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
