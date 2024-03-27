const image =
    "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

class ContestInformationData {
  ContestInformationData({required this.type, required this.value});

  final String type;
  final String value;
}

class ContestInfomation {
  const ContestInfomation({required this.data});

  final List<ContestInformationData> data;
}

List<ContestInfomation> contestInformation = [
  ContestInfomation(data: contestInfoData1),
  ContestInfomation(data: contestInfoData2),
  ContestInfomation(data: contestInfoData3),
];

List<ContestInfomation> contestSponsor = [
  ContestInfomation(data: sponsorData),
];

List<ContestInformationData> contestInfoData1 = [
  ContestInformationData(type: 'title', value: 'Introduction'),
  ContestInformationData(
      type: 'text',
      value:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
  ContestInformationData(type: 'image', value: image),
  ContestInformationData(
      type: 'text',
      value:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
];

List<ContestInformationData> contestInfoData2 = [
  ContestInformationData(type: 'title', value: 'Rules'),
  ContestInformationData(
      type: 'text',
      value:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
];

List<ContestInformationData> contestInfoData3 = [
  ContestInformationData(type: 'title', value: 'Prizes'),
  ContestInformationData(
      type: 'text',
      value:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
];

List<ContestInformationData> sponsorData = [
  ContestInformationData(type: 'title', value: 'EBS'),
  ContestInformationData(
      type: 'text',
      value:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
  ContestInformationData(
      type: 'text',
      value:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
  ContestInformationData(
      type: 'image',
      value:
          'https://th.bing.com/th/id/R.d75865b9b7f74a61ed0d0d8b155381a6?rik=Q%2fCby4bXAYBHkw&pid=ImgRaw&r=0'),
];
