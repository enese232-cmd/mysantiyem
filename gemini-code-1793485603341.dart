import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MySantiyemApp());
}

// UYGULAMA TEMA YÖNETİCİSİ
class ThemeNotifier extends ChangeNotifier {
  bool isDarkMode = true;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

final ThemeNotifier themeNotifier = ThemeNotifier();

// KULLANICI & OTURUM YÖNETİMİ (Profil & Yetkilendirme Altyapısı)
class KullaniciAuthModel {
  bool isLoggedIn = false;
  String kullaniciAdi = "";
  String sirketAdi = "My Şantiyem A.Ş.";
  String rol = "Şirket Sahibi"; // 'Şirket Sahibi', 'Çalışan'
  String paket = "Kurumsal Sınırsız Paket";
  int maksimumKullanici = 5;
}

final KullaniciAuthModel globalAuth = KullaniciAuthModel();

// CANLI RENK PALETİ VE MOD RENKLERİ
class AppColors {
  static const Color girisler = Color(0xFF0EA5E9);
  static const Color ruhsat = Color(0xFF9333EA);
  static const Color kabaInsaat = Color(0xFFE11D48);
  static const Color inceIsler = Color(0xFF0284C7);
  static const Color butce = Color(0xFF059669);
  static const Color imarEmsal = Color(0xFFDB2777);
  static const Color sirket = Color(0xFF7C3AED);
  static const Color harcama = Color(0xFFF59E0B);

  static const Color tesisat = Color(0xFF2563EB);
  static const Color asansor = Color(0xFF8B5CF6);
  static const Color resmi = Color(0xFF10B981);
  static const Color iscilik = Color(0xFFEC4899);
  static const Color gunlukSaha = Color(0xFF06B6D4);
  static const Color santiyeOperasyon = Color(0xFF3B82F6); 
  static const Color maliyetKontrol = Color(0xFF8B5CF6);
  static const Color profil = Color(0xFF14B8A6); // Profil Sekmesi Rengi

  // Halka Grafik İçin Canlı Renkler
  static const Color chartRuhsat = Color(0xFFA855F7);
  static const Color chartKaba = Color(0xFFF43F5E);
  static const Color chartInce = Color(0xFF38BDF8);
  static const Color chartEkstra = Color(0xFFFBBF24);

  // Derin Koyu Gri & Sıcak Krem Tonları
  static Color bgDark = const Color(0xFF080C14);
  static Color cardDark = const Color(0xFF111827);
  static Color bgLight = const Color(0xFFFBF9F5);
  static Color cardLight = const Color(0xFFFFFFFF);
}

// HARCAMA MODELİ
class HarcamaModel {
  String id;
  double tutar;
  String anaKategori;
  String altKategori;
  double miktar;
  String birim;
  String odemeYontemi;
  String tarih;
  String not;

  HarcamaModel({
    required this.id,
    required this.tutar,
    required this.anaKategori,
    required this.altKategori,
    required this.miktar,
    required this.birim,
    required this.odemeYontemi,
    required this.tarih,
    required this.not,
  });
}

// BORÇ / ALACAK MODELİ
class FinansKalemiModel {
  String id;
  String baslik;
  double tutar;
  bool isAlacak;
  String tarih;
  String aciklama;

  FinansKalemiModel({
    required this.id,
    required this.baslik,
    required this.tutar,
    required this.isAlacak,
    required this.tarih,
    required this.aciklama,
  });
}

// GÜNLÜK FOTOĞRAFLI SAHA İLERLEME MODELİ (Saat ve Güncellenebilirlik Eklendi)
class GunlukSahaRaporuModel {
  String id;
  String tarih;
  String saat; // İmalat eklenme saati
  String imalatAdi;
  String aciklama;
  String tamamlanmaOrani;
  String fotografYolu;

  GunlukSahaRaporuModel({
    required this.id,
    required this.tarih,
    this.saat = "09:30",
    required this.imalatAdi,
    required this.aciklama,
    required this.tamamlanmaOrani,
    required this.fotografYolu,
  });
}

// TAŞÖREN MODELİ
class SubcontractorModel {
  String id;
  String name;
  String workType;
  double totalAgreement;
  double paidAmount;
  List<String> faturaGorselleri;

  SubcontractorModel({
    required this.id,
    required this.name,
    required this.workType,
    required this.totalAgreement,
    required this.paidAmount,
    List<String>? faturaGorselleri,
  }) : faturaGorselleri = faturaGorselleri ?? [];

  double get remaining => totalAgreement - paidAmount;
}

// İŞ BİTİRME MODELİ
class IsBitirmeModel {
  String projeAdi;
  String alanM2;
  String yil;
  String isveren;

  IsBitirmeModel({required this.projeAdi, required this.alanM2, required this.yil, required this.isveren});
}

// ŞİRKET PROFİLİ MODELİ
class SirketModel {
  String sirketAdi;
  String yetkiliKisi;
  String merkezAdresi;
  String telefon;
  String vergiDairesi;
  String logoUrl;
  List<IsBitirmeModel> isBitirmeler;

  SirketModel({
    this.sirketAdi = "My Şantiyem A.Ş.",
    this.yetkiliKisi = "Proje Müdürü / Müteahhit",
    this.merkezAdresi = "Maslak Mah. Büyükdere Cad. Şişli / İstanbul",
    this.telefon = "0212 555 00 00",
    this.vergiDairesi = "Maslak VD. - 1234567890",
    this.logoUrl = "",
    List<IsBitirmeModel>? isBitirmeler,
  }) : isBitirmeler = isBitirmeler ?? [
          IsBitirmeModel(projeAdi: "Sunset Rezidans (120 Daire)", alanM2: "18.000 m²", yil: "2024", isveren: "Özel Yatırım"),
          IsBitirmeModel(projeAdi: "Vadi Plaza İş Merkezi", alanM2: "9.500 m²", yil: "2022", isveren: "Kurumsal GYO"),
        ];
}

final SirketModel globalSirket = SirketModel();

// ORTAK ÜST BAR AKSİYONLARI
List<Widget> buildGlobalActions(BuildContext context, VoidCallback onUpdate) {
  return [
    IconButton(
      icon: const Icon(Icons.business_center, color: AppColors.sirket),
      tooltip: "Şirket Profili & İş Bitirmeler",
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SirketProfiliSayfasi(sirket: globalSirket, onUpdate: onUpdate)))
            .then((_) => onUpdate());
      },
    ),
    IconButton(
      icon: const Icon(Icons.settings, color: AppColors.inceIsler),
      tooltip: "Uygulama Ayarları",
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AyarlarSayfasi()))
            .then((_) => onUpdate());
      },
    ),
  ];
}

final List<String> turkiyeIlleriListesi = [
  'Adana', 'Adıyaman', 'Afyonkarahisar', 'Ağrı', 'Amasya', 'Ankara', 'Antalya', 'Artvin', 'Aydın', 'Balıkesir',
  'Bilecik', 'Bingöl', 'Bitlis', 'Bolu', 'Burdur', 'Bursa', 'Çanakkale', 'Çankırı', 'Çorum', 'Denizli',
  'Diyarbakır', 'Edirne', 'Elazığ', 'Erzincan', 'Erzurum', 'Eskişehir', 'Gaziantep', 'Giresun', 'Gümüşhane', 'Hakkari',
  'Hatay', 'Isparta', 'Mersin', 'İstanbul', 'İzmir', 'Kars', 'Kastamonu', 'Kayseri', 'Kırklareli', 'Kırşehir',
  'Kocaeli', 'Konya', 'Kütahya', 'Malatya', 'Manisa', 'Kahramanmaraş', 'Mardin', 'Muğla', 'Muş', 'Nevşehir',
  'Niğde', 'Ordu', 'Rize', 'Sakarya', 'Samsun', 'Siirt', 'Sinop', 'Sivas', 'Tekirdağ', 'Tokat',
  'Trabzon', 'Tunceli', 'Şanlıurfa', 'Uşak', 'Van', 'Yozgat', 'Zonguldak', 'Aksaray', 'Bayburt', 'Karaman',
  'Kırıkkale', 'Batman', 'Şırnak', 'Bartın', 'Ardahan', 'Iğdır', 'Yalova', 'Karabük', 'Kilis', 'Osmaniye', 'Düzce'
];

// PROJE MODELİ
class ProjeModel {
  String projeAdi;
  String YapiTuru;
  String yapiKalitesi;
  String il;
  String baslangicTarihi;
  String bitisTarihi;
  double yillikEnflasyonOrani;

  double toprakUstuM2;
  int katSayisi;
  int kattaDaireSayisi;
  double katBrutM2;
  double ortalamaKatYuksekligi;
  double catiYuksekligi;

  int adet1plus1;
  int adet2plus1;
  int adet3plus1;
  int adet4plus1;

  bool dukkanVar;
  int dukkanAdedi;
  double dukkanBasiM2;

  int bodrumKatSayisi;
  double bodrumM2;
  double bodrumKatYuksekligi;

  bool iksaVar;
  String iksaTuru;
  double iksaBirimMaliyeti;

  int asansorKisiSayisi;
  int asansorDurakSayisi;
  int asansorAdedi;

  double imalatMaliyetiMimari = 850.0;
  double imalatMaliyetiZemin = 150000.0;
  double imalatMaliyetiHaritaci = 120000.0;
  double imalatMaliyetiYapiDenetim = 750000.0;
  double imalatMaliyetiBelediye = 750.0;

  double imalatMaliyetiSantiyeKurulumu = 250000.0;
  double imalatMaliyetiHafriyat = 1250.0;
  double imalatMaliyetiDemir = 48000.0;
  double imalatMaliyetiBeton = 5200.0;
  double imalatMaliyetiIzolasyon = 650.0;
  double imalatMaliyetiCati = 6500.0;

  double imalatMaliyetiElektrik = 2600.0;
  double imalatMaliyetiMekanik = 3000.0;
  double imalatMaliyetiCephe = 2400.0;
  double imalatMaliyetiDograma = 1800.0;
  double imalatMaliyetiPeyzaj = 600.0;

  bool isManuelMimari; double manuelMimari;
  bool isManuelZemin; double manuelZemin;
  bool isManuelHaritaci; double manuelHaritaci;
  bool isManuelYapiDenetim; double manuelYapiDenetim;
  bool isManuelBelediye; double manuelBelediye;

  bool isManuelSantiyeKurulumu; double manuelSantiyeKurulumu;
  bool isManuelHafriyat; double manuelHafriyat;
  bool isManuelDemir; double manuelDemir;
  bool isManuelBeton; double manuelBeton;
  bool isManuelKalip; double manuelKalip;
  bool isManuelDuvar; double manuelDuvar;
  bool isManuelCati; double manuelCati;
  bool isManuelIzolasyon; double manuelIzolasyon;

  bool isManuelAsansor; double manuelAsansor;
  bool isManuelElektrik; double manuelElektrik;
  bool isManuelMekanik; double manuelMekanik;
  bool isManuelCephe; double manuelCephe;
  bool isManuelDograma; double manuelDograma;
  bool isManuelPeyzaj; double manuelPeyzaj;

  List<HarcamaModel> harcamalar;
  List<FinansKalemiModel> finansKalemleri;
  List<SubcontractorModel> taseronlar;
  List<GunlukSahaRaporuModel> gunlukSahaRaporlari;

  ProjeModel({
    required this.projeAdi,
    this.YapiTuru = 'Apartman / Konut',
    this.yapiKalitesi = 'Standart',
    this.il = 'İstanbul',
    this.baslangicTarihi = '15.03.2026',
    this.bitisTarihi = '30.12.2027',
    this.yillikEnflasyonOrani = 35.0,
    this.toprakUstuM2 = 2500,
    this.katSayisi = 6,
    this.kattaDaireSayisi = 3,
    this.katBrutM2 = 400,
    this.ortalamaKatYuksekligi = 3.0,
    this.catiYuksekligi = 2.5,
    this.adet1plus1 = 0,
    this.adet2plus1 = 6,
    this.adet3plus1 = 12,
    this.adet4plus1 = 0,
    this.dukkanVar = true,
    this.dukkanAdedi = 2,
    this.dukkanBasiM2 = 150.0,
    this.bodrumKatSayisi = 2,
    this.bodrumM2 = 450,
    this.bodrumKatYuksekligi = 3.0,
    this.iksaVar = false,
    this.iksaTuru = 'Fore Kazık',
    this.iksaBirimMaliyeti = 3500.0,
    this.asansorKisiSayisi = 8,
    this.asansorDurakSayisi = 7,
    this.asansorAdedi = 1,
    this.isManuelMimari = false, this.manuelMimari = 0,
    this.isManuelZemin = false, this.manuelZemin = 0,
    this.isManuelHaritaci = false, this.manuelHaritaci = 0,
    this.isManuelYapiDenetim = false, this.manuelYapiDenetim = 0,
    this.isManuelBelediye = false, this.manuelBelediye = 0,
    this.isManuelSantiyeKurulumu = false, this.manuelSantiyeKurulumu = 0,
    this.isManuelHafriyat = false, this.manuelHafriyat = 0,
    this.isManuelDemir = false, this.manuelDemir = 0,
    this.isManuelBeton = false, this.manuelBeton = 0,
    this.isManuelKalip = false, this.manuelKalip = 0,
    this.isManuelDuvar = false, this.manuelDuvar = 0,
    this.isManuelCati = false, this.manuelCati = 0,
    this.isManuelIzolasyon = false, this.manuelIzolasyon = 0,
    this.isManuelAsansor = false, this.manuelAsansor = 0,
    this.isManuelElektrik = false, this.manuelElektrik = 0,
    this.isManuelMekanik = false, this.manuelMekanik = 0,
    this.isManuelCephe = false, this.manuelCephe = 0,
    this.isManuelDograma = false, this.manuelDograma = 0,
    this.isManuelPeyzaj = false, this.manuelPeyzaj = 0,
    List<HarcamaModel>? harcamalar,
    List<FinansKalemiModel>? finansKalemleri,
    List<SubcontractorModel>? taseronlar,
    List<GunlukSahaRaporuModel>? gunlukSahaRaporlari,
  })  : harcamalar = harcamalar ?? [
          HarcamaModel(id: '1', tutar: 450000, anaKategori: 'Kaba İnşaat', altKategori: 'Demir', miktar: 9.3, birim: 'Ton', odemeYontemi: 'Nakit/Havale', tarih: '10.04.2026', not: '1. Etap Sezon Demir Alımı'),
          HarcamaModel(id: '2', tutar: 125000, anaKategori: 'Resmi Giderler', altKategori: 'Zemin Etüdü', miktar: 1, birim: 'Adet', odemeYontemi: 'Kredi Kartı', tarih: '02.04.2026', not: 'Zemin Laboratuvar Raporu'),
        ],
        finansKalemleri = finansKalemleri ?? [
          FinansKalemiModel(id: '1', baslik: 'Daire A-2 Ön Avans Ödemesi', tutar: 500000, isAlacak: true, tarih: '20.04.2026', aciklama: 'Müşteri Kapanış Teminatı'),
          FinansKalemiModel(id: '2', baslik: 'Hafriyat Taşeron Teminatı', tutar: 150000, isAlacak: false, tarih: '22.04.2026', aciklama: 'Hafriyat Hak Dediği'),
        ],
        taseronlar = taseronlar ?? [
          SubcontractorModel(id: '1', name: 'Yılmazlar Hafriyat Ltd.', workType: 'Kazı ve Temel Dolgu', totalAgreement: 350000, paidAmount: 220000, faturaGorselleri: ['fatura_ornek_1.jpg']),
          SubcontractorModel(id: '2', name: 'Demirci Ahmet Usta', workType: 'Demir Bağlama İşçiliği', totalAgreement: 180000, paidAmount: 110000, faturaGorselleri: []),
        ],
        gunlukSahaRaporlari = gunlukSahaRaporlari ?? [
          GunlukSahaRaporuModel(
            id: '1',
            tarih: '28.04.2026',
            saat: '14:15',
            imalatAdi: 'Temel Altı Hafriyat ve Grobeton',
            aciklama: 'Bugün temel hafriyat kazısı tamamlandı ve mesai bitimine kadar C20 grobeton dökümü bitirildi.',
            tamamlanmaOrani: '%100',
            fotografYolu: 'saha_ornek_1.jpg',
          )
        ];

  double get ilMaliyetKatsayisi {
    const Map<String, double> ilKatsayilari = {
      'İstanbul': 1.18, 'Ankara': 1.10, 'İzmir': 1.15, 'Antalya': 1.12, 'Bursa': 1.08, 'Muğla': 1.15,
      'Kocaeli': 1.08, 'Adana': 1.05, 'Gaziantep': 1.05, 'Trabzon': 1.07, 'Erzurum': 1.08, 'Hakkari': 1.12,
    };
    return ilKatsayilari[il] ?? 1.00;
  }

  double get projeSuresiYil {
    try {
      List<String> basP = baslangicTarihi.split('.');
      List<String> bitP = bitisTarihi.split('.');
      DateTime bas = DateTime(int.parse(basP[2]), int.parse(basP[1]), int.parse(basP[0]));
      DateTime bit = DateTime(int.parse(bitP[2]), int.parse(bitP[1]), int.parse(bitP[0]));
      int gun = bit.difference(bas).inDays;
      return max(0.25, gun / 365.0);
    } catch (_) {
      return 1.5;
    }
  }

  double get toplamIlCarpani => ilMaliyetKatsayisi;

  double get kaliteKatsayisi {
    switch (yapiKalitesi) {
      case 'Ekonomik': return 0.80;
      case 'Standart': return 1.00;
      case 'Lüks': return 1.35;
      case 'Ultra Lüks': return 1.80;
      default: return 1.00;
    }
  }

  int get toplamKonutAdedi {
    int ozelAdet = adet1plus1 + adet2plus1 + adet3plus1 + adet4plus1;
    return ozelAdet > 0 ? ozelAdet : (katSayisi * kattaDaireSayisi);
  }

  double get toplamInsaatM2 {
    double toplamDukkanM2 = dukkanVar ? (dukkanAdedi * dukkanBasiM2) : 0;
    double toprakAltiM2 = bodrumKatSayisi * bodrumM2;
    return toprakUstuM2 + toprakAltiM2 + toplamDukkanM2;
  }

  double get hafriyatM3 {
    return bodrumKatSayisi > 0 ? (bodrumM2 * ((bodrumKatSayisi * bodrumKatYuksekligi) + 0.70) * 1.15) : (toprakUstuM2 * 0.10);
  }

  double get iksaMaliyeti {
    if (!iksaVar || bodrumKatSayisi <= 0) return 0;
    double cevre = sqrt(bodrumM2) * 4; 
    double iksaAlaniM2 = cevre * (bodrumKatSayisi * bodrumKatYuksekligi);
    return iksaAlaniM2 * iksaBirimMaliyeti;
  }

  double get izolasyonM2 {
    if (bodrumKatSayisi <= 0) return katBrutM2; 
    double temelIzolasyonM2 = bodrumM2; 
    double cevre = sqrt(bodrumM2) * 4; 
    double perdeIzolasyonM2 = cevre * (bodrumKatSayisi * bodrumKatYuksekligi);
    return temelIzolasyonM2 + perdeIzolasyonM2;
  }

  double get asansorHesaplananTutar {
    double basFiyat = 1000000.0;
    if (asansorKisiSayisi == 4) basFiyat = 800000.0;
    else if (asansorKisiSayisi == 8) basFiyat = 1000000.0;
    else if (asansorKisiSayisi == 10) basFiyat = 1100000.0;
    else if (asansorKisiSayisi == 12) basFiyat = 1200000.0;
    else if (asansorKisiSayisi == 16) basFiyat = 1400000.0;

    double durakFarkFiyati = 0;
    if (asansorDurakSayisi > 7) {
      durakFarkFiyati = (asansorDurakSayisi - 7) * 100000.0;
    } else if (asansorDurakSayisi < 7) {
      durakFarkFiyati = -((7 - asansorDurakSayisi) * 50000.0);
    }

    double tekAsansorTutar = (basFiyat + durakFarkFiyati) * kaliteKatsayisi;
    int efAded = (toplamKonutAdedi >= 20 && asansorAdedi < 2) ? 2 : asansorAdedi;
    return tekAsansorTutar * max(1, efAded);
  }

  double get _bazRuhsatOncesi {
    double m = isManuelMimari ? manuelMimari : (toplamInsaatM2 * imalatMaliyetiMimari * kaliteKatsayisi);
    double z = isManuelZemin ? manuelZemin : (imalatMaliyetiZemin * kaliteKatsayisi);
    double h = isManuelHaritaci ? manuelHaritaci : imalatMaliyetiHaritaci;
    double y = isManuelYapiDenetim ? manuelYapiDenetim : imalatMaliyetiYapiDenetim;
    double b = isManuelBelediye ? manuelBelediye : (toplamInsaatM2 * imalatMaliyetiBelediye);
    return m + z + h + y + b;
  }

  double get _bazKabaInsaat {
    double santiye = isManuelSantiyeKurulumu ? manuelSantiyeKurulumu : imalatMaliyetiSantiyeKurulumu;
    double haf = isManuelHafriyat ? manuelHafriyat : ((hafriyatM3 * imalatMaliyetiHafriyat) + iksaMaliyeti);
    double dem = isManuelDemir ? manuelDemir : (((toplamInsaatM2 * 60) / 1000.0) * imalatMaliyetiDemir);
    double bet = isManuelBeton ? manuelBeton : ((toplamInsaatM2 * 0.50) * imalatMaliyetiBeton);
    double izo = isManuelIzolasyon ? manuelIzolasyon : (izolasyonM2 * imalatMaliyetiIzolasyon);
    double cat = isManuelCati ? manuelCati : (katBrutM2 * imalatMaliyetiCati * kaliteKatsayisi);
    return santiye + haf + dem + bet + izo + cat;
  }

  double get _bazInceIsler {
    double asa = isManuelAsansor ? manuelAsansor : asansorHesaplananTutar;
    double ele = isManuelElektrik ? manuelElektrik : (toplamInsaatM2 * imalatMaliyetiElektrik * kaliteKatsayisi);
    double mek = isManuelMekanik ? manuelMekanik : (toplamInsaatM2 * imalatMaliyetiMekanik * kaliteKatsayisi);
    double cep = isManuelCephe ? manuelCephe : (toplamInsaatM2 * imalatMaliyetiCephe * kaliteKatsayisi);
    double dog = isManuelDograma ? manuelDograma : (toplamInsaatM2 * imalatMaliyetiDograma * kaliteKatsayisi);
    double pey = isManuelPeyzaj ? manuelPeyzaj : (toplamInsaatM2 * imalatMaliyetiPeyzaj * kaliteKatsayisi);
    return asa + ele + mek + cep + dog + pey;
  }

  double get toplamRuhsatOncesi => _bazRuhsatOncesi * toplamIlCarpani;
  double get toplamKabaInsaat => _bazKabaInsaat * toplamIlCarpani;
  double get toplamInceIsler => _bazInceIsler * toplamIlCarpani;

  double get genelProjeMaliyeti {
    double ekstraHarcamalar = harcamalar.fold(0, (sum, h) => sum + h.tutar);
    return toplamRuhsatOncesi + toplamKabaInsaat + toplamInceIsler + ekstraHarcamalar;
  }

  double get kdvDahilM2Maliyeti {
    if (toplamInsaatM2 <= 0) return 0;
    double netMaliyetM2 = genelProjeMaliyeti / toplamInsaatM2;
    return netMaliyetM2 * 1.20;
  }
}

List<ProjeModel> globalProjeler = [
  ProjeModel(projeAdi: "Merkez Konut Projesi (Örnek)"),
  ProjeModel(projeAdi: "Vadi Rezidans Blokları", baslangicTarihi: "01.06.2026", bitisTarihi: "15.11.2028"),
];

class MySantiyemApp extends StatelessWidget {
  const MySantiyemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeNotifier,
      builder: (context, child) {
        bool isDark = themeNotifier.isDarkMode;
        return MaterialApp(
          title: 'MY ŞANTİYEM',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: isDark ? Brightness.dark : Brightness.light,
            scaffoldBackgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
            cardColor: isDark ? AppColors.cardDark : AppColors.cardLight,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.kabaInsaat,
              brightness: isDark ? Brightness.dark : Brightness.light,
            ),
            fontFamily: 'Roboto',
          ),
          home: const AnaGirisSayfasi(),
        );
      },
    );
  }
}

// 0. ANA MENÜ EKRANI
class AnaGirisSayfasi extends StatelessWidget {
  const AnaGirisSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;
    Color cardColor = isDark ? AppColors.cardDark : AppColors.cardLight;
    Color textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.kabaInsaat.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.kabaInsaat, width: 1.5),
              ),
              child: const Icon(Icons.architecture, color: AppColors.kabaInsaat, size: 22),
            ),
            const SizedBox(width: 10),
            Text('MY ŞANTİYEM', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: textColor)),
          ],
        ),
        backgroundColor: cardColor,
        elevation: 0,
        actions: buildGlobalActions(context, () {}),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.harcama.withOpacity(0.4), width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.harcama.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.waving_hand, color: AppColors.harcama, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("HOŞ GELDİNİZ.", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: AppColors.harcama)),
                        const SizedBox(height: 2),
                        Text("Proje yönetimi ve Şantiye Saha Operasyonu tek ekranda.", style: TextStyle(fontSize: 11, color: isDark ? Colors.white60 : Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Ana Menü & Modüller", style: TextStyle(color: AppColors.kabaInsaat, fontSize: 16, fontWeight: FontWeight.bold)),
                Text(globalSirket.sirketAdi, style: TextStyle(color: isDark ? Colors.white60 : Colors.black54, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 2.8,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context,
                    title: "Proje & Şantiye Yönetimi",
                    subtitle: "Girdiler, İmalat, Bütçe, Şantiye Operasyonu ve Profil",
                    icon: Icons.domain,
                    color: AppColors.kabaInsaat,
                    cardColor: cardColor,
                    textColor: textColor,
                    destination: const ProjeListesiSayfasi(),
                  ),
                  _buildMenuCard(
                    context,
                    title: "Emsal ve İnşaat Alanı Hesaplama (TAKS/KAKS)",
                    subtitle: "Arsa alanı, TAKS, KAKS/Emsal oranı ve otomatik oturum hesabı",
                    icon: Icons.map,
                    color: AppColors.imarEmsal,
                    cardColor: cardColor,
                    textColor: textColor,
                    destination: const EmsalHesaplamaSayfasi(),
                  ),
                  _buildMenuCard(
                    context,
                    title: "Genişletilmiş Metraj & Malzeme Hesaplayıcı",
                    subtitle: "Tuğla, gazbeton, seramik, yapıştırıcı, sıva ve beton metraj hesabı",
                    icon: Icons.calculate,
                    color: AppColors.harcama,
                    cardColor: cardColor,
                    textColor: textColor,
                    destination: const MaterialCalculatorScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {required String title, required String subtitle, required IconData icon, required Color color, required Color cardColor, required Color textColor, required Widget destination}) {
    bool isDark = themeNotifier.isDarkMode;
    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.4), width: 1.5),
            boxShadow: [BoxShadow(color: color.withOpacity(isDark ? 0.1 : 0.05), blurRadius: 8, offset: const Offset(0, 4))],
          ),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: color.withOpacity(0.15), radius: 28, child: Icon(icon, color: color, size: 28)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(color: isDark ? Colors.white60 : Colors.black54, fontSize: 12)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: color, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// AYARLAR SAYFASI
class AyarlarSayfasi extends StatefulWidget {
  const AyarlarSayfasi({super.key});

  @override
  State<AyarlarSayfasi> createState() => _AyarlarSayfasiState();
}

class _AyarlarSayfasiState extends State<AyarlarSayfasi> {
  bool bildirimlerAktif = true;

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uygulama Ayarları'),
        backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
        actions: buildGlobalActions(context, () => setState(() {})),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("⚙️ Genel Tercihler", style: TextStyle(color: AppColors.kabaInsaat, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 10),
          SwitchListTile(
            title: const Text("Karanlık / Aydınlık Mod"),
            subtitle: Text(isDark ? "Şu an: Karanlık Koyu Gri Tema (Aktif)" : "Şu an: Aydınlık Krem Tema (Aktif)"),
            value: isDark,
            activeColor: AppColors.kabaInsaat,
            onChanged: (v) {
              setState(() {
                themeNotifier.toggleTheme();
              });
            },
          ),
          SwitchListTile(
            title: const Text("Uygulama Bildirimleri"),
            subtitle: const Text("Şantiye bütçe uyarıları ve güncellemeler"),
            value: bildirimlerAktif,
            activeColor: AppColors.inceIsler,
            onChanged: (v) {
              setState(() {
                bildirimlerAktif = v;
              });
            },
          ),
        ],
      ),
    );
  }
}

// 1. ŞİRKET PROFİLİ
class SirketProfiliSayfasi extends StatefulWidget {
  final SirketModel sirket;
  final VoidCallback onUpdate;
  const SirketProfiliSayfasi({super.key, required this.sirket, required this.onUpdate});

  @override
  State<SirketProfiliSayfasi> createState() => _SirketProfiliSayfasiState();
}

class _SirketProfiliSayfasiState extends State<SirketProfiliSayfasi> {
  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;
    final s = widget.sirket;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Şirket Profili & İş Bitirmeler'),
        backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
        actions: buildGlobalActions(context, () => setState(() {})),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.sirket.withOpacity(0.4), width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(backgroundColor: AppColors.sirket, radius: 28, child: Icon(Icons.business, color: Colors.white, size: 32)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.sirketAdi, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                          const Text("Kurumsal Profil", style: TextStyle(color: AppColors.sirket, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(height: 24),
                _bilgiSatir("Merkez Adres:", s.merkezAdresi),
                _bilgiSatir("Telefon:", s.telefon),
                _bilgiSatir("Vergi Dairesi:", s.vergiDairesi),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bilgiSatir(String baslik, String deger) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(baslik, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Expanded(child: Text(deger, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}

// 2. PROJE LİSTESİ
class ProjeListesiSayfasi extends StatefulWidget {
  const ProjeListesiSayfasi({super.key});

  @override
  State<ProjeListesiSayfasi> createState() => _ProjeListesiSayfasiState();
}

class _ProjeListesiSayfasiState extends State<ProjeListesiSayfasi> {
  void _yeniProjeEkleDialog() {
    String yeniAd = "";
    String yeniTarih = "01.07.2026";
    String yeniBitis = "30.12.2027";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Yeni Proje Oluştur"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: const InputDecoration(labelText: "Proje Adı"), onChanged: (v) => yeniAd = v),
            const SizedBox(height: 10),
            TextField(
              controller: TextEditingController(text: yeniTarih),
              decoration: const InputDecoration(labelText: "Başlangıç Tarihi (gg.aa.yyyy)"),
              onChanged: (v) => yeniTarih = v,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: TextEditingController(text: yeniBitis),
              decoration: const InputDecoration(labelText: "Tahmini Bitiş Tarihi (gg.aa.yyyy)"),
              onChanged: (v) => yeniBitis = v,
            ),
          ],
        ),
        actions: [
          TextButton(child: const Text("İptal"), onPressed: () => Navigator.pop(context)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.kabaInsaat),
            child: const Text("Oluştur", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () {
              if (yeniAd.trim().isNotEmpty) {
                setState(() {
                  globalProjeler.add(ProjeModel(projeAdi: yeniAd.trim(), baslangicTarihi: yeniTarih, bitisTarihi: yeniBitis));
                });
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _projeDuzenleDialog(ProjeModel proje) {
    String guncelAd = proje.projeAdi;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Proje İsmini Düzenle"),
        content: TextFormField(
          initialValue: proje.projeAdi,
          decoration: const InputDecoration(labelText: "Proje Adı"),
          onChanged: (v) => guncelAd = v,
        ),
        actions: [
          TextButton(child: const Text("İptal"), onPressed: () => Navigator.pop(context)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.kabaInsaat),
            child: const Text("Kaydet", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () {
              if (guncelAd.trim().isNotEmpty) {
                setState(() {
                  proje.projeAdi = guncelAd.trim();
                });
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _projeSilDialog(ProjeModel proje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Proje Sil"),
        content: Text("'${proje.projeAdi}' isimli projeyi silmek istediğinize emin misiniz?"),
        actions: [
          TextButton(child: const Text("Hayır"), onPressed: () => Navigator.pop(context)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Evet, Sil", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () {
              setState(() {
                globalProjeler.remove(proje);
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proje & Şantiye Yönetimi'),
        backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
        actions: buildGlobalActions(context, () => setState(() {})),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: globalProjeler.length,
        itemBuilder: (context, index) {
          final p = globalProjeler[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.kabaInsaat.withOpacity(0.3), width: 1.5),
            ),
            child: Material(
              color: isDark ? AppColors.cardDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(16),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: const CircleAvatar(backgroundColor: AppColors.kabaInsaat, child: Icon(Icons.apartment, color: Colors.white)),
                title: Text(p.projeAdi, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                subtitle: Text("Tür: ${p.YapiTuru} | İl: ${p.il} | Enflasyon: %${p.yillikEnflasyonOrani.toInt()}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: AppColors.inceIsler, size: 20),
                      onPressed: () => _projeDuzenleDialog(p),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                      onPressed: () => _projeSilDialog(p),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: AppColors.kabaInsaat, size: 14),
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProjeAnaYoneticisi(proje: p, onUpdate: () => setState(() {})))).then((_) => setState(() {}));
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.kabaInsaat,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Yeni Proje Ekle", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed: _yeniProjeEkleDialog,
      ),
    );
  }
}

// 3. PROJE ANA YÖNETİCİSİ (Alt Barda "Şantiye Operasyonu" ve "Profil" Sekmeleri Eklendi)
class ProjeAnaYoneticisi extends StatefulWidget {
  final ProjeModel proje;
  final VoidCallback onUpdate;
  const ProjeAnaYoneticisi({super.key, required this.proje, required this.onUpdate});

  @override
  State<ProjeAnaYoneticisi> createState() => _ProjeAnaYoneticisiState();
}

class _ProjeAnaYoneticisiState extends State<ProjeAnaYoneticisi> {
  int _currentIndex = 0; // 0: Girdiler, 1: İmalat, 2: Bütçe, 3: Şantiye Operasyonu, 4: Profil

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;

    final List<Widget> pages = [
      ProjeGirdilerTab(proje: widget.proje, onUpdate: widget.onUpdate),
      ProjeImalatlarTab(proje: widget.proje, onUpdate: widget.onUpdate),
      ProjeButceTab(proje: widget.proje, onUpdate: widget.onUpdate),
      // 3. İndex: Şantiye Operasyonu Sekmesi (Giriş Kontrollü)
      SantiyeOperasyonAnaSayfasi(proje: widget.proje, onUpdate: widget.onUpdate),
      // 4. İndex: Profil & Kullanıcı Girişi Sekmesi
      KullaniciProfilTab(onUpdate: widget.onUpdate),
    ];

    List<String> sayfaIsimleri = [
      "Proje Girdileri", 
      "İmalat Maliyetleri", 
      "Proje Bütçesi", 
      "Şantiye Saha Operasyonu",
      "Kullanıcı Profili"
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
        elevation: 2,
        title: Row(
          children: [
            const Icon(Icons.domain, color: AppColors.kabaInsaat, size: 22),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButton<ProjeModel>(
                value: widget.proje,
                isExpanded: true,
                dropdownColor: isDark ? AppColors.cardDark : AppColors.cardLight,
                underline: const SizedBox(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? Colors.white : Colors.black),
                items: globalProjeler.map((p) => DropdownMenuItem(value: p, child: Text(p.projeAdi, overflow: TextOverflow.ellipsis))).toList(),
                onChanged: (yeniProje) {
                  if (yeniProje != null) {
                    setState(() {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProjeAnaYoneticisi(proje: yeniProje, onUpdate: widget.onUpdate)));
                    });
                  }
                },
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
            tooltip: "Seçili Sayfayı PDF Olarak Dışa Aktar",
            onPressed: () => _pdfDoktoruDisaAktarDialog(context, _currentIndex, widget.proje, sayfaIsimleri),
          ),
          ...buildGlobalActions(context, () => setState(() {})),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, -3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: _buildCustomNavItem(0, Icons.edit_note, "Girdiler", AppColors.girisler)),
            Expanded(child: _buildCustomNavItem(1, Icons.construction, "İmalat", AppColors.kabaInsaat)),
            Expanded(child: _buildCustomNavItem(2, Icons.pie_chart, "Bütçe", AppColors.butce)),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Kullanıcı giriş yapmamışsa şantiye operasyonuna giremez, uyarı verilir ve profile yönlendirilir
                  if (!globalAuth.isLoggedIn) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("⚠️ Şantiye operasyon verilerini görmek için lütfen önce 'Profil' sekmesinden giriş yapın! Giriş yapmadan sadece yeni proje maliyeti hesaplayabilirsiniz."),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                    setState(() => _currentIndex = 4); // Profil sekmesine atar
                  } else {
                    setState(() => _currentIndex = 3);
                  }
                },
                child: _buildCustomNavItemInner(3, Icons.engineering, "Operasyon", AppColors.santiyeOperasyon, _currentIndex == 3),
              ),
            ),
            Expanded(child: _buildCustomNavItem(4, Icons.person, "Profil", AppColors.profil)),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomNavItem(int index, IconData icon, String label, Color activeColor) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: _buildCustomNavItemInner(index, icon, label, activeColor, isSelected),
    );
  }

  Widget _buildCustomNavItemInner(int index, IconData icon, String label, Color activeColor, bool isSelected) {
    bool isDark = themeNotifier.isDarkMode;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      decoration: BoxDecoration(
        color: isSelected ? activeColor.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? activeColor : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? activeColor : (isDark ? Colors.grey[400] : Colors.grey[600]),
            size: 19,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isSelected ? activeColor : (isDark ? Colors.grey[400] : Colors.grey[600]),
              fontSize: 9.5,
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _pdfDoktoruDisaAktarDialog(BuildContext context, int index, ProjeModel proje, List<String> sayfaIsimleri) {
    String aktifSayfaAdi = sayfaIsimleri[index];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.picture_as_pdf, color: Colors.redAccent),
            SizedBox(width: 8),
            Text("PDF Rapor Dışa Aktar"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Şu an bulunduğunuz sekme: **$aktifSayfaAdi**", style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 10),
            Text("Proje: ${proje.projeAdi}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 14),
            const Text(
              "Bu sekmedeki veriler kurumsal şantiye antetiyle resmi PDF formatına dönüştürülecektir. WhatsApp veya E-posta ile doğrudan paylaşmaya hazırdır.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(child: const Text("İptal"), onPressed: () => Navigator.pop(context)),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            icon: const Icon(Icons.download, color: Colors.white),
            label: const Text("PDF İndir / Paylaş", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("📄 '${proje.projeAdi}' - $aktifSayfaAdi başarıyla PDF olarak oluşturuldu ve paylaşıma hazır!"),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// 👤 YENİ EKLENEN PROFİL & KULLANICI GİRİŞİ SEKME / SAYFASI
class KullaniciProfilTab extends StatefulWidget {
  final VoidCallback onUpdate;
  const KullaniciProfilTab({super.key, required this.onUpdate});

  @override
  State<KullaniciProfilTab> createState() => _KullaniciProfilTabState();
}

class _KullaniciProfilTabState extends State<KullaniciProfilTab> {
  final TextEditingController _kullaniciAdiCtrl = TextEditingController(text: globalAuth.kullaniciAdi);
  final TextEditingController _sirketAdiCtrl = TextEditingController(text: globalAuth.sirketAdi);

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF042F2E), const Color(0xFF134E4A)]
                    : [const Color(0xFFCCFBF1), const Color(0xFF99F6E4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.profil, width: 2),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.profil,
                  radius: 28,
                  child: Icon(Icons.admin_panel_settings, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "MÜTEAHHİT FİRMA & KULLANICI PROFİLİ",
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: AppColors.profil),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        globalAuth.isLoggedIn
                            ? "Aktif Oturum: ${globalAuth.kullaniciAdi} (${globalAuth.rol})"
                            : "Şantiye operasyon verilerini görmek için giriş yapmalısınız.",
                        style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Lisans / Paket Bilgi Kartı
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.profil.withOpacity(0.4), width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("📦 Satın Alınan Paket & Altyapı", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: AppColors.profil.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                      child: Text(globalAuth.paket, style: const TextStyle(color: AppColors.profil, fontWeight: FontWeight.w900, fontSize: 10)),
                    ),
                  ],
                ),
                const Divider(height: 20),
                Text("• Maksimum Kullanıcı Erişim Limiti: ${globalAuth.maksimumKullanici} Kişi", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("• Şirket Güvenliği: Her kullanıcının verileri sadece o şirketin sahibi ve yetkili çalışanları tarafından görüntülenebilir.", style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Giriş Formu / Durumu
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.profil.withOpacity(0.4), width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(globalAuth.isLoggedIn ? "🔐 Oturum Açık (Şirket Yetkilisi)" : "🔑 Kullanıcı Girişi Yapın", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: AppColors.profil)),
                const SizedBox(height: 16),
                TextField(
                  controller: _kullaniciAdiCtrl,
                  decoration: const InputDecoration(
                    labelText: "Kullanıcı Adı / Ad Soyad",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: AppColors.profil),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _sirketAdiCtrl,
                  decoration: const InputDecoration(
                    labelText: "Firma / Şirket Unvanı",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.business, color: AppColors.profil),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: globalAuth.isLoggedIn ? Colors.redAccent : AppColors.profil,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      globalAuth.isLoggedIn ? "ÇIKIŞ YAP" : "GİRİŞ YAP VE YETKİLENDİR",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    onPressed: () {
                      setState(() {
                        if (globalAuth.isLoggedIn) {
                          globalAuth.isLoggedIn = false;
                          globalAuth.kullaniciAdi = "";
                        } else {
                          globalAuth.isLoggedIn = true;
                          globalAuth.kullaniciAdi = _kullaniciAdiCtrl.text.trim().isEmpty ? "Müteahhit Yetkilisi" : _kullaniciAdiCtrl.text.trim();
                          globalAuth.sirketAdi = _sirketAdiCtrl.text.trim().isEmpty ? "My Şantiyem A.Ş." : _sirketAdiCtrl.text.trim();
                          globalSirket.sirketAdi = globalAuth.sirketAdi;
                        }
                      });
                      widget.onUpdate();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(globalAuth.isLoggedIn ? "✅ Başarıyla giriş yapıldı. Şantiye operasyonları yetkilendirildi." : "🔒 Oturum kapatıldı."),
                          backgroundColor: globalAuth.isLoggedIn ? Colors.green : Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 🏗️ ŞANTİYE OPERASYONU ANA EKRANI
class SantiyeOperasyonAnaSayfasi extends StatefulWidget {
  final ProjeModel proje;
  final VoidCallback onUpdate;

  const SantiyeOperasyonAnaSayfasi({super.key, required this.proje, required this.onUpdate});

  @override
  State<SantiyeOperasyonAnaSayfasi> createState() => _SantiyeOperasyonAnaSayfasiState();
}

class _SantiyeOperasyonAnaSayfasiState extends State<SantiyeOperasyonAnaSayfasi> {
  int _operasyonIndex = 0; // 0: Maliyet Kontrol, 1: Saha Takip, 2: Taşören, 3: Harcama, 4: Cari

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;

    final List<Widget> operasyonSayfalari = [
      SantiyeMaliyetKontrolTab(proje: widget.proje, onUpdate: widget.onUpdate),
      ProjeGunlukSahaTab(proje: widget.proje, onUpdate: widget.onUpdate), // Tarih seçilebilir & saatli & düzenlenebilir saha takip
      ProjeTaseronTab(proje: widget.proje, onUpdate: widget.onUpdate),
      HarcamalarAraSayfasi(proje: widget.proje, onUpdate: widget.onUpdate),
      BorcAlacakSekmesi(proje: widget.proje, onUpdate: widget.onUpdate),
    ];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          color: isDark ? AppColors.cardDark : Colors.grey[100],
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildOpTabButton(0, Icons.analytics, "Maliyet Kontrol", AppColors.maliyetKontrol),
                const SizedBox(width: 6),
                _buildOpTabButton(1, Icons.camera_alt, "Saha Takip", AppColors.gunlukSaha),
                const SizedBox(width: 6),
                _buildOpTabButton(2, Icons.engineering, "Taşören", AppColors.tesisat),
                const SizedBox(width: 6),
                _buildOpTabButton(3, Icons.payments, "Harcama", AppColors.harcama),
                const SizedBox(width: 6),
                _buildOpTabButton(4, Icons.account_balance_wallet, "Cari", AppColors.ruhsat),
              ],
            ),
          ),
        ),
        const Divider(height: 1),
        Expanded(child: operasyonSayfalari[_operasyonIndex]),
      ],
    );
  }

  Widget _buildOpTabButton(int index, IconData icon, String label, Color color) {
    bool isSelected = _operasyonIndex == index;
    bool isDark = themeNotifier.isDarkMode;

    return GestureDetector(
      onTap: () => setState(() => _operasyonIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : (isDark ? AppColors.bgDark : Colors.white),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? color : Colors.grey.withOpacity(0.3)),
          boxShadow: isSelected ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 6, offset: const Offset(0, 2))] : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 📊 YENİ EKLENEN ŞANTİYE MALİYET KONTROL & BÜTÇE KARŞILAŞTIRMA SEKMESİ
class SantiyeMaliyetKontrolTab extends StatelessWidget {
  final ProjeModel proje;
  final VoidCallback onUpdate;

  const SantiyeMaliyetKontrolTab({super.key, required this.proje, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;

    double hedefButce = proje.genelProjeMaliyeti;
    double ekstraHarcamalar = proje.harcamalar.fold(0, (sum, h) => sum + h.tutar);
    double taseronOdenen = proje.taseronlar.fold(0, (sum, t) => sum + t.paidAmount);
    double gercekMaliyet = ekstraHarcamalar + taseronOdenen;

    double butceFarki = hedefButce - gercekMaliyet;
    bool isButceAsimi = gercekMaliyet > hedefButce;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF2E1065), const Color(0xFF1E1B4B)]
                    : [const Color(0xFFF3E8FF), const Color(0xFFEDE9FE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.maliyetKontrol, width: 2),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.maliyetKontrol,
                  radius: 26,
                  child: Icon(Icons.balance, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "ŞANTİYE MALİYET & HEDEF BÜTÇE KONTROLÜ",
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: AppColors.maliyetKontrol),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Gerçekleşen şantiye harcamalarının hedef proje bütçesiyle anlık mukayesesi.",
                        style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  title: "HEDEF PROJE BÜTÇESİ",
                  amount: hedefButce,
                  color: AppColors.butce,
                  icon: Icons.account_balance,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  title: "GERÇEK ŞANTİYE MALİYETİ",
                  amount: gercekMaliyet,
                  color: isButceAsimi ? Colors.red : AppColors.harcama,
                  icon: Icons.payments,
                  isDark: isDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.maliyetKontrol.withOpacity(0.4), width: 1.5),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.table_chart, color: AppColors.maliyetKontrol, size: 20),
                    SizedBox(width: 8),
                    Text("📋 Maliyet Sapma & Kalan Marj Tablosu", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
                  ],
                ),
                const Divider(height: 24),
                _buildTableRow("Hesaplanan Proje Bütçesi (Hedef):", "${_formatTL(hedefButce)} ₺", AppColors.butce),
                const Divider(height: 16),
                _buildTableRow("Şantiye Gerçek Harcamalar (Fiili):", "${_formatTL(ekstraHarcamalar)} ₺", AppColors.harcama),
                const Divider(height: 16),
                _buildTableRow("Şantiye Taşören Ödemeleri (Fiili):", "${_formatTL(taseronOdenen)} ₺", AppColors.tesisat),
                const Divider(height: 16),
                _buildTableRow("Toplam Gerçekleşen Maliyet:", "${_formatTL(gercekMaliyet)} ₺", isButceAsimi ? Colors.red : AppColors.kabaInsaat, isBold: true),
                const Divider(height: 20, thickness: 1.5),
                _buildTableRow(
                  isButceAsimi ? "⚠️ Bütçe Aşımlı Fark:" : "🎉 Kalan Bütçe Marjı (Tasarruf):",
                  "${_formatTL(butceFarki.abs())} ₺",
                  isButceAsimi ? Colors.red : Colors.green,
                  isBold: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({required String title, required double amount, required Color color, required IconData icon, required bool isDark}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.5), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 6),
              Expanded(child: Text(title, style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
            ],
          ),
          const SizedBox(height: 10),
          Text("${_formatTL(amount)} ₺", style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 16), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildTableRow(String label, String value, Color color, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w900 : FontWeight.bold,
              fontSize: isBold ? 13 : 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: isBold ? 15 : 13,
          ),
        ),
      ],
    );
  }

  String _formatTL(double value) {
    return value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}

// TAB 1: GİRDİLER
class ProjeGirdilerTab extends StatefulWidget {
  final ProjeModel proje;
  final VoidCallback onUpdate;

  const ProjeGirdilerTab({super.key, required this.proje, required this.onUpdate});

  @override
  State<ProjeGirdilerTab> createState() => _ProjeGirdilerTabState();
}

class _ProjeGirdilerTabState extends State<ProjeGirdilerTab> {
  final List<String> yapiTurleriListesi = [
    'Apartman / Konut', 'Depo', 'Fabrika', 'Hastane', 'İş Merkezi', 'Müstakil Ev', 'Okul', 'Villa'
  ];

  final List<String> kaliteSeviyeleriListesi = ['Ekonomik', 'Standart', 'Lüks', 'Ultra Lüks'];

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;
    final p = widget.proje;

    int toplamBagimsizBolum = p.toplamKonutAdedi + (p.dukkanVar ? p.dukkanAdedi : 0);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle("1. Yapı Türü, Sınıfı, İl, Tarihler & Enflasyon Projeksiyonu", AppColors.kabaInsaat),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : AppColors.cardLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.kabaInsaat.withOpacity(0.3)),
                ),
                child: DropdownButton<String>(
                  value: yapiTurleriListesi.contains(p.YapiTuru) ? p.YapiTuru : 'Apartman / Konut',
                  isExpanded: true,
                  dropdownColor: isDark ? AppColors.cardDark : AppColors.cardLight,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isDark ? Colors.white : Colors.black),
                  underline: const SizedBox(),
                  items: yapiTurleriListesi.map((tur) => DropdownMenuItem(value: tur, child: Text(tur, overflow: TextOverflow.ellipsis))).toList(),
                  onChanged: (v) => setState(() {
                    p.YapiTuru = v!;
                    widget.onUpdate();
                  }),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : AppColors.cardLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.kabaInsaat.withOpacity(0.3)),
                ),
                child: DropdownButton<String>(
                  value: kaliteSeviyeleriListesi.contains(p.yapiKalitesi) ? p.yapiKalitesi : 'Standart',
                  isExpanded: true,
                  dropdownColor: isDark ? AppColors.cardDark : AppColors.cardLight,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isDark ? Colors.white : Colors.black),
                  underline: const SizedBox(),
                  items: kaliteSeviyeleriListesi.map((kalite) => DropdownMenuItem(value: kalite, child: Text("Kalite: $kalite", overflow: TextOverflow.ellipsis))).toList(),
                  onChanged: (v) => setState(() {
                    p.yapiKalitesi = v!;
                    widget.onUpdate();
                  }),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : AppColors.cardLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.kabaInsaat.withOpacity(0.3)),
                ),
                child: DropdownButton<String>(
                  value: turkiyeIlleriListesi.contains(p.il) ? p.il : 'İstanbul',
                  isExpanded: true,
                  dropdownColor: isDark ? AppColors.cardDark : AppColors.cardLight,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isDark ? Colors.white : Colors.black),
                  underline: const SizedBox(),
                  items: turkiyeIlleriListesi.map((ilAdi) => DropdownMenuItem(value: ilAdi, child: Text("İl: $ilAdi (Katsayı: ${ProjeModel(projeAdi: '', il: ilAdi).ilMaliyetKatsayisi})", overflow: TextOverflow.ellipsis))).toList(),
                  onChanged: (v) => setState(() {
                    p.il = v!;
                    widget.onUpdate();
                  }),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: p.baslangicTarihi,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                decoration: InputDecoration(
                  labelText: "Başlangıç Tarihi",
                  filled: true,
                  fillColor: isDark ? AppColors.cardDark : AppColors.cardLight,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.kabaInsaat.withOpacity(0.3))),
                ),
                onChanged: (v) => setState(() {
                  p.baslangicTarihi = v;
                  widget.onUpdate();
                }),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                initialValue: p.bitisTarihi,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                decoration: InputDecoration(
                  labelText: "Tahmini Bitiş Tarihi",
                  filled: true,
                  fillColor: isDark ? AppColors.cardDark : AppColors.cardLight,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.kabaInsaat.withOpacity(0.3))),
                ),
                onChanged: (v) => setState(() {
                  p.bitisTarihi = v;
                  widget.onUpdate();
                }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: p.yillikEnflasyonOrani.toStringAsFixed(0),
                keyboardType: TextInputType.number,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                decoration: InputDecoration(
                  labelText: "Yıllık Beklenen Enflasyon (%) [Projeksiyon]",
                  filled: true,
                  fillColor: isDark ? AppColors.cardDark : AppColors.cardLight,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.kabaInsaat.withOpacity(0.3))),
                ),
                onChanged: (v) {
                  double? d = double.tryParse(v);
                  if (d != null) {
                    setState(() {
                      p.yillikEnflasyonOrani = d;
                      widget.onUpdate();
                    });
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionTitle("2. Toprak Üstü İnşaat & Yükseklik Verileri", AppColors.kabaInsaat),
        Row(
          children: [
            Expanded(child: _buildInput("Toprak Üstü m²", p.toprakUstuM2, (v) => setState(() { p.toprakUstuM2 = v; widget.onUpdate(); }), isDark)),
            const SizedBox(width: 10),
            Expanded(child: _buildInput("Kat Sayısı", p.katSayisi.toDouble(), (v) => setState(() { p.katSayisi = v.toInt(); widget.onUpdate(); }), isDark)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _buildInput("Kat Brüt m²", p.katBrutM2, (v) => setState(() { p.katBrutM2 = v; widget.onUpdate(); }), isDark)),
            const SizedBox(width: 10),
            Expanded(child: _buildInput("Kat Yüksekliği (m)", p.ortalamaKatYuksekligi, (v) => setState(() { p.ortalamaKatYuksekligi = v; widget.onUpdate(); }), isDark)),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionTitle("3. Bodrum Kat Metraj Verileri (Hafriyat & İzolasyon)", AppColors.kabaInsaat),
        Row(
          children: [
            Expanded(child: _buildInput("Bodrum Kat Sayısı", p.bodrumKatSayisi.toDouble(), (v) => setState(() { p.bodrumKatSayisi = v.toInt(); widget.onUpdate(); }), isDark)),
            const SizedBox(width: 10),
            Expanded(child: _buildInput("Bodrum Kat Brüt m²", p.bodrumM2, (v) => setState(() { p.bodrumM2 = v; widget.onUpdate(); }), isDark)),
            const SizedBox(width: 10),
            Expanded(child: _buildInput("Bodrum Yükseklik (m)", p.bodrumKatYuksekligi, (v) => setState(() { p.bodrumKatYuksekligi = v; widget.onUpdate(); }), isDark)),
          ],
        ),
        const SizedBox(height: 16),
        _buildSectionTitle("4. Bağımsız Bölüm & Ticari Dükkan Dağılımı", AppColors.kabaInsaat),
        Row(
          children: [
            Expanded(child: _buildInput("1+1", p.adet1plus1.toDouble(), (v) => setState(() { p.adet1plus1 = v.toInt(); widget.onUpdate(); }), isDark)),
            const SizedBox(width: 6),
            Expanded(child: _buildInput("2+1", p.adet2plus1.toDouble(), (v) => setState(() { p.adet2plus1 = v.toInt(); widget.onUpdate(); }), isDark)),
            const SizedBox(width: 6),
            Expanded(child: _buildInput("3+1", p.adet3plus1.toDouble(), (v) => setState(() { p.adet3plus1 = v.toInt(); widget.onUpdate(); }), isDark)),
            const SizedBox(width: 6),
            Expanded(child: _buildInput("4+1", p.adet4plus1.toDouble(), (v) => setState(() { p.adet4plus1 = v.toInt(); widget.onUpdate(); }), isDark)),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: isDark ? AppColors.cardDark : AppColors.cardLight, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.kabaInsaat.withOpacity(0.3))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: Text("• Projede Ticari Dükkan Var mı?", style: TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis)),
              Switch(value: p.dukkanVar, activeColor: AppColors.kabaInsaat, onChanged: (v) => setState(() { p.dukkanVar = v; widget.onUpdate(); })),
            ],
          ),
        ),
        if (p.dukkanVar) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildInput("Dükkan Adedi", p.dukkanAdedi.toDouble(), (v) => setState(() { p.dukkanAdedi = v.toInt(); widget.onUpdate(); }), isDark)),
              const SizedBox(width: 10),
              Expanded(child: _buildInput("Dükkan Başı m²", p.dukkanBasiM2, (v) => setState(() { p.dukkanBasiM2 = v; widget.onUpdate(); }), isDark)),
            ],
          ),
        ],
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark 
                  ? [const Color(0xFF1E1B4B), const Color(0xFF0F172A)]
                  : [const Color(0xFFFDFBF7), const Color(0xFFF3ECE1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF6366F1), width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withOpacity(isDark ? 0.3 : 0.15),
                blurRadius: 16,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text("📐 TOPLAM İNŞAAT ALANI:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF818CF8)), overflow: TextOverflow.ellipsis)),
                  Text("${_formatTL(p.toplamInsaatM2)} m²", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7))),
                ],
              ),
              const Divider(height: 20, color: Color(0xFF6366F1)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text("🏢 TOPLAM BAĞIMSIZ BÖLÜM:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF818CF8)), overflow: TextOverflow.ellipsis)),
                  Text("$toplamBagimsizBolum Adet", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: isDark ? const Color(0xFF34D399) : const Color(0xFF059669))),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildInput(String label, double initialVal, Function(double) onChanged, bool isDark) {
    return TextFormField(
      initialValue: initialVal.toInt().toString(),
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: isDark ? AppColors.cardDark : AppColors.cardLight,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.kabaInsaat.withOpacity(0.3))),
      ),
      onChanged: (v) {
        double? d = double.tryParse(v);
        if (d != null) onChanged(d);
      },
    );
  }

  String _formatTL(double value) {
    return value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}

// TAB 2: İMALATLAR
class ProjeImalatlarTab extends StatefulWidget {
  final ProjeModel proje;
  final VoidCallback onUpdate;
  const ProjeImalatlarTab({super.key, required this.proje, required this.onUpdate});

  @override
  State<ProjeImalatlarTab> createState() => _ProjeImalatlarTabState();
}

class _ProjeImalatlarTabState extends State<ProjeImalatlarTab> {
  bool isAsansorExpanded = true;
  bool isHafriyatExpanded = true;

  void _imalatMaliyetiGuncelleOnayDialog(String baslik, double mevcutDeger, Function(double) onGuncelle) {
    double yeniDeger = mevcutDeger;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("$baslik Maliyeti"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Bu imalatın birim maliyetini değiştirmek istediğinize emin misiniz?", style: TextStyle(fontSize: 13)),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: mevcutDeger.toStringAsFixed(0),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Yeni İmalat Maliyeti (TL)",
                border: OutlineInputBorder(),
              ),
              onChanged: (v) {
                double? d = double.tryParse(v);
                if (d != null) yeniDeger = d;
              },
            ),
          ],
        ),
        actions: [
          TextButton(child: const Text("Hayır"), onPressed: () => Navigator.pop(context)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.kabaInsaat),
            child: const Text("Evet, Güncelle", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () {
              setState(() {
                onGuncelle(yeniDeger);
              });
              widget.onUpdate();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;
    final p = widget.proje;
    double genelToplam = p.genelProjeMaliyeti;
    double kdvDahilM2 = p.kdvDahilM2Maliyeti;

    double bilesikEnflasyonFaktoru = pow(1 + (p.yillikEnflasyonOrani / 100.0), p.projeSuresiYil).toDouble();
    double enflasyonluTahminiToplam = genelToplam * bilesikEnflasyonFaktoru;

    String m2Metraj = "${p.toplamInsaatM2.toStringAsFixed(0)} m² Proje Alanı";
    String zeminMetraj = "1 Adet Zemin Etüdü";
    String haritaMetraj = "1 Adet Aplikasyon";
    String yapiDenetimMetraj = "${p.toplamInsaatM2.toStringAsFixed(0)} m² Denetim";
    String belediyeMetraj = "${p.toplamInsaatM2.toStringAsFixed(0)} m² Ruhsat Alanı";

    String santiyeKurulumMetraj = "1 Set Konteyner, Çit & Altyapı Kurulumu";
    String hafriyatMetraj = "${p.hafriyatM3.toStringAsFixed(0)} m³ Kazı (Bodrum: ${p.bodrumKatSayisi} Kat)";
    double demirTon = (p.toplamInsaatM2 * 60) / 1000.0;
    String demirMetraj = "${demirTon.toStringAsFixed(1)} Ton İnşaat Demiri";
    double betonM3 = p.toplamInsaatM2 * 0.50;
    String betonMetraj = "${betonM3.toStringAsFixed(0)} m³ Hazır Beton";
    String izolasyonMetraj = "${p.izolasyonM2.toStringAsFixed(0)} m² (Temel + Bodrum Perde İzolasyonu)";
    String catiMetraj = "${p.katBrutM2.toStringAsFixed(0)} m² Çatı Alanı";

    int efAsansorAdet = (p.toplamKonutAdedi >= 20 && p.asansorAdedi < 2) ? 2 : p.asansorAdedi;
    String asansorMetraj = "$efAsansorAdet Adet, ${p.asansorDurakSayisi} Durak (${p.asansorKisiSay_Str()})";
    String elektrikMetraj = "${p.toplamInsaatM2.toStringAsFixed(0)} m² Elektrik Altyapısı";
    String mekanikMetraj = "${p.toplamInsaatM2.toStringAsFixed(0)} m² Mekanik Tesisat";
    String cepheMetraj = "${p.toplamInsaatM2.toStringAsFixed(0)} m² Cephe Kaplama";
    String dogramaMetraj = "${(p.toplamInsaatM2 * 0.20).toStringAsFixed(0)} m² Doğrama / Pencere";
    String peyzaMetraj = "${p.toplamInsaatM2.toStringAsFixed(0)} m² Çevre & Peyzaj";

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark 
                  ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                  : [const Color(0xFF1E3A8A), const Color(0xFF3B82F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.4 : 0.15),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
            border: Border.all(color: isDark ? const Color(0xFF475569) : const Color(0xFF93C5FD), width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.verified, color: Color(0xFF60A5FA), size: 20),
                      SizedBox(width: 6),
                      Text("PROJE ÖZETİ & ENFLASYON PROJEKSİYONU", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 0.5)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: const Color(0xFF3B82F6), borderRadius: BorderRadius.circular(8)),
                    child: Text("${p.il.toUpperCase()} (K: ${p.ilMaliyetKatsayisi})", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 10)),
                  ),
                ],
              ),
              const Divider(height: 16, color: Colors.white24),
              Row(
                children: [
                  Expanded(child: _buildBarDetailItem("Yapı Türü", p.YapiTuru)),
                  Expanded(child: _buildBarDetailItem("Kalite", p.yapiKalitesi)),
                  Expanded(child: _buildBarDetailItem("Süre / Enflasyon", "${p.projeSuresiYil.toStringAsFixed(1)} Yıl (%${p.yillikEnflasyonOrani.toInt()})")),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("GÜNCEL m² MALİYETİ:", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 11)),
                        Text("${_formatTL(kdvDahilM2)} ₺ / m²", style: const TextStyle(color: Color(0xFF34D399), fontWeight: FontWeight.w900, fontSize: 15)),
                      ],
                    ),
                    const Divider(height: 12, color: Colors.white24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Enflasyon Projeksiyonlu Tahmini Bitiş:", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 10)),
                        Text("${_formatTL(enflasyonluTahminiToplam)} ₺", style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.w900, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        _buildSectionHeaderCard("RUHSAT ÖNCESİ GİDERLER", AppColors.ruhsat),
        _buildCleanDetailRow("Mimari Proje Çizim", p.isManuelMimari ? p.manuelMimari : ((p.toplamInsaatM2 * p.imalatMaliyetiMimari * p.kaliteKatsayisi) * p.toplamIlCarpani), genelToplam, p.isManuelMimari, (v) => setState(() => p.isManuelMimari = v), (v) => setState(() => p.manuelMimari = v), AppColors.ruhsat, isDark, "Birim: ${(p.imalatMaliyetiMimari * p.kaliteKatsayisi).toInt()} TL/m²", m2Metraj, () => _imalatMaliyetiGuncelleOnayDialog("Mimari Proje Çizim", p.imalatMaliyetiMimari, (v) => p.imalatMaliyetiMimari = v)),
        _buildCleanDetailRow("Zemin Etüdü Bedeli", p.isManuelZemin ? p.manuelZemin : ((p.imalatMaliyetiZemin * p.kaliteKatsayisi) * p.toplamIlCarpani), genelToplam, p.isManuelZemin, (v) => setState(() => p.isManuelZemin = v), (v) => setState(() => p.manuelZemin = v), AppColors.ruhsat, isDark, "Birim: ${(p.imalatMaliyetiZemin * p.kaliteKatsayisi).toInt()} TL Götürü", zeminMetraj, () => _imalatMaliyetiGuncelleOnayDialog("Zemin Etüdü", p.imalatMaliyetiZemin, (v) => p.imalatMaliyetiZemin = v)),
        _buildCleanDetailRow("Haritacı / Aplikasyon", p.isManuelHaritaci ? p.manuelHaritaci : (p.imalatMaliyetiHaritaci * p.toplamIlCarpani), genelToplam, p.isManuelHaritaci, (v) => setState(() => p.isManuelHaritaci = v), (v) => setState(() => p.manuelHaritaci = v), AppColors.ruhsat, isDark, "Birim: ${p.imalatMaliyetiHaritaci.toInt()} TL Götürü", haritaMetraj, () => _imalatMaliyetiGuncelleOnayDialog("Haritacı Bedeli", p.imalatMaliyetiHaritaci, (v) => p.imalatMaliyetiHaritaci = v)),
        _buildCleanDetailRow("Yapı Denetim Hizmeti", p.isManuelYapiDenetim ? p.manuelYapiDenetim : (p.imalatMaliyetiYapiDenetim * p.toplamIlCarpani), genelToplam, p.isManuelYapiDenetim, (v) => setState(() => p.isManuelYapiDenetim = v), (v) => setState(() => p.manuelYapiDenetim = v), AppColors.ruhsat, isDark, "Birim: ${p.imalatMaliyetiYapiDenetim.toInt()} TL Götürü", yapiDenetimMetraj, () => _imalatMaliyetiGuncelleOnayDialog("Yapı Denetim", p.imalatMaliyetiYapiDenetim, (v) => p.imalatMaliyetiYapiDenetim = v)),
        _buildCleanDetailRow("Belediye Ruhsat Harcı", p.isManuelBelediye ? p.manuelBelediye : ((p.toplamInsaatM2 * p.imalatMaliyetiBelediye) * p.toplamIlCarpani), genelToplam, p.isManuelBelediye, (v) => setState(() => p.isManuelBelediye = v), (v) => setState(() => p.manuelBelediye = v), AppColors.ruhsat, isDark, "Birim: ${p.imalatMaliyetiBelediye.toInt()} TL/m²", belediyeMetraj, () => _imalatMaliyetiGuncelleOnayDialog("Belediye Harcı", p.imalatMaliyetiBelediye, (v) => p.imalatMaliyetiBelediye = v)),

        const SizedBox(height: 20),
        _buildSectionHeaderCard("KABA İNŞAAT & ÇATI İŞLERİ", AppColors.kabaInsaat),
        _buildCleanDetailRow("Şantiye Kurulumu ve Tesisler", p.isManuelSantiyeKurulumu ? p.manuelSantiyeKurulumu : (p.imalatMaliyetiSantiyeKurulumu * p.toplamIlCarpani), genelToplam, p.isManuelSantiyeKurulumu, (v) => setState(() => p.isManuelSantiyeKurulumu = v), (v) => setState(() => p.manuelSantiyeKurulumu = v), AppColors.kabaInsaat, isDark, "Birim: ${p.imalatMaliyetiSantiyeKurulumu.toInt()} TL Götürü", santiyeKurulumMetraj, () => _imalatMaliyetiGuncelleOnayDialog("Şantiye Kurulumu", p.imalatMaliyetiSantiyeKurulumu, (v) => p.imalatMaliyetiSantiyeKurulumu = v)),
        _buildHafriyatIksaDetailRow(p, genelToplam, isDark, hafriyatMetraj),
        _buildCleanDetailRow("İnşaat Demiri (Tonaj)", p.isManuelDemir ? p.manuelDemir : ((demirTon * p.imalatMaliyetiDemir) * p.toplamIlCarpani), genelToplam, p.isManuelDemir, (v) => setState(() => p.isManuelDemir = v), (v) => setState(() => p.manuelDemir = v), AppColors.kabaInsaat, isDark, "Birim: ${p.imalatMaliyetiDemir.toInt()} TL/Ton", demirMetraj, () => _imalatMaliyetiGuncelleOnayDialog("Demir", p.imalatMaliyetiDemir, (v) => p.imalatMaliyetiDemir = v)),
        _buildCleanDetailRow("Hazır Beton (C30/35)", p.isManuelBeton ? p.manuelBeton : ((betonM3 * p.imalatMaliyetiBeton) * p.toplamIlCarpani), genelToplam, p.isManuelBeton, (v) => setState(() => p.isManuelBeton = v), (v) => setState(() => p.manuelBeton = v), AppColors.kabaInsaat, isDark, "Birim: ${p.imalatMaliyetiBeton.toInt()} TL/m³", betonMetraj, () => _imalatMaliyetiGuncelleOnayDialog("Beton", p.imalatMaliyetiBeton, (v) => p.imalatMaliyetiBeton = v)),
        _buildCleanDetailRow("İzolasyon (Temel + Perde)", p.isManuelIzolasyon ? p.manuelIzolasyon : ((p.izolasyonM2 * p.imalatMaliyetiIzolasyon) * p.toplamIlCarpani), genelToplam, p.isManuelIzolasyon, (v) => setState(() => p.isManuelIzolasyon = v), (v) => setState(() => p.manuelIzolasyon = v), AppColors.kabaInsaat, isDark, "Birim: ${p.imalatMaliyetiIzolasyon.toInt()} TL/m²", izolasyonMetraj, () => _imalatMaliyetiGuncelleOnayDialog("İzolasyon", p.imalatMaliyetiIzolasyon, (v) => p.imalatMaliyetiIzolasyon = v)),
        _buildCleanDetailRow("Çelik Çatı İmalatı", p.isManuelCati ? p.manuelCati : ((p.katBrutM2 * p.imalatMaliyetiCati * p.kaliteKatsayisi) * p.toplamIlCarpani), genelToplam, p.isManuelCati, (v) => setState(() => p.isManuelCati = v), (v) => setState(() => p.manuelCati = v), AppColors.kabaInsaat, isDark, "Birim: ${(p.imalatMaliyetiCati * p.kaliteKatsayisi).toInt()} TL/m²", catiMetraj, () => _imalatMaliyetiGuncelleOnayDialog("Çelik Çatı", p.imalatMaliyetiCati, (v) => p.imalatMaliyetiCati = v)),

        const SizedBox(height: 20),
        _buildSectionHeaderCard("İNCE İŞLER & DONATILAR", AppColors.inceIsler),
        _buildAsansorDetailRow(p, genelToplam, isDark, asansorMetraj),
        _buildCleanDetailRow("Elektrik İmalatı", p.isManuelElektrik ? p.manuelElektrik : ((p.toplamInsaatM2 * p.imalatMaliyetiElektrik * p.kaliteKatsayisi) * p.toplamIlCarpani), genelToplam, p.isManuelElektrik, (v) => setState(() => p.isManuelElektrik = v), (v) => setState(() => p.manuelElektrik = v), AppColors.inceIsler, isDark, "Birim: ${(p.imalatMaliyetiElektrik * p.kaliteKatsayisi).toInt()} TL/m²", elektrikMetraj, () => _imalatMaliyetiGuncelleOnayDialog("Elektrik İmalatı", p.imalatMaliyetiElektrik, (v) => p.imalatMaliyetiElektrik = v)),
        _buildCleanDetailRow("Mekanik İmalatlar", p.isManuelMekanik ? p.manuelMekanik : ((p.toplamInsaatM2 * p.imalatMaliyetiMekanik * p.kaliteKatsayisi) * p.toplamIlCarpani), genelToplam, p.isManuelMekanik, (v) => setState(() => p.isManuelMekanik = v), (v) => setState(() => p.manuelMekanik = v), AppColors.inceIsler, isDark, "Birim: ${(p.imalatMaliyetiMekanik * p.kaliteKatsayisi).toInt()} TL/m²", mekanikMetraj, () => _imalatMaliyetiGuncelleOnayDialog("Mekanik İmalat", p.imalatMaliyetiMekanik, (v) => p.imalatMaliyetiMekanik = v)),
        _buildCleanDetailRow("Cephe İmalatları", p.isManuelCephe ? p.manuelCephe : ((p.toplamInsaatM2 * p.imalatMaliyetiCephe * p.kaliteKatsayisi) * p.toplamIlCarpani), genelToplam, p.isManuelCephe, (v) => setState(() => p.isManuelCephe = v), (v) => setState(() => p.manuelCephe = v), AppColors.inceIsler, isDark, "Birim: ${(p.imalatMaliyetiCephe * p.kaliteKatsayisi).toInt()} TL/m²", cepheMetraj, () => _imalatMaliyetiGuncelleOnayDialog("Cephe İmalatı", p.imalatMaliyetiCephe, (v) => p.imalatMaliyetiCephe = v)),
        _buildCleanDetailRow("Doğrama İmalatları", p.isManuelDograma ? p.manuelDograma : ((p.toplamInsaatM2 * p.imalatMaliyetiDograma * p.kaliteKatsayisi) * p.toplamIlCarpani), genelToplam, p.isManuelDograma, (v) => setState(() => p.isManuelDograma = v), (v) => setState(() => p.manuelDograma = v), AppColors.inceIsler, isDark, "Birim: ${(p.imalatMaliyetiDograma * p.kaliteKatsayisi).toInt()} TL/m²", dogramaMetraj, () => _imalatMaliyetiGuncelleOnayDialog("Doğrama İmalatı", p.imalatMaliyetiDograma, (v) => p.imalatMaliyetiDograma = v)),
        _buildCleanDetailRow("Peyzaj İmalatları", p.isManuelPeyzaj ? p.manuelPeyzaj : ((p.toplamInsaatM2 * p.imalatMaliyetiPeyzaj * p.kaliteKatsayisi) * p.toplamIlCarpani), genelToplam, p.isManuelPeyzaj, (v) => setState(() => p.isManuelPeyzaj = v), (v) => setState(() => p.manuelPeyzaj = v), AppColors.inceIsler, isDark, "Birim: ${(p.imalatMaliyetiPeyzaj * p.kaliteKatsayisi).toInt()} TL/m²", peyzaMetraj, () => _imalatMaliyetiGuncelleOnayDialog("Peyzaj İmalatı", p.imalatMaliyetiPeyzaj, (v) => p.imalatMaliyetiPeyzaj = v)),
      ],
    );
  }

  Widget _buildBarDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900), overflow: TextOverflow.ellipsis),
      ],
    );
  }

  Widget _buildHafriyatIksaDetailRow(ProjeModel p, double genelToplam, bool isDark, String hafriyatMetraj) {
    double efTutar = p.isManuelHafriyat ? p.manuelHafriyat : (((p.hafriyatM3 * p.imalatMaliyetiHafriyat) + p.iksaMaliyeti) * p.toplamIlCarpani);
    double yuzde = genelToplam > 0 ? (efTutar / genelToplam) * 100 : 0;
    Color color = AppColors.kabaInsaat;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Material(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: p.isManuelHafriyat ? Border.all(color: color, width: 2) : Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Expanded(child: Text("Hafriyat Kazı & İksa İmalatı", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                          child: Text("%${yuzde.toStringAsFixed(1)}", style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                        IconButton(
                          icon: Icon(isHafriyatExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: color, size: 20),
                          onPressed: () => setState(() => isHafriyatExpanded = !isHafriyatExpanded),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("${_formatTL(efTutar)} TL", style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
                      Row(
                        children: [
                          const Text("Manuel", style: TextStyle(color: Colors.grey, fontSize: 10)),
                          SizedBox(
                            height: 24, 
                            child: Switch(
                              value: p.isManuelHafriyat, 
                              activeColor: color, 
                              onChanged: (v) {
                                setState(() => p.isManuelHafriyat = v);
                                widget.onUpdate();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 2),
              Text("📐 Kullanılacak Miktar: $hafriyatMetraj", style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
              if (isHafriyatExpanded) ...[
                const Divider(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: Text("• Derin Kaz / İksa Sistemi Var mı?", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
                    Switch(
                      value: p.iksaVar,
                      activeColor: color,
                      onChanged: (v) {
                        setState(() => p.iksaVar = v);
                        widget.onUpdate();
                      },
                    )
                  ],
                ),
                if (p.iksaVar) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.bgDark : AppColors.bgLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            value: ['Fore Kazık', 'Püskürtme Beton', 'Kuyu Temel', 'Ankraj / İksa'].contains(p.iksaTuru) ? p.iksaTuru : 'Fore Kazık',
                            isExpanded: true,
                            dropdownColor: isDark ? AppColors.cardDark : AppColors.cardLight,
                            underline: const SizedBox(),
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
                            items: const [
                              DropdownMenuItem(value: "Fore Kazık", child: Text("Fore Kazık Sistemi")),
                              DropdownMenuItem(value: "Püskürtme Beton", child: Text("Püskürtme Beton (Şotkret)")),
                              DropdownMenuItem(value: "Kuyu Temel", child: Text("Kuyu Temel Sistemi")),
                              DropdownMenuItem(value: "Ankraj / İksa", child: Text("Ankrajlı İksa Perdesi")),
                            ],
                            onChanged: (v) {
                              if (v != null) {
                                setState(() => p.iksaTuru = v);
                                widget.onUpdate();
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          initialValue: p.iksaBirimMaliyeti.toInt().toString(),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            labelText: "İksa Birim Maliyeti (TL/m²)",
                            filled: true,
                            fillColor: isDark ? AppColors.bgDark : AppColors.bgLight,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                          ),
                          onChanged: (v) {
                            double? d = double.tryParse(v);
                            if (d != null) {
                              setState(() => p.iksaBirimMaliyeti = d);
                              widget.onUpdate();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
                if (p.isManuelHafriyat) ...[
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: efTutar.toInt().toString(),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: "Özel Toplam Hafriyat Tutarı (TL)",
                      filled: true,
                      fillColor: isDark ? AppColors.bgDark : Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onChanged: (v) {
                      double? d = double.tryParse(v);
                      if (d != null) {
                        setState(() => p.manuelHafriyat = d);
                        widget.onUpdate();
                      }
                    },
                  )
                ]
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAsansorDetailRow(ProjeModel p, double genelToplam, bool isDark, String asansorMetraj) {
    double efTutar = p.isManuelAsansor ? p.manuelAsansor : (p.asansorHesaplananTutar * p.toplamIlCarpani);
    double yuzde = genelToplam > 0 ? (efTutar / genelToplam) * 100 : 0;
    Color color = AppColors.asansor;
    bool zorunluIkiAsansor = p.toplamKonutAdedi >= 20;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Material(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: p.isManuelAsansor ? Border.all(color: color, width: 2) : Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Expanded(child: Text("Asansör İmalatı", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                          child: Text("%${yuzde.toStringAsFixed(1)}", style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                        IconButton(
                          icon: Icon(isAsansorExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: color, size: 20),
                          onPressed: () => setState(() => isAsansorExpanded = !isAsansorExpanded),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("${_formatTL(efTutar)} TL", style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
                      Row(
                        children: [
                          const Text("Manuel", style: TextStyle(color: Colors.grey, fontSize: 10)),
                          SizedBox(
                            height: 24, 
                            child: Switch(
                              value: p.isManuelAsansor, 
                              activeColor: color, 
                              onChanged: (v) {
                                setState(() => p.isManuelAsansor = v);
                                widget.onUpdate();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 2),
              Text("📐 Kullanılacak Miktar: $asansorMetraj", style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
              if (zorunluIkiAsansor) ...[
                const SizedBox(height: 4),
                Text(
                  "⚠️ Projede ${p.toplamKonutAdedi} daire var. Yönetmelik gereği en az 2 asansör hesaplandı.",
                  style: TextStyle(color: Colors.orange[400], fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
              if (isAsansorExpanded) ...[
                const Divider(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.bgDark : AppColors.bgLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<int>(
                          value: [4, 8, 10, 12, 16].contains(p.asansorKisiSayisi) ? p.asansorKisiSayisi : 8,
                          isExpanded: true,
                          dropdownColor: isDark ? AppColors.cardDark : AppColors.cardLight,
                          underline: const SizedBox(),
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
                          items: const [
                            DropdownMenuItem(value: 4, child: Text("4 Kişilik")),
                            DropdownMenuItem(value: 8, child: Text("8 Kişilik")),
                            DropdownMenuItem(value: 10, child: Text("10 Kişilik")),
                            DropdownMenuItem(value: 12, child: Text("12 Kişilik")),
                            DropdownMenuItem(value: 16, child: Text("16 Kişilik")),
                          ],
                          onChanged: (v) {
                            if (v != null) {
                              setState(() => p.asansorKisiSayisi = v);
                              widget.onUpdate();
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        initialValue: p.asansorDurakSayisi.toString(),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: "Durak Sayısı",
                          filled: true,
                          fillColor: isDark ? AppColors.bgDark : AppColors.bgLight,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                        ),
                        onChanged: (v) {
                          int? d = int.tryParse(v);
                          if (d != null) {
                            setState(() => p.asansorDurakSayisi = d);
                            widget.onUpdate();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        initialValue: (p.toplamKonutAdedi >= 20 && p.asansorAdedi < 2 ? 2 : p.asansorAdedi).toString(),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: "Adet",
                          filled: true,
                          fillColor: isDark ? AppColors.bgDark : AppColors.bgLight,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                        ),
                        onChanged: (v) {
                          int? a = int.tryParse(v);
                          if (a != null) {
                            setState(() => p.asansorAdedi = a);
                            widget.onUpdate();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                if (p.isManuelAsansor) ...[
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: efTutar.toInt().toString(),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: "Özel Asansör Tutarı (TL)",
                      filled: true,
                      fillColor: isDark ? AppColors.bgDark : Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onChanged: (v) {
                      double? d = double.tryParse(v);
                      if (d != null) {
                        setState(() => p.manuelAsansor = d);
                        widget.onUpdate();
                      }
                    },
                  )
                ]
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCleanDetailRow(
    String title,
    double efTutar,
    double genelToplam,
    bool isManuel,
    Function(bool) onToggle,
    Function(double) onValChanged,
    Color color,
    bool isDark,
    String maliyetMetin,
    String metrajMetin,
    VoidCallback onMaliyetDuzenle,
  ) {
    double yuzde = genelToplam > 0 ? (efTutar / genelToplam) * 100 : 0;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Material(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: isManuel ? Border.all(color: color, width: 2) : Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis)),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                          child: Text("%${yuzde.toStringAsFixed(1)}", style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("${_formatTL(efTutar)} TL", style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
                      Row(
                        children: [
                          const Text("Manuel", style: TextStyle(color: Colors.grey, fontSize: 10)),
                          SizedBox(
                            height: 24,
                            child: Switch(
                              value: isManuel,
                              activeColor: color,
                              onChanged: (v) {
                                onToggle(v);
                                widget.onUpdate();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text("📐 Miktar: $metrajMetin", style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
                  if (!isManuel)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(child: Text("⚙️ $maliyetMetin", style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
                        IconButton(
                          icon: const Icon(Icons.tune, color: AppColors.kabaInsaat, size: 16),
                          tooltip: "İmalat Maliyetini Düzenle",
                          onPressed: onMaliyetDuzenle,
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.only(left: 4),
                        ),
                      ],
                    ),
                ],
              ),
              if (isManuel) ...[
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: efTutar.toInt().toString(),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "Özel Tutar Giriniz (TL)",
                    filled: true,
                    fillColor: isDark ? AppColors.bgDark : Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onChanged: (v) {
                    double? d = double.tryParse(v);
                    if (d != null) {
                      onValChanged(d);
                      widget.onUpdate();
                    }
                  },
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeaderCard(String title, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(6), border: Border.all(color: color)),
      child: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  String _formatTL(double value) {
    return value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}

extension on ProjeModel {
  String asansorKisiSay_Str() {
    return "$asansorKisiSayisi Kişilik";
  }
}

// TAB 3: BÜTÇE
class ProjeButceTab extends StatelessWidget {
  final ProjeModel proje;
  final VoidCallback onUpdate;
  const ProjeButceTab({super.key, required this.proje, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;
    final p = proje;

    double genelToplam = p.genelProjeMaliyeti;
    double ruhsatOncesi = p.toplamRuhsatOncesi;
    double kabaInsaat = p.toplamKabaInsaat;
    double inceIsler = p.toplamInceIsler;
    double ekstraHarcamalar = p.harcamalar.fold(0, (sum, h) => sum + h.tutar);

    int toplamBagimsizBolum = p.toplamKonutAdedi + (p.dukkanVar ? p.dukkanAdedi : 0);
    double bagimsizBolumBasiMaliyet = toplamBagimsizBolum > 0 ? genelToplam / toplamBagimsizBolum : 0;
    double m2BasiMaliyet = p.toplamInsaatM2 > 0 ? genelToplam / p.toplamInsaatM2 : 0;

    double ruhsatYuzde = genelToplam > 0 ? (ruhsatOncesi / genelToplam) * 100 : 0;
    double kabaYuzde = genelToplam > 0 ? (kabaInsaat / genelToplam) * 100 : 0;
    double inceYuzde = genelToplam > 0 ? (inceIsler / genelToplam) * 100 : 0;
    double ekstraYuzde = genelToplam > 0 ? (ekstraHarcamalar / genelToplam) * 100 : 0;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF111827), const Color(0xFF080C14)]
                  : [const Color(0xFF111827), const Color(0xFF1F2937)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.butce.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(color: AppColors.butce, width: 2),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.account_balance, color: AppColors.butce, size: 20),
                  SizedBox(width: 8),
                  Text("HESAPLANAN PROJE BÜTÇESİ", style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1)),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "${_formatTL(genelToplam)} TL",
                style: const TextStyle(color: Color(0xFF34D399), fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 0.5),
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.white24, height: 1),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("m² Başı Maliyet", style: TextStyle(color: Colors.white60, fontSize: 11)),
                          const SizedBox(height: 4),
                          Text("${_formatTL(m2BasiMaliyet)} TL", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.butce.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.butce.withOpacity(0.5)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("1 Bağımsız Bölüm", style: TextStyle(color: AppColors.butce, fontSize: 11, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text("${_formatTL(bagimsizBolumBasiMaliyet)} TL", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text("📊 Bütçe Dağılımı & Halka Grafik", style: TextStyle(color: AppColors.butce, fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : AppColors.cardLight,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.butce.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 170,
                width: 170,
                child: CustomPaint(
                  painter: HalkaGrafikPainter(
                    ruhsatYuzde: ruhsatYuzde,
                    kabaYuzde: kabaYuzde,
                    inceYuzde: inceYuzde,
                    ekstraYuzde: ekstraYuzde,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("HESAPLANAN BÜTÇE", style: TextStyle(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.bold)),
                        Text("${_formatTL(genelToplam)} TL", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _grafikSatir("Ruhsat Öncesi", ruhsatOncesi, ruhsatYuzde, AppColors.chartRuhsat),
              const Divider(),
              _grafikSatir("Kaba İnşaat", kabaInsaat, kabaYuzde, AppColors.chartKaba),
              const Divider(),
              _grafikSatir("İnce İşler", inceIsler, inceYuzde, AppColors.chartInce),
              const Divider(),
              _grafikSatir("Ekstra Harcamalar", ekstraHarcamalar, ekstraYuzde, AppColors.chartEkstra),
            ],
          ),
        ),
      ],
    );
  }

  Widget _grafikSatir(String baslik, double tutar, double yuzde, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              CircleAvatar(backgroundColor: color, radius: 6),
              const SizedBox(width: 8),
              Expanded(child: Text(baslik, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
        Text("${_formatTL(tutar)} TL (%${yuzde.toStringAsFixed(1)})", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }

  String _formatTL(double value) {
    return value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}

class HalkaGrafikPainter extends CustomPainter {
  final double ruhsatYuzde;
  final double kabaYuzde;
  final double inceYuzde;
  final double ekstraYuzde;

  HalkaGrafikPainter({required this.ruhsatYuzde, required this.kabaYuzde, required this.inceYuzde, required this.ekstraYuzde});

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 18.0;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width - strokeWidth) / 2;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startAngle = -pi / 2;

    List<double> yuzdeler = [ruhsatYuzde, kabaYuzde, inceYuzde, ekstraYuzde];
    List<Color> renkler = [AppColors.chartRuhsat, AppColors.chartKaba, AppColors.chartInce, AppColors.chartEkstra];

    for (int i = 0; i < yuzdeler.length; i++) {
      if (yuzdeler[i] <= 0) continue;
      double sweepAngle = (yuzdeler[i] / 100) * (2 * pi);
      paint.color = renkler[i];
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle - 0.05, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 4. EKSTRA HARCAMALAR SAYFASI
class HarcamalarAraSayfasi extends StatefulWidget {
  final ProjeModel proje;
  final VoidCallback onUpdate;

  const HarcamalarAraSayfasi({super.key, required this.proje, required this.onUpdate});

  @override
  State<HarcamalarAraSayfasi> createState() => _HarcamalarAraSayfasiState();
}

class _HarcamalarAraSayfasiState extends State<HarcamalarAraSayfasi> {
  final Map<String, List<String>> altKategorilerMap = {
    'Kaba İnşaat': ['Beton', 'Demir', 'Kalıp', 'Hafriyat', 'Kat Döşemesi', 'Temel Yalıtımı', 'Diğer'],
    'İnce İşler': ['Sıva', 'Şap', 'Seramik', 'Parke', 'Boya', 'Kapılar', 'Mutfak Dolabı', 'Banyo Ekipmanları', 'Diğer'],
    'Tesisatlar': ['Elektrik Tesisatı', 'Sıhhi Tesisat', 'Doğalgaz Tesisatı', 'Yangın Tesisatı', 'İnternet / TV Altyapısı', 'Diğer'],
    'Asansör ve Ortak Alanlar': ['Asansör', 'Merdiven Kaplamaları', 'Antre / Bina Girişi', 'Kapı / Posta Kutusu', 'Korkuluklar', 'Diğer'],
    'Resmi Giderler': ['Mimari Proje', 'Statik Proje', 'Elektrik-Mekanik', 'Zemin Etüdü', 'Yapı Denetim', 'Belediye Ruhsat', 'İskan', 'Diğer'],
    'İşçilik + SGK': ['Usta Yevmiyeleri', 'Taşeren Bedelleri', 'SGK Primleri', 'Bağkur', 'Diğer'],
  };

  final Map<String, IconData> kategoriIkonlar = {
    'Kaba İnşaat': Icons.handyman,
    'İnce İşler': Icons.home_repair_service,
    'Tesisatlar': Icons.bolt,
    'Asansör ve Ortak Alanlar': Icons.elevator,
    'Resmi Giderler': Icons.description,
    'İşçilik + SGK': Icons.badge,
  };

  final Map<String, Color> kategoriRenkler = {
    'Kaba İnşaat': AppColors.kabaInsaat,
    'İnce İşler': AppColors.inceIsler,
    'Tesisatlar': AppColors.tesisat,
    'Asansör ve Ortak Alanlar': AppColors.asansor,
    'Resmi Giderler': AppColors.resmi,
    'İşçilik + SGK': AppColors.iscilik,
  };

  void _harcamaSilDialog(HarcamaModel harcama) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Harcamayı Sil"),
        content: const Text("Bu harcama kalemini silmek istediğinize emin misiniz?"),
        actions: [
          TextButton(child: const Text("Hayır"), onPressed: () => Navigator.pop(context)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Evet, Sil", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () {
              setState(() {
                widget.proje.harcamalar.remove(harcama);
              });
              widget.onUpdate();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _yeniHarcamaEkleDialog(BuildContext context) {
    double tutar = 0;
    String secilenAnaKategori = 'Kaba İnşaat';
    String secilenAltKategori = 'Demir';
    double miktar = 1;
    String birim = 'Ton';
    String odemeYontemi = 'Nakit/Havale';
    String tarih = '15.04.2026';
    String not = '';

    List<String> odemeYontemleri = ['Nakit/Havale', 'Kredi Kartı', 'Çek'];

    showDialog(
      context: context,
      builder: (context) {
        bool isDark = themeNotifier.isDarkMode;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            List<String> altKategoriler = altKategorilerMap[secilenAnaKategori] ?? ['Diğer'];
            if (!altKategoriler.contains(secilenAltKategori)) {
              secilenAltKategori = altKategoriler.first;
            }

            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Ekstra Harcama Ekle", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                          IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                        ],
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: "TUTAR (TL)",
                          filled: true,
                          fillColor: isDark ? AppColors.bgDark : AppColors.bgLight,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                        ),
                        onChanged: (v) => tutar = double.tryParse(v) ?? 0,
                      ),
                      const SizedBox(height: 16),
                      const Text("KATEGORİ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                      const SizedBox(height: 8),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2.2,
                        ),
                        itemCount: altKategorilerMap.keys.length,
                        itemBuilder: (context, index) {
                          String kat = altKategorilerMap.keys.elementAt(index);
                          bool secili = secilenAnaKategori == kat;
                          Color renk = kategoriRenkler[kat] ?? AppColors.kabaInsaat;
                          IconData ikon = kategoriIkonlar[kat] ?? Icons.category;

                          return GestureDetector(
                            onTap: () {
                              setDialogState(() {
                                secilenAnaKategori = kat;
                                secilenAltKategori = altKategorilerMap[kat]!.first;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: secili ? renk : (isDark ? AppColors.bgDark : AppColors.bgLight),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: secili ? renk : Colors.grey.withOpacity(0.3), width: secili ? 2 : 1),
                              ),
                              child: Row(
                                children: [
                                  Icon(ikon, color: secili ? Colors.white : renk, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      kat,
                                      style: TextStyle(
                                        color: secili ? Colors.white : (isDark ? Colors.white : Colors.black),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text("ALT KALEM", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: altKategoriler.map((ak) {
                          bool seciliAk = secilenAltKategori == ak;
                          return GestureDetector(
                            onTap: () => setDialogState(() => secilenAltKategori = ak),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: seciliAk ? AppColors.kabaInsaat.withOpacity(0.2) : (isDark ? AppColors.bgDark : AppColors.bgLight),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: seciliAk ? AppColors.kabaInsaat : Colors.grey.withOpacity(0.3), width: seciliAk ? 1.5 : 1),
                              ),
                              child: Text(
                                ak,
                                style: TextStyle(
                                  color: seciliAk ? AppColors.kabaInsaat : (isDark ? Colors.white70 : Colors.black87),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      const Text("ÖDEME YÖNTEMİ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Row(
                        children: odemeYontemleri.map((yontem) {
                          bool seciliYontem = odemeYontemi == yontem;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setDialogState(() => odemeYontemi = yontem),
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: seciliYontem ? AppColors.kabaInsaat : (isDark ? AppColors.bgDark : AppColors.bgLight),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: seciliYontem ? AppColors.kabaInsaat : Colors.grey.withOpacity(0.3)),
                                ),
                                child: Center(
                                  child: Text(
                                    yontem,
                                    style: TextStyle(
                                      color: seciliYontem ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: TextEditingController(text: tarih),
                              decoration: InputDecoration(
                                labelText: "Tarih (gg.aa.yyyy)",
                                filled: true,
                                fillColor: isDark ? AppColors.bgDark : AppColors.bgLight,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                              ),
                              onChanged: (v) => tarih = v,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Harcama Notu / Açıklama",
                          filled: true,
                          fillColor: isDark ? AppColors.bgDark : AppColors.bgLight,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                        onChanged: (v) => not = v,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.kabaInsaat,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text("Harcamayı Kaydet", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                          onPressed: () {
                            if (tutar > 0) {
                              HarcamaModel yeniHarcama = HarcamaModel(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                tutar: tutar,
                                anaKategori: secilenAnaKategori,
                                altKategori: secilenAltKategori,
                                miktar: miktar,
                                birim: birim,
                                odemeYontemi: odemeYontemi,
                                tarih: tarih,
                                not: not,
                              );
                              setState(() {
                                widget.proje.harcamalar.insert(0, yeniHarcama);
                              });
                              widget.onUpdate();
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;
    double toplamHarcanan = widget.proje.harcamalar.fold(0, (toplam, h) => toplam + h.tutar);

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.harcama, width: 2),
            ),
            child: Column(
              children: [
                const Text("ŞANTİYE HARCAMALARI TOPLAMI", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text("${_formatTL(toplamHarcanan)} TL", style: TextStyle(color: isDark ? Colors.amberAccent : Colors.amber[800], fontSize: 24, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(child: Text("📋 Şantiye Harcama Akışı", style: TextStyle(color: AppColors.harcama, fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis)),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.harcama, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                  icon: const Icon(Icons.add, color: Colors.white, size: 16),
                  label: const Text("Harcama Ekle", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  onPressed: () => _yeniHarcamaEkleDialog(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: widget.proje.harcamalar.isEmpty
                ? const Center(child: Text("Şantiyede henüz harcama eklenmedi.", style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: widget.proje.harcamalar.length,
                    itemBuilder: (context, index) {
                      final h = widget.proje.harcamalar[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.cardDark : AppColors.cardLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.harcama.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${h.anaKategori} › ${h.altKategori}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 4),
                                  Text("Tarih: ${h.tarih} | Yöntem: ${h.odemeYontemi}", style: const TextStyle(color: Colors.grey, fontSize: 11), overflow: TextOverflow.ellipsis),
                                  if (h.not.isNotEmpty) ...[
                                    const SizedBox(height: 2),
                                    Text("Not: ${h.not}", style: TextStyle(color: isDark ? Colors.white60 : Colors.black54, fontSize: 11, fontStyle: FontStyle.italic), overflow: TextOverflow.ellipsis),
                                  ]
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("${_formatTL(h.tutar)} TL", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: AppColors.harcama)),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                  tooltip: "Harcamayı Sil",
                                  constraints: const BoxConstraints(),
                                  padding: const EdgeInsets.all(4),
                                  onPressed: () => _harcamaSilDialog(h),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _formatTL(double value) {
    return value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}

// 📸 GÜNLÜK FOTOĞRAFLI SAHA TAKİBİ (Tarih Filtreleme, Saat Gösterimi ve Düzenleme Özellikleri Eklendi)
class ProjeGunlukSahaTab extends StatefulWidget {
  final ProjeModel proje;
  final VoidCallback onUpdate;

  const ProjeGunlukSahaTab({super.key, required this.proje, required this.onUpdate});

  @override
  State<ProjeGunlukSahaTab> createState() => _ProjeGunlukSahaTabState();
}

class _ProjeGunlukSahaTabState extends State<ProjeGunlukSahaTab> {
  // Tarih filtresi: Boş bırakıldığında "mevcutta bulunduğumuz gün" baz alınır.
  String? secilenFiltreTarihi;
  final String bugunTarih = "28.04.2026"; // Mevcut aktif simülasyon günü

  void _sahaRaporuEkleDuzenleDialog({GunlukSahaRaporuModel? rapor}) {
    final bool isEditing = rapor != null;
    String imalatAdi = isEditing ? rapor.imalatAdi : "Kaba İnşaat Demir Bağlama";
    String aciklama = isEditing ? rapor.aciklama : "";
    String oran = isEditing ? rapor.tamamlanmaOrani : "%50";
    String tarih = isEditing ? rapor.tarih : bugunTarih;
    String saat = isEditing ? rapor.saat : "14:30";
    String secilenFotograf = isEditing ? rapor.fotografYolu : "saha_ornek_foto.jpg";

    showDialog(
      context: context,
      builder: (context) {
        bool isDark = themeNotifier.isDarkMode;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(isEditing ? "✏️ Saha Raporunu Düzenle" : "📸 Günlük Fotoğraflı Saha Raporu"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: TextEditingController(text: imalatAdi),
                      decoration: const InputDecoration(labelText: "İmalat Başlığı (Örn: 3. Kat Kolon Kalıbı)"),
                      onChanged: (v) => imalatAdi = v,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(labelText: "Tarih (gg.aa.yyyy)"),
                            controller: TextEditingController(text: tarih),
                            onChanged: (v) => tarih = v,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(labelText: "Eklenme Saati (ss:mm)"),
                            controller: TextEditingController(text: saat),
                            onChanged: (v) => saat = v,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(labelText: "Tamamlanma Oranı (Örn: %80)"),
                      controller: TextEditingController(text: oran),
                      onChanged: (v) => oran = v,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      maxLines: 2,
                      controller: TextEditingController(text: aciklama),
                      decoration: const InputDecoration(labelText: "Mesai / Açıklama Notu"),
                      onChanged: (v) => aciklama = v,
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.gunlukSaha.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.gunlukSaha),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.camera_alt, color: AppColors.gunlukSaha),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "📷 Fotoğraf: $secilenFotograf",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          TextButton(
                            child: const Text("Değiştir"),
                            onPressed: () {
                              setDialogState(() {
                                secilenFotograf = "saha_guncel_${DateTime.now().second}.jpg";
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(child: const Text("İptal"), onPressed: () => Navigator.pop(context)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.gunlukSaha),
                  child: Text(isEditing ? "Güncellemeyi Kaydet" : "Raporu Kaydet", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    if (imalatAdi.trim().isNotEmpty) {
                      setState(() {
                        if (isEditing) {
                          rapor.imalatAdi = imalatAdi;
                          rapor.tarih = tarih;
                          rapor.saat = saat;
                          rapor.tamamlanmaOrani = oran;
                          rapor.aciklama = aciklama;
                          rapor.fotografYolu = secilenFotograf;
                        } else {
                          widget.proje.gunlukSahaRaporlari.insert(
                            0,
                            GunlukSahaRaporuModel(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              tarih: tarih,
                              saat: saat,
                              imalatAdi: imalatAdi,
                              aciklama: aciklama.isEmpty ? 'Bugünkü mesai dahilinde planlanan imalat ilerlemesi kaydedildi.' : aciklama,
                              tamamlanmaOrani: oran,
                              fotografYolu: secilenFotograf,
                            ),
                          );
                        }
                      });
                      widget.onUpdate();
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _sahaRaporuSil(GunlukSahaRaporuModel rapor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Saha Raporunu Sil"),
        content: const Text("Bu saha ilerleme raporunu silmek istediğinize emin misiniz?"),
        actions: [
          TextButton(child: const Text("İptal"), onPressed: () => Navigator.pop(context)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Sil", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () {
              setState(() {
                widget.proje.gunlukSahaRaporlari.remove(rapor);
              });
              widget.onUpdate();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;

    // Tarih seçilmemişse mevcutta bulunduğumuz güne (bugunTarih) ait veriler gösterilir.
    // Tarih seçilmişse seçilen tarihteki imalatlar listelenir.
    String aktifFiltre = secilenFiltreTarihi ?? bugunTarih;
    List<GunlukSahaRaporuModel> filtrelenmisRaporlar = widget.proje.gunlukSahaRaporlari
        .where((r) => r.tarih == aktifFiltre)
        .toList();

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark ? [const Color(0xFF0E7490), const Color(0xFF164E63)] : [const Color(0xFFCFFAFE), const Color(0xFF99F6E4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.gunlukSaha, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(backgroundColor: AppColors.gunlukSaha, radius: 24, child: Icon(Icons.camera_enhance, color: Colors.white)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Şantiye Şefi & Müteahhit Saha İlerleme Takibi", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: AppColors.gunlukSaha)),
                          const SizedBox(height: 2),
                          Text(secilenFiltreTarihi == null ? "📅 Varsayılan: Bugünün Verileri ($bugunTarih)" : "📅 Seçilen Tarih: $secilenFiltreTarihi", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : Colors.black87)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.gunlukSaha),
                        icon: const Icon(Icons.calendar_month, color: Colors.white, size: 16),
                        label: Text(secilenFiltreTarihi == null ? "Tarih Seç ($bugunTarih)" : "Seçili: $secilenFiltreTarihi", style: const TextStyle(color: Colors.white, fontSize: 11)),
                        onPressed: () {
                          // Hızlı tarih filtreleme diyaloğu
                          String tempTarih = aktifFiltre;
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Tarih Seçin"),
                              content: TextField(
                                controller: TextEditingController(text: tempTarih),
                                decoration: const InputDecoration(labelText: "Tarih (gg.aa.yyyy)"),
                                onChanged: (v) => tempTarih = v,
                              ),
                              actions: [
                                TextButton(child: const Text("Bugüne Dön"), onPressed: () {
                                  setState(() => secilenFiltreTarihi = null);
                                  Navigator.pop(context);
                                }),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.gunlukSaha),
                                  child: const Text("Filtrele", style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    setState(() => secilenFiltreTarihi = tempTarih);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    if (secilenFiltreTarihi != null) ...[
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text("Bugüne Dön", style: TextStyle(color: Colors.redAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                        onPressed: () => setState(() => secilenFiltreTarihi = null),
                      ),
                    ]
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("📋 Saha Raporları ($aktifFiltre)", style: const TextStyle(color: AppColors.gunlukSaha, fontWeight: FontWeight.bold, fontSize: 14)),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.gunlukSaha, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                  icon: const Icon(Icons.add_a_photo, color: Colors.white, size: 16),
                  label: const Text("Rapor Ekle", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  onPressed: () => _sahaRaporuEkleDuzenleDialog(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: filtrelenmisRaporlar.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.event_busy, size: 48, color: Colors.grey),
                        const SizedBox(height: 8),
                        Text("$aktifFiltre tarihinde kayıtlı saha imalatı bulunmuyor.", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filtrelenmisRaporlar.length,
                    itemBuilder: (context, index) {
                      final rapor = filtrelenmisRaporlar[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.cardDark : AppColors.cardLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.gunlukSaha.withOpacity(0.4), width: 1.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text(rapor.imalatAdi, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14), overflow: TextOverflow.ellipsis)),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(color: AppColors.gunlukSaha.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                                      child: Text(rapor.tamamlanmaOrani, style: const TextStyle(color: AppColors.gunlukSaha, fontWeight: FontWeight.w900, fontSize: 11)),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: AppColors.inceIsler, size: 18),
                                      tooltip: "Raporu Düzenle",
                                      onPressed: () => _sahaRaporuEkleDuzenleDialog(rapor: rapor),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 18),
                                      tooltip: "Raporu Sil",
                                      onPressed: () => _sahaRaporuSil(rapor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.access_time, size: 13, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text("Eklenme Tarihi: ${rapor.tarih} | Saat: ${rapor.saat}", style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(rapor.aciklama, style: TextStyle(fontSize: 12, color: isDark ? Colors.white70 : Colors.black87)),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.bgDark : AppColors.bgLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.image, color: AppColors.gunlukSaha, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text("Yüklenen Fotoğraf: ${rapor.fotografYolu}", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
                                  const Icon(Icons.check_circle, color: Colors.green, size: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// 👥 TAŞÖREN & FATURA GÖRSELİ SEKMESİ
class ProjeTaseronTab extends StatefulWidget {
  final ProjeModel proje;
  final VoidCallback onUpdate;

  const ProjeTaseronTab({super.key, required this.proje, required this.onUpdate});

  @override
  State<ProjeTaseronTab> createState() => _ProjeTaseronTabState();
}

class _ProjeTaseronTabState extends State<ProjeTaseronTab> {
  void _openSubcontractorDialog({SubcontractorModel? subcontractor}) {
    final bool isEditing = subcontractor != null;

    final nameCtrl = TextEditingController(text: isEditing ? subcontractor.name : '');
    final workCtrl = TextEditingController(text: isEditing ? subcontractor.workType : '');
    final totalCtrl = TextEditingController(text: isEditing ? subcontractor.totalAgreement.toStringAsFixed(0) : '');
    final paidCtrl = TextEditingController(text: isEditing ? subcontractor.paidAmount.toStringAsFixed(0) : '');
    List<String> guncelFaturalar = isEditing ? List.from(subcontractor.faturaGorselleri) : [];

    showDialog(
      context: context,
      builder: (context) {
        bool isDark = themeNotifier.isDarkMode;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              backgroundColor: isDark ? AppColors.cardDark : Colors.white,
              child: Container(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.tesisat.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              isEditing ? Icons.edit : Icons.person_add,
                              color: AppColors.tesisat,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              isEditing ? 'Taşören & Fatura Düzenle' : 'Yeni Taşören & Fatura Ekle',
                              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                            ),
                          ),
                          IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildFancyTextField(controller: nameCtrl, label: 'Firma / Usta Adı', icon: Icons.business, isDark: isDark),
                      const SizedBox(height: 14),
                      _buildFancyTextField(controller: workCtrl, label: 'Yapılacak İş Kalemi (Örn: Demir İşçiliği)', icon: Icons.work, isDark: isDark),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(child: _buildFancyTextField(controller: totalCtrl, label: 'Anlaşma (₺)', icon: Icons.payments, isDark: isDark, isNumber: true)),
                          const SizedBox(width: 10),
                          Expanded(child: _buildFancyTextField(controller: paidCtrl, label: 'Ödenen (₺)', icon: Icons.check_circle_outline, isDark: isDark, isNumber: true)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.bgDark : AppColors.bgLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.tesisat.withOpacity(0.4)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("📑 Taşören Fatura Görselleri", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                TextButton.icon(
                                  icon: const Icon(Icons.camera_alt, size: 16, color: AppColors.tesisat),
                                  label: const Text("Fatura Fotoğrafı Ekle", style: TextStyle(fontSize: 11)),
                                  onPressed: () {
                                    setDialogState(() {
                                      guncelFaturalar.add("taseron_fatura_${DateTime.now().millisecondsSinceEpoch}.jpg");
                                    });
                                  },
                                ),
                              ],
                            ),
                            if (guncelFaturalar.isEmpty)
                              const Text("Henüz fatura görseli yüklenmedi.", style: TextStyle(color: Colors.grey, fontSize: 11))
                            else
                              ...guncelFaturalar.map((fatura) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.receipt_long, size: 14, color: Colors.green),
                                        const SizedBox(width: 6),
                                        Expanded(child: Text(fatura, style: const TextStyle(fontSize: 11), overflow: TextOverflow.ellipsis)),
                                        IconButton(
                                          icon: const Icon(Icons.delete, size: 14, color: Colors.red),
                                          constraints: const BoxConstraints(),
                                          onPressed: () {
                                            setDialogState(() {
                                              guncelFaturalar.remove(fatura);
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.tesisat,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 4,
                          ),
                          onPressed: () {
                            if (nameCtrl.text.trim().isEmpty) return;

                            double total = double.tryParse(totalCtrl.text) ?? 0;
                            double paid = double.tryParse(paidCtrl.text) ?? 0;

                            setState(() {
                              if (isEditing) {
                                subcontractor.name = nameCtrl.text.trim();
                                subcontractor.workType = workCtrl.text.trim();
                                subcontractor.totalAgreement = total;
                                subcontractor.paidAmount = paid;
                                subcontractor.faturaGorselleri = guncelFaturalar;
                              } else {
                                widget.proje.taseronlar.add(
                                  SubcontractorModel(
                                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                                    name: nameCtrl.text.trim(),
                                    workType: workCtrl.text.trim(),
                                    totalAgreement: total,
                                    paidAmount: paid,
                                    faturaGorselleri: guncelFaturalar,
                                  ),
                                );
                              }
                            });
                            widget.onUpdate();
                            Navigator.pop(context);
                          },
                          child: Text(
                            isEditing ? 'GÜNCELLE VE KAYDET' : 'TAŞÖRENİ KAYDET',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFancyTextField({required TextEditingController controller, required String label, required IconData icon, required bool isDark, bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.tesisat, size: 20),
        filled: true,
        fillColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.tesisat, width: 2)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      ),
    );
  }

  void _taseronSil(SubcontractorModel sub) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Taşören Sil"),
        content: Text("'${sub.name}' taşören kaydını silmek istediğinize emin misiniz?"),
        actions: [
          TextButton(child: const Text("İptal"), onPressed: () => Navigator.pop(context)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Sil", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () {
              setState(() {
                widget.proje.taseronlar.remove(sub);
              });
              widget.onUpdate();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;

    double toplamAnlasma = widget.proje.taseronlar.fold(0, (sum, t) => sum + t.totalAgreement);
    double toplamOdenen = widget.proje.taseronlar.fold(0, (sum, t) => sum + t.paidAmount);
    double toplamKalan = toplamAnlasma - toplamOdenen;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF111827), const Color(0xFF080C14)]
                    : [const Color(0xFFEFF6FF), const Color(0xFFDBEAFE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.tesisat, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.tesisat.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.engineering, color: AppColors.tesisat, size: 20),
                    SizedBox(width: 8),
                    Text("TAŞÖREN MALİ & FATURA GÖRSELİ YÖNETİMİ", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 0.5)),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(child: _buildSummaryItem("TOPLAM ANLAŞMA", toplamAnlasma, AppColors.tesisat)),
                    Container(height: 30, width: 1, color: Colors.grey.withOpacity(0.3)),
                    Expanded(child: _buildSummaryItem("ÖDENEN MİKTAR", toplamOdenen, Colors.green)),
                    Container(height: 30, width: 1, color: Colors.grey.withOpacity(0.3)),
                    Expanded(child: _buildSummaryItem("KALAN BAKİYE", toplamKalan, Colors.redAccent)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(child: Text("👥 Kayıtlı Taşören & Fatura Listesi", style: TextStyle(color: AppColors.tesisat, fontWeight: FontWeight.bold, fontSize: 14), overflow: TextOverflow.ellipsis)),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tesisat,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: 16),
                  label: const Text("Taşören Ekle", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  onPressed: () => _openSubcontractorDialog(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: widget.proje.taseronlar.isEmpty
                ? const Center(child: Text("Şantiyeye ait henüz taşören eklenmedi.", style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: widget.proje.taseronlar.length,
                    itemBuilder: (context, index) {
                      final sub = widget.proje.taseronlar[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.cardDark : AppColors.cardLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.tesisat.withOpacity(0.3)),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 3)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const CircleAvatar(backgroundColor: AppColors.tesisat, radius: 16, child: Icon(Icons.person, color: Colors.white, size: 18)),
                                      const SizedBox(width: 10),
                                      Expanded(child: Text(sub.name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15), overflow: TextOverflow.ellipsis)),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: AppColors.inceIsler, size: 20),
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.all(4),
                                      onPressed: () => _openSubcontractorDialog(subcontractor: sub),
                                    ),
                                    const SizedBox(width: 4),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.all(4),
                                      onPressed: () => _taseronSil(sub),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: AppColors.tesisat.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                              child: Text("İş Kalemi: ${sub.workType}", style: const TextStyle(color: AppColors.tesisat, fontWeight: FontWeight.bold, fontSize: 12), overflow: TextOverflow.ellipsis),
                            ),
                            const SizedBox(height: 8),
                            if (sub.faturaGorselleri.isNotEmpty)
                              Row(
                                children: [
                                  const Icon(Icons.receipt_long, size: 16, color: Colors.green),
                                  const SizedBox(width: 4),
                                  Text("Yüklü Fatura Görselleri: ${sub.faturaGorselleri.length} Adet", style: const TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            const Divider(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Anlaşma / Ödenen", style: TextStyle(color: Colors.grey, fontSize: 10)),
                                      const SizedBox(height: 2),
                                      Text("${_formatTL(sub.totalAgreement)} TL / ${_formatTL(sub.paidAmount)} TL", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11), overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text("Kalan Bakiye", style: TextStyle(color: Colors.grey, fontSize: 10)),
                                    const SizedBox(height: 2),
                                    Text("${_formatTL(sub.remaining)} TL", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: sub.remaining > 0 ? Colors.redAccent : Colors.green)),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, double amount, Color color) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        Text("${_formatTL(amount)} ₺", style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 12), overflow: TextOverflow.ellipsis),
      ],
    );
  }

  String _formatTL(double value) {
    return value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}

// 💳 CARİ BORÇ / ALACAK YÖNETİMİ SEKMESİ
class BorcAlacakSekmesi extends StatefulWidget {
  final ProjeModel proje;
  final VoidCallback onUpdate;

  const BorcAlacakSekmesi({super.key, required this.proje, required this.onUpdate});

  @override
  State<BorcAlacakSekmesi> createState() => _BorcAlacakSekmesiState();
}

class _BorcAlacakSekmesiState extends State<BorcAlacakSekmesi> {
  final List<String> hazirAlacakTurleri = [
    '🏢 Daire Ön Avans Ödemesi',
    '📑 Daire Ara Ödemesi',
    '🔑 Teslimat / Kapanış Ödemesi',
    '🛒 Ticari Dükkan Satış Avansı',
    '✍️ Özel Cari Alacak',
  ];

  void _finansKalemiEkleDuzenleDialog({FinansKalemiModel? kalem, required bool isAlacak}) {
    final bool isEditing = kalem != null;
    String secilenTur = isEditing ? (hazirAlacakTurleri.contains(kalem.baslik.split(' (').first) ? kalem.baslik.split(' (').first : hazirAlacakTurleri.first) : hazirAlacakTurleri.first;
    String ozelBaslik = isEditing ? kalem.baslik : "";
    double tutar = isEditing ? kalem.tutar : 0;
    String tarih = isEditing ? kalem.tarih : "28.04.2026";
    String aciklama = isEditing ? kalem.aciklama : "";
    bool mevcutAlacakDurumu = isEditing ? kalem.isAlacak : isAlacak;

    showDialog(
      context: context,
      builder: (context) {
        bool isDark = themeNotifier.isDarkMode;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
              child: Container(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: (mevcutAlacakDurumu ? Colors.green : Colors.red).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              isEditing ? Icons.edit : (mevcutAlacakDurumu ? Icons.arrow_downward : Icons.arrow_upward),
                              color: mevcutAlacakDurumu ? Colors.green : Colors.red,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              isEditing ? (mevcutAlacakDurumu ? "Alacak Kaydını Düzenle" : "Borç Kaydını Düzenle") : (mevcutAlacakDurumu ? "🟢 Yeni Alacak Ekle" : "🔴 Yeni Borç Ekle"),
                              style: TextStyle(color: mevcutAlacakDurumu ? Colors.green : Colors.red, fontWeight: FontWeight.w900, fontSize: 16),
                            ),
                          ),
                          IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (mevcutAlacakDurumu) ...[
                        const Text("Alacak Türü:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.bgDark : AppColors.bgLight,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green.withOpacity(0.3)),
                          ),
                          child: DropdownButton<String>(
                            value: hazirAlacakTurleri.contains(secilenTur) ? secilenTur : hazirAlacakTurleri.first,
                            isExpanded: true,
                            underline: const SizedBox(),
                            dropdownColor: isDark ? AppColors.cardDark : AppColors.cardLight,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
                            items: hazirAlacakTurleri.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                            onChanged: (v) {
                              if (v != null) setDialogState(() => secilenTur = v);
                            },
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                      TextField(
                        controller: TextEditingController(text: ozelBaslik),
                        decoration: InputDecoration(
                          labelText: mevcutAlacakDurumu ? "Daire No / Müşteri Adı" : "Borçlu Olunan Cari / Firma",
                          filled: true,
                          fillColor: isDark ? AppColors.bgDark : AppColors.bgLight,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                        onChanged: (v) => ozelBaslik = v,
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: TextEditingController(text: tutar > 0 ? tutar.toStringAsFixed(0) : ''),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        decoration: InputDecoration(
                          labelText: "Tutar (TL)",
                          filled: true,
                          fillColor: isDark ? AppColors.bgDark : AppColors.bgLight,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                        onChanged: (v) => tutar = double.tryParse(v) ?? 0,
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: TextEditingController(text: tarih),
                        decoration: InputDecoration(
                          labelText: "Tarih (gg.aa.yyyy)",
                          filled: true,
                          fillColor: isDark ? AppColors.bgDark : AppColors.bgLight,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                        onChanged: (v) => tarih = v,
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: TextEditingController(text: aciklama),
                        decoration: InputDecoration(
                          labelText: "Açıklama / Not",
                          filled: true,
                          fillColor: isDark ? AppColors.bgDark : AppColors.bgLight,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                        onChanged: (v) => aciklama = v,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mevcutAlacakDurumu ? Colors.green : Colors.red,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 4,
                          ),
                          child: Text(
                            isEditing ? "DEĞİŞİKLİKLERİ KAYDET" : "KAYDI OLUŞTUR",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          onPressed: () {
                            String nihaiBaslik = mevcutAlacakDurumu ? "$secilenTur (${ozelBaslik.trim().isEmpty ? 'Özel' : ozelBaslik.trim()})" : ozelBaslik.trim();

                            if (nihaiBaslik.isNotEmpty && tutar > 0) {
                              setState(() {
                                if (isEditing) {
                                  kalem.baslik = nihaiBaslik;
                                  kalem.tutar = tutar;
                                  kalem.tarih = tarih;
                                  kalem.aciklama = aciklama;
                                } else {
                                  widget.proje.finansKalemleri.insert(
                                    0,
                                    FinansKalemiModel(
                                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                                      baslik: nihaiBaslik,
                                      tutar: tutar,
                                      isAlacak: mevcutAlacakDurumu,
                                      tarih: tarih,
                                      aciklama: aciklama,
                                    ),
                                  );
                                }
                              });
                              widget.onUpdate();
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _finansKalemiSil(FinansKalemiModel kalem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Kayıt Sil"),
        content: const Text("Bu finansal kalemi silmek istediğinize emin misiniz?"),
        actions: [
          TextButton(child: const Text("İptal"), onPressed: () => Navigator.pop(context)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Sil", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () {
              setState(() {
                widget.proje.finansKalemleri.remove(kalem);
              });
              widget.onUpdate();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;

    double toplamAlacak = widget.proje.finansKalemleri.where((f) => f.isAlacak).fold(0, (sum, item) => sum + item.tutar);
    double toplamBorc = widget.proje.finansKalemleri.where((f) => !f.isAlacak).fold(0, (sum, item) => sum + item.tutar);
    double netBakiye = toplamAlacak - toplamBorc;

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF111827), const Color(0xFF080C14)]
                    : [const Color(0xFFF0FDF4), const Color(0xFFFEF2F2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.ruhsat.withOpacity(0.5), width: 1.5),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.account_balance_wallet, color: AppColors.ruhsat, size: 20),
                    SizedBox(width: 8),
                    Text("ŞANTİYE CARİ BORÇ & ALACAK DURUMU", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 0.5)),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(child: _buildSummaryItem("TOPLAM ALACAK", toplamAlacak, Colors.green)),
                    Container(height: 30, width: 1, color: Colors.grey.withOpacity(0.3)),
                    Expanded(child: _buildSummaryItem("TOPLAM BORÇ", toplamBorc, Colors.red)),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: Text("NET CARİ DURUM:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), overflow: TextOverflow.ellipsis)),
                    Text(
                      "${_formatTL(netBakiye)} TL",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: netBakiye >= 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.arrow_downward, color: Colors.white, size: 16),
                    label: const Text("Alacak Ekle", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: () => _finansKalemiEkleDuzenleDialog(isAlacak: true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.arrow_upward, color: Colors.white, size: 16),
                    label: const Text("Borç Ekle", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: () => _finansKalemiEkleDuzenleDialog(isAlacak: false),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: widget.proje.finansKalemleri.isEmpty
                ? const Center(child: Text("Şantiyede henüz borç veya alacak kaydı bulunmuyor.", style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: widget.proje.finansKalemleri.length,
                    itemBuilder: (context, index) {
                      final item = widget.proje.finansKalemleri[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.cardDark : AppColors.cardLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: item.isAlacak ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3)),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 3))],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: item.isAlacak ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                              child: Icon(item.isAlacak ? Icons.arrow_downward : Icons.arrow_upward, color: item.isAlacak ? Colors.green : Colors.red, size: 18),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.baslik, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 2),
                                  Text("Tarih: ${item.tarih} ${item.aciklama.isNotEmpty ? '| ' + item.aciklama : ''}", style: const TextStyle(color: Colors.grey, fontSize: 11), overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("${_formatTL(item.tutar)} TL", style: TextStyle(color: item.isAlacak ? Colors.green : Colors.red, fontWeight: FontWeight.w900, fontSize: 13)),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 18),
                                      tooltip: "Sil",
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.all(4),
                                      onPressed: () => _finansKalemiSil(item),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, double amount, Color color) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        Text("${_formatTL(amount)} ₺", style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 13), overflow: TextOverflow.ellipsis),
      ],
    );
  }

  String _formatTL(double value) {
    return value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}

// 6. EMSAL VE İNŞAAT ALANI HESAPLAMA (TAKS/KAKS) SAYFASI
class EmsalHesaplamaSayfasi extends StatefulWidget {
  const EmsalHesaplamaSayfasi({super.key});

  @override
  State<EmsalHesaplamaSayfasi> createState() => _EmsalHesaplamaSayfasiState();
}

class _EmsalHesaplamaSayfasiState extends State<EmsalHesaplamaSayfasi> {
  double arsaAlani = 1000.0;
  double taksOrani = 0.35;
  double kaksOrani = 1.50;

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;

    double tabanOturumM2 = arsaAlani * taksOrani;
    double emsaleDahilInsaatM2 = arsaAlani * kaksOrani;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emsal ve İnşaat Alanı (TAKS/KAKS)'),
        backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
        actions: buildGlobalActions(context, () => setState(() {})),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.imarEmsal, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("📐 İmar ve Emsal Parametre Girişi", style: TextStyle(color: AppColors.imarEmsal, fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: arsaAlani.toString(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Arsa Alanı (m²)",
                    filled: true,
                    fillColor: isDark ? AppColors.bgDark : AppColors.bgLight,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                  onChanged: (v) {
                    double? d = double.tryParse(v);
                    if (d != null) setState(() => arsaAlani = d);
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: taksOrani.toString(),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "TAKS Oranı (Örn: 0.35)",
                          filled: true,
                          fillColor: isDark ? AppColors.bgDark : AppColors.bgLight,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                        onChanged: (v) {
                          double? d = double.tryParse(v);
                          if (d != null) setState(() => taksOrani = d);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        initialValue: kaksOrani.toString(),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "KAKS / Emsal Oranı (Örn: 1.50)",
                          filled: true,
                          fillColor: isDark ? AppColors.bgDark : AppColors.bgLight,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                        onChanged: (v) {
                          double? d = double.tryParse(v);
                          if (d != null) setState(() => kaksOrani = d);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.cardLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.butce, width: 2),
            ),
            child: Column(
              children: [
                const Text("📊 HESAPLANAN İMAR METRİKLERİ", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _sonucSatir("Maksimum Taban Oturumu (TAKS):", "${_formatTL(tabanOturumM2)} m²", AppColors.imarEmsal),
                const Divider(height: 20),
                _sonucSatir("Emsale Dahil Toplam İnşaat Alanı (KAKS):", "${_formatTL(emsaleDahilInsaatM2)} m²", AppColors.butce),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _sonucSatir(String baslik, String deger, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(baslik, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12), overflow: TextOverflow.ellipsis)),
        Text(deger, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 15)),
      ],
    );
  }

  String _formatTL(double value) {
    return value.toStringAsFixed(1).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}

// 7. GENİŞLETİLMİŞ METRAJ & MALZEME HESAPLAYICI
class MaterialCalculatorScreen extends StatefulWidget {
  const MaterialCalculatorScreen({super.key});

  @override
  State<MaterialCalculatorScreen> createState() => _MaterialCalculatorScreenState();
}

class _MaterialCalculatorScreenState extends State<MaterialCalculatorScreen> {
  String _selectedCategory = 'Tuğla Duvar';
  final TextEditingController _areaController = TextEditingController();
  
  String _selectedBrickType = '8.5\'luk Tuğla (Yatay delikli)';
  final Map<String, double> _brickRates = {
    '8.5\'luk Tuğla (Yatay delikli)': 30.0,
    '10\'luk Tuğla (Yatay delikli)': 25.0,
    '13.5\'luk Tuğla (Yatay delikli)': 20.0,
    '19\'luk Tuğla (Düşey delikli)': 50.0,
  };

  String _selectedGazbetonType = '10 cm Gazbeton Blok';
  final Map<String, double> _gazbetonRates = {
    '7.5 cm Gazbeton Blok': 6.8,
    '10 cm Gazbeton Blok': 6.8,
    '13.5 cm Gazbeton Blok': 6.8,
    '15 cm Gazbeton Blok': 6.8,
    '20 cm Gazbeton Blok': 6.8,
  };

  String _resultText = '';

  void _calculate() {
    double area = double.tryParse(_areaController.text) ?? 0.0;
    if (area <= 0) {
      setState(() => _resultText = 'Lütfen geçerli bir m² veya m³ değeri girin!');
      return;
    }

    if (_selectedCategory == 'Tuğla Duvar') {
      double rate = _brickRates[_selectedBrickType] ?? 30.0;
      double totalBricks = area * rate;
      double withWaste = totalBricks * 1.05;
      setState(() {
        _resultText = 'Proje Alanı: $area m²\nSeçilen: $_selectedBrickType\n\n'
            'Net Tuğla: ${totalBricks.toStringAsFixed(0)} Adet\n'
            'Fire Dahil (%5): ${withWaste.toStringAsFixed(0)} Adet';
      });
    } else if (_selectedCategory == 'Gazbeton Duvar') {
      double blocks = area * 6.8;
      double adhesiveKg = area * 2.5;
      double withWaste = blocks * 1.05;
      setState(() {
        _resultText = 'Proje Alanı: $area m² ($_selectedGazbetonType)\n\n'
            'Net Gazbeton Blok: ${blocks.toStringAsFixed(0)} Adet\n'
            'Fire Dahil (%5): ${withWaste.toStringAsFixed(0)} Adet\n'
            'Gazbeton Tutkalı (İnce Harç): ${adhesiveKg.toStringAsFixed(1)} kg (${(adhesiveKg / 25).ceil()} Torba / 25kg)';
      });
    } else if (_selectedCategory == 'Sıva İşi') {
      double cementPerM2 = 12.0;
      double sandPerM2 = 0.035;
      setState(() {
        _resultText = 'Proje Alanı: $area m² (Kaba + İnce Sıva)\n\n'
            'Yaklaşık Çimento: ${(area * cementPerM2).toStringAsFixed(1)} kg (${((area * cementPerM2) / 50).ceil()} Torba / 50kg)\n'
            'Yaklaşık Kum: ${(area * sandPerM2).toStringAsFixed(2)} m³';
      });
    } else if (_selectedCategory == 'Seramik Kaplama') {
      double withWaste = area * 1.10;
      setState(() {
        _resultText = 'Uygulama Alanı: $area m²\n\n'
            'Net Seramik İhtiyacı: $area m²\n'
            'Fire Dahil (%10 Kesim Payı): ${withWaste.toStringAsFixed(1)} m²';
      });
    } else if (_selectedCategory == 'Seramik Yapıştırıcı & Derz') {
      double adhesivePerM2 = 5.0;
      double groutPerM2 = 0.5;
      double totalAdhesive = area * adhesivePerM2;
      double totalGrout = area * groutPerM2;
      setState(() {
        _resultText = 'Uygulama Alanı: $area m²\n\n'
            'Seramik Yapıştırıcı (Toz Harç): ${totalAdhesive.toStringAsFixed(1)} kg (${(totalAdhesive / 25).ceil()} Torba / 25kg)\n'
            'Derz Dolgu Malzemesi: ${totalGrout.toStringAsFixed(1)} kg (${(totalGrout / 20).ceil()} Paket / 20kg)';
      });
    } else if (_selectedCategory == 'Beton & Demir (Kaba)') {
      setState(() {
        _resultText = 'Hacim: $area m³ (Betonarme)\n\n'
            'Hazır Beton: $area m³\n'
            'İnşaat Demiri (Ort. 90kg/m³): ${(area * 90).toStringAsFixed(1)} kg';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = themeNotifier.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genişletilmiş Metraj & Malzeme Hesaplayıcı'),
        backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Hesaplanacak Kalem', border: OutlineInputBorder()),
              items: [
                'Tuğla Duvar',
                'Gazbeton Duvar',
                'Sıva İşi',
                'Seramik Kaplama',
                'Seramik Yapıştırıcı & Derz',
                'Beton & Demir (Kaba)'
              ].map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
              onChanged: (val) => setState(() { _selectedCategory = val!; _resultText = ''; }),
            ),
            const SizedBox(height: 16),
            if (_selectedCategory == 'Tuğla Duvar') ...[
              DropdownButtonFormField<String>(
                value: _selectedBrickType,
                decoration: const InputDecoration(labelText: 'Tuğla Tipi ve Ölçüsü', border: OutlineInputBorder()),
                items: _brickRates.keys.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                onChanged: (val) => setState(() => _selectedBrickType = val!),
              ),
              const SizedBox(height: 16),
            ],
            TextField(
              controller: _areaController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: _selectedCategory == 'Beton & Demir (Kaba)' ? 'Toplam Hacim (m³)' : 'Toplam Alan (m²)',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.harcama, foregroundColor: Colors.white, padding: const EdgeInsets.all(14)),
              onPressed: _calculate,
              icon: const Icon(Icons.calculate),
              label: const Text('HESAPLA', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            if (_resultText.isNotEmpty)
              Card(
                color: isDark ? AppColors.cardDark : Colors.amber[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(_resultText, style: const TextStyle(fontSize: 16, height: 1.5)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}