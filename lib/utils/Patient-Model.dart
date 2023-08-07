class PatientData {
  String name;
  int age;
  String gender;
  double weight;
  double height;
  String hasBreathShortness;
  String hasExpectoration;
  String hasDiabetes;
  String smoker;
  String smokerType;
  String alcoholConsumer;
  int mMRCgrade;
  double fev1PreBD;
  double fev1FVCPostBD;
  int? goldGrade;

  PatientData({
    required this.name,
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.hasBreathShortness,
    required this.hasExpectoration,
    required this.hasDiabetes,
    required this.smoker,
    required this.smokerType,
    required this.alcoholConsumer,
    required this.mMRCgrade,
    required this.fev1PreBD,
    required this.fev1FVCPostBD,
    this.goldGrade = null,
  });

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'AGE': age,
      'GENDER': gender,
      'WEIGHT IN KGS': weight,
      'HEIGHT IN CM': height,
      'SHORTNESS OF BREATH': hasBreathShortness,
      'EXPECTORATION': hasExpectoration,
      'DIABETES': hasDiabetes,
      'TYPE OF SMOKER': smoker,
      'CIGARETTE/BIDI/GANJA': smokerType,
      'ALCOHOL USE': alcoholConsumer,
      'mMRC GRADE': mMRCgrade,
      '(FEV1 PRE BD) %PRED': fev1PreBD,
      '(FEV1/FVC POST BD ) L/SEC': fev1FVCPostBD,
      'Gold Grade': goldGrade,
    };
  }

  factory PatientData.fromJson(Map<String, dynamic> json) {
    return PatientData(
      name: json['Name'],
      age: json['AGE'],
      gender: json['GENDER'],
      weight: json['WEIGHT IN KGS'],
      height: json['HEIGHT IN CM'],
      hasBreathShortness: json['SHORTNESS OF BREATH'],
      hasExpectoration: json['EXPECTORATION'],
      hasDiabetes: json['DIABETES'],
      smoker: json['TYPE OF SMOKER'],
      smokerType: json['CIGARETTE/BIDI/GANJA'],
      alcoholConsumer: json['ALCOHOL USE'],
      mMRCgrade: json['mMRC GRADE'],
      fev1PreBD: json['(FEV1 PRE BD) %PRED'],
      fev1FVCPostBD: json['(FEV1/FVC POST BD ) L/SEC'],
      goldGrade: json['Gold Grade'],
    );
  }
}
