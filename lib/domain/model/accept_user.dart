class AcceptUser {
  final int userId;
  final String name;
  final String uniqueNumber;
  final String? nickname;
  final String? email;
  final String? profileImageUrl;
  final bool isSolidarityLeader;
  final bool isAdmin;

  AcceptUser({
    required this.userId,
    required this.name,
    required this.uniqueNumber,
    this.nickname = '',
    this.email = '',
    this.profileImageUrl = '',
    this.isSolidarityLeader = false,
    this.isAdmin = false,
  });
}
