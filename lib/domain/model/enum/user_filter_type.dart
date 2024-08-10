enum UserFilterType {
  all('ALL', '전체'),
  admin('ADMIN', '어드민'),
  solidarityLeader('SOLIDARITY_LEADER', '주주대표'),
  acceptUser('ACCEPTOR_USER', '수임인');

  const UserFilterType(this.queryValue, this.label);

  final String queryValue;
  final String label;
}
