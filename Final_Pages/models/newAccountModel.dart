class NewAccountFields {
  //create final static variables for each column name
  static final List<String> values = [
    id,
    firstName,
    lastName,
    email,
    reEnterPassword,
    mobileNo,
    address,
    alarmTime,
    estTime,
    readyTimeFinal,
    freqDate,
    startDate,
    endDate,
    orgAddress,
    destAddress,
    commTime,
    calcAlarmTime,
    field1,
    field2,
  ];

  //create final static variables for each column name
  static final String id = '_id';
  static final String firstName = 'firstName';
  static final String lastName = 'lastName';
  static final String email = 'email';

  static final String reEnterPassword = 'reEnterPassword';
  static final String mobileNo = 'mobileNo';
  static final String address = 'address';
  static final String alarmTime = 'alarmTime';
  static final String estTime = 'estTime';
  static final String readyTimeFinal = 'readyTimeFinal';
  static final String freqDate = 'freqDate';
  static final String startDate = 'startDate';
  static final String endDate = 'endDate';
  static final String orgAddress = 'orgAddress';
  static final String destAddress = 'destAddress';
  static late final String commTime = 'commTime';
  static final String calcAlarmTime = 'calcAlarmTime';
  static final String field1 = 'field1';
  static final String field2 = 'field2';
}

//create a class for each column
class NewAccount {
  final int? id;
  late final String firstName;
  final String lastName;
  final String email;
  final String reEnterPassword;
  final String mobileNo;
  final String address;
  late final String alarmTime;
  late final String estTime;
  late final String readyTimeFinal;
  late final String freqDate;
  late final String startDate;
  late final String endDate;
  late final String orgAddress;
  late final String destAddress;
  late String commTime;
  late String calcAlarmTime;
  late String field1;
  late String field2;

  NewAccount({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.reEnterPassword,
    required this.mobileNo,
    required this.address,
    required this.alarmTime,
    required this.estTime,
    required this.readyTimeFinal,
    required this.freqDate,
    required this.startDate,
    required this.endDate,
    required this.orgAddress,
    required this.destAddress,
    required this.commTime,
    required this.calcAlarmTime,
    required this.field1,
    required this.field2,
  });

  NewAccount copy({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? reEnterPassword,
    String? mobileNo,
    String? address,
    String? alarmTime,
    String? estTime,
    String? readyTimeFinal,
    String? freqDate,
    String? startDate,
    String? endDate,
    String? orgAddress,
    String? destAddress,
    String? commTime,
    String? calcAlarmTime,
    String? field1,
    String? field2,
  }) =>
      NewAccount(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        reEnterPassword: reEnterPassword ?? this.reEnterPassword,
        mobileNo: mobileNo ?? this.mobileNo,
        address: address ?? this.address,
        alarmTime: alarmTime ?? this.alarmTime,
        estTime: estTime ?? this.estTime,
        readyTimeFinal: readyTimeFinal ?? this.readyTimeFinal,
        freqDate: freqDate ?? this.freqDate,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        orgAddress: orgAddress ?? this.orgAddress,
        destAddress: destAddress ?? this.destAddress,
        commTime: commTime ?? this.commTime,
        calcAlarmTime: calcAlarmTime ?? this.calcAlarmTime,
        field1: field1 ?? this.field1,
        field2: field2 ?? this.field2,
      );

  static NewAccount fromJson(Map<String, Object?> json) => NewAccount(
        id: json[NewAccountFields.id] as int?,
        firstName: json[NewAccountFields.firstName] as String? ?? '',
        lastName: json[NewAccountFields.lastName] as String? ?? '',
        email: json[NewAccountFields.email] as String? ?? '',
        reEnterPassword:
            json[NewAccountFields.reEnterPassword] as String? ?? '',
        mobileNo: json[NewAccountFields.mobileNo] as String? ?? '',
        address: json[NewAccountFields.address] as String? ?? '',
        alarmTime: json[NewAccountFields.alarmTime] as String? ?? '',
        estTime: json[NewAccountFields.estTime] as String? ?? '',
        readyTimeFinal: json[NewAccountFields.readyTimeFinal] as String? ?? '',
        freqDate: json[NewAccountFields.freqDate] as String? ?? '',
        startDate: json[NewAccountFields.startDate] as String? ?? '',
        endDate: json[NewAccountFields.endDate] as String? ?? '',
        orgAddress: json[NewAccountFields.orgAddress] as String? ?? '',
        destAddress: json[NewAccountFields.destAddress] as String? ?? '',
        commTime: json[NewAccountFields.commTime] as String? ?? '',
        calcAlarmTime: json[NewAccountFields.calcAlarmTime] as String? ?? '',
        field1: json[NewAccountFields.field1] as String? ?? '',
        field2: json[NewAccountFields.field2] as String? ?? '',
      );

  Map<String, Object?> toJson() => {
        NewAccountFields.id: id,
        NewAccountFields.firstName: firstName,
        NewAccountFields.lastName: lastName,
        NewAccountFields.email: email,
        NewAccountFields.reEnterPassword: reEnterPassword,
        NewAccountFields.mobileNo: mobileNo,
        NewAccountFields.address: address,
        NewAccountFields.alarmTime: alarmTime,
        NewAccountFields.estTime: estTime,
        NewAccountFields.readyTimeFinal: readyTimeFinal,
        NewAccountFields.freqDate: freqDate,
        NewAccountFields.startDate: startDate,
        NewAccountFields.endDate: endDate,
        NewAccountFields.orgAddress: orgAddress,
        NewAccountFields.destAddress: destAddress,
        NewAccountFields.commTime: commTime,
        NewAccountFields.calcAlarmTime: calcAlarmTime,
        NewAccountFields.field1: field1,
        NewAccountFields.field2: field2,
      };
}
