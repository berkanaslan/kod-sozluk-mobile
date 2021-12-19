abstract class IDashboardViewModel {
  Future<void> getPagedDashboardData();

  Future<void> getPagedDashboardDataWithSearchFilter();

  void fetchDashboardData();

  Future<void> refresh({bool cleanSorting = false, bool cleanSearchQuery = false});

  Future<void> clean({bool cleanSorting = false, bool cleanSearchQuery = false});
}
